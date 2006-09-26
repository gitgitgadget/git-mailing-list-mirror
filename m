From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 8/6] let the GIT native protocol use offsets to delta base when
 possible
Date: Tue, 26 Sep 2006 11:27:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609261108250.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 17:33:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSEqd-0004Kj-B2
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 17:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWIZP1l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 11:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWIZP1l
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 11:27:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42788 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932120AbWIZP1k
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 11:27:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6700JFMHM37B70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Sep 2006 11:27:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27798>

There is no reason not to always do this when both ends agree.  
Therefore a client that can accept offsets to delta base always sends 
the "ofs-delta" flag.  The server will stream a pack with or without 
offset to delta base depending on whether that flag is provided or not 
with no additional cost.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Yeah... 8th of 6 should mean this is pretty much over now.

Since this depends on support that has been merged into the pu branch I 
diffed this against pu.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
diff --git a/fetch-pack.c b/fetch-pack.c
index 99ac08b..90b7940 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -166,12 +166,13 @@ static int find_common(int fd[2], unsign
 		}
 
 		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s\n",
+			packet_write(fd[1], "want %s%s%s%s%s%s\n",
 				     sha1_to_hex(remote),
 				     (multi_ack ? " multi_ack" : ""),
 				     (use_sideband == 2 ? " side-band-64k" : ""),
 				     (use_sideband == 1 ? " side-band" : ""),
-				     (use_thin_pack ? " thin-pack" : ""));
+				     (use_thin_pack ? " thin-pack" : ""),
+				     " ofs-delta");
 		else
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
diff --git a/upload-pack.c b/upload-pack.c
index 4e53edd..4572fff 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -22,7 +22,7 @@ #define REACHABLE	(1u << 15)
 static unsigned long oldest_have;
 
 static int multi_ack, nr_our_refs;
-static int use_thin_pack;
+static int use_thin_pack, use_ofs_delta;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -143,7 +143,9 @@ static void create_pack_file(void)
 		close(pu_pipe[1]);
 		close(pe_pipe[0]);
 		close(pe_pipe[1]);
-		execl_git_cmd("pack-objects", "--stdout", "--progress", NULL);
+		execl_git_cmd("pack-objects", "--stdout", "--progress",
+			      use_ofs_delta ? "--delta-base-offset" : NULL,
+			      NULL);
 		kill(pid_rev_list, SIGKILL);
 		die("git-upload-pack: unable to exec git-pack-objects");
 	}
@@ -476,6 +478,8 @@ static void receive_needs(void)
 			multi_ack = 1;
 		if (strstr(line+45, "thin-pack"))
 			use_thin_pack = 1;
+		if (strstr(line+45, "ofs-delta"))
+			use_ofs_delta = 1;
 		if (strstr(line+45, "side-band-64k"))
 			use_sideband = LARGE_PACKET_MAX;
 		else if (strstr(line+45, "side-band"))
@@ -501,7 +505,7 @@ static void receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	static const char *capabilities = "multi_ack thin-pack side-band side-band-64k";
+	static const char *capabilities = "multi_ack thin-pack side-band side-band-64k ofs-delta";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
