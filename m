From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: do not fail on invalid bookmarks
Date: Mon, 6 Jan 2014 22:51:58 +0100
Message-ID: <CALWbr2zC-Q8YduW9b1feThBtz38Tsk7D1BoCRd7KxnCuht27PQ@mail.gmail.com>
References: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
	<52CAB508.5010002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 06 22:52:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0I5e-0004x3-MT
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 22:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbaAFVwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jan 2014 16:52:01 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:50877 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbaAFVwA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 16:52:00 -0500
Received: by mail-lb0-f180.google.com with SMTP id x18so10021177lbi.25
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 13:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=v160D++cRW8h0egc5K7yxH8clDtQGKokp7JKJVDuzhA=;
        b=VcZuOlkeFPQr/eb+fRfIzE6Aod7vBl/pFTjFK6XoIfsw4yAZ7RAUkvkEtIGv3QNKMC
         KrcSfrD5EmXj55JZbPm2td//Zf49smngomsM4PgPjdbH1Q1GPBzkWF6DoKZWzCpECRq7
         3x/liB6bfrD0yU5AlC4gvfWKNaNl8keB9PjK71p3iBsCYsn8flZqukQvKuo1ScA8B89t
         UqwTeG0Hn6RgA1TVS2d9sXT7jUWyaITSCZXO6SkHBrXRwFX51tKUV/X+o7pT50pkS5C0
         MB6W6utlQVvDjtbScnU8MTvOZME0DGbljj1JxsFHChzRK8xQJKk5B5BbyxbifPwZnFe2
         1MrQ==
X-Received: by 10.152.87.211 with SMTP id ba19mr46017351lab.13.1389045118998;
 Mon, 06 Jan 2014 13:51:58 -0800 (PST)
Received: by 10.112.52.40 with HTTP; Mon, 6 Jan 2014 13:51:58 -0800 (PST)
In-Reply-To: <52CAB508.5010002@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240069>

Thanks for noticing,
I can reproduce at work, I will try to come-up with an improved version=
 soon,

Cheers,
Antoine

On Mon, Jan 6, 2014 at 2:52 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2013-12-29 12.30, Antoine Pelisse wrote:
>> Mercurial can have bookmarks pointing to "nullid" (the empty root
>> revision), while Git can not have references to it.
>> When cloning or fetching from a Mercurial repository that has such a
>> bookmark, the import will fail because git-remote-hg will not be abl=
e to
>> create the corresponding reference.
>>
>> Warn the user about the invalid reference, and continue the import,
>> instead of stopping right away.
>>
>> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-hg | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-h=
elpers/git-remote-hg
>> index eb89ef6..12d850e 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -625,6 +625,9 @@ def list_head(repo, cur):
>>  def do_list(parser):
>>      repo =3D parser.repo
>>      for bmark, node in bookmarks.listbookmarks(repo).iteritems():
>> +        if node =3D=3D '0000000000000000000000000000000000000000':
>> +            warn("Ignoring invalid bookmark '%s'", bmark)
>> +            continue
>>          bmarks[bmark] =3D repo[node]
>>
>>      cur =3D repo.dirstate.branch()
>>
> (Side note: ap/remote-hg-skip-null-bookmarks)
>
> When I run the test-suite like this:
> ~/projects/git/git.pu/contrib/remote-helpers$ debug=3Dt verbose=3Dt m=
ake test-hg-hg-git.sh
>
> All 11 test cases fail on my systems (Debian Wheezy and Mac OS X):
> [snip]
> WARNING: Ignoring invalid bookmark 'master'
> To hg::../hgrepo-git
>  ! [remote rejected] master -> master
> error: failed to push some refs to 'hg::../hgrepo-git'
> not ok 1 - executable bit
> #
> [snip]
>
>
