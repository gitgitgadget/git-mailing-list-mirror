From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] honor repack.usedeltabaseoffset when fetching packs
Date: Fri, 01 May 2009 20:18:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905012012380.6741@xanadu.home>
References: <1241215224-29374-1-git-send-email-spearce@spearce.org>
 <alpine.LFD.2.00.0905011916130.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 02 02:18:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M02vr-0007Iy-1y
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 02:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbZEBASL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 20:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754702AbZEBASJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 20:18:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29874 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbZEBASI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 20:18:08 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIZ00MA8Q62TA50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 May 2009 20:18:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0905011916130.6741@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118111>

If the local receiving repository has disabled the use of delta base
offset, for example to retain compatibility with older versions of
Git that predate OFS_DELTA, we shouldn't ask for ofs-delta support
when we obtain a pack from the remote server.

[ issue noticed by Shawn Pearce ]

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Fri, 1 May 2009, Nicolas Pitre wrote:

> Good point.  I doubt it actually matters in practice or we would have 
> heard about some complaints by now.  But for consistency sake I should 
> produce a similar patch for C git as well.

Here it is, with commit log stolen from Shawn's JGit patch.

 builtin-fetch-pack.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 5d134be..012d044 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -13,6 +13,7 @@
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
+static int prefer_ofs_delta = 1;
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -200,7 +201,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				     (args.use_thin_pack ? " thin-pack" : ""),
 				     (args.no_progress ? " no-progress" : ""),
 				     (args.include_tag ? " include-tag" : ""),
-				     " ofs-delta");
+				     (prefer_ofs_delta ? " ofs-delta" : ""));
 		else
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
@@ -596,6 +597,11 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
+	if (server_supports("ofs-delta")) {
+		if (args.verbose)
+			fprintf(stderr, "Server supports ofs-delta\n");
+	} else
+		prefer_ofs_delta = 0;
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
@@ -648,6 +654,11 @@ static int fetch_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "repack.usedeltabaseoffset") == 0) {
+		prefer_ofs_delta = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
