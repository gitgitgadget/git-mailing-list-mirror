From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Allow the ident attribute to include a length specifier
Date: Mon, 14 May 2007 14:05:29 +0100
Message-ID: <200705141405.29550.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 15:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnaFH-0007dU-NK
	for gcvg-git@gmane.org; Mon, 14 May 2007 15:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbXENNFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 09:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbXENNFh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 09:05:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:18274 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbXENNFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 09:05:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1333153uga
        for <git@vger.kernel.org>; Mon, 14 May 2007 06:05:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=RfHsWUx4GeuhQxGCylvN4+EzlA05DidFjLfJ7e6xlLcVn2AKD1QQbDFFcnlejl6bgj/CXZyXTgE5lOiWe0eXse+/v/+V9zQqvKAO+cafceyTv3TnbJUVklxF7rrhhqy2BRwGcePYyCIbBkGn+qoqknmRKFTdgWBI+1QkJ23/XWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=W4L4E4oSW1mCP5amO4PmHuM+u+078KAegFOZCHS5qGRyrLzj/HlrmpqV9Up1PI81X+Cw0U98FzV8nKPZL77I+aiKV62g72VjZc44f0GtfLvFMu/CWE2g2+LEct1IdMUw0UrXwIr/lZ0jGFbXVT+gYFDXJqBhGN4GgYyx5h1POss=
Received: by 10.82.158.12 with SMTP id g12mr1675498bue.1179147934840;
        Mon, 14 May 2007 06:05:34 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm15593863ikz.2007.05.14.06.05.33;
        Mon, 14 May 2007 06:05:33 -0700 (PDT)
X-TUID: 75e3a6cba7be185a
X-UID: 307
X-Length: 1597
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47237>

When the ident attribute is found for a path, then git replaces $ident$
with:

  $ident: df2a1fd3ebce86876721bd7e12ce02ac89c885db $

With this patch, you can put the following in your attribute file:

  somepath ident=10

And get expansions like this:

  $ident: df2a1fd3eb $

There is no change to existing behaviour.  With no parameter, the
expansion is all 40 hex digits.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 convert.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 9ee31b0..79dfbcf 100644
--- a/convert.c
+++ b/convert.c
@@ -534,8 +534,8 @@ static char *ident_to_worktree(const char *path, const char *src, unsigned long
 
 		memcpy(dst, "ident: ", 7);
 		dst += 7;
-		memcpy(dst, sha1_to_hex(sha1), 40);
-		dst += 40;
+		memcpy(dst, sha1_to_hex(sha1), ident);
+		dst += ident;
 		*dst++ = ' ';
 		size -= (cp - src);
 		src = cp;
@@ -580,7 +580,13 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 {
 	const char *value = check->value;
 
-	return !!ATTR_TRUE(value);
+	if( ATTR_UNSET(value) || ATTR_FALSE(value) )
+		return 0;
+
+	if( ATTR_TRUE(value) )
+		return 40;
+
+	return atoi(value);
 }
 
 char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
-- 
1.5.2.rc3.27.g43d151-dirty
