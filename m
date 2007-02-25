From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/8] diff: support reading a file from stdin via "-"
Date: Sun, 25 Feb 2007 15:41:22 -0800
Message-ID: <7virdprejh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702252335410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvehprgl7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702260009530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 00:41:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLSze-0006V0-Op
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 00:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXBYXlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbXBYXlY
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 18:41:24 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57558 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbXBYXlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 18:41:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225234123.RSPA6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 18:41:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TzhN1W00A1kojtg0000000; Sun, 25 Feb 2007 18:41:22 -0500
In-Reply-To: <Pine.LNX.4.63.0702260009530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 26 Feb 2007 00:11:38 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40596>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I see this purely for purposes of --no-index diff. And in that case, we 
> only compare one file pair. Either one of them is from stdin, or it is 
> not. Therefore, if memory gets tight, we cannot compare that file pair 
> anyway, and have to error out.
>
> Maybe I missed something obvious?

I think the responsibility to mark if a path whose name is "-"
is a filesystem object or stdin lies within the option parser.
If the user says "diff - a" or diff a -" then the user clearly
means the stdin, while if the user says "diff ./- a" it is a
path (and the later stages like populate_filespec() would see
canonicalized "-" as the filename).  The point is that the
disambiguation must be done by somebody, and I think the option
parser, who calls get_pathspec(), should be the one that does
it.

So we at least need a bit in diff_options that lets the option
parser to tell the later stages "if you see - in pathspec, the
user means stdin".  And my suggestion was that if you are going
to do that in the option parser anyway, you could read stdin in
the option parser and hang that data in diff_options, and the
presence of that stdin data (pointer being non NULL) can be used
as that signal.

I think the callers of populate_filespec() may need to pass
around diff_options as a parameter for the above to work, but
hopefully that should not be a rocket surgery.
