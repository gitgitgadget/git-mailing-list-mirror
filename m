From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Sanity-ckeck config variable names
Date: Thu, 20 Jan 2011 19:06:29 -0500
Message-ID: <20110121000629.GA7773@sigill.intra.peff.net>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz>
 <20110119141112.GD8034@fm.suse.cz>
 <20110120232232.GA9442@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 21 01:06:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4WT-0002dS-JZ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 01:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab1AUAGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 19:06:32 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54518 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913Ab1AUAGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 19:06:32 -0500
Received: (qmail 15177 invoked by uid 111); 21 Jan 2011 00:06:31 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 00:06:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jan 2011 19:06:29 -0500
Content-Disposition: inline
In-Reply-To: <20110120232232.GA9442@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165349>

On Thu, Jan 20, 2011 at 06:22:32PM -0500, Jeff King wrote:

> Other than that, the code looks OK to me.

Actually, I take this back.

Doesn't this hunk:

> @@ -168,10 +167,6 @@ static int get_value(const char *key_, const char *regex_)
>       }
>  
>       key = xstrdup(key_);
> -     for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
> -             *tl = tolower(*tl);
> -     for (tl=key; *tl && *tl != '.'; ++tl)
> -             *tl = tolower(*tl);

Mean that regexp keys no longer get downcased properly? I.e.,

  git config Foo.value true
  git config --get-regexp 'foo.*'
  git config --get-regexp 'Foo.*'

used to work for both lookups, but now fails for the second one?

The problem is that your git_config_parse_key handles the downcasing for
the non-regexp case, but it is not called (for obvious reasons) in the
regexp case.

-Peff
