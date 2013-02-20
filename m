From: Jeff King <peff@peff.net>
Subject: [PATCH v3 16/19] teach get_remote_heads to read from a memory buffer
Date: Wed, 20 Feb 2013 15:06:45 -0500
Message-ID: <20130220200645.GP25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:07:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fwp-0007xV-QW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935469Ab3BTUGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:06:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54687 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935294Ab3BTUGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:06:47 -0500
Received: (qmail 17898 invoked by uid 107); 20 Feb 2013 20:08:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:08:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:06:45 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216731>

Now that we can read packet data from memory as easily as a
descriptor, get_remote_heads can take either one as a
source. This will allow further refactoring in remote-curl.

Signed-off-by: Jeff King <peff@peff.net>
---
Another "wrapper vs NULL argument" opportunity. I could go either way if
we feel strongly in one direction. A third option is:

  struct packet_source {
          /* Choose one. */
          int fd;
          char *buf;
          int len;
  };

but then each caller has to be bothered to define and fill in the
struct, which ends up even uglier.

 builtin/fetch-pack.c | 2 +-
 builtin/send-pack.c  | 2 +-
 cache.h              | 4 +++-
 connect.c            | 6 +++---
 remote-curl.c        | 2 +-
 transport.c          | 6 +++---
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c21cc2c..03ed2ca 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -125,7 +125,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
-	get_remote_heads(fd[0], &ref, 0, NULL);
+	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest,
 			 &sought, pack_lockfile_ptr);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8778519..152c4ea 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -207,7 +207,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	memset(&extra_have, 0, sizeof(extra_have));
 
-	get_remote_heads(fd[0], &remote_refs, REF_NORMAL, &extra_have);
+	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_have);
 
 	transport_verify_remote_names(nr_refspecs, refspecs);
 
diff --git a/cache.h b/cache.h
index e493563..db646a2 100644
--- a/cache.h
+++ b/cache.h
@@ -1049,7 +1049,9 @@ struct extra_have_objects {
 	int nr, alloc;
 	unsigned char (*array)[20];
 };
-extern struct ref **get_remote_heads(int in, struct ref **list, unsigned int flags, struct extra_have_objects *);
+extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+				     struct ref **list, unsigned int flags,
+				     struct extra_have_objects *);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
diff --git a/connect.c b/connect.c
index 061aa5b..f57efd0 100644
--- a/connect.c
+++ b/connect.c
@@ -62,8 +62,8 @@ static void die_initial_contact(int got_at_least_one_head)
 /*
  * Read all the refs from the other end
  */
-struct ref **get_remote_heads(int in, struct ref **list,
-			      unsigned int flags,
+struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+			      struct ref **list, unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
 	int got_at_least_one_head = 0;
@@ -76,7 +76,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		int len, name_len;
 		char *buffer = packet_buffer;
 
-		len = packet_read(in, NULL, 0,
+		len = packet_read(in, &src_buf, &src_len,
 				  packet_buffer, sizeof(packet_buffer),
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
diff --git a/remote-curl.c b/remote-curl.c
index c0edd4c..3bc6cb5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -192,7 +192,7 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 
 	if (start_async(&async))
 		die("cannot start thread to parse advertised refs");
-	get_remote_heads(async.out, &list,
+	get_remote_heads(async.out, NULL, 0, &list,
 			for_push ? REF_NORMAL : 0, NULL);
 	close(async.out);
 	if (finish_async(&async))
diff --git a/transport.c b/transport.c
index 886ffd8..62df466 100644
--- a/transport.c
+++ b/transport.c
@@ -507,7 +507,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	struct ref *refs;
 
 	connect_setup(transport, for_push, 0);
-	get_remote_heads(data->fd[0], &refs,
+	get_remote_heads(data->fd[0], NULL, 0, &refs,
 			 for_push ? REF_NORMAL : 0, &data->extra_have);
 	data->got_remote_heads = 1;
 
@@ -541,7 +541,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
-		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0, NULL);
 		data->got_remote_heads = 1;
 	}
 
@@ -799,7 +799,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
 
-		get_remote_heads(data->fd[0], &tmp_refs, REF_NORMAL, NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL);
 		data->got_remote_heads = 1;
 	}
 
-- 
1.8.2.rc0.9.g352092c
