From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Tue, 16 Mar 2010 16:47:17 -0500
Message-ID: <20100316214717.GA24880@progeny.tock>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com>
 <1268768556-32176-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 22:54:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NreiU-0007jV-8R
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 22:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab0CPVyR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 17:54:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62815 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0CPVyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 17:54:15 -0400
Received: by gyg8 with SMTP id 8so145495gyg.19
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oSkQlV6X0dR12f14jsualSH2nRnu8zkWJ3aIzahorRo=;
        b=s3Ei5vC3ID7FQWozmvpGUuFTbmAxlMLQPOizBDhbyEz7LjOFiEZt3Zscnz3u/qdOk6
         6QLLDp0jCjcP2rHF2aNwQAbSbukX5yJSafM1ZJ1lIV4spbmWLmfASr7OIOEJb3S+2yyr
         QADubHW/MpYaLRMlYZOkOMoh6p3sMHtqKLyio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kC65MERbyX+VpRaz/8ptgr2UwW/ED170OG+zoZAY/oV6KEJcsw8EM/ICWo8TYqsCqf
         TBw63PlpJBkA3SVK9jA1Wmq8SbboxHhJe/nDRnlL0da+jP2cL4bqM7ETKt2fL0mPXJTQ
         bP/+2w+Bm/1sbRR8pLCGUYE1oz0XckVmW2GJM=
Received: by 10.101.56.17 with SMTP id i17mr74558ank.375.1268776021664;
        Tue, 16 Mar 2010 14:47:01 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm5675450iwn.6.2010.03.16.14.46.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Mar 2010 14:47:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1268768556-32176-1-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142352>

Hi Marc,

Marc Branchaud wrote:

> This option tells rebase--interactive to cherry-pick all the commits =
in the
> rebased branch, instead of fast-forwarding over any unchanged commits=
=2E
>=20
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
[...]
> This offers an alterntive way to deal with reverted merges (the
> revert-a-faulty-merge.txt howto recommends reverting the initial reve=
rsion
> before re-merging a modified topic branch).
>=20
> With this change, you can instead use the --no-ff option to recreate =
the
> branch with entirely new commits (they're new because at the very lea=
st the
> committer time is different).  This obviates the need to revert the
> reversion, as you can re-merge the new topic branch directly.

I think this rationale should go in the commit message, for the sake of
future readers studying the code you=E2=80=99ve changed.

But let me make sure I understand it.

If I am understanding properly, your idea is that this would be used on
a branch after =E2=80=9Cunmerging=E2=80=9D it from master:

    B --- C --- D [topic]
  /              \
 A ---  ...   --- M ... --- U [master]

Here M is a merge commit and U a commit reverting the change from M^
to M.

As howto/revert-a-faulty-merge explains, this is an accident waiting to
happen: if you merge master into topic, then it will pull in the revert
along with the rest of the changes.  Similarly, if you merge topic into
master, it will be a no-op (=E2=80=9Calready up to date=E2=80=9D).

Your solution, to rewrite the branch, should address both of these
problems.  The new history looks like this:

    B' --- C' --- D' [topic]
  /
 |  B --- C --- D
 |/              \
 A ---   ...  --- M ... --- U [master]

What happens now if you merge topic into master (or master into topic)?

Git will try to reconcile the changes from the two branches since when
they diverged.  master gained the changes from the old topic branch and
then reverted them since it diverged from topic; since merge algorithm
is a simple three-way merge, all that history is ignored and Git will
just combine any new changes from master with the changes from topic.
Success.

Side note:

After this maneuver, I would want to merge =E2=80=98master=E2=80=99 int=
o =E2=80=98topic=E2=80=99 as
soon as possible.  Why?  Because there is still a failure mode possible
after this: if you merge any commits from the old topic into the new
one before then, you=E2=80=99re back in trouble.  This could happen if =
some
topic2 that topic ends up needing is based on a point in master after M
and before U.

After merging master into topic, the _meaning_ of the history is much
clearer: by making U an ancestor, we are saying that as far as this
branch is concerned, the state at the tip of the topic branch is to be
preferred over the reverted state.

This suggests an alternative method to achieve your goal:

 git checkout master
 git revert -m 1 M;	# (1)
 git checkout topic
 git merge master^;	# (2)
 git merge -s ours master;	# (3)

1. Add a commit U removing the changes introduced by topic from master.

2. Merge all changes from master before the revert into topic.

3. Declare the changes from topic to supersede the master branch.
   This way, if topic is ever merged back to master, the changes will b=
e
   reintroduced again.

Resulting history:

    B --- C --- D --- ... --- T^ --- T [topic]
  /              \            /     /
 A ---   ...  --- M ... --- U^ --- U [master]

You can avoid the perhaps pointless commit T^ by using --no-commit in
the command (2).  If not all changes from M..master are suitable for
merging into topic, you can use the same trick on a temporary side
branch:

 git checkout -b revert-topic M
 git revert -m 1 M
 git checkout topic
 git merge --no-commit revert-topic^
 git merge -s ours revert-topic
 git checkout master
 git merge revert-topic

If not all changes from topic..M are suitable for merging into topic,
then things are harder.  I=E2=80=99d suggest making a special unrevert-=
topic
branch as above to keep in the wings until its time.

> (Honestly, I wouldn't say that this approach is vastly superior to
> reverting the reversion.  I just find it a little less messy and a li=
ttle
> more intuitive.  It's also a bit easier to explain to people to "use =
--no-ff
> after reverting a merge" instead of making sure they get the double-
> reversion right.)

Hope this helps clarify things.

Your patch itself might still be a good idea.  I think plain
=E2=80=98git rebase=E2=80=99 already has something like it, in the form=
 of the
--force-rebase option.  I have used it before, though I don=E2=80=99t r=
emember
why.

Thanks for the food for thought,
Jonathan
