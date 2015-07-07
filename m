From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Tue, 7 Jul 2015 16:48:37 -0400
Message-ID: <20150707204837.GA15483@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165501.GB23503@peff.net>
 <xmqqbnfn3dsb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:48:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCZnJ-0007rX-FL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 22:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbbGGUsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 16:48:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:57114 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932704AbbGGUsk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 16:48:40 -0400
Received: (qmail 11055 invoked by uid 102); 7 Jul 2015 20:48:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 15:48:40 -0500
Received: (qmail 13315 invoked by uid 107); 7 Jul 2015 20:48:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 16:48:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2015 16:48:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnfn3dsb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273600>

On Tue, Jul 07, 2015 at 01:37:08PM -0700, Junio C Hamano wrote:

> >   3. Provide a wrapper that generates the correct struct on
> >      the fly. The big downside is that we end up pointing to
> >      a single global, which makes our wrapper non-reentrant.
> >      But show_date is already not reentrant, so it does not
> >      matter.
> >
> > This patch implements 3, along with a minor macro to keep
> > the size of the callers sane.
> 
> Another big downside is that DATE_NORMAL is defined to be "0".
> 
> This makes it very cumbersome to merge a side branch that uses an
> outdated definition of show_date() and its friends and tell them
> to show date normally.  The compiler does not help detecting
> places that need to be adjusted during merge and instead just pass
> a NULL pointer as a pointer to the new struct.

My assumption was that using the raw "0" is something we would frowned
upon in new code. There was a single historical instance that I fixed in
the series, but I wouldn't expect new ones (and actually, that instance
was "1", which would be caught by the compiler).

However, if you're concerned, I think we could have show_date massage a
NULL date, like:

diff --git a/date.c b/date.c
index 8f91569..a04d089 100644
--- a/date.c
+++ b/date.c
@@ -173,6 +173,10 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
+	static const struct fallback_mode = { DATE_NORMAL };
+
+	if (!mode)
+		mode = &fallback_mode;
 
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);


That would also allow people to explicitly call:

  show_date(t, tz, NULL);

to get the default format, though I personally prefer spelling it out.

I guess we _could_ introduce:

  #define DATE_MODE(x) ((struct date_mode *)(x))

and then take any numeric value, under the assumption that the first
page of memory will never be a valid pointer:

diff --git a/date.c b/date.c
index 8f91569..f388fee 100644
--- a/date.c
+++ b/date.c
@@ -173,6 +173,18 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
+	struct date_mode fallback;
+
+	/* hysterical compatibility */
+	if (mode < 1024) {
+		if (mode == DATE_STRFTIME)
+			die("BUG: nice try");
+		fallback.type = mode;
+		mode = &fallback;
+	}
+
+	if (!mode)
+		mode = &fallback_mode;
 
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);

That's kind of nasty, but at least it's hidden from the callers.

-Peff
