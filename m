From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revert/cherry-pick: allow the last parameter to be -h
Date: Tue, 22 May 2007 22:52:59 -0700
Message-ID: <7v8xbg5bno.fsf@assigned-by-dhcp.cox.net>
References: <20070522212945.GA8002@diku.dk>
	<20070522221156.GL30871@steel.home>
	<7vwsz07b10.fsf@assigned-by-dhcp.cox.net>
	<20070523053110.GA23971@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed May 23 07:53:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqjmW-00023p-Op
	for gcvg-git@gmane.org; Wed, 23 May 2007 07:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935AbXEWFxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 01:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756236AbXEWFxE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 01:53:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36546 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbXEWFxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 01:53:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523055300.EKMT15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 23 May 2007 01:53:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2Vt01X0061kojtg0000000; Wed, 23 May 2007 01:53:01 -0400
In-Reply-To: <20070523053110.GA23971@diku.dk> (Jonas Fonseca's message of
	"Wed, 23 May 2007 07:31:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48143>

Jonas Fonseca <fonseca@diku.dk> writes:

> Junio C Hamano <junkio@cox.net> wrote Tue, May 22, 2007:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> ...
>> > Why should cherry-pick be different?
>> 
>> Good question.  FYI
>> 
>> 	$ git rev-list --huh?
>> 
>> works equally well ;-)
>
> Because it is different?
>
>    $ git revert --why-must-it-be-so-hard-to-learn-git-sometimes
>    fatal: Cannot find '--why-must-it-be-so-hard-to-learn-git-sometimes'
>
> Because, contrary to git-rev-list, git-revert/cherry-pick is considered
> part of the porcelain?

No, I did not notice it until now but you are right.  The
command line argument parser for these commands is done somewhat
sloppily, compared to others.

How about doing something like this instead?

-- >8 --
Fix command line parameter parser of revert/cherry-pick

The parser was inconsistently done, in that it did not look at
the last command line parameter to see if it could be an unknown
option, although it was designed to notice unknown options if
they were given in positions the command expects to find them
(i.e. everything except the last parameter, which ought to be
<commit-ish>).  This prevented a very natural invocation

	$ git cherry-pick --help

from issuing the usage help.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/builtin-revert.c b/builtin-revert.c
index ea2f15b..80c348c 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -45,8 +45,10 @@ static void parse_options(int argc, const char **argv)
 	if (argc < 2)
 		usage(usage_str);
 
-	for (i = 1; i < argc - 1; i++) {
+	for (i = 1; i < argc; i++) {
 		arg = argv[i];
+		if (arg[0] != '-')
+			break;
 		if (!strcmp(arg, "-n") || !strcmp(arg, "--no-commit"))
 			no_commit = 1;
 		else if (!strcmp(arg, "-e") || !strcmp(arg, "--edit"))
@@ -59,7 +61,8 @@ static void parse_options(int argc, const char **argv)
 		else if (strcmp(arg, "-r"))
 			usage(usage_str);
 	}
-
+	if (i != argc - 1)
+		usage(usage_str);
 	arg = argv[argc - 1];
 	if (get_sha1(arg, sha1))
 		die ("Cannot find '%s'", arg);
