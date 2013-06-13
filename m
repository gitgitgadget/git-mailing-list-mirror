From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] show-branch: use pager
Date: Thu, 13 Jun 2013 03:01:19 -0400
Message-ID: <20130613070118.GA23235@sigill.intra.peff.net>
References: <1371105811-3112-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 09:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un1XC-0004lq-0T
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 09:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab3FMHBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 03:01:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:43904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757314Ab3FMHBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 03:01:21 -0400
Received: (qmail 8877 invoked by uid 102); 13 Jun 2013 07:02:14 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Jun 2013 02:02:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2013 03:01:19 -0400
Content-Disposition: inline
In-Reply-To: <1371105811-3112-1-git-send-email-oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227701>

On Thu, Jun 13, 2013 at 08:43:31AM +0200, =C3=98ystein Walle wrote:

> This is for consistency with other porcelain commands such as 'log'.

I do not use show-branch myself, but being consistent with the other
porcelain commands makes sense to me.

> I marked this as an RFC because of Jeff King's comments in
> daa0c3d97 where I got the impression this this might not be a good id=
ea.
> However I haven't found any bugs and all the tests pass. It is more a=
 huble
> suggestion than anything but I thought I might as well send it as a p=
atch.

I don't think the problems described in daa0c3d97 should be an issue fo=
r
us, as the purpose of that commit was to delay the color decision until
the last minute. That helps commands which load color config before
having decided on whether to use a pager. In other words, it covers the
exact situation you introduce here:

> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 90fc6b1..bd3e10c 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -683,6 +683,7 @@ int cmd_show_branch(int ac, const char **av, cons=
t char *prefix)
>  	};
> =20
>  	git_config(git_show_branch_config, NULL);
> +	setup_pager();

So I think your patch is fine with respect to those problems.

However, I do not see any need for show_branch to delay its pager setup
at all. Commands like "git diff" and "git log" must do so, because they
do not know whether they want a pager or not until after parsing
command-line arguments. But in this case we are always starting the
pager.

Would it make more sense to just set the USE_PAGER flag in the
"show-branch" entry in git.c (see the "shortlog" entry for an example)?

-Peff
