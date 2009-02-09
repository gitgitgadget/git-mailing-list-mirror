From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: receive.denyCurrentBranch
Date: Sun, 8 Feb 2009 20:47:26 -0500
Message-ID: <76718490902081747s7a1ebe12yaf08665429a594c6@mail.gmail.com>
References: <20090208042910.19079.qmail@science.horizon.com>
	 <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
	 <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
	 <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
	 <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com>
	 <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWLGa-0001wn-Bz
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 02:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbZBIBra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 20:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZBIBra
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 20:47:30 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:37662 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZBIBr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 20:47:29 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1580334rvb.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 17:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nzbq8E0TTsZ1Uy9rJ/GhBglDbomgNxiolp/W7hudP1s=;
        b=TpeBWhVJNkA31JVU68wvPyacxlJWX35YQDX+tEY4VPtCFUSCGC/qciIbj5xxlmrPKy
         vYdNSInKF9ij2AhZHyTfjh57qEl8Rs7oxYiBKc0A9JRpdGTv4Ed0LXWuKFowGqoo5Qs6
         tDvUw3hqlSxVsqHmXRhu3cTR5Os7SS2c61K8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I17CwPB34G63DItJVngFoffUnTsap8r/hhGjnDEYQb8iz0/57yH3mfj6+cF0ciBeyn
         Pn9cIv9cMFgmF+aCFlqv+EAt/r7vpIfbBrfaOeGG8EuD8af6Ms7oDWu8NviBQVYA8kMy
         SMAsqc1Gos27vUzGVzR0h6ltgkOFc3F5fZEKE=
Received: by 10.140.139.4 with SMTP id m4mr3387019rvd.213.1234144046947; Sun, 
	08 Feb 2009 17:47:26 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109033>

On Sun, Feb 8, 2009 at 6:41 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 8 Feb 2009, Jay Soffian wrote:
>
>> If you had paid attention, you would have noticed that Mercurial did not
>> attempt to merge. Rather, it created a new branch head in the remote
>> repository.
>
> So this is the "detached HEAD" idea.  Which contradicts the law of the
> least surprise.

I agree that a detached HEAD is a bad idea. The closest parallel that
I can come up with for git would be for receive-pack to store incoming
changes into separate branch hierarchy, NOT for it to detach HEAD. A
toy-patch I played around with earlier allowed this on the non-bare
upstream repo:

[receive]
     prefix = refs/remotes/incoming

Then a push to refs/heads/master was automatically stored as
refs/remotes/incoming/master instead.

And yes, I'm aware the user can use a push refspec on the sending side.

> It should be clear that the equivalent of a central repository is a bare
> repository.  And hopefully Junio's strategy will make that clearer, so I
> think this is the superior approach.

I foresee new user doing this:

laptop:~$ git clone ssh://workstation/~/repo
laptop:~$ cd repo
laptop:~/repo (master)$ echo change >> file && git commit -am change
laptop:~/repo (master)$ git push
...
error: refusing to update checked out branch: refs/heads/master
To ssh://workstation/~/repo
 ! [remote rejected] master -> master (branch is currently checked out)
error: failed to push some refs to 'ssh://workstation/~/repo'

And now new user is stumped.

Perhaps adding something like this to the git-push man page:

---8<---

Non-bare Repositories
---------------------
When pushing to a non-bare upstream repository (i.e. an upstream repository
with a working copy), changes to the checked out branch are NOT reflected in
the upstream index, nor in the working copy. This creates a situation where it
is easy to accidentally revert the changes on the next commit in the upstream
repository.

e.g. Assume the following history exists in the upstream repository:

A---B master

master is the currently checked out branch, nothing is staged in the index and
the working copy is clean.

A single change is made to master downstream and pushed. The upstream
repository is now in this state:

A---B---C master

However, the index and working copy reflect the state at commit B. Performing
a new commit in the upstream repository would do this:

A---B---C---B' master

B' is a new commit, but reflects the same state as B.

In order to prevent this situation, it is recommended that if you need to push
into a non-bare upstream repository, set receive.denyCurrentBranch = true in
the upstream repository (this will become the default in git-X.Y). This will
prevent the push from occurring. Instead, you can push into an alternate
branch, and then merge that branch in the upstream repository. e.g.:

server$ cd ~/repo && git config receive.denyCurrentBranch true

laptop$ git push
...
error: refusing to update checked out branch: refs/heads/master
To ssh://server/~/repo
 ! [remote rejected] master -> master (branch is currently checked out)
error: failed to push some refs to 'ssh://server/~/repo'
laptop$ git push origin master:refs/remotes/laptop/master
laptop$ ssh server
server$ cd ~/repo
server$ git merge laptop/master

Alternatively, you can set receive.denyCurrentBranch = warn in the upstream
repo, but then you must remember to perform "git reset --hard" in the upstream
repo after pushing to its currently checked out branch. (But be careful, as
"git reset --hard" throws away uncommitted changes.)

---8<---

j.
