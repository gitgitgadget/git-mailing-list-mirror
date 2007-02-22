From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-diff{,-files} the new option `--no-index`
Date: Thu, 22 Feb 2007 11:18:28 -0800
Message-ID: <7vmz36f1bv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 20:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKJSd-0006X4-Tk
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 20:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXBVTSa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 14:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbXBVTSa
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 14:18:30 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37057 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbXBVTS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 14:18:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222191829.GPVV233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 14:18:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SjJU1W00W1kojtg0000000; Thu, 22 Feb 2007 14:18:29 -0500
In-Reply-To: <Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Feb 2007 19:27:15 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40372>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Can't they made to call a new function, which has the option
>> parsing followed by the switch between magic max_count==-2
>> codepath and run_diff_files()?
>
> How about adding "int always_use_index" to the signature of 
> run_diff_files()?

The "magic" part is not about the index at all (it is about
using only that magic part to do diff on filesystem), and the
original code is about "index vs filesystem".  I would rather
keep them in separate function.  That is:

	run_diff_files(); /* compares index vs filesystem */
                
	run_diff_filesystem(); /* runs diff2 */

        run_diff_files_cmd() {
             	/* a new helper */
		parse args;
		if (magic)
                	run_diff_filesystem();
		else
                	run_diff_files();
	}

	builtin_diff() {
        	if (not about two trees nor two blobs ...)
                	run_diff_files_cmd();
		else if (about two trees)
                	run_diff_tree();
		else if (about tree and index)
                	run_diff_index();
	}

        wt_status() {
        	run_diff_files();
                run_diff_index();
	}

For one thing, I want to move read_cache() out of
run_diff_files() and run_diff_index() to their callers, so that
the caller can use a handcrafted active_cache[] that is somewhat
different from what read_cache() originally read.
