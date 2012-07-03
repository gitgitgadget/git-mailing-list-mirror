From: Jeff King <peff@peff.net>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Mon, 2 Jul 2012 23:45:03 -0400
Message-ID: <20120703032345.GA7143@sigill.intra.peff.net>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net>
 <m2vci5n5r5.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 05:45:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slu3A-0001x5-SV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 05:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab2GCDpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 23:45:07 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51989
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489Ab2GCDpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 23:45:06 -0400
Received: (qmail 16790 invoked by uid 107); 3 Jul 2012 03:45:13 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jul 2012 23:45:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2012 23:45:03 -0400
Content-Disposition: inline
In-Reply-To: <m2vci5n5r5.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200894>

On Tue, Jul 03, 2012 at 12:43:42AM +0200, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's very odd for pread to report ENOENT (since it is always operating
> > on an already-opened file descriptor).
> 
> It doesn't, but gettext will clobber errno:
> 
> 		n = pread(pack_fd, inbuf, n, from);
> 		if (n < 0)
> 			die_errno(_("cannot pread pack file"));
> 
> There is nothing that saves errno.  This isn't limited to i18n though,
> any function call in the arguments may potentially clobber errno.

That's horribly lame of gettext. I don't expect arbitrary functions to
save errno, but when the entire purpose of a function is to be a
non-intrusive wrapper to massage messages to the user, it seems kind of
evil to overwrite errno. Isn't the whole point of calling it "_" that
you don't want to or have to notice it?

Can we do something like this to get around it?

diff --git a/gettext.h b/gettext.h
index 57ba8bb..b7c3ae5 100644
--- a/gettext.h
+++ b/gettext.h
@@ -44,7 +44,10 @@ extern int use_gettext_poison(void);
 
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+	int saved_errno = errno;
+	const char *r = use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+	errno = saved_errno;
+	return r;
 }
 
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
