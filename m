From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Output a warning about stale files in the index
Date: Mon, 06 Aug 2007 23:46:30 -0700
Message-ID: <7vbqdj9709.fsf@assigned-by-dhcp.cox.net>
References: <46B80993.3080409@midwinter.com>
	<20070807063523.GA29617@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIIqv-0001VE-KG
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbXHGGqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 02:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755860AbXHGGqn
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:46:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46618 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbXHGGqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 02:46:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807064632.GKRJ26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 7 Aug 2007 02:46:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YumX1X0061kojtg0000000; Tue, 07 Aug 2007 02:46:31 -0400
In-Reply-To: <20070807063523.GA29617@midwinter.com> (Steven Grimm's message of
	"Mon, 6 Aug 2007 23:35:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55227>

Steven Grimm <koreth@midwinter.com> writes:

> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
> 	This is based on (and includes) Junio's patch. This should
> 	hopefully address the "I want to know when my index is very
> 	stale" problem with both his original patch and mine.
>
> 	If we are running a pager, I output the warning to standard
> 	output so it doesn't get immediately scrolled off the screen by
> 	the paged diff output. Otherwise I output to standard error
> 	which is really the more appropriate place for the warning.
> 	Obviously that is no good if the user is running his own pager,
> 	but I'm not sure how to detect that and not cause problems for
> 	diffs that are piped into other programs.

Hmph.  One way to avoid causing problems for diffs that are
piped into other programs and still give the "index of sync"
warning is to emit "diff --git" line and no patch body fot
textual diffs, or 0{40} SHA-1 on the right hand side for --raw
format diffs.

Jokes aside...

For textual diffs, I think we can always spit out the warning
message at the beginning of at the end on the standard output
without harming any of the patch based toolchain.

So how about...

 - If and only if the output format asks for textual diff
   (DIFF_FORMAT_PATCH), we do this "stat-dirty-removal";
   otherwise we do not spend extra cycles and keep the current
   behaviour.

 - At the end of patch text, show "stat-dirty-removal" warning
   on stdout.
