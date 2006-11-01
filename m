X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/6] Allow pack header preprocessing before
 unpack-objects/index-pack.
Date: Wed, 01 Nov 2006 17:06:20 -0500
Message-ID: <11624187853116-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Nov 2006 22:06:47 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.3.g87b2-dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30664>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOEB-0005XC-H7 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752502AbWKAWG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbWKAWG1
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:06:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63137 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752502AbWKAWG0
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:06:26 -0500
Received: from localhost.localdomain ([74.56.106.175]) by
 VL-MH-MR002.ip.videotron.ca (Sun Java System Messaging Server 6.2-2.05 (built
 Apr 28 2005)) with ESMTP id <0J8200BN9O2PMF20@VL-MH-MR002.ip.videotron.ca>
 for git@vger.kernel.org; Wed, 01 Nov 2006 17:06:25 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Some applications which invoke unpack-objects or index-pack --stdin
may want to examine the pack header to determine the number of
objects contained in the pack and use that value to determine which
executable to invoke to handle the rest of the pack stream.

However if the caller consumes the pack header from the input stream
then its no longer available for unpack-objects or index-pack --stdin,
both of which need the version and object count to process the stream.

This change introduces --pack_header=ver,cnt as a command line option
that the caller can supply to indicate it has already consumed the
pack header and what version and object count were found in that
header.  As this option is only meant for low level applications
such as receive-pack we are not documenting it at this time.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Patch description text shamelessly stolen from a similar patch from
Shawn Pearce <spearce@spearce.org>.



 builtin-unpack-objects.c |   15 +++++++++++++++
 index-pack.c             |   13 +++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 74a90c1..e6d7574 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -371,6 +371,21 @@ int cmd_unpack_objects(int argc, const c
 				recover = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--pack_header=", 14)) {
+				struct pack_header *hdr;
+				char *c;
+
+				hdr = (struct pack_header *)buffer;
+				hdr->hdr_signature = htonl(PACK_SIGNATURE);
+				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
+				if (*c != ',')
+					die("bad %s", arg);
+				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
+				if (*c)
+					die("bad %s", arg);
+				len = sizeof(*hdr);
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
diff --git a/index-pack.c b/index-pack.c
index b37dd78..a3b55f9 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -841,6 +841,19 @@ int main(int argc, char **argv)
 				keep_msg = "";
 			} else if (!strncmp(arg, "--keep=", 7)) {
 				keep_msg = arg + 7;
+			} else if (!strncmp(arg, "--pack_header=", 14)) {
+				struct pack_header *hdr;
+				char *c;
+
+				hdr = (struct pack_header *)input_buffer;
+				hdr->hdr_signature = htonl(PACK_SIGNATURE);
+				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
+				if (*c != ',')
+					die("bad %s", arg);
+				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
+				if (*c)
+					die("bad %s", arg);
+				input_len = sizeof(*hdr);
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
 			} else if (!strcmp(arg, "-o")) {
-- 
1.4.3.3.g87b2-dirty
