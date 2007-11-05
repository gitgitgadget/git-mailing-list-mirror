From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] Enhance --early-output format
Date: Mon, 05 Nov 2007 12:24:10 -0800
Message-ID: <7vsl3kphjp.fsf@gitster.siamese.dyndns.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	<18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 21:24:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip8Ur-0006m8-FV
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 21:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbXKEUYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 15:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbXKEUYT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 15:24:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33428 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbXKEUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 15:24:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D4E4D2EF;
	Mon,  5 Nov 2007 15:24:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C3D6F92881;
	Mon,  5 Nov 2007 15:24:33 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 4 Nov 2007 12:12:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63547>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It wasn't totally trivial, but it doesn't seem to be excessively subtle 
> either. About half the patch is moving around some code to look at whether 
> the commit is interesting or not and rewriting the parents, so that it can 
> be shared with the revision walker.

Very nicely done.

> +	while (list) {
> +		struct commit *commit = list->item;
> +		unsigned int flags = commit->object.flags;
> +
> +		list = list->next;
> +		if (flags & UNINTERESTING)
> +			continue;
> +		if (rev->prune_fn && rev->dense && !(flags & TREECHANGE)) {
> +			if (commit->parents && !commit->parents->next)
> +				continue;
> +		}

When looking at:

	if (A && B && C) {
        	if (D && E)
                	continue;
	}

an uninitiated might say "Huh?  Why use nested 'if'?", but to
somebody who knows how revision traversal works, the above split
is a more logical way to test this condition.  Maybe one liner
comment is in order?

> +static void show_early_header(struct rev_info *rev, const char *stage, int nr)
> +{
> +	if (rev->shown_one) {
> +		rev->shown_one = 0;
> +		if (rev->commit_format != CMIT_FMT_ONELINE)
> +			putchar(rev->diffopt.line_termination);
> +	}
> +	printf("Final output: %d %s\n", nr, stage);
> +}

As you noted, this is more like "Partial output" now.
How about painting the bikeshed pink by saying:

	Partial output: 20
        Partial output: 70
        Final output: 70000

> +	/* Did we already get enough commits for the early output? */
> +	if (!i)
> +		return;
> +
> +	/*
> +	 * ..if no, then repeat it twice a second until we
> +	 * do.
> +	 *
> +	 * NOTE! We don't use "it_interval", because if the
> +	 * reader isn't listening, we want our output to be
> +	 * throttled by the writing, and not have the timer
> +	 * trigger every second even if we're blocked on a
> +	 * reader!
> +	 */

A comment like this is very much appreciated.

> +	early_output_timer.it_value.tv_sec = 0;
> +	early_output_timer.it_value.tv_usec = 500000;
> +	setitimer(ITIMER_REAL, &early_output_timer, NULL);
>  }
