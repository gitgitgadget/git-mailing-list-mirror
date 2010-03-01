From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Mar 2010 10:14:56 -0800 (PST)
Message-ID: <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <7v1vg4ufas.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 19:16:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmA95-0002HO-7y
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 19:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab0CASPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 13:15:00 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:11329 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab0CASO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 13:14:58 -0500
Received: by qw-out-2122.google.com with SMTP id 8so551899qwh.37
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 10:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references;
        bh=ePh8oHTs2OpR8O9vwaCEatCeSTO2FZ1hCNVqKo8dxr0=;
        b=rVvmGXxh5iZu5mTMRVQYLFgSm7TUVGPbDEDu/k3dGCYw+wsp1jQRQlYooZNpsCkZsl
         mQdYHp3K+FQ+TE/pSspiLb0SSBl3UP0Go4LVhQLC7CnI3xcuilWYyfUI+6B8C2EIk+15
         NgcbwjkBO0BpUfqgz3+ep18fYwkI9rjAqas6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references;
        b=SytUdcBvf7gYw9qT2R5y6EvCuzJCNklVfOEIB+NR2pAFMZyFhs0x05NJycRFmRCmF+
         o/sSidiusvSd8a/as+mxRKFh5FOK3ncCiRPy/RwnPEQzuhMjICaDXsEjq/TGfusScx5s
         41Yf5vqEv0B8cLYLjDPj4RhVoTOxAjDejZB5s=
Received: by 10.229.222.4 with SMTP id ie4mr2229612qcb.79.1267467297914;
        Mon, 01 Mar 2010 10:14:57 -0800 (PST)
Received: from gmail.com (tor-proxy.fejk.se [66.90.75.206])
        by mx.google.com with ESMTPS id 21sm3200836iwn.11.2010.03.01.10.14.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 10:14:56 -0800 (PST)
In-Reply-To: <7v1vg4ufas.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141338>

On Mon, Mar 1, 2010 at 11:23, Junio C Hamano <gitster@pobox.com> wrote:
> Your "checkout" needs a bit better error checking.  For example, you
> don't want to "reset --hard" when stash failed for whatever reason.

Yes, you are correct.

However, in my defense, the goal was just to illustrate the gist
of the desired functionality.

> For performance and cleanliness reasons, it should first try a branch
> switch, and only after seeing it fail due to local changes, perform your
> stash-unstash magic.  You would probably want to use the usual "stash
> save", as you will be consuming the stashed change yourself as its first
> user, and "pop" will clear it if things resolve cleanly, or the stash will
> be left as the first element to make it easy to re-attempt the conflict
> resolution.  No need for stash-id nor special casing of detached HEAD
> situation.
>
> And it should do all that only under "-m" option, i.e. when the user
> indicated that s/he is willilng to face conflict resolution while
> switching.  That would be a genuine improvement compared to the current
> system (and I suspect it would be easier to implement).  "checkout -m" so
> far has been as bad as "CVS/SVN update" in that it can get you into an
> unresolvable mess without a chance to go back and retry.  autostash will
> remedy that.

You've still got the wrong problem in your head (though you're
solving a more useful issue).

Markus Elfring's goal (I think) is to associate local modifications with
a particular branch, *not* carry them across branches; that is, the goal
is to stash local modifications away when we leave a branch and only pop
them off the stash when we RETURN to that same branch.

Here's an example using the previously defined custom `checkout' function
(don't bother trying to follow the file modifications exactly; what's
important is how the stash is used during `checkout'):

  $ git init repo
  Initialized empty Git repository in /home/michael/repo/.git/


  $ cd repo
  $ echo 0 > file_0
  $ git add file_0
  $ git commit -m 0
  [master (root-commit) 26ea762] 0
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 file_0


  $ echo 1 > file_1
  $ git add file_1
  $ git commit -m 1
  [master 2faaa55] 1
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 file_1


  $ echo 2 > file_0
  $ echo 3 > file_1
  $ git add file_1


  $ git branch branch
  $ checkout branch               # Note: That's the custom 'checkout'
  Switched to branch 'branch'


  $ git stash list | cat
  stash@{0}: On master: e2f0bfbd9de98acd4941a1842e4bc55f


  $ echo 4 > file_0
  $ checkout HEAD^
  Note: checking out 'HEAD^'.
  
  You are in 'detached HEAD' state. You can look around, make experimental
  changes and commit them, and you can discard any commits you make in this
  state without impacting any branches by performing another checkout.
  
  If you want to create a new branch to retain commits you create, you may
  do so (now or later) by using -b with the checkout command again. Example:
  
    git checkout -b new_branch_name
  
  HEAD is now at 26ea762... 0


  $ git stash list | cat
  stash@{0}: On branch: 3e4d8fe5cbdcf73b9272ad21b4510424
  stash@{1}: On master: e2f0bfbd9de98acd4941a1842e4bc55f


  $ echo 5 > file_0 


  $ checkout master
  HEAD is now at 26ea762 0
  Previous HEAD position was 26ea762... 0
  Switched to branch 'master'
  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #	modified:   file_1
  #
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #	modified:   file_0
  #
  Dropped stash@{1} (6871afd660a5814a1caffe5275a9c145dba3c85a)


  $ git stash list | cat
  stash@{0}: On branch: 3e4d8fe5cbdcf73b9272ad21b4510424


  $ checkout branch
  Switched to branch 'branch'
  # On branch branch
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #	modified:   file_0
  #
  no changes added to commit (use "git add" and/or "git commit -a")
  Dropped stash@{1} (f6ecf1ceed97c760cb2b3279bbb39fc1cd16f052)


  $ git stash list | cat
  stash@{0}: On master: e2f0bfbd9de98acd4941a1842e4bc55f


  $ checkout master
  Switched to branch 'master'
  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #	modified:   file_1
  #
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #	modified:   file_0
  #
  Dropped stash@{1} (46a64d63441a924d9684c8a733a9fae4c7aa4b92)


  $ git stash list | cat
  stash@{0}: On branch: 3e4d8fe5cbdcf73b9272ad21b4510424

  $ git diff | cat
  diff --git a/file_0 b/file_0
  index 573541a..0cfbf08 100644
  --- a/file_0
  +++ b/file_0
  @@ -1 +1 @@
  -0
  +2

  $ git diff --staged | cat
  diff --git a/file_1 b/file_1
  index d00491f..00750ed 100644
  --- a/file_1
  +++ b/file_1
  @@ -1 +1 @@
  -1
  +3

etc.
