From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config.c: change the function signature of
 `git_config_string()`
Date: Tue, 22 Jul 2014 07:07:20 -0400
Message-ID: <20140722110720.GA386@peff.net>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:07:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Xut-0006SN-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 13:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbaGVLHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 07:07:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:38145 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752303AbaGVLHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 07:07:22 -0400
Received: (qmail 24458 invoked by uid 102); 22 Jul 2014 11:07:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Jul 2014 06:07:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2014 07:07:20 -0400
Content-Disposition: inline
In-Reply-To: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254012>

On Tue, Jul 22, 2014 at 03:49:56AM -0700, Tanay Abhra wrote:

> `git_config_string()` output parameter `dest` is declared as a const
> which is unnecessary as the caller of the function is given a strduped
> string which can be modified without causing any harm.
> 
> Thus, remove the const from the function signature.

You are correct that it is unnecessary. However, this patch alone is not
sufficient because of the way const-ness in C works. If I have:

  static const char *some_global;

then with your patch, calling:

  git_config_string(&some_global, var, value);

will complain that we are passing a pointer to "const char *", not a
pointer to "char *". And indeed, compiling with your patch introduces a
ton of compiler warnings.

We would have to convert each of the variables we pass to it to:

  static char *some_global;

That's not so bad, but:

  static char *some_global = "some_default_value";

is wrong. Such a global sometimes points to const storage (i.e.,
initially), and sometimes to allocated storage (if it was loaded from
config). We simply keep the latter as a const pointer (since we would
not bother to free it at the end of the program anyway), and that
decision influences git_config_string, which is just a helper for
setting such variables anyway.

So I would not mind lifting this unnecessary restriction on
git_config_string, but I do not see a way to do it without making the
rest of the code much uglier (and I do not see a particular advantage in
modifying git_config_string here that would make it worth the trouble).

-Peff
