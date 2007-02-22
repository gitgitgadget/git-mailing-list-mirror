From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-diff{,-files} the new option `--no-index`
Date: Thu, 22 Feb 2007 21:01:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222051490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz36f1bv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:02:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKK8m-0008Eh-2E
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbXBVUCE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbXBVUCE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:02:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:35261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751810AbXBVUCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:02:01 -0500
Received: (qmail invoked by alias); 22 Feb 2007 20:02:00 -0000
X-Provags-ID: V01U2FsdGVkX1/6Aesv97f6hTzOQc5/UjyjUXIkOLl4tCQ7jPDYl/
	vQ2Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz36f1bv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40375>

Hi,

On Thu, 22 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Can't they made to call a new function, which has the option
> >> parsing followed by the switch between magic max_count==-2
> >> codepath and run_diff_files()?
> >
> > How about adding "int always_use_index" to the signature of 
> > run_diff_files()?
> 
> The "magic" part is not about the index at all (it is about
> using only that magic part to do diff on filesystem), and the
> original code is about "index vs filesystem".

I don't understand. diff-files until --no-index _always_ diffed against 
the index. Now, if "allow_no_index" is non-zero, under very special 
circumstances diff-files does the DWIMery.

> I would rather keep them in separate function.  That is:
> 
> 	run_diff_files(); /* compares index vs filesystem */
>                 
> 	run_diff_filesystem(); /* runs diff2 */
> 
>         run_diff_files_cmd() {
>              	/* a new helper */
> 		parse args;
> 		if (magic)
>                 	run_diff_filesystem();
> 		else
>                 	run_diff_files();
> 	}
> 
> 	builtin_diff() {
>         	if (not about two trees nor two blobs ...)
>                 	run_diff_files_cmd();
> 		else if (about two trees)
>                 	run_diff_tree();
> 		else if (about tree and index)
>                 	run_diff_index();
> 	}
> 
>         wt_status() {
>         	run_diff_files();
>                 run_diff_index();
> 	}

So you mean only add run_diff_files_cmd(), called by diff and diff-files?

> For one thing, I want to move read_cache() out of run_diff_files() and 
> run_diff_index() to their callers, so that the caller can use a 
> handcrafted active_cache[] that is somewhat different from what 
> read_cache() originally read.

I don't understand. Would it not be easier to "return active_nr" in 
read_cache_from(path) _also_ when active_cache is set? Or alternatively 
check if active_alloc is set?

Ciao,
Dscho
