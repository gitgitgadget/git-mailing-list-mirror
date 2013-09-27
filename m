From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/10] pack v4 UI support
Date: Thu, 26 Sep 2013 22:59:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309262150190.312@syhkavp.arg>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309260031290.312@syhkavp.arg>
 <CACsJy8De9mMvSpnzHuq+XG+Pfi5QD1fY44uHT8hNQZN6sU-hgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 04:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPOH6-0007S5-SB
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 04:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab3I0C7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 22:59:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27283 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab3I0C7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 22:59:19 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTR00HMFKAUTM50@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 26 Sep 2013 22:59:19 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id AF8B12DA045F; Thu, 26 Sep 2013 22:59:18 -0400 (EDT)
In-reply-to: <CACsJy8De9mMvSpnzHuq+XG+Pfi5QD1fY44uHT8hNQZN6sU-hgg@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235441>

On Thu, 26 Sep 2013, Duy Nguyen wrote:

> On Thu, Sep 26, 2013 at 11:51 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> Multi-base tree support is not part of "packv4" capability. Let's see
> >> if such support comes before the series is merged to master. If so we
> >> can drop that line from protocol-capabilities.txt. Otherwise a new
> >> capability can be added for multi-base trees.
> >
> > What is that for?  Multi-base trees are not created yet, but the code to
> > parse them is already there.  So I don't see the point of having a
> > capability in the protocol for this.
> 
> pv4_get_tree() can. index-pack cannot.

Hmmm... right.

I think this ought to be part of the "packv4" capability nevertheless. 
This is not going into the official git branch right away so there is 
still time to implement it.

> >> Another capability could be added for sending the actual number of
> >> objects in a thin pack for more accurate display in index-pack. Low
> >> priority in my opinion.
> >
> > That just cannot be communicated during capability exchange.  This
> > number is known only after object enumeration.  Hence my suggestion of a
> > ['T', 'H', 'I', 'N', htonl(<number_of_sent_objects>)] special header
> > prepended to the actual pack on the wire.  And that has to be decided
> > before formalizing the pack v4 capability.  That makes it a somewhat
> > higher priority.
> 
> The capability is to let the server know the client understands ['T',
> 'H', 'I', 'N' ..]. The server can choose not to send it later, but
> that's ok. Hence the new capability. I'm somewhat reluctant to do it
> because of peeking code in fetch-pack and receive-pack and some
> refactoring may be needed first. But I could certainly put it on
> higher priority.

Here's what I'm suggesting as a start (untested):

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..04e5ae1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -792,9 +792,10 @@ static struct command *read_head_info(void)
 	return commands;
 }
 
-static const char *parse_pack_header(struct pack_header *hdr)
+static const char *parse_pack_header(struct pack_header *hdr,
+				     struct thin_header *thin_hdr)
 {
-	switch (read_pack_header(0, hdr)) {
+	switch (read_pack_header(0, hdr, thin_hdr)) {
 	case PH_ERROR_EOF:
 		return "eof before pack header was fully read";
 
@@ -817,23 +818,25 @@ static const char *pack_lockfile;
 static const char *unpack(int err_fd)
 {
 	struct pack_header hdr;
+	struct thin_header thin_hdr;
 	const char *hdr_err;
-	char hdr_arg[38];
+	char hdr_arg[50];
 	int fsck_objects = (receive_fsck_objects >= 0
 			    ? receive_fsck_objects
 			    : transfer_fsck_objects >= 0
 			    ? transfer_fsck_objects
 			    : 0);
 
-	hdr_err = parse_pack_header(&hdr);
+	hdr_err = parse_pack_header(&hdr, &thin_hdr);
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
 		return hdr_err;
 	}
 	snprintf(hdr_arg, sizeof(hdr_arg),
-			"--pack_header=%"PRIu32",%"PRIu32,
-			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
+			"--pack_header=%"PRIu32",%"PRIu32",%"PRIu32,
+			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries),
+			ntohl(thin_hdr.hdr_entries));
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i = 0;
diff --git a/fetch-pack.c b/fetch-pack.c
index 6684348..d86e5d1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -715,12 +715,14 @@ static int get_pack(struct fetch_pack_args *args,
 	*hdr_arg = 0;
 	if (!args->keep_pack && unpack_limit) {
 		struct pack_header header;
+		struct thin_header thin_hdr;
 
-		if (read_pack_header(demux.out, &header))
+		if (read_pack_header(demux.out, &header, &thin_hdr))
 			die("protocol error: bad pack header");
 		snprintf(hdr_arg, sizeof(hdr_arg),
-			 "--pack_header=%"PRIu32",%"PRIu32,
-			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
+			 "--pack_header=%"PRIu32",%"PRIu32",%"PRIu32,
+			 ntohl(header.hdr_version), ntohl(header.hdr_entries),
+			 ntohl(thin_hdr.hdr_entries));
 		if (ntohl(header.hdr_entries) < unpack_limit)
 			do_keep = 0;
 		else
diff --git a/pack.h b/pack.h
index ccefdbe..974b860 100644
--- a/pack.h
+++ b/pack.h
@@ -16,6 +16,18 @@ struct pack_header {
 };
 
 /*
+ * Pack v4 header prefix for thin packs, indicating the actual number
+ * of objects being transmitted.  Expected before the actual pack header
+ * on the wire and not stored on disk upon reception.  This is not
+ * included in the computation of the pack trailing SHA1.
+ */
+#define THIN_SIGNATURE 0x5448494e	/* "THIN" */
+struct thin_header {
+	uint32_t hdr_signature;
+	uint32_t hdr_entries;
+};
+
+/*
  * The first four bytes of index formats later than version 1 should
  * start with this signature, as all older git binaries would find this
  * value illegal and abort reading the file.
@@ -88,7 +100,7 @@ extern int pv4_encode_object_header(enum object_type, uintmax_t, unsigned char *
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
 #define PH_ERROR_PROTOCOL	(-3)
-extern int read_pack_header(int fd, struct pack_header *);
+extern int read_pack_header(int fd, struct pack_header *, struct thin_header *);
 
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
 extern void finish_tmp_packfile(char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
diff --git a/sha1_file.c b/sha1_file.c
index ef6ecc8..5f00c15 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3180,12 +3180,26 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 	return 0;
 }
 
-int read_pack_header(int fd, struct pack_header *header)
+int read_pack_header(int fd, struct pack_header *header,
+		     struct thin_header *thin_hdr)
 {
 	if (read_in_full(fd, header, sizeof(*header)) < sizeof(*header))
 		/* "eof before pack header was fully read" */
 		return PH_ERROR_EOF;
 
+	if (header->hdr_signature == htonl(THIN_SIGNATURE)) {
+		char *thin_hdr_end = (char *)header + sizeof(*thin_hdr);
+		int leftover = sizeof(*header) - sizeof(*thin_hdr);
+		if (!thin_hdr)
+			return PH_ERROR_PROTOCOL;
+		memcpy(thin_hdr, header, sizeof(*thin_hdr));
+		memcpy(header, thin_hdr_end, leftover);
+		if (read_in_full(fd, thin_hdr_end, sizeof(*header) - leftover)
+				< sizeof(*header) - leftover)
+			return PH_ERROR_EOF;
+	} else if (thin_hdr)
+		memset(thin_hdr, 0, sizeof(*thin_hdr));
+
 	if (header->hdr_signature != htonl(PACK_SIGNATURE))
 		/* "protocol error (pack signature mismatch detected)" */
 		return PH_ERROR_PACK_SIGNATURE;


Nicolas
