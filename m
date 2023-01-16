Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338CFC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjAPRo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjAPRoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:44:30 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983685688E
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:23:30 -0800 (PST)
Received: (qmail 15399 invoked by uid 109); 16 Jan 2023 17:23:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Jan 2023 17:23:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31727 invoked by uid 111); 16 Jan 2023 17:23:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 12:23:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 12:23:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 3/3] http: support CURLOPT_PROTOCOLS_STR
Message-ID: <Y8WIEStWY8r8LKAx@coredump.intra.peff.net>
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
 <230116.86edruzk5m.gmgdl@evledraar.gmail.com>
 <xmqqzgaicvmj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzgaicvmj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 08:05:56AM -0800, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > +#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR (LIBCURL_VERSION_NUM >= 0x075500)
> > +#if GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
> > +#define GIT_CURLOPT_REDIR_PROTOCOLS_STR CURLOPT_REDIR_PROTOCOLS_STR 
> > +#define GIT_CURLOPT_PROTOCOLS_STR CURLOPT_PROTOCOLS_STR
> > +#else
> > +#define GIT_CURLOPT_REDIR_PROTOCOLS_STR 0
> > +#define GIT_CURLOPT_PROTOCOLS_STR 0
> >  #endif
> 
> I find it a bit ugly that CURLOPT_* being used are all non-zero, but
> it may be true in practice.

I don't think it matters what the dummy values are, at least from a
run-time perspective. We'd only feed them to curl inside the "if (0)"
block. They just need to be non-empty so the compiler is happy.

But I do think there's the possibility of compile-time confusion. Curl
is doing macro magic for deprecation and type-checking here, and it's
not clear how it will handle the magic "0" values, even if we know
the code will never actually run.

> I somehow find the above over-engineered solution looking for a
> problem.  Conditional compilation might be ugly, but what is uglier
> is a conditional compilation hidden behind what pretends to be a
> runtime conditional but gets optimized away at compile time.  Also,
> when the non _STR variant changes status from deprecated to removed,
> the code will cease to build, so I am not sure if the above is the
> whole story.  You'd also need dummy definitions for them when the
> version of cURL is advanced enough.
> 
> It is true that with the above we will always pass both sides to the
> compiler, which may be an upside, but at the same time doesn't it
> make it harder to notice and remove the support of the older side
> once the time comes?

I likewise found that solution in an uncanny valley of over-engineering
for not much gain.

If you really want to over-engineer, then something like the patch below
at least makes the conditional part simpler, because it shares the
curl_easy_setopt() calls. You can actually take it even further and
abstract the declaration of the strbuf completely (and thus omit it when
it is not going to be used), but it makes the code even more obscure.

I dunno. My original patch tried to err on the side of
simple-and-stupid. If we don't mind repeating the list of
http/https/ftp/ftps, then it can be even simpler (and stupider). But the
eventual cleanup becomes really easy, then: just delete the #else half
of each #ifdef.

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd..e545d26dfa 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -126,4 +126,20 @@
 #define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
 #endif
 
+/**
+ * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
+ * released in August 2022.
+ */
+#if LIBCURL_VERSION_NUM >= 0x075500
+#define GIT_CURL_PROTOCOL_TYPE const char *
+#define GIT_CURL_PROTOCOL_RETURN(list, bits) list->buf
+#define GIT_CURL_OPT_PROTOCOLS CURLOPT_PROTOCOLS_STR
+#define GIT_CURL_OPT_REDIR_PROTOCOLS CURLOPT_REDIR_PROTOCOLS_STR
+#else
+#define GIT_CURL_PROTOCOL_TYPE long
+#define GIT_CURL_PROTOCOL_RETURN(list, bits) bits
+#define GIT_CURL_OPT_PROTOCOLS CURLOPT_PROTOCOLS
+#define GIT_CURL_OPT_REDIR_PROTOCOLS CURLOPT_REDIR_PROTOCOLS
+#endif
+
 #endif
diff --git a/http.c b/http.c
index ca0fe80ddb..e5ed3521db 100644
--- a/http.c
+++ b/http.c
@@ -764,20 +764,32 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
 
-static long get_curl_allowed_protocols(int from_user)
+static void proto_list_append(struct strbuf *list_str, const char *proto_str,
+			      long *list_bits, long proto_bits)
 {
-	long allowed_protocols = 0;
+	*list_bits |= proto_bits;
+	if (list_str) {
+		if (list_str->len)
+			strbuf_addch(list_str, ',');
+		strbuf_addstr(list_str, proto_str);
+	}
+}
+
+static GIT_CURL_PROTOCOL_TYPE get_curl_allowed_protocols(struct strbuf *list,
+							 int from_user)
+{
+	long bits = 0;
 
 	if (is_transport_allowed("http", from_user))
-		allowed_protocols |= CURLPROTO_HTTP;
+		proto_list_append(list, "http", &bits, CURLPROTO_HTTP);
 	if (is_transport_allowed("https", from_user))
-		allowed_protocols |= CURLPROTO_HTTPS;
+		proto_list_append(list, "https", &bits, CURLPROTO_HTTPS);
 	if (is_transport_allowed("ftp", from_user))
-		allowed_protocols |= CURLPROTO_FTP;
+		proto_list_append(list, "ftp", &bits, CURLPROTO_FTP);
 	if (is_transport_allowed("ftps", from_user))
-		allowed_protocols |= CURLPROTO_FTPS;
+		proto_list_append(list, "ftps", &bits, CURLPROTO_FTPS);
 
-	return allowed_protocols;
+	return GIT_CURL_PROTOCOL_RETURN(list, bits);
 }
 
 #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
@@ -921,10 +933,17 @@ static CURL *get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
-	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
-			 get_curl_allowed_protocols(0));
-	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
-			 get_curl_allowed_protocols(-1));
+
+	{
+		struct strbuf buf = STRBUF_INIT;
+
+		curl_easy_setopt(result, GIT_CURL_OPT_REDIR_PROTOCOLS,
+				 get_curl_allowed_protocols(&buf, 0));
+		curl_easy_setopt(result, GIT_CURL_OPT_PROTOCOLS,
+				 get_curl_allowed_protocols(&buf, -1));
+		strbuf_release(&buf);
+	}
+
 	if (getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(result);
