From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pkt-line: Fix sparse errors and warnings
Date: Sat, 23 Feb 2013 17:37:00 -0500
Message-ID: <20130223223700.GB2504@sigill.intra.peff.net>
References: <51290DF4.4040309@ramsay1.demon.co.uk>
 <20130223223134.GA2504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Nir-0000rM-M1
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 23:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758938Ab3BWWhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 17:37:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58775 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758530Ab3BWWhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 17:37:02 -0500
Received: (qmail 25315 invoked by uid 107); 23 Feb 2013 22:38:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Feb 2013 17:38:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2013 17:37:00 -0500
Content-Disposition: inline
In-Reply-To: <20130223223134.GA2504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216922>

On Sat, Feb 23, 2013 at 05:31:34PM -0500, Jeff King wrote:

> On Sat, Feb 23, 2013 at 06:44:04PM +0000, Ramsay Jones wrote:
> 
> > Sparse issues the following error and warnings:
> > 
> >     pkt-line.c:209:51: warning: Using plain integer as NULL pointer
> >     sideband.c:41:52: warning: Using plain integer as NULL pointer
> >     daemon.c:615:39: warning: Using plain integer as NULL pointer
> >     remote-curl.c:220:75: error: incompatible types for operation (>)
> >     remote-curl.c:220:75:    left side has type char *
> >     remote-curl.c:220:75:    right side has type int
> >     remote-curl.c:291:53: warning: Using plain integer as NULL pointer
> >     remote-curl.c:408:43: warning: Using plain integer as NULL pointer
> >     remote-curl.c:562:47: warning: Using plain integer as NULL pointer
> > 
> > All of these complaints "blame" to commit 17243606 ("pkt-line: share
> > buffer/descriptor reading implementation", 20-02-2013).
> > 
> > In order to suppress the warnings, we simply replace the integer
> > constant 0 with NULL.
> [...]
> Oddly, you seemed to miss the one in connect.c (which my sparse does
> detect).

Ah, I saw why as soon as I finished off the rebase: that (NULL, 0) goes
away in the very next patch, and you probably ran sparse just on the tip
of the topic (via pu). I still think it's worth fixing since we are
squashing anyway. Junio, it will give you a trivial conflict on patch
16, but you can just resolve in favor of what patch 16 does. If it's
easier, here's the revised patch 16:

-- >8 --
Subject: [PATCH] teach get_remote_heads to read from a memory buffer

Now that we can read packet data from memory as easily as a
descriptor, get_remote_heads can take either one as a
source. This will allow further refactoring in remote-curl.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
index 3d99999..f57efd0 100644
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
 
-		len = packet_read(in, NULL, NULL,
+		len = packet_read(in, &src_buf, &src_len,
 				  packet_buffer, sizeof(packet_buffer),
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
diff --git a/remote-curl.c b/remote-curl.c
index c8379a5..24c8626 100644
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
1.8.1.4.4.g265d2fa
