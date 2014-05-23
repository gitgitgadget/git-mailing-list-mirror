From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Fri, 23 May 2014 16:03:47 -0400
Message-ID: <20140523200347.GC19088@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521102742.GB30464@sigill.intra.peff.net>
 <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
 <20140522055852.GA16587@sigill.intra.peff.net>
 <xmqq38g1oe2y.fsf@gitster.dls.corp.google.com>
 <20140522184113.GC1167@sigill.intra.peff.net>
 <xmqqppj5msob.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:03:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnvh3-000626-R1
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbaEWUDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:03:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:58318 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751074AbaEWUDt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:03:49 -0400
Received: (qmail 2173 invoked by uid 102); 23 May 2014 20:03:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 15:03:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 16:03:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqppj5msob.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250021>

On Thu, May 22, 2014 at 02:04:20PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> > Yes, and that would be fine with me (I actually wrote strbuf_tolower for
> >> > my own use, and _then_ realized that we already had such a thing that
> >> > could be replaced).
> >> ...
> > ... I think
> > the bigger question is: is this refactor worth doing, since there is
> > only one caller?
> 
> If you wrote it for your own use and then realized that it is
> applicable to this codepath, wouldn't that say that there are
> multiple potential callers that would benefit from having it?

Sure, and that's why I posted it. But I know our standard for adding
code is often a bit higher. We don't generally add code that has no
callers.  In this case, there is one caller, but it is still only
theoretical that there will be another. I.e., for the same reason that I
did not end up using it in my patch (namely, that we often want to
downcase _and_ do other things while we traverse the string), other
places may not.

That's why I asked: it is a judgement call on "does this seem like it is
likely to be a useful thing in the future?". Probably, but I wouldn't be
sad if people disagreed and we dropped it.

Anyway, here is an updated patch. It uses pointer arithmetic (though I
am curious whether hand-optimizing "*p" is actually any faster than
"sb->buf[i]" with modern compilers), but traverses past NULs. I also
updated the commit message to reflect the discussion.

-- >8 --
Subject: strbuf: add strbuf_tolower function

This is a convenience wrapper to call tolower on each
character of the string.

This makes config's lowercase() function obsolete, though
note that because we have a strbuf, we are careful to
operate over the whole strbuf, rather than assuming that a
NUL is the end-of-string.

We could continue to offer a pure-string lowercase, but
there would be no callers (in most pure-string cases, we
actually duplicate and lowercase the duplicate, for which we
have the xstrdup_tolower wrapper).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-strbuf.txt | 4 ++++
 config.c                               | 8 +-------
 strbuf.c                               | 7 +++++++
 strbuf.h                               | 1 +
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 3350d97..8480f89 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -125,6 +125,10 @@ Functions
 
 	Strip whitespace from the end of a string.
 
+`strbuf_tolower`::
+
+	Lowercase each character in the buffer using `tolower`.
+
 `strbuf_cmp`::
 
 	Compare two buffers. Returns an integer less than, equal to, or greater
diff --git a/config.c b/config.c
index a30cb5c..03ce5c6 100644
--- a/config.c
+++ b/config.c
@@ -147,12 +147,6 @@ int git_config_include(const char *var, const char *value, void *data)
 	return ret;
 }
 
-static void lowercase(char *p)
-{
-	for (; *p; p++)
-		*p = tolower(*p);
-}
-
 void git_config_push_parameter(const char *text)
 {
 	struct strbuf env = STRBUF_INIT;
@@ -180,7 +174,7 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	lowercase(pair[0]->buf);
+	strbuf_tolower(pair[0]);
 	if (fn(pair[0]->buf, pair[1] ? pair[1]->buf : NULL, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
diff --git a/strbuf.c b/strbuf.c
index 854c725..2d059b9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -106,6 +106,13 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_tolower(struct strbuf *sb)
+{
+	char *p = sb->buf, *end = sb->buf + sb->len;
+	for (; p < end; p++)
+		*p = tolower(*p);
+}
+
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 				 int terminator, int max)
 {
diff --git a/strbuf.h b/strbuf.h
index 4de7531..25328b9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -45,6 +45,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
+extern void strbuf_tolower(struct strbuf *sb);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 /*
-- 
2.0.0.rc1.436.g03cb729
