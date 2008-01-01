From: Jeff King <peff@peff.net>
Subject: Re: git config problem with strange config files
Date: Tue, 1 Jan 2008 01:23:14 -0500
Message-ID: <20080101062314.GA21555@coredump.intra.peff.net>
References: <200712311847.41499.kumbayo84@arcor.de> <20080101061734.GA15453@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 07:23:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9aXU-00028Y-AK
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 07:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYAAGXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 01:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYAAGXR
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 01:23:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1475 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbYAAGXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 01:23:17 -0500
Received: (qmail 5195 invoked by uid 111); 1 Jan 2008 06:23:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 01 Jan 2008 01:23:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jan 2008 01:23:14 -0500
Content-Disposition: inline
In-Reply-To: <20080101061734.GA15453@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69428>

On Tue, Jan 01, 2008 at 01:17:34AM -0500, Jeff King wrote:

> @@ -118,7 +119,7 @@ static int get_value(config_fn_t fn, char *name, unsigned int len)
>  	/* Get the full name */
>  	for (;;) {
>  		c = get_next_char();
> -		if (c == EOF)
> +		if (config_file_eof)
>  			break;
>  		if (!iskeychar(c))
>  			break;
> @@ -182,7 +183,7 @@ static int get_base_var(char *name)
>  
>  	for (;;) {
>  		int c = get_next_char();
> -		if (c == EOF)
> +		if (config_file_eof)
>  			return -1;
>  		if (c == ']')
>  			return baselen;

In these two hunks, we now check the eof flag correctly, which follows
through on the intent of the original code. But if you look carefully at
get_next_char(), it _never_ returns EOF in the first place; it replaces
it with '\n' and sets an external flag. So this 'if' branch was never
reached, but happened to work because the returned newline triggers a
similar effect.

By actually looking at the flag, I am implementing the original intent,
but it is a potential behavior change (I don't _think_ it should matter,
and it passes all of the config tests, but I haven't looked carefully at
all the ramifications). So it might be simpler yet to just eliminate
that conditional return.

-Peff
