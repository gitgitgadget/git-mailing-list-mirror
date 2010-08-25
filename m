From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 15/32] unpack_trees: only unpack $GIT_DIR/narrow subtree
 in narrow repository
Date: Wed, 25 Aug 2010 15:38:54 +1000
Message-ID: <AANLkTikiazizLaXtotxL2UcuJ64KgWwGCwy+E6rv42_G@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-16-git-send-email-pclouds@gmail.com>
	<AANLkTinaF6e+bfVqRRThuZ=2PjpOs4P88RKFsxOTVSJR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 07:39:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo8hW-0002MQ-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 07:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab0HYFi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 01:38:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39005 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0HYFiz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 01:38:55 -0400
Received: by wwb34 with SMTP id 34so399270wwb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 22:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NyANL5pQvzXTrRk5t6otNQXEBx6Q1ovxgej1iefGynI=;
        b=MJEtfOR4XkC0UKOFWfTymA5yOdKHFQjHVQ84p6esbwkF+Y0daRBXdgvTfBfqvSwJ8A
         gZJgJhQ429tFT5oPJMWlh57RW4tgHvUxFznY5aJ2QIFBQMR+luD+c63wYNCi1KkjD2Y4
         EbTBbkPsDLNgwZ8FZ67z9E8RWIlzS6Zx7/Ims=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DWyPlkaQVau6qjJ+KwCZQtKxQQ1bY5yltOS8IaoBS942b5tTQUgNVQ9PweQqsTLZmG
         d6+xoX6/XtfHqh1pWlK0wSbIOL484NPEAWyN8dv/rhcU1pviYvwXTvn+ugExFEJKCi6T
         XDBUjXMoMW/o7nfG6RFw12kxzZU56dkgrGyPI=
Received: by 10.216.231.73 with SMTP id k51mr6930424weq.5.1282714734398; Tue,
 24 Aug 2010 22:38:54 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 22:38:54 -0700 (PDT)
In-Reply-To: <AANLkTinaF6e+bfVqRRThuZ=2PjpOs4P88RKFsxOTVSJR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154423>

On Wed, Aug 25, 2010 at 3:04 PM, Elijah Newren <newren@gmail.com> wrote=
:
> Hi,
>
> 2010/8/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> By definition, narrow repository is incomplete. It does not even hav=
e
>> enough tree for a single commit. So populating a full index is
>> impossible.
>>
>> Because of this, unpack_trees() is modified to only unpack trees
>> within $GIT_DIR/narrow, which narrow repo has all needed trees. This
>> makes the resulting index unsuitable for creating commits later on.
>> This is the reason index version is increased to 4, to avoid older
>> git from using it.
>>
>> The resulting tree objects created from the index is only part of th=
e
>> full tree. Manipulation will be needed at commit time to create prop=
er
>> tree for commits.
>
> I spent a while thinking about this a couple weeks ago and never came
> to a strong conclusion about which of two alternatives should be
> preferred; I'm curious why you decided to go for this solution. =C2=A0=
An
> alternative I thought of was having the index have entries for missin=
g
> files (whose contents did not exist in the repository or the working
> copy; rather all we know is the filename and its sha1sum) and also
> gain the ability to have entries for missing trees (which behave
> similarly; all we know is their name and their sha1sum, but the
> contents of that sha1sum are not in the repository or the working
> directory) =C2=A0Is there a reason to prefer one alternative over the
> other? =C2=A0Does the alternative I thought of even make sense?

That was nightmare. I had to deal with unpack_callback() and skip
uninterested paths. And that function is, I think, quite optimized. I
tried another approach, putting directories in index with hope that it
would cut down the number of code path I'd have to touch. It did, but
then index sorting order is just weird and I couldn't get it right
(felt to risky).

unpack_trees() is used by diff (all diffs except diff_tree_sha1).
traverse_trees()/unpack_trees() is also used by merge strategy. All
those code is really complicated that I'd rather stay away from them.

That was before I went with tree rewrites. Soon after I realized the
nice effect of tree rewrites is that the index is narrowed down. So I
can get rid of tree rewrites as long as the index is still narrow.
That's how I come to this approach.

Back to your questions. I think the alternative makes sense, it just
looks a lot of work and quite intrusive. On the other hand, my current
approach is quite simple (but it probably won't work for more than a
single narrow tree)
--=20
Duy
