From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix mkpath abuse in dwim_ref and dwim_log of sha1_name.c
Date: Sun, 26 Oct 2008 23:07:24 +0100
Message-ID: <20081026220724.GB18594@blimp.localdomain>
References: <20081026215913.GA18594@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 23:08:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuDmt-0005xA-Ns
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYJZWH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYJZWH1
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 18:07:27 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:32369 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbYJZWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 18:07:26 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81pE/a
Received: from tigra.home (Fab75.f.strato-dslnet.de [195.4.171.117])
	by post.webmailer.de (klopstock mo52) (RZmta 17.14)
	with ESMTP id B04137k9QKWKZE ; Sun, 26 Oct 2008 23:07:25 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id A076D277C8;
	Sun, 26 Oct 2008 23:07:24 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 809AF36D27; Sun, 26 Oct 2008 23:07:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081026215913.GA18594@blimp.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99187>

Otherwise the function sometimes fail to resolve obviously correct
refnames, because the string data pointed to by "str" argument were
reused.

The change in dwim_log does not fix anything, just optimizes away
strcpy code as the path can be created directly in the available
buffer.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Was noticed in cygwin port, which somehow (supposedly by excessive
calling of git_config from lstat stub setup) managed to reuse the
just returned buffer.

 sha1_name.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 41b6809..159c2ab 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -245,11 +245,13 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 	*ref = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
+		char fullref[PATH_MAX];
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
 
 		this_result = refs_found ? sha1_from_ref : sha1;
-		r = resolve_ref(mkpath(*p, len, str), this_result, 1, NULL);
+		mksnpath(fullref, sizeof(fullref), *p, len, str);
+		r = resolve_ref(fullref, this_result, 1, NULL);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -272,7 +274,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		char path[PATH_MAX];
 		const char *ref, *it;
 
-		strcpy(path, mkpath(*p, len, str));
+		mksnpath(path, sizeof(path), *p, len, str);
 		ref = resolve_ref(path, hash, 1, NULL);
 		if (!ref)
 			continue;
-- 
1.6.0.3.540.g3f8b
