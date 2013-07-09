From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] describe: use argv-array
Date: Tue, 9 Jul 2013 00:51:51 -0400
Message-ID: <20130709045151.GE27903@sigill.intra.peff.net>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
 <1373236424-25617-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 06:52:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwPuP-0002kp-On
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 06:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672Ab3GIEvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 00:51:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:35451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab3GIEvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 00:51:54 -0400
Received: (qmail 2821 invoked by uid 102); 9 Jul 2013 04:53:09 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 23:53:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 00:51:51 -0400
Content-Disposition: inline
In-Reply-To: <1373236424-25617-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229908>

On Sun, Jul 07, 2013 at 03:33:43PM -0700, Junio C Hamano wrote:

> +		argv_array_init(&args);
> +		argv_array_push(&args, "name-rev");
> +		argv_array_push(&args, "--name-only");
> +		argv_array_push(&args, "--no-undefined");
> [...]
> -		memcpy(args + i, argv, argc * sizeof(char *));
> -		args[i + argc] = NULL;
> -		return cmd_name_rev(i + argc, args, prefix);
> +		return cmd_name_rev(args.argc, args.argv, prefix);

This leaks the memory allocated by "args". The original did, too, and it
is probably not that big a deal (we exit right after anyway). The fix
would be something like:

  rc = cmd_name_rev(args.argc, args.argv, prefix);
  argv_array_clear(&args);
  return rc;

-Peff
