From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/16] refactor skip_prefix to return a boolean
Date: Thu, 19 Jun 2014 22:08:24 -0400
Message-ID: <20140620020824.GA31908@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
 <20140618194417.GD22622@sigill.intra.peff.net>
 <CAPig+cTKgrYx1hcO-hV3ZT2sm1rR17bWJC0ktZzFQB=TMr6Xuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 04:08:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxoFj-0002Td-EI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 04:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbaFTCI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 22:08:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:47924 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756312AbaFTCI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 22:08:26 -0400
Received: (qmail 30038 invoked by uid 102); 20 Jun 2014 02:08:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 21:08:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 22:08:24 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTKgrYx1hcO-hV3ZT2sm1rR17bWJC0ktZzFQB=TMr6Xuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252208>

On Thu, Jun 19, 2014 at 09:59:39PM -0400, Eric Sunshine wrote:

> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index b6f03b3..556c839 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -349,13 +349,31 @@ extern void set_die_is_recursing_routine(int (*routine)(void));
> >  extern int starts_with(const char *str, const char *prefix);
> >  extern int ends_with(const char *str, const char *suffix);
> >
> > -static inline const char *skip_prefix(const char *str, const char *prefix)
> > +/*
> > + * If "str" begins with "prefix", return 1. If out is non-NULL,
> > + * it it set to str + strlen(prefix) (i.e., the prefix is skipped).
> 
> The documentation claims that 'out' can be NULL, however, the code
> does not respect this. NULL 'out' seems rather pointless (unless you
> want an alias for starts_with()), so presumably the documentation is
> incorrect.

Thanks for catching. My original version (before I sent to the list) did
allow for a conditional NULL out, but I realized there was exactly one
caller who wanted this, and that they would be better off using
starts_with. I added patch 3 ("avoid using skip_prefix as a boolean")
and stripped the conditional from skip_prefix, but forgot to update the
comment.

I think we'd just want to squash the patch below (I also took the
opportunity to fix a typo and clarify the text a bit):

diff --git a/git-compat-util.h b/git-compat-util.h
index 556c839..1187e1a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -350,8 +350,9 @@ extern int starts_with(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
 
 /*
- * If "str" begins with "prefix", return 1. If out is non-NULL,
- * it it set to str + strlen(prefix) (i.e., the prefix is skipped).
+ * If the string "str" begins with the string found in "prefix", return 1.
+ * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
+ * the string right after the prefix).
  *
  * Otherwise, returns 0 and out is left untouched.
  *

-Peff
