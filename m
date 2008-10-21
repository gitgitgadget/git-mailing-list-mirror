From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Mon, 20 Oct 2008 21:17:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 03:18:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks5tC-00011e-Ma
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 03:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbYJUBRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 21:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbYJUBRO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 21:17:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45170 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbYJUBRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 21:17:13 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9200HE9E8J77GB@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 20 Oct 2008 21:17:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98753>

Before commit d0b92a3f6e it was possible to run 'git index-pack'
directly in the .git/objects/pack/ directory.  Restore that ability.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/index-pack.c b/index-pack.c
index 0a917d7..79f6fd6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -878,10 +877,26 @@ int main(int argc, char **argv)
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
-	int nongit = 0;
 
-	setup_git_directory_gently(&nongit);
-	git_config(git_index_pack_config, NULL);
+	/*
+	 * We wish to read the repository's config file if any, and
+	 * for that it is necessary to call setup_git_directory_gently().
+	 * However if the cwd was inside .git/objects/pack/ then we need
+	 * to go back there or all the pack name arguments will be wrong.
+	 * And in that case we cannot rely on any prefix returned by 
+	 * setup_git_directory_gently() either.
+	 */
+	{
+		char cwd[PATH_MAX+1];
+		int nongit;
+
+		if (!getcwd(cwd, sizeof(cwd)-1))
+			die("Unable to get current working directory");
+		setup_git_directory_gently(&nongit);
+		git_config(git_index_pack_config, NULL);
+		if (chdir(cwd))
+			die("Cannot come back to cwd");
+	}
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
