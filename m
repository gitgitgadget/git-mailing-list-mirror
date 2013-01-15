From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 06/14] imap-send.c: remove some unused fields from
 struct store
Date: Tue, 15 Jan 2013 12:32:04 -0800
Message-ID: <20130115203204.GA12524@google.com>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
 <1358237193-8887-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:32:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvDBV-00083n-FG
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab3AOUcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 15:32:15 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:46023 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab3AOUcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 15:32:12 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so265158pbc.9
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+pkf8gQr5fOagavvCY8zIoum2xljdk/XY+be+RXc7n0=;
        b=F2zKcKbhODs2FRqjasHpgPQZkhuv5h2lNLh+TnyotwC8aul2cTYr9JWj+V5KgJNGvw
         IK/cFS3VbQivc8LV8oo8n6yp+XpWJ8xGdnG57F5ZakqpDTAipoQZkeBFHKHg7U6QEqKp
         agw2sXCZPvR/OeCzkbRLA6tX7eAHwBjthYAZnZ1VGBO6LkKQcvgIoLb6BTuSlZDtccOp
         pl8nFYio8+MqaJ1vWjMbb4UHstW6JNA1QLlWSxOFpsNhcVTbxPCjJCAIu3DV6ZSofeId
         Av//yiSrgtTM9eMbhVuBla+V0KQGizpxnuVDH+5dMijjeR4hGWrd4+AzaCaw8zXyr9uV
         qm0A==
X-Received: by 10.68.204.103 with SMTP id kx7mr269973034pbc.33.1358281931929;
        Tue, 15 Jan 2013 12:32:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id kl5sm10782289pbc.74.2013.01.15.12.32.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 12:32:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358237193-8887-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213672>

Michael Haggerty wrote:

> -			else if ((arg1 = next_arg(&cmd))) {
> -				if (!strcmp("EXISTS", arg1))
> -					ctx->gen.count = atoi(arg);
> -				else if (!strcmp("RECENT", arg1))
> -					ctx->gen.recent = atoi(arg);
> +			} else if ((arg1 = next_arg(&cmd))) {
> +				/* unused */

The above is just the right thing to do to ensure no behavior change.
Let's take a look at the resulting code, though:

			if (... various reasonable things ...) {
				...
			} else if ((arg1 = next_arg(&cmd))) {
				/* unused */
			} else {
				fprintf(stderr, "IMAP error: unable to parse untagged response\n");
				return RESP_BAD;

Anyone forced by some bug to examine this "/* unused */" case is going
to have no clue what's going on.  In that respect, the old code was
much better, since it at least made it clear that one case where this
code gets hit is handling "<num> EXISTS" and "<num> RECENT" untagged
responses.

I suspect that original code did not have an implicit and intended
missing

				else
					; /* negligible response; ignore it */

but the intent was rather 

				else {
					fprintf(stderr, "IMAP error: I can't parse this\n");
					return RESP_BAD;
				}

Since actually fixing that is probably too aggressive for this patch,
how about a FIXME comment like the following?

		/*
		 * Unhandled response-data with at least two words.
		 * Ignore it.
		 *
		 * NEEDSWORK: Previously this case handled '<num> EXISTS'
		 * and '<num> RECENT' but as a probably-unintended side
		 * effect it ignores other unrecognized two-word
		 * responses.  imap-send doesn't ever try to read
		 * messages or mailboxes these days, so consider
		 * eliminating this case.
		 */
