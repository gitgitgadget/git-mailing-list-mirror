From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Little performance optimization - replace the
	previous one
Date: Sat, 31 Jan 2009 15:19:26 +0100
Message-ID: <1233411566.7844.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O.Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:21:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTGiQ-0007bY-Uj
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 15:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbZAaOTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 09:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZAaOTc
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 09:19:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15715 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZAaOTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 09:19:31 -0500
Received: by fg-out-1718.google.com with SMTP id 16so237199fgg.17
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=J/KdxKUnfSHqgNENpp+G3ih89rtO6oFQtRRONX4squQ=;
        b=fd3X4GatIB+ocdiBriI/EfW5R/mFxmQizfreSiN9luBwnzkj/4PbnV28+TNDWDmnbP
         5X87nHwy0x9e4L8qaDixK8h3ceBI5MxBGfKcG2NOH8WtSKMFWeh3yRvLA8Avv90f2dzm
         8FTDb5Ewzc3ht6cMyQYPXAmXRImMIFZ1G1T2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=hQOiQd+4zbV3gSlYUwb/8hU1K1ZPB2vA/xPUFbCGnnvgaobq8n+JbGaZro/w1T9nMB
         k0rZ7DEBqOhsaAe//Glm2LkHSGiFRc2bHEtN2fWp/BU63l+aPmbpRc6aSOGVn8NMRwoe
         1gQWjFB5QbyfRfdqsQO2dcvIuca223X4j2VNY=
Received: by 10.103.217.5 with SMTP id u5mr413415muq.42.1233411569320;
        Sat, 31 Jan 2009 06:19:29 -0800 (PST)
Received: from ?85.178.76.63? (e178076063.adsl.alicedsl.de [85.178.76.63])
        by mx.google.com with ESMTPS id 23sm1058784mun.28.2009.01.31.06.19.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 06:19:28 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107923>

- avoid one if
- avoid to calculate 2 times the same value

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/GitIndex.java         |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 454b540..6eeccff 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -411,11 +411,9 @@ Entry(ByteBuffer b) {
                 * @throws IOException
                 */
                public boolean update(File f) throws IOException {
-                       boolean modified = false;
                        long lm = f.lastModified() * 1000000L;
-                       if (mtime != lm)
-                               modified = true;
-                       mtime = f.lastModified() * 1000000L;
+                       boolean modified = mtime != lm;
+                       mtime = lm;
                        if (size != f.length())
                                modified = true;
                        if (config_filemode()) {
--
1.6.0.6
