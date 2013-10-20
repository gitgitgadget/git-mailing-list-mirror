From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack corruption post-mortem
Date: Sun, 20 Oct 2013 16:56:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310201644330.1951@syhkavp.arg>
References: <20131016083400.GA31266@sigill.intra.peff.net>
 <CACsJy8ABdE8mZMVFZkqYMC4ZeN_baWw=XcYOZYBCZytWP97rRw@mail.gmail.com>
 <alpine.LFD.2.03.1310191024000.1951@syhkavp.arg>
 <CAJo=hJugNGkpDxh6o6azVGc7pP3fTGsK113vRgb4A7ipNeV2ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 20 22:57:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VY03X-0003kY-6D
	for gcvg-git-2@plane.gmane.org; Sun, 20 Oct 2013 22:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab3JTU4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Oct 2013 16:56:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65219 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3JTU4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Oct 2013 16:56:46 -0400
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUZ00CWUJILQIB0@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 20 Oct 2013 16:56:45 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 0631A2DA04B7; Sun, 20 Oct 2013 16:56:45 -0400 (EDT)
In-reply-to: <CAJo=hJugNGkpDxh6o6azVGc7pP3fTGsK113vRgb4A7ipNeV2ZA@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236421>

On Sat, 19 Oct 2013, Shawn Pearce wrote:

> On Sat, Oct 19, 2013 at 7:41 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Sat, 19 Oct 2013, Duy Nguyen wrote:
> >
> >> On Wed, Oct 16, 2013 at 3:34 PM, Jeff King <peff@peff.net> wrote:
> >> > I was recently presented with a repository with a corrupted packfile,
> >> > and was asked if the data was recoverable. This post-mortem describes
> >> > the steps I took to investigate and fix the problem. I thought others
> >> > might find the process interesting, and it might help somebody in the
> >> > same situation.
> >> >
> >> > I started with an fsck, which found a problem with exactly one object
> >> > (I've used $pack and $obj below to keep the output readable, and also
> >> > because I'll refer to them later):
> >> >
> >> >     $ git fsck
> >> >     error: $pack SHA1 checksum mismatch
> >> >     error: index CRC mismatch for object $obj from $pack at offset 51653873
> >> >     error: inflate: data stream error (incorrect data check)
> >> >     error: cannot unpack $obj from $pack at offset 51653873
> >>
> >> I wonder if we should protect the sha-1 and pathname tables in packv4
> >> with CRC too. A bit flipped in there could cause stream of corrupt
> >> objects and make it hard to pinpoint the corrupt location..
> >
> > It turns out that we already have this covered.
> >
> > The SHA1 used in the name of the pack file is actually the SHA1 checksum
> > of the SHA1 table.
> 
> I continue to believe this naming is wrong. The pack file name should
> be the SHA1 checksum of the pack data stream, but the SHA1 table. This
> would allow cleaner update of a repository that was repacked with
> different compression settings, but identical objects.

OK, after some thoughts, I decided that it is best _not_ to rely on the 
pack name.  The pack name currently carries no meaning what so ever and 
git works just fine if some packs are arbitrarily named.  Your concern 
about its current naming scheme is certainly legitimate, and I don't 
want pack v4 to introduce any kind of restrictions here.

Furthermore, the SHA1 table is the only pack element which integrity may 
not independently be verified at the moment.  This makes corruption 
isolation much harder when receiving a streamed pack.

Therefore I decided to introduce a small pack v4 format change with the 
following patch:

----- >8
From: Nicolas Pitre <nico@fluxnic.net>
Date: Sun, 20 Oct 2013 14:52:24 -0400
Subject: [PATCH] pack v4: add a SHA1 checksum to the SHA1 table

Every packed element currently has some integrity protection coming from
the CRC32 embedded in the zlib deflated stream, except for the SHA1 table.

Some bit flip corruption in the SHA1 table may have repercutions on a
whole lot of objects and could be very hard to isolate.

Let's add some integrity protection on the SHA1 table by terminating it
with an additional SHA1 entry being the SHA1 checksum of the table.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index fd2e737..a370f26 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -94,7 +94,9 @@ Git pack format
 === Pack v4 tables
 
  - A table of sorted SHA-1 object names for all objects contained in
-   the on-disk pack.
+   the on-disk pack, with a final entry being the SHA1 sum of all the
+   previous entries.  The size of this table is therefore
+   (nr_objects + 1) * 20 bytes.
 
    The SHA-1 table in thin packs must include the omitted objects as well.
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index caec388..01300d6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1471,7 +1471,10 @@ static struct packv4_dict *read_dict(void)
 
 static void parse_dictionaries(void)
 {
+	git_SHA_CTX ctx;
+	unsigned char table_sha1[20];
 	int i;
+
 	if (!packv4)
 		return;
 
@@ -1485,6 +1488,12 @@ static void parse_dictionaries(void)
 			die(_("wrong order in SHA-1 table at entry %d"), i);
 	}
 
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, sha1_table, 20 * nr_objects_final);
+	git_SHA1_Final(table_sha1, &ctx);
+	if (hashcmp(table_sha1, fill_and_use(20)) != 0)
+		die(_("SHA-1 table checksum mismatch"));
+
 	name_dict = read_dict();
 	path_dict = read_dict();
 }
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 9fd5640..eb57ada 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -816,11 +816,18 @@ static void unpack_all(void)
 	use(sizeof(struct pack_header));
 
 	if (packv4) {
+		git_SHA_CTX ctx;
+		unsigned char table_sha1[20];
 		sha1_table = xmalloc(20 * nr_objects);
 		for (i = 0; i < nr_objects; i++) {
 			unsigned char *p = sha1_table + i * 20;
 			hashcpy(p, fill_and_use(20));
 		}
+		git_SHA1_Init(&ctx);
+		git_SHA1_Update(&ctx, sha1_table, 20 * nr_objects);
+		git_SHA1_Final(table_sha1, &ctx);
+		if (hashcmp(table_sha1, fill_and_use(20)) != 0)
+			die("SHA-1 table checksum mismatch");
 		name_dict = read_dict();
 		path_dict = read_dict();
 	}
