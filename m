From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Support running an arbitrary git action through checkout
Date: Fri, 10 May 2013 19:00:17 +0200
Message-ID: <20130510170016.GA29848@sigill.intra.peff.net>
References: <2d5cfb3be9487f607051cad3d5230434660307ba.1368198269.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Steve Losh <steve@stevelosh.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 10 19:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaqgD-0003ul-I1
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 19:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392Ab3EJRAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 13:00:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:49558 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575Ab3EJRAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 13:00:21 -0400
Received: (qmail 4912 invoked by uid 102); 10 May 2013 17:00:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 May 2013 12:00:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 May 2013 19:00:17 +0200
Content-Disposition: inline
In-Reply-To: <2d5cfb3be9487f607051cad3d5230434660307ba.1368198269.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223881>

On Fri, May 10, 2013 at 05:06:07PM +0200, Thomas Rast wrote:

> +	if (argc > 1 && !prefixcmp(argv[1], "--")) {
> +		const char *subcommand = argv[1] + 2;
> +		struct cmdnames main_cmds, other_cmds;
> +
> +		memset(&main_cmds, 0, sizeof(main_cmds));
> +		memset(&other_cmds, 0, sizeof(other_cmds));
> +
> +		load_command_list("git-", &main_cmds, &other_cmds);
> +
> +		if (is_in_cmdlist(&main_cmds, subcommand) ||
> +		    is_in_cmdlist(&other_cmds, subcommand)) {
> +			const char **args = xmalloc((argc) * sizeof(char*));
> +			args[0] = subcommand;
> +			memcpy(args+1, argv+2, argc*sizeof(char*));
> +			args[argc] = NULL;

Doesn't this memcpy overflow args, since it is only argc slots long? I
think you want to copy only (argc-1) slots, since you are omitting both
argv[0] as well as the "--subcommand" argument in argv[1]. You can also
drop the setting of NULL, as you will copy the original NULL as the last
item in your memcpy.

Other than that, the patch looks brilliant. :)

-Peff
