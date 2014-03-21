From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Fri, 21 Mar 2014 12:21:19 +0700
Message-ID: <20140321052118.GA28519@duynguyen-vnpc.dek-tpc.internal>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
 <532AF304.7040301@gmail.com>
 <CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
 <CACsJy8AYs0-rmGZz2_KEkT2ibW-sTpm=Q9FxFhNGRYd2b6R+sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQrtb-00086p-9o
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 06:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbaCUFV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 01:21:27 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44022 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbaCUFV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 01:21:26 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so1946204pab.13
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PFwZxFQtSJNpopL6WieBk0IyfGE5m1AQN/ozAJm8Tx8=;
        b=xtfeAkJNbnx3rDCPCEien4pNXAEWVs8Pl09pAbyjlqPG0kXOYxCgugkWAmy7/jMFu4
         MaBJFCwKpibTdCfU2LpMTu+85hTkC6uKNM9ARblL2SAhOrXrtfkE0lIZg0fFZF1UkAKp
         lePCCC60tvpJJaWrs/WfSXWKey49c8G9YkdHe/Jujw9H5eW/srHCJFWssHieZ1hSVsaU
         CGJ5iEUHX2HG1LBrrRxZuafmwcUOjHgBU6XXU+5v0OCPgywP5yaeWxj09OIN4U99LAMB
         EwzYQJhhFyzJWLA4DC5PlJW1GNV5TSaYYImNY1SacaTJ7mL+16Fhn1/lOmGyLyNCFF2r
         tx1g==
X-Received: by 10.66.163.138 with SMTP id yi10mr51618087pab.95.1395379285796;
        Thu, 20 Mar 2014 22:21:25 -0700 (PDT)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id dk1sm7394164pbc.46.2014.03.20.22.21.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 22:21:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 21 Mar 2014 12:21:19 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8AYs0-rmGZz2_KEkT2ibW-sTpm=Q9FxFhNGRYd2b6R+sA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244639>

On Fri, Mar 21, 2014 at 08:51:18AM +0700, Duy Nguyen wrote:
> On Thu, Mar 20, 2014 at 11:08 PM, Stefan Zager <szager@chromium.org> wrote:
> > Duy, would you like to re-post your patch without the new pread implementation?
> 
> I will but let me try out the sliding window idea first. My quick
> tests on git.git show me we may only need 21k mmap instead of 177k
> pread. That hints some potential performance improvement.

The patch at the bottom reuses (un)use_pack() instead of pread(). The
results on linux-2.6 do not look any different. I guess we can drop
the idea.

It makes me wonder, though, what's wrong a simple patch like this to
make pread in index-pack thread-safe? It does not look any different
either from the performance point of view, perhaps because
unpack_data() reads small deltas most of the time

-- 8< --
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a6b1c17..b91f4f8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -40,11 +40,6 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
 
