From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Bugs with detection of renames that are also overwrites
Date: Tue, 23 Feb 2010 23:53:13 +1100
Message-ID: <2cfc40321002230453q3a593fa6l43850207ebddfc99@mail.gmail.com>
References: <alpine.DEB.2.00.1002131820150.14055@dr-wily.mit.edu>
	 <20100223122257.GA1735@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjuGO-0004NL-14
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 13:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab0BWMxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 07:53:15 -0500
Received: from mail-pz0-f174.google.com ([209.85.222.174]:61919 "EHLO
	mail-pz0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab0BWMxO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 07:53:14 -0500
Received: by pzk4 with SMTP id 4so530916pzk.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 04:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jNSuY3Rrw3wfulSYNigg3HfdWFtGJjeEHuFJyVeGdpw=;
        b=ab0nNAvfyFdg2H/tYCPdnwUuM8y2hvAYzCuWT/aOlmaqsDGYz9ErqUoCINErntPhz7
         wQXOinQk1qvSXs/qkZqs+uhgJXJTY6eJX6SyvLgucfmVHICRVzQZviWdny3DNk2+ELzD
         Vv8heDyCaiJqa3+Zh67eKL/mg7IwPoamcAnqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=joewYuM80PGJgbGgSJ7qa6xpduMm+Ky8N9J6tCmDXpWXM/+icaJKwNAaP+kulUHvg2
         1aFNcNRjv5VIIUK17ZW7NZQVeT3An1f/7KE1ytw7rBSh4YwqGLZgH7QTwAvzr0ar4upg
         pCzRxWIe3VWv4UqeKEmfAel655fi9ZDwEsMkg=
Received: by 10.115.135.9 with SMTP id m9mr3194241wan.82.1266929593260; Tue, 
	23 Feb 2010 04:53:13 -0800 (PST)
In-Reply-To: <20100223122257.GA1735@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140793>

I came across a similar case recently while testing my rebasing ideas
which lead me to wonder - is there a way to suppress the rename and
overwrite detection? For my purposes, I don't care if the diff is
bulky, I just want it to apply reliably.

jon

On Tue, Feb 23, 2010 at 11:22 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 13, 2010 at 06:46:55PM -0500, Anders Kaseorg wrote:
>
>> One can create a rename that also overwrites an existing file, for e=
xample
>> with =91git mv -f=92:
>>
>> $ git init
>> $ seq 100 200 > a; seq 300 400 > b; git add a b
>> $ git commit -m foo; git tag foo
>> $ git mv -f a b
>> $ git commit -m bar; git tag bar
>>
>> Git does not ordinarily detect this as a rename, even with -M.
>
> Right. Git looks at only a subset of the files when looking for renam=
es.
> For straight renames, the set of possible sources is the list of dele=
ted
> files, and the possible destinations are the new files.
>
> Finding copies ("-C") is similar, except that we also consider files
> that were modified but not deleted. And --find-copies-harder will loo=
k
> at _all_ files as sources, not just modified ones.
>
> But what you are asking for is to expand the possible destination lis=
t
> to include files that were modified but are not new. I don't think th=
ere
> is currently a way to do that explicitly.
>
> As you discovered, though, if either the source or destination file h=
as
> changed significantly, we should break them apart using "-B":
>
>> But it can (sometimes*) be forced to detect the rename with -M -B.
>>
>> $ git diff --stat -M -B foo bar
>> =A0a =3D> b | =A0 =A00
>> =A01 files changed, 0 insertions(+), 0 deletions(-)
>
> In which case the rename engine sees the deletion and addition
> separately (they just happen to have the same path name), and therefo=
re
> the path gets added to the source and destination lists.
>
>> However, the resulting patch incorrectly omits the deletion of the
>> overwritten file!
>>
>> $ git diff -M -B foo bar
>> diff --git a/a b/b
>> similarity index 100%
>> rename from a
>> rename to b
>>
>> Therefore, the patch can=92t be applied to its own source tree.
>>
>> $ git checkout foo
>> $ git diff -M -B foo bar | git apply
>> error: b: already exists in working directory
>
> Hmm. I think this is a conflict between what the user wants to see an=
d
> what apply wants to see. From the user's perspective, thinking about =
the
> diff representing a change, "b" was not really deleted. It was simply
> overwritten. But from apply's perspective, the diff is a set of
> instructions, and those instructions do not mention that "b" previous=
ly
> existed and was overwritten. So it is right to be cautious and declar=
e a
> conflict.
>
> I'm not sure just throwing a "delete" line in there would be the best
> thing, though. The instructions for apply really need to be "if 'b' h=
as
> this sha1, then it is safe to delete and rename a into place. Otherwi=
se
> it is a conflict". And I'm not sure how we would represent that (I gu=
ess
> with a full diff and an "index" line).
>
>> Also, a question: is it possible to get =91git merge=92 to recognize=
 this
>> rename?
>
> No, I don't think there is a way currently. You would need to patch g=
it
> to set opts.break_opt in merge-recursive.c:get_renames, I think.
>
>> (* I say =93sometimes=94 because -B only detects the rewrite if it d=
eems the
>> renamed file to be sufficiently different than the overwritten file.=
 =A0If
>> you use 190 and 390 instead of 200 and 400 above, the rewrite and re=
name
>> will not be detected, even though the rename would be detected if it=
 was
>> not an overwrite. =A0This also feels like a bug.)
>
> I think you are getting into a philosophical discussion of what is a
> rename, here. If "a" and "b" are very similar, "a" is removed, and "b=
"
> has the same (or similar) content as "a", was it a rename from "a", o=
r
> was it simply that "b" was changed, possibly to incorporate the
> duplicated items in "a"?
>
> So I don't think it is a bug. But that isn't to say you can't come up
> with a case where it would be nice, during a diff or a merge, to show
> things that way. I mentioned at the beginning of the message that wha=
t
> you wanted was to expand the list of destination possibilities. You
> could have a "--find-overwrites" which puts all of the modified files
> into the destination list. You would not want it on by default, thoug=
h,
> I think, as it would add a lot of computation time to find a somewhat
> rare case.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
