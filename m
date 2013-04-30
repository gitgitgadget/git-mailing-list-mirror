From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/8] Some object db protection when add_submodule_odb
 is used
Date: Tue, 30 Apr 2013 17:32:21 +0700
Message-ID: <CACsJy8D6nKP4yDiZBETnUrB7nyPj_5G2tRdNddSZqjKycnzwPA@mail.gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com> <87ehdsxvbt.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 30 12:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX7rs-0004Sq-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 12:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760117Ab3D3Kcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 06:32:53 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:38347 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520Ab3D3Kcw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 06:32:52 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so294767obb.28
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=mKeVYOLtcUFHRLs5Om/dwRMH9rbj775d9HDiWGigxYo=;
        b=ajsThrFKN8kb9axAVqnC/fAiYffsAqB08HdkZA+x9KEBmFvjGjE75/9pOAyf3KdJhI
         38PsA3ZJiDqelW0oRMtoOUzqSKLG767+2cnZwXeqwBMuidXom9a9oGSG4Rxmw7O0vO/y
         F4pTihRnWPTf4PjBIttciF4vE41dLPKW0qGI00rJuaPZZDFclrbPASb923BteALzcy/m
         QMFZPqzCJThgo4qtZrx/PmIVq/GrN5FVyUYW3E/XQArdPvzxlkhUt1cDDcxZ0mqvgNwO
         lP67JDmgElMaC5ltFFUrW4oj8iL0CqFNHCxhpszgHgioQ7LplnfH4v8fzqyCSEcpcf41
         q2/A==
X-Received: by 10.60.50.70 with SMTP id a6mr26579023oeo.43.1367317971818; Tue,
 30 Apr 2013 03:32:51 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 03:32:21 -0700 (PDT)
In-Reply-To: <87ehdsxvbt.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222926>

On Tue, Apr 30, 2013 at 3:43 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> The idea behind this series is, after add_submodule_odb, odb may hav=
e
>> new temporary objects that only appear after the call. These tempora=
ry
>> objects may lead to repo corruption (e.g. some new objects are creat=
ed
>> and point to these temporary objects). This series attempts to catch
>> those cases. It would make it safer to dig deeper into submodule's o=
db,
>> e.g. to implement unified git-diff.
>>
>> Previous approach [1] is record the odb source, then check if the
>> source is from submodule's odb. But that means we rely on the
>> lookup order in sha1_file.c. This approach instead allows the caller
>> to select what odb sources it wants to look up from.
>>
>> The checks are also less drastic than before. Checks are now done at
>> higher level, e.g. commit_tree(), instead of at write_sha1_file,
>> because we do allow to write objects that point to nowhere.
>>
>> Another new thing from previous round is I completely forbid the use
>> of add_submodule_odb in security sensitive commands like index-pack =
or
>> rev-list. We could loosen up later if we need to.
>>
>> For fun, I set object_database_contaminated to 1 by default and ran
>> the test suite. It passed :)
>
> How does this interact with alternates set up by the user?  It's not
> immediately obvious from the commit messages (hint hint) or the comme=
nts
> near ODB_LOCAL etc.

Room for improvement in the next reroll. Basically objects are put in
the following sources:

 - ODB_CACHED: builtin objects, always exist
 - ODB_LOCAL: objects in $GIT_DIR/objects
 - ODB_ALT: objects from $GIT_DIR/objects/info/alternates
 - and later ODB_EXTALT: objects added by add_submodule_odb()

Many functions now take "origin" as argument. If you pass ODB_ALT, it
will only lookup objects from $GIT_DIR/objects/info/alternates for
example, which might fail if the object does not exist there, or if
it's in a pack and some of the required bases are elsewhere.

By default, everything uses odb_default as the origin, which is
ODB_CACHED|ODB_LOCAL|ODB_ALT (for this patch), so nothing is really
changed regarding alternates setup.
--
Duy
