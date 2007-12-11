From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 01:39:41 -0500
Message-ID: <20071211063941.GB21718@coredump.intra.peff.net>
References: <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org> <7vzlwhhli5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:40:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yml-0002cO-5a
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbXLKGjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbXLKGjp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:39:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3293 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbXLKGjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:39:44 -0500
Received: (qmail 6730 invoked by uid 111); 11 Dec 2007 06:39:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 01:39:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 01:39:41 -0500
Content-Disposition: inline
In-Reply-To: <7vzlwhhli5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67805>

On Mon, Dec 10, 2007 at 09:02:26PM -0800, Junio C Hamano wrote:

> [PATCH] commit: do not add extra LF at the end of the summary.
> 
> The scripted version relied on the nice "auto-strip the terminating LF"
> behaviour shell gives to "var=$(cmd)" construct, but we have to roll
> that ourselves.

This looks reasonable and generates the correct output as far as I can
tell, but...

> -	log_tree_commit(&rev, commit);
> -	printf("\n");
> +	if (!log_tree_commit(&rev, commit)) {
> +		struct strbuf buf = STRBUF_INIT;
> +		pretty_print_commit(rev.commit_format, commit, &buf,
> +				    0, NULL, NULL, 0, 0);
> +		printf("%s\n", buf.buf);
> +		strbuf_release(&buf);
> +	}

We are duplicating the "!shown && ..." conditional branch from
log_tree_commit, which calls show_log. Why are we not calling show_log
instead of pretty_print_commit (I understand that show_log should end up
calling pretty_print_commit, but it is not immediately obvious that all
of the extra code in show_log is going to be ignored).

-Peff
