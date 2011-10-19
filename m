From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 15:38:34 -0400
Message-ID: <20111019193834.GA14168@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 21:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGbyO-0002En-38
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 21:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab1JSTih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 15:38:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35751
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab1JSTig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 15:38:36 -0400
Received: (qmail 31846 invoked by uid 107); 19 Oct 2011 19:38:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Oct 2011 15:38:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2011 15:38:34 -0400
Content-Disposition: inline
In-Reply-To: <20111019190114.GA4670@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183943>

On Wed, Oct 19, 2011 at 03:01:14PM -0400, Jeff King wrote:

> Too bad it won't work in an append only way.  The internal state of sha1
> after a certain set of bytes is deterministic, so you could do something
> like:

OK, here's a patch which does that. It's way faster:

  $ git init
  $ time for i in `seq 1 10`; do
      echo $i >file
      git add file
      git commit -q -m $i
    done
  real    0m1.212s
  user    0m1.132s
  sys     0m0.028s

So that's about .12 seconds per commit. Without my patch, it's about .01
seconds. So you waste a tenth of a second generating the collision. Not
too bad.

And the result:

  $ git log --oneline
  31337a1 10
  313376b 9
  3133782 8
  31337cf 7
  313377a 6
  313374b 5
  31337b1 4
  31337a3 3
  3133703 2
  3133706 1

And nothing shows up in the body, because git truncates at the NUL we
added:

  $ git show
  commit 31337a1093af2d97eb2e6c08b261c2946395fdd3
  Author: Jeff King <peff@peff.net>
  Date:   Wed Oct 19 15:34:00 2011 -0400

      10

  diff --git a/file b/file
  index ec63514..f599e28 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -9
  +10

It also parameterizes the desired sha1, so you could easily find hashes
ending in 31337, or any other pattern. Or add "git commit
--collide=31337".

---
diff --git a/commit.c b/commit.c
index 73b7e00..c478752 100644
--- a/commit.c
+++ b/commit.c
@@ -840,6 +840,57 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static unsigned char elite_want[20] = { 0x31, 0x33, 0x70 };
+static unsigned char elite_mask[20] = { 0xff, 0xff, 0xf0 };
+
+static inline int sha1_match_mask(unsigned char *sha1,
+				  unsigned char *want,
+				  unsigned char *mask)
+{
+	int i;
+	for (i = 0; i < 20; i++)
+		if ((want[i] & mask[i]) != (sha1[i] & mask[i]))
+		    return 0;
+	return 1;
+}
+
+static void collide_commit(struct strbuf *data,
+			   unsigned char want[20],
+			   unsigned char mask[20])
+{
+	static const char terminator[] = { 0 };
+	char header[32];
+	int header_len;
+	unsigned int lulz;
+	SHA_CTX base;
+
+	header_len = snprintf(header, sizeof(header),
+			      "commit %lu",
+			      data->len + 1 + sizeof(lulz)) + 1;
+	SHA1_Init(&base);
+	SHA1_Update(&base, header, header_len);
+	SHA1_Update(&base, data->buf, data->len);
+	SHA1_Update(&base, terminator, sizeof(terminator));
+
+	lulz = 0;
+	do {
+		SHA_CTX guess;
+		unsigned char sha1[20];
+
+		memcpy(&guess, &base, sizeof(guess));
+		SHA1_Update(&guess, &lulz, sizeof(lulz));
+		SHA1_Final(sha1, &guess);
+
+		if (sha1_match_mask(sha1, want, mask)) {
+			strbuf_add(data, terminator, sizeof(terminator));
+			strbuf_add(data, &lulz, sizeof(lulz));
+			return;
+		}
+
+		lulz++;
+	} while (1);
+}
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -890,6 +941,8 @@ int commit_tree(const char *msg, unsigned char *tree,
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
+	collide_commit(&buffer, elite_want, elite_mask);
+
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
 	return result;
