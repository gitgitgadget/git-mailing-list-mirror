X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: fetching packs and storing them as packs
Date: Wed, 25 Oct 2006 23:44:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 03:44:49 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30137>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcwAT-0007pm-TM for gcvg-git@gmane.org; Thu, 26 Oct
 2006 05:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422900AbWJZDo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 23:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422901AbWJZDo2
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 23:44:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11559 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1422900AbWJZDo1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 23:44:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q00LCC51O7990@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Wed,
 25 Oct 2006 23:44:13 -0400 (EDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

With the last few patches I just posted it is now possible to receive 
(fetch) packs, validate them on the fly, complete them if they are thin 
packs, and store them directly without exploding them into loose 
objects.

There are advantages and inconvenients to both methods, so I think this 
should become a configuration option and/or even a command line argument 
to git-fetch. I think there are many more advantages to keeping packs 
packed hence I think using index-pack should become the default.

But I'm a bit tired to play with it and the final integration is for 
someone else to do.  I've tested it lightly using the extremely crude 
patch below to hook it in the fetch process.

Have fun!

diff --git a/fetch-clone.c b/fetch-clone.c
index 76b99af..28796c3 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -142,7 +142,8 @@ int receive_unpack_pack(int xd[2], const
 		dup2(fd[0], 0);
 		close(fd[0]);
 		close(fd[1]);
-		execl_git_cmd("unpack-objects", quiet ? "-q" : NULL, NULL);
+		execl_git_cmd("index-pack", "--stdin", "--fix-thin",
+			      quiet ? NULL : "-v", NULL);
 		die("git-unpack-objects exec failed");
 	}
 	close(fd[0]);
diff --git a/receive-pack.c b/receive-pack.c
index 1fcf3a9..7f6dc49 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -7,7 +7,7 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
-static const char *unpacker[] = { "unpack-objects", NULL };
+static const char *unpacker[] = { "index-pack", "-v", "--stdin", "--fix-thin", NULL };
 
 static int report_status;
