From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] config: Add hashtable for config parsing &
 retrieval
Date: Tue, 17 Jun 2014 01:46:45 -0400
Message-ID: <20140617054645.GD29957@sigill.intra.peff.net>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
 <1402907232-24629-3-git-send-email-tanayabh@gmail.com>
 <20140617053436.GB29957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 07:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwmEN-00046W-6r
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 07:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbaFQFqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 01:46:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:45817 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbaFQFqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 01:46:46 -0400
Received: (qmail 11259 invoked by uid 102); 17 Jun 2014 05:46:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 00:46:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 01:46:45 -0400
Content-Disposition: inline
In-Reply-To: <20140617053436.GB29957@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251845>

On Tue, Jun 17, 2014 at 01:34:36AM -0400, Jeff King wrote:

> You need some mechanism to store entries that are NULL. It may be enough
> to silently convert them into the string "true" inside the cached
> storage. But there may be callers who treat NULL specially (e.g., a
> tri-state true/false/auto that treats a bare boolean as "auto"); you'd
> need to check.
> 
> The other alternative is to use something besides string_list that can
> handle a NULL.  You may also need to give some thought to how such NULLs
> would be handled by git_config_get_string() (since a NULL there also
> means "not found").

After reading your other patch and thinking about config_error_nonbool,
I don't think it would be right to silently convert this to "true".

E.g., imagine config like:

  [alias]
  foo

If we interpret alias.foo as a boolean, it means "true". But since
alias.* variables are not booleans, the current alias code will produce
an error (with config_error_nonbool). Silently converting it to true in
the config layer would mean the alias code sees only "true", and rather
than generating an error, it would run the command "true".

-Peff
