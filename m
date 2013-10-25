From: Jeff King <peff@peff.net>
Subject: Re: pack corruption post-mortem
Date: Fri, 25 Oct 2013 03:55:02 -0400
Message-ID: <20131025075502.GC17029@sigill.intra.peff.net>
References: <20131016083400.GA31266@sigill.intra.peff.net>
 <201310160941.16904.mfick@codeaurora.org>
 <20131017003546.GA12439@sigill.intra.peff.net>
 <xmqqfvrz3nnq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZcEj-0005lA-I7
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3JYHzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 03:55:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:55414 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751378Ab3JYHzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 03:55:05 -0400
Received: (qmail 8842 invoked by uid 102); 25 Oct 2013 07:55:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 02:55:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 03:55:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvrz3nnq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236694>

On Thu, Oct 17, 2013 at 08:47:05AM -0700, Junio C Hamano wrote:

> > In general, I don't think we know enough about patterns of recovery
> > corruption to say which commands would definitely be worth implementing.
> > Part of the reason I wrote this up is to document this one case. But
> > this is the first time in 7 years of git usage that I've had to do this.
> > So I'd feel a little bit better about sinking time into it after seeing
> > a few more cases and realizing where the patterns are.
> 
> There was one area in our Documentation/ set we used to use to keep
> this kind of message almost as-is; perhaps this message fits there?

I've wondered if that howto section has much value, as they are already
available in the list archive, and often show their age after a while.
Still, I suppose it is a sort of curated list of interesting posts.

Here's my article, all gussied up for the howto directory. Take it or
leave it.

-- >8 --
Subject: [PATCH] howto: add article on recovering a corrupted object

This is an asciidoc-ified version of a corruption post-mortem sent to
the git list. It complements the existing howto article, since it covers
a case where the object couldn't be easily recreated or copied from
elsewhere.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile                             |   1 +
 .../howto/recover-corrupted-object-harder.txt      | 242 +++++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 Documentation/howto/recover-corrupted-object-harder.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4f13a23..91a12c7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -53,6 +53,7 @@ SP_ARTICLES += howto/setup-git-server-over-http
 SP_ARTICLES += howto/separating-topic-branches
 SP_ARTICLES += howto/revert-a-faulty-merge
 SP_ARTICLES += howto/recover-corrupted-blob-object
+SP_ARTICLES += howto/recover-corrupted-object-harder
 SP_ARTICLES += howto/rebuild-from-update-hook
 SP_ARTICLES += howto/rebase-from-internal-branch
 SP_ARTICLES += howto/maintain-git
