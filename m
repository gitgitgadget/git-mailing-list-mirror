From: Junio C Hamano <junkio@cox.net>
Subject: Unresolved issues
Date: Mon, 19 Feb 2007 23:28:35 -0800
Message-ID: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 08:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJPQW-0002OL-Fy
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 08:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbXBTH2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 02:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbXBTH2h
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 02:28:37 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39033 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964805AbXBTH2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 02:28:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220072836.VMXZ21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 02:28:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RjUb1W00A1kojtg0000000; Tue, 20 Feb 2007 02:28:36 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40205>

Here are some issues recently raised on the list, some of them
with patches, that have not been resolved satisfactory.

 [gmane=http://thread.gmane.org/gmane.comp.version-control.git]

* "git status" is not a read-only operation.

  It needs to do enough lstat(2) to run "update-index --refresh" to come
  up with the information it needs to give.  We could do so internally
  without writing out the result to the index (there is a patch to do
  this) even if a repository is not writable.

	$gmane/39205
        $gmane/39206

  However, a big downside of this approach is that doing so
  unconditionally would mean the expensive lstat(2) is wasted
  afterwards.

	$gmane/39246

  Currently an workaround is to run git-runstatus and live with the fact
  that otherwise unmodified but stat-dirty paths to show up in the
  output.  I think (iff somebody feels strongly about it) a possible
  compromise would be to see if we can update the index, and do what the
  current code does if we can, and otherwise fall back on the new code
  that does the internal "update-index --refresh".

* "git -p status" does not honor color.

  The problem is that when git-runstatus is run, it already runs as an
  upstream process of a pipe and git_config_colorbool() would say "oh,
  our output is not a terminal, and we did not start pager ourselves".

	$gmane/39919

  A patch was proposed to propagate pager_in_use as an environment down
  to subprocesses,

	$gmane/39936

  but I think this would have unintended side effects when scripts want
  to run commands and redirect their output internally for their own use
  (they will get colorized output from lower level in their temporary
  files or v=$(cmd) redirect).

* "git log -r --raw -z -- path | grep -z SHA-1" is not very useful.  

  We would need a separate -Z option that means "output records are
  separated with NUL, but output fields are not".

	$gmane/39207

  This would help to solve "someone mails me a blob, git please tell me
  what it is" problem.

	$gmane/39925

* "git fetch" between repositories with hundreds of refs.

	$gmane/39330

  There are partial rewrite of the most expensive parts of git-fetch in
  C parked in 'pu'.  It might be good enough for public consumption
  without going the whole nine yards.  I dunno.  I am not very keen on
  rewriting all of "git fetch" in C right now, as people seem to be
  still interested in touching it (including "git bundle" topic).

* core.autocrlf

  Linus and I laid out most of the infrastructure and the basic things
  already seem to work.  We even added some tests ;-)

        commit 6716027108f426c83038b05baf3f20ceefe6fbd1
        commit 634ede32ae7d4c76e96e88f9cd5c1b3a70ea08ac
        commit d7f4633405acf3dc09798a759463c616c7c49dfd
        commit 6c510bee2013022fbce52f4b0ec0cc593fc0cc48

  What's still missing is support for .gitignore like "these files are
  text" information.

  One thing that might be tricky is what should be done while making a
  merge or checking out from a tree.  Ideally, the information should be
  read from the tree that is being extracted, but that would make the
  code structure a little bit, eh, "interesting".

* Use update-ref in cvsserver.

  It currently does it by hand, which is racy and does not leave traces
  in reflog.

	$gmane/39541

* Dissociating a repository from its alternates

  I sent out a rather elaborate changes in the binary, but what Johannes
  suggests is much easier to implement.

	$gmane/39834

  Volunteers?

* User-wide ignore list

	$gmane/39809

  I am not really sure if this is even a desirable feature, but assuming
  it is, one possible solution would be to do this:

	$gmane/39820

  But I am not going to do this myself; I suspect that it would be
  fairly simple and straightforward that some git-hacker-hopeful should
  be able to.

* git-diff2

  It somehow feels a tad ugly that this is a separate command from
  git-diff, but I do not feel strongly enough to fix it myself.
  Currently parked in 'pu'.
