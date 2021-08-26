Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD1C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 23:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618BE60E8B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 23:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhHZXZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:25:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:60246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhHZXZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 19:25:38 -0400
Received: (qmail 4891 invoked by uid 109); 26 Aug 2021 23:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Aug 2021 23:24:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10202 invoked by uid 111); 26 Aug 2021 23:24:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Aug 2021 19:24:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Aug 2021 19:24:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, me@ttaylorr.com,
        git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/2] upload-pack: use stdio in send_ref callbacks
Message-ID: <YSgiwXFnLrLy6pH3@coredump.intra.peff.net>
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
 <20210826100648.10333-1-jacob@gitlab.com>
 <20210826100648.10333-2-jacob@gitlab.com>
 <xmqqpmu0f9ob.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmu0f9ob.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 09:33:08AM -0700, Junio C Hamano wrote:

> > +	/*
> > +	 * Increase the stdio buffer size for stdout, for the benefit of ref
> > +	 * advertisement writes. We are only allowed to call setvbuf(3) "after
> > +	 * opening a stream and before any other operations have been performed
> > +	 * on it", so let's call it before we have written anything to stdout.
> > +	 */
> > +	if (setvbuf(stdout, xmalloc(LARGE_PACKET_MAX), _IOFBF,
> > +			LARGE_PACKET_MAX))
> > +		die_errno("failed to grow stdout buffer");
> 
> Nice to see a comment on the tricky part.  I do not think we mind if
> we rounded up the allocation size to the next power of two here, but
> there probably won't be any measurable benefit for doing so.

I'm a little negative on this part, actually. The commit message claims
it's for consistency across platforms. But I would argue that if your
libc buffer size is sub-optimal, then we shouldn't be sprinkling these
adjustments through the code. Either:

 - we should consider it a quality-of-implementation issue, and people
   using that libc should push back on their platform to change the
   default size; or

 - we should fix it consistently and transparently throughout Git by
   adjusting std{in,out,err} in common-main, and using fopen()/fdopen()
   wrappers to adjust to something more sensible

I also find the use of LARGE_PACKET_MAX weird here. Is that really the
optimal stdio buffer size? The whole point of this is coalescing _small_
packets into a single write() syscall. So how many small packets fit
into LARGE_PACKET_MAX is comparing apples and oranges.

> >  	packet_flush(1);
> 
> I briefly wondered if all the operations on refline can be turned
> into direct operations on stdout, but the answer obviously is no.
> We still need to have a strbuf to assemble a single packet and
> measure its final length before we can send it out to stdout.

I think we could push quite a bit more down into the pkt-line code by
making a few more operations FILE-aware. E.g., the patch below shows an
alternate version of patch 2, where we have more helpers and the changes
to the caller are much smaller.

The proliferation of packet_write_fmt() vs packet_fwrite_fmt() is a
little ugly, but:

  - I didn't bother to factor out commonality for this proof-of-concept.
    I think we could be sharing a bit more code in pkt-line.c, as noted.

  - This would all be much nicer if we refactored upload-pack to use
    the packet_writer interface. And then the caller sets up the "FILE
    vs descriptor" choice once when creating the writer, and all of the
    code it calls doesn't have to care either way.

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d..e6a2dbd962 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -105,7 +105,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	}
 
 	strbuf_addch(&refline, '\n');
-	packet_write(1, refline.buf, refline.len);
+	packet_fwrite(stdout, refline.buf, refline.len);
 
 	strbuf_release(&refline);
 	return 0;
@@ -171,7 +171,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 		strvec_push(&data.prefixes, "");
 	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
 				     send_ref, &data, 0);
-	packet_flush(1);
+	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	return 0;
 }
diff --git a/pkt-line.c b/pkt-line.c
index 244b326708..12cf09804b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -92,6 +92,14 @@ void packet_flush(int fd)
 		die_errno(_("unable to write flush packet"));
 }
 
+void packet_fflush(FILE *fh)
+{
+	packet_trace("0000", 4, 1);
+	fwrite_or_die(fh, "0000", 4);
+	if (fflush(fh))
+		die_errno(_("unable to flush packet stream"));
+}
+
 void packet_delim(int fd)
 {
 	packet_trace("0001", 4, 1);
@@ -194,6 +202,21 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+/* this could be refactored to share code with packet_write_fmt_1 */
+void packet_fwrite_fmt(FILE *fh, const char *fmt, ...)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	va_list args;
+
+	strbuf_reset(&buf);
+
+	va_start(args, fmt);
+	format_packet(&buf, "", fmt, args);
+	va_end(args);
+
+	fwrite_or_die(fh, buf.buf, buf.len);
+}
+
 static int do_packet_write(const int fd_out, const char *buf, size_t size,
 			   struct strbuf *err)
 {
diff --git a/pkt-line.h b/pkt-line.h
index c9cb5e1719..7899f8d8e1 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -21,9 +21,11 @@
  * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
+void packet_fflush(FILE *fh);
 void packet_delim(int fd);
 void packet_response_end(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_fwrite_fmt(FILE *fh, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
 void set_packet_header(char *buf, int size);
diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb4..7c98c04d73 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1207,7 +1207,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 		format_symref_info(&symref_info, &data->symref);
 		format_session_id(&session_id, data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
+		packet_fwrite_fmt(stdout, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
@@ -1223,11 +1223,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		strbuf_release(&symref_info);
 		strbuf_release(&session_id);
 	} else {
-		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
 	if (!peel_iterated_oid(oid, &peeled))
-		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+		packet_fwrite_fmt(stdout, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
 
@@ -1348,6 +1348,14 @@ void upload_pack(struct upload_pack_options *options)
 		reset_timeout(data.timeout);
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
+		/*
+		 * sadly we still have to fflush manually here, because
+		 * advertise_shallow_grafts() uses the descriptor directly
+		 * before we could call packet_fflush(). But isn't that a good
+		 * reason to convert that function to stdio, too?
+		 */
+		if (fflush(stdout))
+			die_errno(_("write failure on standard output"));
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {

> > +	struct strbuf send_ref_buf = STRBUF_INIT;
> 
> IIUC, the most notable difference between this round and the
> previous one is that now we are no longer buffering more than one
> packet worth of data because we let the stdio to accumulate them.
> I was a bit surprised that we still want to have a strbuf inside
> this structure (which is there only because it wants to persist
> during the whole conversation with the other side).
> 
> Ahh, sorry, scratch that.  I do remember the discussion/patch that
> it was hurting to make calls to strbuf-init/strbuf-release once per
> ref, and it is an easy way to have the structure here to reuse it.

You'll note in my patch above that we format into a static strbuf to
avoid this cost. Perhaps a little ugly, but that's exactly what the
existing packet_write_fmt() code is doing!

If we want to get rid of that, I think there are two options:

  - for stdio handles, we don't ever need the fully-formatted packet. We
    can get the formatted size with a too-small snprintf(), and then
    directly fprintf() out the result (this doesn't work with
    descriptors, because we have to format the result to feed it to
    write()).

  - if this were all using packet_writer, it could easily learn to
    heap-allocate a single buffer for repeated use. That's roughly the
    same as what's happening in this series, but it would all be taken
    care of by the pkt-line code.

-Peff
