From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Mon, 04 Aug 2014 21:19:46 +0200
Message-ID: <53DFDCD2.2090803@gmail.com>
References: <20140728171743.GA1927@peff.net> <53D806AC.3070806@gmail.com> <20140801223739.GA15649@peff.net> <20140801231044.GA17960@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 21:20:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XENnX-0001en-QR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 21:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbaHDTTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 15:19:49 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33590 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaHDTTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 15:19:49 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so8114905wgh.11
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZB5q19N10vnakKb3bgBv/eCECurmN4Rux4zZ0bcKD/g=;
        b=EBQuN6fiINsMIDL7sPjjlRXVfkoidxcvrZ/N/eTsf1Han0A6BhyZxhh1i852O464vo
         VuYVHvuKZeMcQ88MiEKivDd94PNQkBR/BbtCFf0Bfrv1xtiCsy4PC0hPiVreGkfuP6uI
         hFPkvw4qsEEh4kxmMfLzDo5Meah4p/COh2hJzxoZbHFDAXb8G05mUCW/L3dpFzd3e07o
         /Smi0UxpoLQrn9fQERAECrbvKgRSjNqjFkoSRNFxBFWtTamowu1bGNXxi2yD0kFDvNXi
         QuXi9YMeQ/75ZvPztETu9RE2OymguV7tN4008Si+1RQgJkxsqkBGgXSW/ceeDz+7siB/
         m+HA==
X-Received: by 10.194.237.135 with SMTP id vc7mr35548843wjc.86.1407179987108;
        Mon, 04 Aug 2014 12:19:47 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id lh15sm43618839wic.10.2014.08.04.12.19.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 12:19:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140801231044.GA17960@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254769>

Am 02.08.2014 01:10, schrieb Jeff King:
> On Fri, Aug 01, 2014 at 06:37:39PM -0400, Jeff King wrote:
> 
>>> Btw.: Using struct-packing on 'struct bitmap_disk_entry' means that the
>>> binary format of .bitmap files is incompatible between GCC and other
>>> builds, correct?
>>
>> The on-disk format is defined by JGit; if there are differences between
>> the builds, that's a bug (and I would not be too surprised if there is
>> one, as bitmaps have gotten very extensive testing on 32- and 64-bit
>> gcc, but probably not much elsewhere).
>>
>> We do use structs to represent disk structures in other bits of the
>> packfile code (e.g., struct pack_idx_header), but the struct is vanilla
>> enough that we assume every compiler gives us two tightly-packed 32-bit
>> integers without having to bother with the "packed" attribute (and it
>> seems to have worked in practice).
>>
>> We should probably be more careful with that bitmap code. It looks like
>> it wouldn't be too bad to drop it. I'll see if I can come up with a
>> patch.
> 
> I confirmed that this does break horribly without the packed attribute
> (as you'd expect; it's asking for 48-bit alignment!). p5310 notices it,
> _if_ you have jgit installed to check against.
> 
> Here's a fix.
> 
> Subject: pack-bitmap: do not use gcc packed attribute
> 
> The "__attribute__" flag may be a noop on some compilers.
> That's OK as long as the code is correct without the
> attribute, but in this case it is not. We would typically
> end up with a struct that is 2 bytes too long due to struct
> padding, breaking both reading and writing of bitmaps.
> 
> We can work around this by using an array of unsigned char
> to represent the data, and relying on get/put_be32 to handle
> alignment issues as we interact with the array.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The accessors may be overkill; each function is called only a single
> time in the whole codebase. But doing it this way rather than accessing
> entry[4] inline at least puts the magic constants all in one place.
> 
[...]

Hmm, I wonder if it wouldn't be simpler to read / write the desired on-disk
structure directly, without copying to a uchar[6] first.

When writing, sha1write already buffers the data, so calling this with 4/1/1
bytes of payload shouldn't affect performance.

Similarly for reading - we already have a function to read a bitmap and
advance the 'file' position, why not have similar functions to read uint8/32
in a stream-based fashion?

