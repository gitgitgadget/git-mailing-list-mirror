From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] strbuf: move strbuf_branchname to sha1_name.c
Date: Sat, 6 Nov 2010 06:46:52 -0500
Message-ID: <20101106114652.GD27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhEh-0002eX-6M
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab0KFLrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:47:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44181 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0KFLrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:47:00 -0400
Received: by mail-iw0-f174.google.com with SMTP id 41so1927724iwn.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bUH8qhnArTD3RL7+b2DWI+Q1X6Fzw6CEFXLRTksDCSg=;
        b=vnRfY3CCqMUFFJTafac7Za3FeJAUF26ooP9VahxXydthPLChw5X+HGwQsTz7uHy4Pj
         F9wfU1M9JLgVuVU2b0RJU4FnntzVhPfBs5Mo0kzNepvaXiSNF0b4s7HZ/2Z8YiRzLhEi
         0oMLd19it7atDt3NpzQMAtz6FjOKSRDpMdYcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ngz24viwUOE7lxeQCMd54zVdcmvui7ws0sfgTQQS1rvSGllI3QGHocoWjF56gmW10i
         XrS773dixH0zC6lJBvLGH/4achD54BstcmsujtBdpIYJPXqm+ti9JAIMs+X28UYBrJQQ
         U328Spwc5qZuxhWyCRRPJmKEFr8vrJVKVEx+I=
Received: by 10.231.35.136 with SMTP id p8mr2600124ibd.21.1289044019802;
        Sat, 06 Nov 2010 04:46:59 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d21sm2822822ibg.15.2010.11.06.04.46.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:46:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160846>

strbuf_branchname is a thin wrapper around interpret_branch_name
from sha1_name.o.  Most strbuf.o users do not need it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_name.c |   16 ++++++++++++++++
 strbuf.c    |   16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 484081d..1beebe9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -934,6 +934,22 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	return len;
 }
 
+int strbuf_branchname(struct strbuf *sb, const char *name)
+{
+	int len = strlen(name);
+	if (interpret_branch_name(name, sb) == len)
+		return 0;
+	strbuf_add(sb, name, len);
+	return len;
+}
+
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+{
+	strbuf_branchname(sb, name);
+	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
+	return check_ref_format(sb->buf);
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
diff --git a/strbuf.c b/strbuf.c
index bc3a080..9b3c445 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -386,19 +386,3 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
 }
-
-int strbuf_branchname(struct strbuf *sb, const char *name)
-{
-	int len = strlen(name);
-	if (interpret_branch_name(name, sb) == len)
-		return 0;
-	strbuf_add(sb, name, len);
-	return len;
-}
-
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
-{
-	strbuf_branchname(sb, name);
-	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
-	return check_ref_format(sb->buf);
-}
-- 
1.7.2.3.557.gab647.dirty
