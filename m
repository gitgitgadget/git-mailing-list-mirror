From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Sat, 1 Nov 2008 13:26:27 -0600
Message-ID: <51419b2c0811011226p3369b7f7t37b98032ca8dd9ac@mail.gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>, git@vger.kernel.org,
	"Sam Vilain" <samv@vilain.net>
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 01 20:27:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwM8M-0006bo-Pt
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 20:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbYKAT03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 15:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYKAT03
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 15:26:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:59116 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYKAT02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 15:26:28 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1854316rvb.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2CjWr1+y3e35s8goB2R5byZPZUZl8Hqx6ndFd5d5xWM=;
        b=M3vCoVMWCwvr05cHHeXMUqTlIbIB7L31kcDYfulrpaAwBaCgKM78S3FHh5DGhwv7+H
         NhE5+Wa8K4OIhr0ZzHXQe5KSVsW1jxs79rAyr3p8nPPjky7vqKoNpeuXytx4hAgotK1F
         NivzfKCfyCWB2JStrYoSCAm/BqrzOYP3yppJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=V/wNuOrgEuSJWhhLfuXyZp/v3mtbuQ/XtvipmFEmdQ434nA4t9CicKUxz+9UCe7KAm
         lUgVdUMyLOxCze9lAS6ngMc+7AaEunAjU58pnq3+ioE19eF0YBodNUJ1DZ/b+MIwDDla
         AzyCzTt1LWqxbSzCOh0TWP+WL25HXBkTXeMVk=
Received: by 10.141.162.1 with SMTP id p1mr7641739rvo.271.1225567587341;
        Sat, 01 Nov 2008 12:26:27 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Sat, 1 Nov 2008 12:26:27 -0700 (PDT)
In-Reply-To: <20081030143918.GB14744@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99762>

Hi,

On Thu, Oct 30, 2008 at 8:39 AM, Theodore Tso <tytso@mit.edu> wrote:
> Here are my favorites:
>
> * Add the command "git revert-file <files>" which is syntactic sugar for:
>
>        git checkout HEAD -- <files>
>
>  Rationale: Many other SCM's have a way of undoing local edits to a
>  file very simply, i.e."hg revert <file>" or "svn revert <file>", and
>  for many developers's workflow, it's useful to be able to undo local
>  edits to a single file, but not to everything else in the working
>  directory.  And "git checkout HEAD -- <file>" is rather cumbersome
>  to type, and many beginning users don't find it intuitive to look in
>  the "git-checkout" man page for instructions on how to revert a
>  local file.

I agree with the rationale, but the suggested implementation (as with
the original suggestion for "git undo") is somewhat problematic.  I
have a write-up somewhere documenting the ways various individual git
commands fail to be an appropriate replacement for svn/hg/bzr
revert[1], but in short the "git checkout HEAD -- <file>"
implementation for svn/hg/bzr-like revert fails in the following ways:
  * It does not work for the initial commit
  * It won't untrack or remove files (this is related to the previous
and following items)
  * It doesn't allow reverting a file or directory to a revision prior
to HEAD (making it like svn; note though that both bzr and hg have
such an option and I have found it handy a few times)
  * It's inappropriate to use during an incomplete merge.

The incomplete merge case is particularly interesting.  If the user
specifies a file or subdirectory, they should also specify a branch to
revert relative to (and it should be an error if they don't).  If the
user specifies "." then there's the question of whether they are
attempting to undo the merge (meaning that .git/MERGE_MSG and
.git/MERGE_HEAD should be removed).

Just as food for thought, here's what eg does in the incomplete merge case:

$ eg revert foo
Aborting: Cannot revert the changes since the last commit, since you are in
the middle of a merge and there are multiple last commits.  Please add
  --since BRANCH
to your flags to eg revert, where BRANCH is one of
  master, devel
If you simply want to abort your merge and undo its conflicts, run
  eg revert --since HEAD


There's a couple more issues here that I could go on about, but I'll
mention just one more thing for this email:  Since users often get
confused between different kinds of "reverting" or "undoing", a plain
'eg revert' is also pretty helpful in a wide variety of circumstances
(it always aborts with an error message, but one that detects what the
user might want and suggests appropriate commands in the various
cases.)

Elijah


[1] There are a number of different commands that people suggest for
new users to replace other systems' revert behavior, but each has
areas in which it will fail to do what users expect or do additional
things users don't want (including discarding data)  Interestingly,
I've tried four different alternative git porcelains and each one
implemented their svn/hg/bzr-like revert incorrectly.  One of these
was EasyGit, in which I got it wrong not once but three separate
times.  (And if alternative porcelain authors can't easily get it
right, we clearly can't expect normal users to know how to do so; I
think this is a pretty good argument for providing a function for this
behavior in core git.)  I think I finally have it implemented
correctly now in EasyGit, after my fourth try...
