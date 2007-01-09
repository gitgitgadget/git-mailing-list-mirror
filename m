From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-am applies half of a patch
Date: Tue, 9 Jan 2007 08:08:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701090803070.3661@woody.osdl.org>
References: <45A36D6B.4010303@garzik.org> <7vtzz0mpzk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 17:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4JXC-0002Tc-VH
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 17:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbXAIQJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 11:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXAIQJG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 11:09:06 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50147 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179AbXAIQJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 11:09:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l09G8uWi010881
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Jan 2007 08:08:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l09G8s6R008865;
	Tue, 9 Jan 2007 08:08:55 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzz0mpzk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.667 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36371>


Oh well, I should read my whole mbox ..

On Tue, 9 Jan 2007, Junio C Hamano wrote:
>
> ---
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 1c35837..918822b 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -811,7 +811,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
>  			struct fragment dummy;
>  			if (parse_fragment_header(line, len, &dummy) < 0)
>  				continue;
> -			error("patch fragment without header at line %d: %.*s", linenr, (int)len-1, line);
> +			return error("patch fragment without header at line %d: %.*s", linenr, (int)len-1, line);

I don't think this really does anything, Junio.

Yes, it will now return an error value from "find_header()", but that's 
strictly normal: we _always_ get an error value from find_header() at the 
very end of a patch ("there's no more header").

And the caller (parse_chunk()) just ends up returning the error value, and 
the caller of THAT just ends up breaking out of the loop that does the 
patching, ie it does

	..
	while (size > 0) {
		..
		nr = parse_chunk(buffer + offset, size, patch);
		if (nr < 0)
			break;
		..

so you really need to make the "return error(..)" thing be a "die()" 
instead.

Alternatively, you could just say that _any_ garbage at the end of a patch 
is fatal, and make apply_patch() just die on a negative error from 
parse_chunk(), but garbage at the end of a patch is strictly normal 
(things like signatures or just even empty lines), so that wouldn't really 
work either.

In other words, I really don't think your patch does anything (except if 
the garbage is at the BEGINNING of a patch), and that you should take mine 
instead.

But test it.

		Linus
