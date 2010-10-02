From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Sat, 2 Oct 2010 03:41:00 -0500
Message-ID: <20101002084100.GH29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:44:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xhX-0005Fm-6Z
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab0JBIoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:44:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62035 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab0JBIoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:44:08 -0400
Received: by iwn5 with SMTP id 5so4742916iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UjfALOL+A1lg6ufERKFTv3wEgZWX/mkB6Q+5GpnYHVs=;
        b=YhFjIcWss+fYO2aAAyMeMx02VkoDmgRlwXKXKvM7KwSLzAoBFAmd7Gn38jsGpNBVTF
         UPMrdMjEZXIdZnHH8p64+Hiufy8qmsmV0nvGR3s/q8RugQBh9yeEjnrmAp/EFoyRtHU5
         SHN1ZudksSKhumgV399yb7Kw4jbpSAYU+MM0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ck77Ifzo6Qk0cz+zO9es2X8QPVQ/ww9VFHCPUU+tZYaDUesTW1nqrbB+HVvHnmx5Bh
         wM54zyWb7jdHOvC68yPLgPXdugMolT1F1CJXH+cwMFs3JLKC7gqLqc1yyYkd/GcTMMUp
         KE1Jf0ebQW3HAxV2F6b7eaBu39jNlqjoTBuPg=
Received: by 10.231.59.212 with SMTP id m20mr6922287ibh.130.1286009048485;
        Sat, 02 Oct 2010 01:44:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r3sm2234883ibk.7.2010.10.02.01.44.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:44:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002082752.GA29638@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157802>

This buffer is freed by the C runtime when commit-tree exits moments
later, but freeing it explicitly should hopefully make this code
easier to reuse (in addition to making valgrind quieter).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

 builtin/commit-tree.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 87f0591..732f895 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -56,10 +56,12 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die_errno("git commit-tree: failed to read");
 
-	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
-		printf("%s\n", sha1_to_hex(commit_sha1));
-		return 0;
-	}
-	else
+	if (commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
+		strbuf_release(&buffer);
 		return 1;
+	}
+
+	printf("%s\n", sha1_to_hex(commit_sha1));
+	strbuf_release(&buffer);
+	return 0;
 }
-- 
1.7.2.3
