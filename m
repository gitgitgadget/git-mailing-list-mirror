From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] init: plug tiny one-time memory leak
Date: Sun, 3 Oct 2010 23:34:27 -0500
Message-ID: <20101004043427.GE24884@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002083122.GB29638@burratino>
 <7vpqvqdelx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <air@kanis.fr>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 06:37:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2co8-0000d7-PG
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 06:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0JDEho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 00:37:44 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38384 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab0JDEhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 00:37:43 -0400
Received: by gxk9 with SMTP id 9so1552466gxk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 21:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3M31xmKlO2yeEc1KdfpcqMUHjtyXkct0TMIfNDlYDJ0=;
        b=cd9XcVfh/duAH6AYm2UK8pRT4UowRTkWA9Je8SeAnrnS48Ftl1kkxnydlLTDd/s2OV
         a9S2e4CJ0rVCkkDVLo7GxR+mtIB09FqZzwdQm8cSQPGIP+wY7bRp1fDveoMs2oUgycws
         5iDwyr/5wtei07Gn3VeyveVruwMJ2615VWgRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PKgtBCJYchz6JCHNUDsMezrxtqpK0fLZTkja+c1q1MuiKFBpoiKmoHcYDr4ABm2M3/
         2vqoo/PVHOkJ6Mmq953zHsUomXfJxJAzoxZop55hZelTsdP99cN/bvE8u8VLqO6osKBJ
         xM8U6oDqKUgdMkMbzpGLjIy4xmB5y+jur7XUM=
Received: by 10.100.232.8 with SMTP id e8mr4918452anh.92.1286167062456;
        Sun, 03 Oct 2010 21:37:42 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u14sm8377115ann.0.2010.10.03.21.37.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 21:37:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vpqvqdelx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157974>

The buffer used to construct paths like ".git/objects/info" and
".git/objects/pack" is allocated on the heap and never freed.

So free it.  While at it, factor out the relevant code into its own
function and rename the sha1_dir variable to object_directory (to
match the change in everyday usage after the renaming of
SHA1_FILE_DIRECTORY in v0.99~603^2~7, 2005).

Noticed by valgrind while setting up tests (in test-lib).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> While at it it might be a good idea to rename its outdated name to
> something saner, e.g. object_dir, perhaps?

Yes.

 builtin/init-db.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0271285..9d4886c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -294,11 +294,26 @@ static int create_default_files(const char *template_path)
 	return reinit;
 }
 
+static void create_object_directory(void)
+{
+	const char *object_directory = get_object_directory();
+	int len = strlen(object_directory);
+	char *path = xmalloc(len + 40);
+
+	memcpy(path, object_directory, len);
+
+	safe_create_dir(object_directory, 1);
+	strcpy(path+len, "/pack");
+	safe_create_dir(path, 1);
+	strcpy(path+len, "/info");
+	safe_create_dir(path, 1);
+
+	free(path);
+}
+
 int init_db(const char *template_dir, unsigned int flags)
 {
-	const char *sha1_dir;
-	char *path;
-	int len, reinit;
+	int reinit;
 
 	safe_create_dir(get_git_dir(), 0);
 
@@ -313,16 +328,7 @@ int init_db(const char *template_dir, unsigned int flags)
 
 	reinit = create_default_files(template_dir);
 
-	sha1_dir = get_object_directory();
-	len = strlen(sha1_dir);
-	path = xmalloc(len + 40);
-	memcpy(path, sha1_dir, len);
-
-	safe_create_dir(sha1_dir, 1);
-	strcpy(path+len, "/pack");
-	safe_create_dir(path, 1);
-	strcpy(path+len, "/info");
-	safe_create_dir(path, 1);
+	create_object_directory();
 
 	if (shared_repository) {
 		char buf[10];
-- 
1.7.2.3
