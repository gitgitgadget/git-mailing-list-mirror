From: Junio C Hamano <junkio@cox.net>
Subject: git-rev-parse question.
Date: Tue, 23 Aug 2005 01:02:49 -0700
Message-ID: <7v7jedulli.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 10:05:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7TkI-0007oO-7X
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 10:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVHWICv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 04:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVHWICv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 04:02:51 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51940 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbVHWICv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 04:02:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823080249.JUZT550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 04:02:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have been looking at what git-rev-parse does and could not
figure out a way to convince it to give me only arguments with
a '-' prefix.  Specifically, I wanted to remove the hardcoded -p
and -M flags from git-diff-script.  Running

    $ sh -x git-diff-script -C HEAD^ HEAD

reveals that none of the following would pick up "-C" from the
command line:

    rev=($(git-rev-parse --revs-only "$@")) || exit
    flags=($(git-rev-parse --no-revs --flags "$@"))
    files=($(git-rev-parse --no-revs --no-flags "$@"))

I am not even sure if the current implementation of rev-parse
matches what you originally wanted it to do; I suspect it does
not.  I would like to know what was the intended behaviour
first, so that I can enhance it to be usable for my purpose
without breaking things.

What I want the rev-parse flags to mean is as follows.  By "rev
argument", I mean what get_sha1() can understand.  I have to
admit that some flags are what I introduced while I was
butchering it without really knowing the original intention:

  output format:
  --sq		output in a format usable for shell "eval".
  --symbolic	output rev argument in symbolic form, not SHA1.

  output selection:
  --flags	show only arguments with '-' prefix.
  --no-flags	do not show arguments with '-' prefix.

  --revs-only	show only arguments meant for rev-list.
  --no-revs	show arguments not meant for rev-list.

  input munging:
  --default R	if no revision, pretend R is given.
  --not		pretend all rev arguments without prefix ^ have
                prefix ^, and the ones with prefix ^ do not.
  --all		pretend all refs under $GIT_DIR/refs are given
  		on the command line.

  special:
  --verify	make sure only one rev argument is given, nothing else.

I think flags/no-flags and revs-only/no-revs *should* be
orthogonal.  That is, "rev-parse --flags --no-revs" should give
parameters that start with '-' and not meant for rev-list
(e.g. '-C' in earlier example); "rev-parse --revs-only
--merge-order HEAD Documentation/" should yield "--merge-order
HEAD".

Also there is an undocumented --show-prefix.  What is it?

-jc

PS. BTW, any response about unsuspecting companies?
