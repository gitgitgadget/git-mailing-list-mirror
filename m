From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (BUGFIX)] Respect core.autocrlf in combined diff
Date: Sat, 23 Aug 2008 23:21:21 +0400
Organization: TEPKOM
Message-ID: <200808232321.21795.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 21:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWyhC-0006CY-RU
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYHWTVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbYHWTVn
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:21:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:6318 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbYHWTVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:21:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so561959fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4eYrqVzNbllpD+DKXcrPyQp7rf0gRWciVUlaZypvN0Y=;
        b=hNXxa3bGp5khA6zb8WY3XJ8KCS6Sa6KeO4LdusPM4/ePzsNjgcHJx3yk2vU8x00H+a
         L357g0nx15jfIsnrh5pwUDyH0hGchi+LkMrw5W5IdDoq5km6dN7kL+r8sZd6lchuX1dE
         DleGeiURTKeLaqrtn3y8ZMRwHXNMrdsmtASg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=VR/VfVYr0x8X6bOYrGYhBRiM/btGlrg3Pkkq3UiKCwrE2RZhKzURLRNGa1CzaMWKB0
         PgvwN5WCbDwmu6AYjBWIhSL3PaFjtirtJIRFmAqJ/MtMyZwkCV4VKySRB/HEGOa7ej7o
         2bI8iOyr6sYp/nwM33inGgZgKDlY5Ah7SPSuk=
Received: by 10.180.244.19 with SMTP id r19mr1372811bkh.94.1219519300903;
        Sat, 23 Aug 2008 12:21:40 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id e17sm2225066fke.10.2008.08.23.12.21.39
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 12:21:39 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93474>

Fix git-diff to make it produce useful 3-way
diffs for merge conflicts in repositories with
autocrlf enabled. Otherwise it always reports
that the whole file was changed.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I noticed that combined diffs, which are shown by git-diff for files
	with conflicts, are unusable on repositories with autocrlf=true. 

	Steps to reproduce:

		git init
		echo foo > file
		git add file
		git commit -m init
		git checkout -b a
		git checkout -b b
		echo bbb >> file
		git add file
		git commit -m bbb
		git checkout a
		echo aaa >> file
		git add file
		git commit -m aaa
		git config core.autocrlf true
		git merge b

	Then look at the output of git diff.

	-- Alexander

 combine-diff.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 9f80a1c..da1ca99 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -727,6 +727,18 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				die("early EOF '%s'", elem->path);
 
 			result[len] = 0;
+
+			/* If not a fake symlink, apply filters, e.g. autocrlf */
+			if (is_file) {
+				struct strbuf buf;
+				
+				strbuf_init(&buf, 0);
+				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+					free(result);
+					result = strbuf_detach(&buf, &len);
+					result_size = len;
+				}
+			}
 		}
 		else {
 		deleted_file:
-- 
1.6.0.rc2
