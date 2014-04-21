From: Jeff King <peff@peff.net>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Mon, 21 Apr 2014 16:24:54 -0400
Message-ID: <20140421202454.GA6062@sigill.intra.peff.net>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sitaramc@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 22:25:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcKly-0004h3-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbaDUUY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:24:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:35565 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750891AbaDUUY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:24:56 -0400
Received: (qmail 8364 invoked by uid 102); 21 Apr 2014 20:24:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Apr 2014 15:24:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Apr 2014 16:24:54 -0400
Content-Disposition: inline
In-Reply-To: <1398107248-32140-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246631>

On Mon, Apr 21, 2014 at 03:07:28PM -0400, Richard Hansen wrote:

> Both bash and zsh subject the value of PS1 to parameter expansion,
> command substitution, and arithmetic expansion.  Rather than include
> the raw, unescaped branch name in PS1 when running in two- or
> three-argument mode, construct PS1 to reference a variable that holds
> the branch name.  Because the shells do not recursively expand, this
> avoids arbitrary code execution by specially-crafted branch names such
> as '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)'.

Cute. We already disallow quite a few characters in refnames (including
space, as you probably discovered), and generally enforce that during
ref transfer. I wonder if we should tighten that more as a precuation.
It would be backwards-incompatible, but I wonder if things like "$" and
";" in refnames are actually useful to people.

Did you look into similar exploits with completion? That's probably
slightly less dire (this one hits you as soon as you "cd" into a
malicious clone, whereas completion problems require you to actually hit
<tab>). I'm fairly sure that we miss some quoting on pathnames, for
example. That can lead to bogus completion, but I'm not sure offhand if
it can lead to execution.

-Peff
