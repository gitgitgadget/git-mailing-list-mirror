From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make shallow repository deepening more network efficient
Date: Thu, 03 Sep 2009 19:08:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909031847520.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 01:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjLQM-0007xt-GW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 01:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbZICXIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 19:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbZICXIw
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 19:08:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52705 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429AbZICXIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 19:08:51 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPF00GGY4A98HP1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Sep 2009 19:08:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127668>


First of all, I can't find any reason why thin pack generation is 
explicitly disabled when dealing with a shallow repository.  The 
possible delta base objects are collected from the edge commits which 
are always obtained through history walking with the same shallow refs 
as the client, Therefore the client is always going to have those base 
objects available. So let's remove that restriction.

Then we can make shallow repository deepening much more efficient by 
using the remote's unshallowed commits as edge commits to get preferred 
base objects for thin pack generation.  On git.git, this makes the data 
transfer for the deepening of a shallow repository from depth 1 to depth 2
around 134 KB instead of 3.68 MB.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/upload-pack.c b/upload-pack.c
index f73e3c9..c77ab71 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -32,6 +32,7 @@ static int no_progress, daemon_mode;
 static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
+static struct object_array extra_edge_obj;
 static unsigned int timeout;
 /* 0 for no sideband,
  * otherwise maximum packet size (up to 65520 bytes).
@@ -135,6 +136,10 @@ static int do_rev_list(int fd, void *create_full_pack)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
+	if (use_thin_pack)
+		for (i = 0; i < extra_edge_obj.nr; i++)
+			fprintf(pack_pipe, "-%s\n", sha1_to_hex(
+					extra_edge_obj.objects[i].item->sha1));
 	traverse_commit_list(&revs, show_commit, show_object, NULL);
 	fflush(pack_pipe);
 	fclose(pack_pipe);
@@ -562,7 +567,6 @@ static void receive_needs(void)
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
-			use_thin_pack = 0;
 			if (get_sha1(line + 8, sha1))
 				die("invalid shallow line: %s", line);
 			object = parse_object(sha1);
@@ -574,7 +578,6 @@ static void receive_needs(void)
 		}
 		if (!prefixcmp(line, "deepen ")) {
 			char *end;
-			use_thin_pack = 0;
 			depth = strtol(line + 7, &end, 0);
 			if (end == line + 7 || depth <= 0)
 				die("Invalid deepen: %s", line);
@@ -657,6 +660,7 @@ static void receive_needs(void)
 							NULL, &want_obj);
 					parents = parents->next;
 				}
+				add_object_array(object, NULL, &extra_edge_obj);
 			}
 			/* make sure commit traversal conforms to client */
 			register_shallow(object->sha1);
