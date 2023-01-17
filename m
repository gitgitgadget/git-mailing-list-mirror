Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497EBC46467
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 03:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjAQDDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 22:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjAQDDY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 22:03:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007E9C
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 19:03:22 -0800 (PST)
Received: (qmail 19188 invoked by uid 109); 17 Jan 2023 03:03:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Jan 2023 03:03:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3829 invoked by uid 111); 17 Jan 2023 03:03:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 22:03:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 22:03:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] avoiding deprecated curl options
Message-ID: <Y8YP+R/hyNr6sEFA@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
 <xmqqilh9kqdy.fsf@gitster.g>
 <xmqqzgakgu0n.fsf@gitster.g>
 <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 03:09:26PM -0500, Jeff King wrote:

> So I took a look at just dropping the deprecated bits, and it wasn't
> _too_ bad. Here's that series. The first two I hope are obviously good.
> The third one is _ugly_, but at least it punts on the whole "how should
> we silence this" argument, and it takes us in the direction we'd
> ultimately want to go.
> 
>   [1/3]: http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
>   [2/3]: http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
>   [3/3]: http: support CURLOPT_PROTOCOLS_STR

In the interests of wrapping this up, here's a v2 that:

  - bumps the required curl version to 7.19.5 in patch 2

  - aims for slightly better readability in the final code of patch 3,
    versus minimizing the diff

As discussed, there are a lot of different ways one could do patch 3,
but I really don't think it's worth spending that much brain power on.
What's here is correct (most important), and I think should be easy to
clean up when we can eventually drop the old style.

  [1/3]: http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
  [2/3]: http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
  [3/3]: http: support CURLOPT_PROTOCOLS_STR

 INSTALL           |  2 +-
 git-curl-compat.h |  8 +++++
 http-push.c       |  6 ++--
 http.c            | 79 +++++++++++++++++++++++++++++++++--------------
 http.h            |  2 +-
 remote-curl.c     | 28 ++++++++---------
 6 files changed, 81 insertions(+), 44 deletions(-)

1:  2229c0468f = 1:  5ae6831af5 http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
2:  00120fa40e ! 2:  5be76d74de http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
    @@ Commit message
         instead. It was added in 2008 via curl 7.18.0; our INSTALL file already
         indicates we require at least curl 7.19.4.
     
    -    We have to rewrite the ioctl functions into seek functions. In some ways
    -    they are simpler (seeking is the only operation), but in some ways more
    -    complex (the ioctl allowed only a full rewind, but now we can seek to
    -    arbitrary offsets).
    +    But there's one catch: curl says we should use CURL_SEEKFUNC_{OK,FAIL},
    +    and those didn't arrive until 7.19.5. One workaround would be to use a
    +    bare 0/1 here (or define our own macros).  But let's just bump the
    +    minimum required version to 7.19.5. That version is only a minor version
    +    bump from our existing requirement, and is only a 2 month time bump for
    +    versions that are almost 13 years old. So it's not likely that anybody
    +    cares about the distinction.
    +
    +    Switching means we have to rewrite the ioctl functions into seek
    +    functions. In some ways they are simpler (seeking is the only
    +    operation), but in some ways more complex (the ioctl allowed only a full
    +    rewind, but now we can seek to arbitrary offsets).
     
         Curl will only ever use SEEK_SET (per their documentation), so I didn't
         bother implementing anything else, since it would naturally be
    @@ Commit message
     
         Signed-off-by: Jeff King <peff@peff.net>
     
    + ## INSTALL ##
    +@@ INSTALL: Issues of note:
    + 	  not need that functionality, use NO_CURL to build without
    + 	  it.
    + 
    +-	  Git requires version "7.19.4" or later of "libcurl" to build
    ++	  Git requires version "7.19.5" or later of "libcurl" to build
    + 	  without NO_CURL. This version requirement may be bumped in
    + 	  the future.
    + 
    +
      ## http-push.c ##
     @@ http-push.c: static void curl_setup_http(CURL *curl, const char *url,
      	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
3:  22eb2fd0fe ! 3:  d2c28e22e1 http: support CURLOPT_PROTOCOLS_STR
    @@ http.c: void setup_curl_trace(CURL *handle)
      }
      
     -static long get_curl_allowed_protocols(int from_user)
    -+static void proto_list_append(struct strbuf *list_str, const char *proto_str,
    -+			      long *list_bits, long proto_bits)
    -+{
    -+	*list_bits |= proto_bits;
    -+	if (list_str) {
    -+		if (list_str->len)
    -+			strbuf_addch(list_str, ',');
    -+		strbuf_addstr(list_str, proto_str);
    -+	}
    -+}
    -+
    -+static long get_curl_allowed_protocols(int from_user, struct strbuf *list)
    ++static void proto_list_append(struct strbuf *list, const char *proto)
      {
    - 	long allowed_protocols = 0;
    +-	long allowed_protocols = 0;
    ++	if (!list)
    ++		return;
    ++	if (list->len)
    ++		strbuf_addch(list, ',');
    ++	strbuf_addstr(list, proto);
    ++}
      
    - 	if (is_transport_allowed("http", from_user))
    +-	if (is_transport_allowed("http", from_user))
     -		allowed_protocols |= CURLPROTO_HTTP;
    -+		proto_list_append(list, "http", &allowed_protocols, CURLPROTO_HTTP);
    - 	if (is_transport_allowed("https", from_user))
    +-	if (is_transport_allowed("https", from_user))
     -		allowed_protocols |= CURLPROTO_HTTPS;
    -+		proto_list_append(list, "https", &allowed_protocols, CURLPROTO_HTTPS);
    - 	if (is_transport_allowed("ftp", from_user))
    +-	if (is_transport_allowed("ftp", from_user))
     -		allowed_protocols |= CURLPROTO_FTP;
    -+		proto_list_append(list, "ftp", &allowed_protocols, CURLPROTO_FTP);
    - 	if (is_transport_allowed("ftps", from_user))
    +-	if (is_transport_allowed("ftps", from_user))
     -		allowed_protocols |= CURLPROTO_FTPS;
    -+		proto_list_append(list, "ftps", &allowed_protocols, CURLPROTO_FTPS);
    ++static long get_curl_allowed_protocols(int from_user, struct strbuf *list)
    ++{
    ++	long bits = 0;
      
    - 	return allowed_protocols;
    +-	return allowed_protocols;
    ++	if (is_transport_allowed("http", from_user)) {
    ++		bits |= CURLPROTO_HTTP;
    ++		proto_list_append(list, "http");
    ++	}
    ++	if (is_transport_allowed("https", from_user)) {
    ++		bits |= CURLPROTO_HTTPS;
    ++		proto_list_append(list, "https");
    ++	}
    ++	if (is_transport_allowed("ftp", from_user)) {
    ++		bits |= CURLPROTO_FTP;
    ++		proto_list_append(list, "ftp");
    ++	}
    ++	if (is_transport_allowed("ftps", from_user)) {
    ++		bits |= CURLPROTO_FTPS;
    ++		proto_list_append(list, "ftps");
    ++	}
    ++
    ++	return bits;
      }
    + 
    + #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
     @@ http.c: static CURL *get_curl_handle(void)
      
      	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
