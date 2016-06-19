Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F711FE4E
	for <e@80x24.org>; Sun, 19 Jun 2016 10:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbcFSKs0 (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 06:48:26 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:5607 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbcFSKs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 06:48:26 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 0dd32947
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Sun, 19 Jun 2016 12:48:21 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:	Junio C Hamano <gitster@pobox.com>
From:	Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <146597489449.32143.1327156804178869158@s-8d3a2dc3.on.site.uni-stuttgart.de>
Cc:	git@vger.kernel.org, "Nicolas Pitre" <nico@fluxnic.net>,
	"Johannes Sixt" <j6t@kdbg.org>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
 <xmqqbn338nu1.fsf@gitster.mtv.corp.google.com>
 <146597489449.32143.1327156804178869158@s-8d3a2dc3.on.site.uni-stuttgart.de>
Message-ID: <146633329934.562.6352514848469017860@typhoon>
User-Agent: alot/0.3.7
Subject: Re: [PATCH v2] Refactor recv_sideband()
Date:	Sun, 19 Jun 2016 12:48:19 +0200
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 15 Jun 2016 at 09:14:54, Lukas Fleischer wrote:
> What we could do is reintroduce the local prefix variable I had in v1
> and use that to store whether a prefix needs to be prepended or not. If
> we do that and if we are fine with strbuf memory being (potentially)
> allocated and re-allocated multiple times during a single
> recv_sideband() invocation, the strbuf could be made local to the part
> that actually needs it and could be used as in asprintf().

When I revamped the patch and looked at similar code I had another idea
that I did not want to keep to myself:

In contexts similar to this patch, we often seem to use statically
allocated string buffers as follows:

-- 8< --
diff --git a/sideband.c b/sideband.c
index 8340a1b..08b75e2 100644
--- a/sideband.c
+++ b/sideband.c
@@ -22,9 +22,10 @@ int recv_sideband(const char *me, int in_stream, int out)
 {
 	const char *term, *suffix;
 	char buf[LARGE_PACKET_MAX + 1];
-	struct strbuf outbuf = STRBUF_INIT;
+	static struct strbuf outbuf = STRBUF_INIT;
 	const char *b, *brk;
 
+	strbuf_reset(&outbuf);
 	strbuf_addf(&outbuf, "%s", PREFIX);
 	term = getenv("TERM");
 	if (isatty(2) && term && strcmp(term, "dumb"))
-- 8< --

The benefits are obvious: No memory (re-)allocation overhead and no need
to take care of freeing on every return path. The downside is that the
function becomes non-thread-safe. After looking at the call sites, it
seems like we do not seem to call recv_sideband() from different threads
yet -- but do we want to rely on that?

The other two options are:

1. As I suggested earlier, introduce a wrapper that could be named
   xwritef() or fprintf_atomic() and allocate a new buffer (i.e., use a
   fresh strbuf) each time something is printed.

2. Keep using a fixed-size buffer size we already know the maximum size
   each of the strings can have.

Which one do you prefer?

Regards,
Lukas