This raises the question why we read via mmap at all (without munmap()ing the
file when done...). We copy all data into internal data structures anyway. Is
an fopen/fread-based solution (with fread_u8/_u32 helpers) that much slower?


Here's what I came up with (just a sketch, commit message is lacky and the
helper functions deserve a better place / name):

----8<-----
Subject: [PATCH] pack-bitmap: do not use packed structs to read / write bitmap
 files

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 pack-bitmap-write.c | 18 +++++++++++++-----
 pack-bitmap.c       | 21 ++++++++++++++-------
 pack-bitmap.h       |  6 ------
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5f1791a..01995cb 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -465,6 +465,16 @@ static const unsigned char *sha1_access(size_t pos, void *table)
 	return index[pos]->sha1;
 }
 
+static inline void sha1write_u8(struct sha1file *f, uint8_t data)
+{
+	sha1write(f, &data, sizeof(data));
+}
+static inline void sha1write_u32(struct sha1file *f, uint32_t data)
+{
+	data = htonl(data);
+	sha1write(f, &data, sizeof(data));
+}
+
 static void write_selected_commits_v1(struct sha1file *f,
 				      struct pack_idx_entry **index,
 				      uint32_t index_nr)
@@ -473,7 +483,6 @@ static void write_selected_commits_v1(struct sha1file *f,
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
-		struct bitmap_disk_entry on_disk;
 
 		int commit_pos =
 			sha1_pos(stored->commit->object.sha1, index, index_nr, sha1_access);
@@ -481,11 +490,10 @@ static void write_selected_commits_v1(struct sha1file *f,
 		if (commit_pos < 0)
 			die("BUG: trying to write commit not in index");
 
-		on_disk.object_pos = htonl(commit_pos);
-		on_disk.xor_offset = stored->xor_offset;
-		on_disk.flags = stored->flags;
+		sha1write_u32(f, commit_pos);
+		sha1write_u8(f, stored->xor_offset);
+		sha1write_u8(f, stored->flags);
 
-		sha1write(f, &on_disk, sizeof(on_disk));
 		dump_bitmap(f, stored->write_as);
 	}
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 91e4101..cb1b2dd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -197,13 +197,23 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	return stored;
 }
 
+static inline uint32_t read_u32(const unsigned char *buffer, size_t *pos)
+{
+	uint32_t result = get_be32(buffer + *pos);
+	(*pos) += sizeof(result);
+	return result;
+}
+static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
+{
+	return buffer[(*pos)++];
+}
+
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
 	static const size_t MAX_XOR_OFFSET = 160;
 
 	uint32_t i;
 	struct stored_bitmap **recent_bitmaps;
-	struct bitmap_disk_entry *entry;
 
 	recent_bitmaps = xcalloc(MAX_XOR_OFFSET, sizeof(struct stored_bitmap));
 
@@ -214,15 +224,12 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		uint32_t commit_idx_pos;
 		const unsigned char *sha1;
 
-		entry = (struct bitmap_disk_entry *)(index->map + index->map_pos);
-		index->map_pos += sizeof(struct bitmap_disk_entry);
+		commit_idx_pos = read_u32(index->map, &index->map_pos);
+		xor_offset = (int) read_u8(index->map, &index->map_pos);
+		flags = (int) read_u8(index->map, &index->map_pos);
 
-		commit_idx_pos = ntohl(entry->object_pos);
 		sha1 = nth_packed_object_sha1(index->pack, commit_idx_pos);
 
-		xor_offset = (int)entry->xor_offset;
-		flags = (int)entry->flags;
-
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
 			return -1;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8b7f4e9..487600b 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -5,12 +5,6 @@
 #include "khash.h"
 #include "pack-objects.h"
 
-struct bitmap_disk_entry {
-	uint32_t object_pos;
-	uint8_t xor_offset;
-	uint8_t flags;
-} __attribute__((packed));
-
 struct bitmap_disk_header {
 	char magic[4];
 	uint16_t version;
-- 
2.0.3.920.g16a4828.dirty
