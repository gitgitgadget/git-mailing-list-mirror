From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Teach builtin-add to pass multiple paths to
	git-add--interactive
Date: Thu, 22 Nov 2007 04:08:28 -0500
Message-ID: <20071122090828.GC7153@sigill.intra.peff.net>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <1195689773-28601-1-git-send-email-win@wincent.com> <1195689773-28601-2-git-send-email-win@wincent.com> <1195689773-28601-3-git-send-email-win@wincent.com> <1195689773-28601-4-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:08:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv83G-0000vl-IM
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbXKVJId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbXKVJIc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:08:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbXKVJIb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:08:31 -0500
Received: (qmail 20984 invoked by uid 111); 22 Nov 2007 09:08:29 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 04:08:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 04:08:28 -0500
Content-Disposition: inline
In-Reply-To: <1195689773-28601-4-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65760>

On Thu, Nov 22, 2007 at 01:02:52AM +0100, Wincent Colaiuta wrote:

> -int interactive_add(const char *path)
> +int interactive_add(const char **argv, int argc)
>  {
> -	const char *argv[3] = { "add--interactive", path, NULL };
> -
> -	return run_command_v_opt(argv, RUN_GIT_CMD);
> +	int status;
> +	const char **args = xmalloc(sizeof(const char *) * (argc + 1));
> +	args[0] = "add--interactive";
> +	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * argc);

The source for the memcpy (argv) is sometimes NULL. The standard forbids
this, even when the size field is 0. I have no idea if any reasonable
implementations actually care.

But...

> +		if (argc > 0)
> +			exit(interactive_add(argv, argc));
>  		else
> -			exit(interactive_add(NULL));
> +			exit(interactive_add(NULL, 0));

There really is no reason to pass NULL at all (since the argc limits us
anyway), so we can just get rid of the conditional and simplify to:

  exit(interactive_add(argv, argc));

for both cases.

-Peff