-#if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
-/* pread() emulation is not thread-safe. Disable threading. */
-#define NO_PTHREADS
-#endif
-
 struct thread_local {
 #ifndef NO_PTHREADS
 	pthread_t thread;
@@ -175,6 +170,22 @@ static void cleanup_thread(void)
 #endif
 
 
+#if defined(NO_THREAD_SAFE_PREAD)
+static inline ssize_t pread_safe(int fd, void *buf, size_t count, off_t off)
+{
+	int ret;
+	read_lock();
+	ret = pread(fd, buf, count, off);
+	read_unlock();
+	return ret;
+}
+#else
+static inline ssize_t pread_safe(int fd, void *buf, size_t count, off_t off)
+{
+	return pread(fd, buf, count, off);
+}
+#endif
+
 static int mark_link(struct object *obj, int type, void *data)
 {
 	if (!obj)
@@ -542,7 +553,7 @@ static void *unpack_data(struct object_entry *obj,
 
 	do {
 		ssize_t n = (len < 64*1024) ? len : 64*1024;
-		n = pread(pack_fd, inbuf, n, from);
+		n = pread_safe(pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno(_("cannot pread pack file"));
 		if (!n)
-- 8< --

And the sliding window patch for the list archive

-- 8< --
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a6b1c17..6f5c6d9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -91,7 +91,8 @@ static off_t consumed_bytes;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
-static int input_fd, output_fd, pack_fd;
+static int input_fd, output_fd;
+static struct packed_git *pack;
 
 #ifndef NO_PTHREADS
 
@@ -224,8 +225,10 @@ static unsigned check_objects(void)
 static void flush(void)
 {
 	if (input_offset) {
-		if (output_fd >= 0)
+		if (output_fd >= 0) {
 			write_or_die(output_fd, input_buffer, input_offset);
+			pack->pack_size += input_offset;
+		}
 		git_SHA1_Update(&input_ctx, input_buffer, input_offset);
 		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
@@ -277,6 +280,10 @@ static void use(int bytes)
 
 static const char *open_pack_file(const char *pack_name)
 {
+	pack = xmalloc(sizeof(*pack) + 1);
+	memset(pack, 0, sizeof(*pack));
+	pack->pack_name[0] = '\0';
+
 	if (from_stdin) {
 		input_fd = 0;
 		if (!pack_name) {
@@ -288,13 +295,17 @@ static const char *open_pack_file(const char *pack_name)
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
 			die_errno(_("unable to create '%s'"), pack_name);
-		pack_fd = output_fd;
+		pack->pack_fd = output_fd;
 	} else {
+		struct stat st;
 		input_fd = open(pack_name, O_RDONLY);
 		if (input_fd < 0)
 			die_errno(_("cannot open packfile '%s'"), pack_name);
+		if (lstat(pack_name, &st))
+			die_errno(_("cannot stat packfile '%s'"), pack_name);
 		output_fd = -1;
-		pack_fd = input_fd;
+		pack->pack_fd = input_fd;
+		pack->pack_size = st.st_size;
 	}
 	git_SHA1_Init(&input_ctx);
 	return pack_name;
@@ -531,9 +542,15 @@ static void *unpack_data(struct object_entry *obj,
 	unsigned char *data, *inbuf;
 	git_zstream stream;
 	int status;
+	struct pack_window *w_cursor = NULL;
+
+	if (from + len > pack->pack_size)
+		die(Q_("premature end of pack file, %lu byte missing",
+		       "premature end of pack file, %lu bytes missing",
+		       from + len - pack->pack_size),
+		    (unsigned long)(from + len - pack->pack_size));
 
 	data = xmalloc(consume ? 64*1024 : obj->size);
-	inbuf = xmalloc((len < 64*1024) ? len : 64*1024);
 
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
@@ -541,15 +558,12 @@ static void *unpack_data(struct object_entry *obj,
 	stream.avail_out = consume ? 64*1024 : obj->size;
 
 	do {
-		ssize_t n = (len < 64*1024) ? len : 64*1024;
-		n = pread(pack_fd, inbuf, n, from);
-		if (n < 0)
-			die_errno(_("cannot pread pack file"));
-		if (!n)
-			die(Q_("premature end of pack file, %lu byte missing",
-			       "premature end of pack file, %lu bytes missing",
-			       len),
-			    len);
+		ssize_t n;
+		unsigned long left;
+		read_lock();
+		inbuf = use_pack(pack, &w_cursor, from, &left);
+		read_unlock();
+		n = left > len ? len : left;
 		from += n;
 		len -= n;
 		stream.next_in = inbuf;
@@ -568,6 +582,9 @@ static void *unpack_data(struct object_entry *obj,
 				stream.avail_out = 64*1024;
 			} while (status == Z_OK && stream.avail_in);
 		}
+		read_lock();
+		unuse_pack(&w_cursor);
+		read_unlock();
 	} while (len && status == Z_OK && !stream.avail_in);
 
 	/* This has been inflated OK when first encountered, so... */
@@ -575,7 +592,6 @@ static void *unpack_data(struct object_entry *obj,
 		die(_("serious inflate inconsistency"));
 
 	git_inflate_end(&stream);
-	free(inbuf);
 	if (consume) {
 		free(data);
 		data = NULL;
@@ -1657,6 +1673,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	free(objects);
 	free(index_name_buf);
 	free(keep_name_buf);
+	close_pack_windows(pack);
+	free(pack);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
diff --git a/sha1_file.c b/sha1_file.c
index 187f5a6..aa0b16d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -977,7 +977,13 @@ unsigned char *use_pack(struct packed_git *p,
 	 */
 	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
-	if (offset > (p->pack_size - 20))
+	/*
+	 * index-pack uses this function even if the pack is not
+	 * complete yet (i.e. trailing SHA-1 missing). Loosen the
+	 * check a bit in this case (pack_empty name uses as the
+	 * indicator).
+	 */
+	if (offset > (p->pack_size - (*p->pack_name ? 20 : 0)))
 		die("offset beyond end of packfile (truncated pack?)");
 
 	if (!win || !in_window(win, offset)) {
-- 8< --

--
Duy
