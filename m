From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 8 Mar 2007 08:37:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPLcn-0004Wf-Bq
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 17:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbXCHQht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 11:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbXCHQht
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 11:37:49 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51666 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbXCHQhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 11:37:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l28Gbjq8005231
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Mar 2007 08:37:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l28GbiGq031920;
	Thu, 8 Mar 2007 08:37:45 -0800
In-Reply-To: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.488 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41755>



On Thu, 8 Mar 2007, Junio C Hamano wrote:
> 
> Not so.  "git shortlog" acts as a filter when no revs are given,
> unlike "git log" which defaults to HEAD.  It was reading from
> its standard input.

Could we just change that?

There aren't *that* many users of "git shortlog", I bet, and I'm not sure 
the "filter mode" is really worth it, especially since it ends up being 
confusing once you get used to using it as just another "git log" variant.

It was a filter not really because people wanted a filter, but for 
historical reasons, and because it wasn't really able to do things on its 
own, and it was just an external script...

Yeah, as a filter it *can* stil lbe useful, of course, but I suspect the 
usefullness is limited.

> +	if (rev.pending.nr == 0) {
> +		if (isatty(0))
> +			fprintf(stderr, "(reading log to summarize from standard input)\n");

Sure, this probably gets some cases (and the one you tried in particular), 
but if you pipe the output to a pager, I doubt it's actually all that 
useful.

To simulate a "wait a long time without output" case, try this:

	( echo "Important warning" >&2 ; sleep 10) | less -S

and at least for me, I don't see squat _in_case_I'm_at_the_top_ of the 
window, simply because "less" will clear the screen for me.

In other words, putting warnings on stderr usually isn't all that useful 
when you have something like a pager that will do tty stuff - it will 
easily overwrite the warning so quickly that you'll never see it at all.

So I think your patch is an improvement, but I suspect it would be a 
bigger improvement to just make "git shortlog" work as "git log". If we 
want to support the filtering mode, we could just make it be a separate 
command ("git shortlog-filter") instead?

			Linus
