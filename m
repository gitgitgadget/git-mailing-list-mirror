X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames with spaces and non-ascii characters.
Date: Sun, 10 Dec 2006 16:39:21 +0100
Message-ID: <200612101639.22397.robin.rosenberg@dewire.com>
References: <20061209232919.31863.58547.stgit@lathund.dewire.com> <7v3b7o8s5j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 15:38:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <7v3b7o8s5j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33896>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtQkv-0002Me-7d for gcvg-git@gmane.org; Sun, 10 Dec
 2006 16:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761248AbWLJPh6 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 10:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761256AbWLJPh6
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 10:37:58 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10591 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1761248AbWLJPh5 convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 10:37:57 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id EFB188030B8; Sun, 10 Dec 2006 16:34:02 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 07943-08; Sun, 10 Dec
 2006 16:34:02 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id 2EB00802AB4; Sun, 10 Dec 2006 16:34:00 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

s=F6ndag 10 december 2006 02:18 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> > This patch uses git-apply to do the patching which simplifies the c=
ode a
> > lot.
> >
> > Removed the test for checking for matching binary files when deleti=
ng
> > them since git-apply happily deletes the file. This is matter of ta=
ste
> > since we allow some fuzz for text patches also.
> >
> > Error handling was cleaned up, but not much tested.
>
> Interesting.
>
> I think you should be able to generate the patchfile once, and
> use git-apply to figure out additions, deletions and binaryness,
> and then use the same patchfile to apply the changes.  Currently
> checking for binaryness is not easy with git-apply, so we would
> want to fix git-apply first, instead of forcing you to have a
> change like this:
>
>    # the --binary format is harder to grok for names of binary
>    # files so we execute a new diff
>    # if it looks like binary files exists to find out
>    if (grep /^GIT binary patch$/, @diff) {
>        @binfiles =3D grep m/^Binary files/,
>        safe_pipe_capture('git-diff-tree', '-p', $parent, $commit);
>
> which is way too ugly.
>
> 	... goes to look and comes back, with a big grin ...
<grin> apparently

>
> Well, have you tried this?
>
> 	git diff-tree -p --binary fe142b3a | git apply --summary --numstat
of course not. I didn't understand it. Why can't it tell me about remov=
ed
binary files, so I could remove the git-diff-tree invocation to find ou=
t about=20
added/removed files?

> The numstat part would let you see the binaryness, so we do not
> have to "fix" git-apply.
>
> Another thing that _might_ be interesting is to use rename
> detection when preparing the patch, and make the matching rename
> on the CVS side, but I do not recall the details of how one
> would make CVS pretend to support renamed paths ;-).  I think it
> involved copying the ,v file to a new name, and marking the
> older revisions in that new ,v file as nonexistent or something
> like that, but I did it only in my distant past and forgot the
> details.
In server mode, which is the normal way of using CVS you cannot
do this with the CVS most of us are used with. CvsNT does support=20
a rename command, I think, but I don't use it, partly due to rumors of =
it=20
being somewhat unstable. If there's any truth in that, I don't know.

Anyway, I don't practice the rename trick in CVS myself. I'm not  sure =
how=20
that would work with the roundtripping via CVS that I do.  cvsimport=20
detects "renames" with the current approach so I'm happy as is, not tha=
t I=20
rename files much.  I also think there than a copy is needed to play ni=
ce,=20
like removing old tags from the copy, how about rename back and forth e=
tc.=20
There's a reason people want to migrate from CVS, as well as there are=20
reasons not to hurry. CVS doesn't support rename, it's that simple.

> By the way, I am not sure if giving fuzz by default is such a
> good idea, though.

It was in the original. I don't know why. Maybe the original author can=
 tell=20
us why it was important. It may be problematic to stay fully in sync wi=
th a=20
CVS repo because you have to git-cvsimport it first and that takes some=
 time.=20
This fuzz gives some, but not much slack. Reverting the option could be=
 a=20
good idea.

Update follows.

