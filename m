From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/8] http: extract type/subtype portion of content-type
Date: Fri, 23 May 2014 16:12:45 -0400
Message-ID: <20140523201245.GE19088@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
 <20140522092947.GD15032@sigill.intra.peff.net>
 <567F86A0-98E4-49AF-81C8-8D9E1AEC3C5E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnvpj-0005LJ-Bi
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbaEWUMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:12:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:58332 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872AbaEWUMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:12:47 -0400
Received: (qmail 2748 invoked by uid 102); 23 May 2014 20:12:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 15:12:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 16:12:45 -0400
Content-Disposition: inline
In-Reply-To: <567F86A0-98E4-49AF-81C8-8D9E1AEC3C5E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250024>

On Thu, May 22, 2014 at 03:52:21PM -0700, Kyle J. McKay wrote:

> >+static void extract_content_type(struct strbuf *raw, struct strbuf *type)
> >+{
> >+	const char *p;
> >+
> >+	strbuf_reset(type);
> >+	strbuf_grow(type, raw->len);
> >+	for (p = raw->buf; *p; p++) {
> >+		if (isspace(*p))
> >+			continue;
> >+		if (*p == ';')
> >+			break;
> >+		strbuf_addch(type, tolower(*p));
> >+	}
> >+}
> >+
> 
> This will parse invalid content types as valid.  Probably not important
> since the producer of an invalid content type shouldn't be depending on any
> particular behavior by the consumer of such a type, but I think it warrants
> a note in the comment block, perhaps something like:
> 
>   * Note that an invalid content-type may be converted to a valid one
> 
> or some such.

Yeah, that is intentional based on our earlier discussion (this function
started as "normalize_content_type" :) ). I think it's not a big deal,
but agree it's worth a comment. Like:

diff --git a/http.c b/http.c
index 4edf5b9..6bfd093 100644
--- a/http.c
+++ b/http.c
@@ -911,8 +911,14 @@ static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
  * spaces suppressed, all letters lowercased, and no trailing ";"
  * or parameters.
  *
+ * Note that we will silently remove even invalid whitespace. For
+ * example, "text / plain" is specifically forbidden by RFC 2616,
+ * but "text/plain" is the only reasonable output, and this keeps
+ * our code simple.
+ *
  * Example:
  *   "TEXT/PLAIN; charset=utf-8" -> "text/plain"
+ *   "text / plain" -> "text/plain"
  */
 static void extract_content_type(struct strbuf *raw, struct strbuf *type)
 {

-Peff
