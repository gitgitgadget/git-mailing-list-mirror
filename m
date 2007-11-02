From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make the pack index version configurable
Date: Thu, 01 Nov 2007 23:26:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711012312480.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 04:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnJN-0007QO-FT
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbXKBD0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXKBD0H
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:26:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25732 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbXKBD0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:26:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQV00JAS07GTM20@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 23:26:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63051>

It is a good idea to use pack index version 2 all the time since it has
proper protection against propagation of certain pack corruptions when
repacking which is not possible with index version 1, as demonstrated
in test t5302.

Hence this config option.

The default is still pack index version 1.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/Documentation/config.txt b/Documentation/config.txt
index d4a476e..862b79e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -660,6 +660,15 @@ pack.threads::
 	machines. The required amount of memory for the delta search window
 	is however multiplied by the number of threads.
 
+pack.indexVersion::
+	Specify the default pack index version.  Valid values are 1 for
+	legacy pack index used by Git versions prior to 1.5.2, and 2 for
+	the new pack index with capabilities for packs larger than 4 GB
+	as well as proper protection against the repacking of corrupted
+	packs.  Version 2 is selected and this config option ignored
+	whenever the corresponding pack is larger than 2 GB.  Otherwise
+	the default is 1.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 25ec65d..e923689 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1768,6 +1768,12 @@ static int git_pack_config(const char *k, const char *v)
 #endif
 		return 0;
 	}
+	if (!strcmp(k, "pack.indexversion")) {
+		pack_idx_default_version = git_config_int(k, v);
+		if (pack_idx_default_version > 2)
+			die("bad pack.indexversion=%d", pack_idx_default_version);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
 
diff --git a/index-pack.c b/index-pack.c
index 61ea762..715a5bb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -683,6 +683,17 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	}
 }
 
+static int git_index_pack_config(const char *k, const char *v)
+{
+	if (!strcmp(k, "pack.indexversion")) {
+		pack_idx_default_version = git_config_int(k, v);
+		if (pack_idx_default_version > 2)
+			die("bad pack.indexversion=%d", pack_idx_default_version);
+		return 0;
+	}
+	return git_default_config(k, v);
+}
+
 int main(int argc, char **argv)
 {
 	int i, fix_thin_pack = 0;
@@ -693,6 +704,8 @@ int main(int argc, char **argv)
 	struct pack_idx_entry **idx_objects;
 	unsigned char sha1[20];
 
+	git_config(git_index_pack_config);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
