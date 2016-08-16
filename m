Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39AD1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbcHPOqr (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 10:46:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:56234 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753398AbcHPOqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 10:46:46 -0400
Received: (qmail 11651 invoked by uid 109); 16 Aug 2016 14:46:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 14:46:45 +0000
Received: (qmail 26763 invoked by uid 111); 16 Aug 2016 14:46:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 10:46:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 10:46:42 -0400
Date:	Tue, 16 Aug 2016 10:46:42 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/3] receive-pack: allow a maximum input size to be
 specified
Message-ID: <20160816144642.5ikkta4l5hyx6act@sigill.intra.peff.net>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
 <20160815195729.16826-4-chriscool@tuxfamily.org>
 <20160815204034.rrjn57wigxtjpgye@sigill.intra.peff.net>
 <xmqqr39pejhk.fsf@gitster.mtv.corp.google.com>
 <20160816010309.zstrljqknc3vjziq@sigill.intra.peff.net>
 <CAP8UFD2Bpp-gcxEQGNSFxvKyptkyeAsMtaHZaBebJO2XiF+W3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2Bpp-gcxEQGNSFxvKyptkyeAsMtaHZaBebJO2XiF+W3g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 10:25:44AM +0200, Christian Couder wrote:

> >> > Those are patches I plan to share upstream but just haven't gotten
> >> > around to yet.
> 
> I would be happy to help if I can on these patches too!

Thanks. I'll try to extract the quarantine patches, though I have a few
other things in my backlog first. I wrote them with the intent of
upstreaming, so I think they should be fairly clean.

> [register_tempfile on odb tmpfiles]
> > Also a patch I may try to polish and share in the future, but not as
> > high priority as some of the other stuff.
> 
> I can help polishing this patch if you want.

The original patch is not worth looking at; it predated all of the
tempfile.c infrastructure, so it added its own hacky versions those
functions.

This is basically what we're doing now (this is extracted from a larger
diff, so the line numbers may be a little funny):

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3431de2..9c34353 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -304,8 +346,10 @@ static const char *open_pack_file(const char *pack_name)
 		input_fd = 0;
 		if (!pack_name) {
 			static char tmp_file[PATH_MAX];
+			struct tempfile *t = xcalloc(1, sizeof(*t));
 			output_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
 						"pack/tmp_pack_XXXXXX");
+			register_tempfile(t, tmp_file);
 			pack_name = xstrdup(tmp_file);
 		} else
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
diff --git a/pack-write.c b/pack-write.c
index 33293ce..14597b4 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "tempfile.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -73,7 +74,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	} else {
 		if (!index_name) {
 			static char tmp_file[PATH_MAX];
+			struct tempfile *t = xcalloc(1, sizeof(*t));
 			fd = odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_idx_XXXXXX");
+			register_tempfile(t, tmp_file);
 			index_name = xstrdup(tmp_file);
 		} else {
 			unlink(index_name);
@@ -327,10 +330,13 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
 
 struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 {
+	struct tempfile *t = xcalloc(1, sizeof(*t));
 	char tmpname[PATH_MAX];
 	int fd;
 
 	fd = odb_mkstemp(tmpname, sizeof(tmpname), "pack/tmp_pack_XXXXXX");
+
+	register_tempfile(t, tmpname);
 	*pack_tmp_name = xstrdup(tmpname);
 	return sha1fd(fd, *pack_tmp_name);
 }

But it makes me wonder if we should just be switching odb_mkstemp() to
calling register_tempfile(). Or better yet, switching out
git_mkstemp_mode() for one of the tempfile.h functions (mks_tempfile_m,
I think). There may be some trickery with the allocation of "struct
tempfile" though (the struct needs to persist for the remainder of the
program, but we would not want to allocate and leak one per object, so
we need some way of reusing them).

I also wonder if it should be configurable whether to keep half-written
temporary files. In the early days, it was a good source of debugging
(e.g., look at this half-written pack and see why index-pack choked on
it). But these days I doubt that is really that helpful. So maybe it
would be OK to just drop them unconditionally.

-Peff
