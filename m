From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] branch_get: provide per-branch pushremote pointers
Date: Wed, 8 Jan 2014 05:27:07 -0500
Message-ID: <20140108102707.GA23145@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093531.GD15720@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 11:27:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0qLz-0002Og-PL
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 11:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbaAHK1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 05:27:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:57129 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755084AbaAHK1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 05:27:09 -0500
Received: (qmail 32679 invoked by uid 102); 8 Jan 2014 10:27:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 04:27:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 05:27:07 -0500
Content-Disposition: inline
In-Reply-To: <20140108093531.GD15720@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240205>

On Wed, Jan 08, 2014 at 04:35:31AM -0500, Jeff King wrote:

> @@ -385,8 +387,11 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	name = key + 7;
>  
>  	/* Handle remote.* variables */
> -	if (!strcmp(name, "pushdefault"))
> -		return git_config_string(&pushremote_name, key, value);
> +	if (!strcmp(name, "pushdefault")) {
> +		if (git_config_string(&pushremote_config_default, key, value) < 0)
> +			return -1;
> +		pushremote_name = pushremote_config_default;
> +	}

This needs "return 0" squashed in at the end of the conditional, of
course, to match the old behavior.

This patch passes the test suite by itself (with or without that fixup).
But oddly, it seems to fail t5531 when merged with 'next'. I can't
figure out why, though. It shouldn't affect any code that doesn't look
at branch->pushremote.

-Peff