diff --git a/Documentation/howto/recover-corrupted-object-harder.txt b/Documentation/howto/recover-corrupted-object-harder.txt
new file mode 100644
index 0000000..6f33dac
--- /dev/null
+++ b/Documentation/howto/recover-corrupted-object-harder.txt
@@ -0,0 +1,242 @@
+Date: Wed, 16 Oct 2013 04:34:01 -0400
+From: Jeff King <peff@peff.net>
+Subject: pack corruption post-mortem
+Abstract: Recovering a corrupted object when no good copy is available.
+Content-type: text/asciidoc
+
+How to recover an object from scratch
+=====================================
+
+I was recently presented with a repository with a corrupted packfile,
+and was asked if the data was recoverable. This post-mortem describes
+the steps I took to investigate and fix the problem. I thought others
+might find the process interesting, and it might help somebody in the
+same situation.
+
+********************************
+Note: In this case, no good copy of the repository was available. For
+the much easier case where you can get the corrupted object from
+elsewhere, see link:recover-corrupted-blob-object.html[this howto].
+********************************
+
+I started with an fsck, which found a problem with exactly one object
+(I've used $pack and $obj below to keep the output readable, and also
+because I'll refer to them later):
+
+-----------
+    $ git fsck
+    error: $pack SHA1 checksum mismatch
+    error: index CRC mismatch for object $obj from $pack at offset 51653873
+    error: inflate: data stream error (incorrect data check)
+    error: cannot unpack $obj from $pack at offset 51653873
+-----------
+
+The pack checksum failing means a byte is munged somewhere, and it is
+presumably in the object mentioned (since both the index checksum and
+zlib were failing).
+
+Reading the zlib source code, I found that "incorrect data check" means
+that the adler-32 checksum at the end of the zlib data did not match the
+inflated data. So stepping the data through zlib would not help, as it
+did not fail until the very end, when we realize the crc does not match.
+The problematic bytes could be anywhere in the object data.
+
+The first thing I did was pull the broken data out of the packfile. I
+needed to know how big the object was, which I found out with:
+
+------------
+    $ git show-index <$idx | cut -d' ' -f1 | sort -n | grep -A1 51653873
+    51653873
+    51664736
+------------
+
+Show-index gives us the list of objects and their offsets. We throw away
+everything but the offsets, and then sort them so that our interesting
+offset (which we got from the fsck output above) is followed immediately
+by the offset of the next object. Now we know that the object data is
+10863 bytes long, and we can grab it with:
+
+------------
+  dd if=$pack of=object bs=1 skip=51653873 count=10863
+------------
+
+I inspected a hexdump of the data, looking for any obvious bogosity
+(e.g., a 4K run of zeroes would be a good sign of filesystem
+corruption). But everything looked pretty reasonable.
+
+Note that the "object" file isn't fit for feeding straight to zlib; it
+has the git packed object header, which is variable-length. We want to
+strip that off so we can start playing with the zlib data directly. You
+can either work your way through it manually (the format is described in
+link:../technical/pack-format.html[Documentation/technical/pack-format.txt]),
+or you can walk through it in a debugger. I did the latter, creating a
+valid pack like:
+
+------------
+    # pack magic and version
+    printf 'PACK\0\0\0\2' >tmp.pack
+    # pack has one object
+    printf '\0\0\0\1' >>tmp.pack
+    # now add our object data
+    cat object >>tmp.pack
+    # and then append the pack trailer
+    /path/to/git.git/test-sha1 -b <tmp.pack >trailer
+    cat trailer >>tmp.pack
+------------
+
+and then running "git index-pack tmp.pack" in the debugger (stop at
+unpack_raw_entry). Doing this, I found that there were 3 bytes of header
+(and the header itself had a sane type and size). So I stripped those
+off with:
+
+------------
+    dd if=object of=zlib bs=1 skip=3
+------------
+
+I ran the result through zlib's inflate using a custom C program. And
+while it did report the error, I did get the right number of output
+bytes (i.e., it matched git's size header that we decoded above). But
+feeding the result back to "git hash-object" didn't produce the same
+sha1. So there were some wrong bytes, but I didn't know which. The file
+happened to be C source code, so I hoped I could notice something
+obviously wrong with it, but I didn't. I even got it to compile!
+
+I also tried comparing it to other versions of the same path in the
+repository, hoping that there would be some part of the diff that didn't
+make sense. Unfortunately, this happened to be the only revision of this
+particular file in the repository, so I had nothing to compare against.
+
+So I took a different approach. Working under the guess that the
+corruption was limited to a single byte, I wrote a program to munge each
+byte individually, and try inflating the result. Since the object was
+only 10K compressed, that worked out to about 2.5M attempts, which took
+a few minutes.
+
+The program I used is here:
+
+----------------------------------------------
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <zlib.h>
+
+static int try_zlib(unsigned char *buf, int len)
+{
+	/* make this absurdly large so we don't have to loop */
+	static unsigned char out[1024*1024];
+	z_stream z;
+	int ret;
+
+	memset(&z, 0, sizeof(z));
+	inflateInit(&z);
+
+	z.next_in = buf;
+	z.avail_in = len;
+	z.next_out = out;
+	z.avail_out = sizeof(out);
+
+	ret = inflate(&z, 0);
+	inflateEnd(&z);
+	return ret >= 0;
+}
+
+/* eye candy */
+static int counter = 0;
+static void progress(int sig)
+{
+	fprintf(stderr, "\r%d", counter);
+	alarm(1);
+}
+
+int main(void)
+{
+	/* oversized so we can read the whole buffer in */
+	unsigned char buf[1024*1024];
+	int len;
+	unsigned i, j;
+
+	signal(SIGALRM, progress);
+	alarm(1);
+
+	len = read(0, buf, sizeof(buf));
+	for (i = 0; i < len; i++) {
+		unsigned char c = buf[i];
+		for (j = 0; j <= 0xff; j++) {
+			buf[i] = j;
+
+			counter++;
+			if (try_zlib(buf, len))
+				printf("i=%d, j=%x\n", i, j);
+		}
+		buf[i] = c;
+	}
+
+	alarm(0);
+	fprintf(stderr, "\n");
+	return 0;
+}
+----------------------------------------------
+
+I compiled and ran with:
+
+-------
+  gcc -Wall -Werror -O3 munge.c -o munge -lz
+  ./munge <zlib
+-------
+
+
+There were a few false positives early on (if you write "no data" in the
+zlib header, zlib thinks it's just fine :) ). But I got a hit about
+halfway through:
+
+-------
+  i=5642, j=c7
+-------
+
+I let it run to completion, and got a few more hits at the end (where it
+was munging the crc to match our broken data). So there was a good
+chance this middle hit was the source of the problem.
+
+I confirmed by tweaking the byte in a hex editor, zlib inflating the
+result (no errors!), and then piping the output into "git hash-object",
+which reported the sha1 of the broken object. Success!
+
+I fixed the packfile itself with:
+
+-------
+  chmod +w $pack
+  printf '\xc7' | dd of=$pack bs=1 seek=51659518 conv=notrunc
+  chmod -w $pack
+-------
+
+The `\xc7` comes from the replacement byte our "munge" program found.
+The offset 51659518 is derived by taking the original object offset
+(51653873), adding the replacement offset found by "munge" (5642), and
+then adding back in the 3 bytes of git header we stripped.
+
+After that, "git fsck" ran clean.
+
+As for the corruption itself, I was lucky that it was indeed a single
+byte. In fact, it turned out to be a single bit. The byte 0xc7 was
+corrupted to 0xc5. So presumably it was caused by faulty hardware, or a
+cosmic ray.
+
+And the aborted attempt to look at the inflated output to see what was
+wrong? I could have looked forever and never found it. Here's the diff
+between what the corrupted data inflates to, versus the real data:
+
+--------------
+  -       cp = strtok (arg, "+");
+  +       cp = strtok (arg, ".");
+--------------
+
+It tweaked one byte and still ended up as valid, readable C that just
+happened to do something totally different! One takeaway is that on a
+less unlucky day, looking at the zlib output might have actually been
+helpful, as most random changes would actually break the C code.
+
+But more importantly, git's hashing and checksumming noticed a problem
+that easily could have gone undetected in another system. The result
+still compiled, but would have caused an interesting bug (that would
+have been blamed on some random commit).
-- 
1.8.4.1.898.g8bf8a41.dirty