diff --git a/packv4-create.c b/packv4-create.c
index 14be867..7b51792 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -688,13 +688,20 @@ unsigned long packv4_write_tables(struct sha1file *f,
 	struct pack_idx_entry *objs = v4->all_objs;
 	struct dict_table *commit_ident_table = v4->commit_ident_table;
 	struct dict_table *tree_path_table = v4->tree_path_table;
+	git_SHA_CTX ctx;
+	unsigned char table_sha1[20];
 	unsigned i;
 	unsigned long written = 0;
 
 	/* The sorted list of object SHA1's is always first */
-	for (i = 0; i < nr_objects; i++)
+	git_SHA1_Init(&ctx);
+	for (i = 0; i < nr_objects; i++) {
+		git_SHA1_Update(&ctx, objs[i].sha1, 20);
 		sha1write(f, objs[i].sha1, 20);
-	written = 20 * nr_objects;
+	}
+	git_SHA1_Final(table_sha1, &ctx);
+	sha1write(f, table_sha1, 20);
+	written = 20 * (nr_objects + 1);
 
 	/* Then the commit dictionary table */
 	written += write_dict_table(f, commit_ident_table,
diff --git a/packv4-parse.c b/packv4-parse.c
index 31c89c7..e6f5028 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -128,7 +128,7 @@ static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
 
 static void load_ident_dict(struct packed_git *p)
 {
-	off_t offset = 12 + p->num_objects * 20;
+	off_t offset = 12 + (p->num_objects + 1) * 20;
 	struct packv4_dict *names = load_dict(p, &offset);
 	if (!names)
 		die("bad pack name dictionary in %s", p->pack_name);


Nicolas
