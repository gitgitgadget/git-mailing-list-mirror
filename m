From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 1 Feb 2012 03:20:05 -0500
Message-ID: <20120201082005.GA32348@sigill.intra.peff.net>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
 <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 09:20:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsVQS-00024Z-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 09:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab2BAIUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 03:20:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52050
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793Ab2BAIUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 03:20:08 -0500
Received: (qmail 7456 invoked by uid 107); 1 Feb 2012 08:27:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 03:27:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 03:20:05 -0500
Content-Disposition: inline
In-Reply-To: <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189502>

On Wed, Feb 01, 2012 at 12:01:41AM -0800, Junio C Hamano wrote:

> > So if this was all spelled:
> >
> >   $ cat .gitattributes
> >   *.pdf filetype=pdf
> >   $ cat .git/config
> >   [filetype "pdf"]
> >           binary = true
> >           textconv = pdf2txt
> >
> > I think it would be a no-brainer that those type attributes should apply
> > to "git grep".
> 
> I think this discussion has, instead of forking into two equally
> interesting subthreads, veered to a more intellectually stimulating
> tangent and we ended up losing focus.

That's what I'm here for.

> Regardless of what to do with "I do not want to grep in these types of
> files" and "I want textconv applied when grepping in these types", which
> would be new attributes to implement two new features, I would like to see
> us first concentrate on fixing the "binary" issue.  When somebody tells us
> "Your autodetection may screw it up, but this file is binary; just show
> 'Binary files differ.' when comparing." with "-diff" (or "binary"), we
> should honor that when "git grep" decides if it should take the 'Binary
> file matches' codepath.  We currently do not, and it clearly is a bug.

Right. It may have been lost in the verbosity of what I wrote in my
previous email, but I completely agree. With the caveat that one should
also respect "diff=foo" coupled with "diff.foo.binary = true" as making
something binary. But that is already handled transparently by the
userdiff.[ch] code (which seems like the obvious entry point for
grep to use for attribute lookup, and which we already use there for
funcname lookup).

The trivial-ish patch is below.

> We should have to teach the underlying machinery that matches pathspec
> about negative pathspec entries only once. After we have done so, all the
> callers, not just "git grep", should be able to take advantage of the
> change by just learning to place negative pathspec entries in the "struct
> pathspec" they pass to the machinery.  Doing anything else will lead to
> madness of adding ad-hoc "here we should further filter with the other
> negative 'struct pathspec'" in each and every application.

Yes, I agree.

> But I suspect that it would not materialize anytime soon.  And I also
> suspect that the correct handling of 'Binary file matches', which is a
> pure bugfix, should solve the original issue started these threads 90% in
> practice.

Also agree. Let's fix the bug and then give it some time to see whether
people really want more explicit exclusions.

Here's the bug-fix patch. Not quite ready for inclusion, as it obviously
needs tests and a commit message. Also, we can cache the result of the
userdiff lookup so the funcname code doesn't have to look it up again.

---
diff --git a/grep.c b/grep.c
index b29d09c..d7ab054 100644
--- a/grep.c
+++ b/grep.c
@@ -960,6 +960,15 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
+static int grep_buffer_is_binary(const char *path,
+				 char *buf, unsigned long size)
+{
+	struct userdiff_driver *drv = userdiff_find_by_path(path);
+	if (drv && drv->binary != -1)
+		return drv->binary;
+	return buffer_is_binary(buf, size);
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
@@ -994,11 +1003,11 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
-		if (buffer_is_binary(buf, size))
+		if (grep_buffer_is_binary(name, buf, size))
 			binary_match_only = 1;
 		break;
 	case GREP_BINARY_NOMATCH:
-		if (buffer_is_binary(buf, size))
+		if (grep_buffer_is_binary(name, buf, size))
 			return 0; /* Assume unmatch */
 		break;
 	case GREP_BINARY_TEXT:
