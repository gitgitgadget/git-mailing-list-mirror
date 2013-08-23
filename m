From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] sha1-lookup: handle duplicate keys with
 GIT_USE_LOOKUP
Date: Fri, 23 Aug 2013 14:24:10 -0400
Message-ID: <20130823182409.GA30130@sigill.intra.peff.net>
References: <20130822231215.GA16978@sigill.intra.peff.net>
 <20130822231404.GB17060@sigill.intra.peff.net>
 <xmqqob8opdey.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 20:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCw1x-0002ni-3H
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab3HWSYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 14:24:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:39241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938Ab3HWSYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 14:24:12 -0400
Received: (qmail 12913 invoked by uid 102); 23 Aug 2013 18:24:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 13:24:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 14:24:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqob8opdey.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232820>

On Fri, Aug 23, 2013 at 09:41:57AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Furthermore, we know that one of our endpoints must be
> > the edge of the run of duplicates. For example, given this
> > sequence:
> >
> >  idx 0 1 2 3 4 5
> >  key A C C C C D
> >
> > If we are searching for "B", we might hit the duplicate run
> > at lo=1, hi=3 (e.g., by first mi=3, then mi=0). But we can
> > never have lo > 1, because B < C. That is, if our key is
> > less than the run, we know that "lo" is the edge, but we can
> > say nothing of "hi". Similarly, if our key is greater than
> > the run, we know that "hi" is the edge, but we can say
> > nothing of "lo". But that is enough for us to return not
> > only "not found", but show the position at which we would
> > insert the new item.
> 
> This is somewhat tricky and may deserve an in-code comment.

Do you want me to re-roll, pushing it down into the comment, or do you
want to mark it up yourself? I think there might be some value in the
latter as your re-writing of it as a comment may cross-check that my
logic is sound.

> > +			if (ofs == 20) {
> > +				mi = lo;
> > +				mi_key = base + elem_size * mi + key_offset;
> > +				cmp = memcmp(mi_key, key, 20);
> 
> It think we already know that mi_key[0:ofs_0] and key[0:ofs_0] are
> the same at this point and we do not have to compare full 20 bytes
> again, but this is done only once and a better readablity of the
> above trumps micro-optimization possibility, I think.

Yes, I had the same idea, and came to the same conclusion. Though if
anybody did want to try it, note that we have just overwritten the old
ofs_0, so you would want to bump the new code up above that line).

> > +uint32_octal() {
> 
> micronit (style):
> 
> 	uint32_octal () {

Hmph. I always forget which one we prefer, and we seem to have equal
numbers of both already. Again, want a re-roll or to mark it up
yourself?

> > +# Print the pack data for object $1, as a delta against object $2 (or as a full
> > +# object if $2 is missing or empty). The output is suitable for including
> > +# directly in the packfile, and represents the entirety of the object entry.
> > +# Doing this on the fly (especially picking your deltas) is quite tricky, so we
> > +# have hardcoded some well-known objects. See the case statements below for the
> > +# complete list.
> 
> Cute ;-) I like the idea of having this function with a right API in
> place, and cheating by limiting its implementation to what is
> necessary.

Just for reference, the procedure I used to generate the "base" data is
reasonably straight forward:

  sha1=$(printf %s "$content" | git hash-object -w --stdin)
  echo $sha1 | git pack-objects --stdout >tmp.pack
  tail -c +13 tmp.pack >no-header.pack
  head -c -20 no-header.pack >no-trailer.pack
  od -b no-trailer.pack | grep ' ' | cut -d' ' -f2- | tr ' ' '\\'

Since we want binary, we can skip the "od" call at the end (I needed it
to convert to something readable to hand "printf"). But "head -c" is not
portable, nor is head with a negative count.

To find items in the same fanout, I just used for-loops to calculate the
sha1s of all 2-byte blobs. And that is why we have the odd magic "\7\76"
blob.

Making the deltas was considerably less elegant, since we cannot provoke
pack-objects to pick arbitrary deltas (and it will not even try to delta
tiny objects, anyway, which would bloat our samples). I ended up with
the horrible patch below. We _could_ clean it up (error-checking? Who
needs it?) and make it a debug-and-testing-only option for pack-objects,
but I just didn't think the grossness was worth it. Still, it's probably
worth documenting here on the list in case somebody else ever needs to
add new samples to lib-pack.sh.

---
 builtin/pack-objects.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8da2a66..e8937f5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2442,6 +2442,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	const char *rp_av[6];
 	int rp_ac = 0;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
+	int magic = 0;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -2505,6 +2506,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
 			    N_("do not hide commits by grafts"), 0),
+		OPT_BOOL(0, "magic", &magic, "make deltas"),
 		OPT_END(),
 	};
 
@@ -2520,6 +2522,34 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
 
+	if (magic) {
+		unsigned char sha1[20];
+		struct delta_index *index;
+		void *src, *trg, *delta;
+		enum object_type src_type, trg_type;
+		unsigned long src_size, trg_size, delta_size, z_delta_size;
+		unsigned char header[10];
+		unsigned long header_len;
+
+		get_sha1(argv[0], sha1);
+		trg = read_sha1_file(sha1, &trg_type, &trg_size);
+
+		get_sha1(argv[1], sha1);
+		src = read_sha1_file(sha1, &src_type, &src_size);
+
+		index = create_delta_index(src, src_size);
+		delta = create_delta(index, trg, trg_size, &delta_size, 8192);
+
+		z_delta_size = do_compress(&delta, delta_size);
+		header_len = encode_in_pack_object_header(OBJ_REF_DELTA, delta_size,
+							  header);
+		fwrite(header, 1, header_len, stdout);
+		fwrite(sha1, 1, 20, stdout);
+		fwrite(delta, 1, z_delta_size, stdout);
+		return 0;
+	}
+
+
 	if (argc) {
 		base_name = argv[0];
 		argc--;
