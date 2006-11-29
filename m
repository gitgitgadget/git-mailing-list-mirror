X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: remove redundent status information
Date: Wed, 29 Nov 2006 17:15:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611291704440.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 29 Nov 2006 22:16:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32673>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpXie-0005MO-1H for gcvg-git@gmane.org; Wed, 29 Nov
 2006 23:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758844AbWK2WPu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 17:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758851AbWK2WPu
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 17:15:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8310 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1758844AbWK2WPt
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 17:15:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9I00KB2J6CYC70@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 29 Nov 2006 17:15:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The final 'nr_result' and 'written' values must always be the same 
otherwise we're in deep trouble.  So let's remove a redundent report.

And for paranoia sake let's make sure those two variables are actually 
equal after all objects are written (one never knows).

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 753bcd5..a2dc7d1 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -514,6 +514,8 @@ static void write_pack_file(void)
 	if (do_progress)
 		fputc('\n', stderr);
  done:
+	if (written != nr_result)
+		die("wrote %d objects while expecting %d", written, nr_result);
 	sha1close(f, pack_file_sha1, 1);
 }
 
@@ -1662,7 +1664,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 	if (progress)
-		fprintf(stderr, "Total %d, written %d (delta %d), reused %d (delta %d)\n",
-			nr_result, written, written_delta, reused, reused_delta);
+		fprintf(stderr, "Total %d (delta %d), reused %d (delta %d)\n",
+			written, written_delta, reused, reused_delta);
 	return 0;
