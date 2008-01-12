From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Sat, 12 Jan 2008 14:52:04 +1300
Message-ID: <47881D44.9060105@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org> <47869C24.3000400@vilain.net> <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org> <4786BFCD.1000303@vilain.net> <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org> <47870CDF.4010606@vilain.net> <alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 03:11:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVpv-0000mB-Jw
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 03:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935AbYALCKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 21:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762828AbYALCKf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 21:10:35 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:50453 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758294AbYALCKe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 21:10:34 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id C1581FCCF6; Sat, 12 Jan 2008 15:10:31 +1300 (NZDT)
FCC: imap://sam@mail.utsl.gen.nz/INBOX/Sent
X-Identity-Key: id1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70250>

Linus Torvalds wrote:
> 
> On Fri, 11 Jan 2008, Sam Vilain wrote:
>> The difference seems only barely measurable;
> 
> Ok. 
> 
> It may be that it might help other cases, but that seems unlikely.
> 
> The more likely answer is that it's either of:
> 
>  - yes, zlib uncompression is noticeable in profiles, but that the 
>    cold-cache access is simply the bigger problem, and getting rid of zlib 
>    just moves the expense to whatever other thing that needs to access it 
>    (memcpy, xdelta apply, whatever)
> 
> or
> 
>  - I don't know exactly which patch you used (did you just do the 
>    "core.deltacompression=0" thing?), and maybe zlib is fairly expensive 
>    even for just the setup crud, even when it doesn't really need to be.
> 
> but who knows..

Well, my figures agree with Pierre I think - 6-10% time savings for
'git annotate'.

I think Pierre has hit the nail on the head - that skipping
compression for small objects is a clear win.  He saw the obvious
criterion, really.  I've knocked it up as a config option that doesn't
change the default behaviour below.

I can't help but speculate what benefits having a range of one or two
of the most elite compression algorithms (eg, lzop or even lzma for
the larger blobs) available would be, in general.  eg, if gzip takes a
stream longer than X kb to offer substantial benefits over lzop, lzop
the ones shorter than that.

If the uncompressed objects are clustered in the pack, then they might
stream compress a lot better, should they be tranmitted over a http
transport with gzip encoding.  In packs which should be as small as
possible, with a format change they could be distributed as one
compressed resource.  The ordering of the objects would ideally be
selected such that it results in optimum compression - which could add
a savings akin to bzip2 vs gzip, at the expense of having to scan the
small objects for mini-deltas and arrange them clustering objects
which share these mini-deltas.

Well, interesting ideas anyway :)

Subject: [PATCH] pack-objects: add compressionMinSize option

Objects smaller than a page don't save much space when compressed, and
cause some overhead.  Allow the user to specify a minimum size for
objects before they are compressed.

Credit: Pierre Habouzit <madcoder@debian.org>
Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/config.txt |    5 +++++
 builtin-pack-objects.c   |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1b6d6d6..245121e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -734,6 +734,11 @@ pack.compression::
 	compromise between speed and compression (currently equivalent
 	to level 6)."
 
+pack.compressionMinSize::
+	Objects smaller than this are not compressed.  This can make
+	operations that deal with many small objects (such as log)
+	faster.
+
 pack.deltaCacheSize::
 	The maximum memory in bytes used for caching deltas in
 	linkgit:git-pack-objects[1].
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a39cb82..316b809 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -76,6 +76,7 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int compression_min_size = 0;
 
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 0;
@@ -433,7 +434,7 @@ static unsigned long write_object(struct sha1file *f,
 		}
 		/* compress the data to store and put compressed length in datalen */
 		memset(&stream, 0, sizeof(stream));
-		deflateInit(&stream, pack_compression_level);
+		deflateInit(&stream, size >= compression_min_size ? pack_compression_level : 0);
 		maxsize = deflateBound(&stream, size);
 		out = xmalloc(maxsize);
 		/* Compress it */
@@ -1841,6 +1842,10 @@ static int git_pack_config(const char *k, const char *v)
 		pack_compression_seen = 1;
 		return 0;
 	}
+	if (!strcmp(k, "pack.compressionminsize")) {
+		compression_min_size = git_config_int(k, v);
+		return 0;	
+	}
 	if (!strcmp(k, "pack.deltacachesize")) {
 		max_delta_cache_size = git_config_int(k, v);
 		return 0;
-- 
1.5.3.7.2095.gb2448-dirty
