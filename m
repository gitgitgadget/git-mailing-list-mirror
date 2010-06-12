From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] grep: refactor grep_objects loop into its own function
Date: Sat, 12 Jun 2010 11:31:18 -0500
Message-ID: <20100612163118.GA5657@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
 <20100612162945.GB1406@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:31:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTcJ-0005BS-JP
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab0FLQb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 12:31:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33588 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab0FLQb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:31:26 -0400
Received: by iwn9 with SMTP id 9so1590125iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ul1VEoGEXeDqYGBx9utXWQ76jzll7XCRt/YbU+CJYDY=;
        b=InBIiCXOzBiAiSt8SHbbXlAgJh+xvFL11u78oTgZAU5M43NeOrOobQ5dd+fm3e6Hrb
         Cjtb2puQxTJ9NGEEk8sF1fnpsl0RKt3M+cKbAY/ZEyU5ZfiStmNMaz9YVHKonJA7kM6i
         Oo2gLndkJRHYa8nIaQ3TENkOZ44TF9cYpLxF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XxajIoOhW1ZkSUbdFBz65FHgnyLWmMkHX7sWbzPUjMN039+VVZa6zKlbzBP02n2L3x
         j6eKsHSA/qBvuHLUC3qpn2RkuYFuCT8evqJeb8gXsdLdM5pc9mjuTwiNrYqzy6/XdBYX
         K0ZcEoOmNTM42uYS1YOQD9zT8+uauFyLSYmLc=
Received: by 10.231.150.2 with SMTP id w2mr3753729ibv.37.1276360285468;
        Sat, 12 Jun 2010 09:31:25 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm11109818ibi.5.2010.06.12.09.31.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 09:31:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100612162945.GB1406@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149016>

Simplify cmd_grep by splitting off the loop that finds matches in a
list of trees.  So now the main part of cmd_grep looks like:

	if (!use_index) {
		int hit = grep_directory(&opt, paths);
		if (use_threads)
			hit |= wait_all();
		return !hit;
	}
	if (!list.nr) {
		if (!cached)
			setup_work_tree();
		int hit = grep_cache(&opt, paths, cached);
		if (use_threads)
			hit |= wait_all;
		return !hit;
	}
	hit = grep_objects(&opt, path, &list);
	if (use_threads)
		hit |= wait_all();
	return !hit;

and is ripe for further refactoring.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/grep.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index b194ea3..5b8879f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -675,6 +675,25 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 	die("unable to grep from object of type %s", typename(obj->type));
 }
 
+static int grep_objects(struct grep_opt *opt, const char **paths,
+			const struct object_array *list)
+{
+	unsigned int i;
+	int hit = 0;
+	const unsigned int nr = list->nr;
+
+	for (i = 0; i < nr; i++) {
+		struct object *real_obj;
+		real_obj = deref_tag(list->objects[i].item, NULL, 0);
+		if (grep_object(opt, paths, real_obj, list->objects[i].name)) {
+			hit = 1;
+			if (opt->status_only)
+				break;
+		}
+	}
+	return hit;
+}
+
 static int grep_directory(struct grep_opt *opt, const char **paths)
 {
 	struct dir_struct dir;
@@ -1024,16 +1043,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (cached)
 		die("both --cached and trees are given.");
-
-	for (i = 0; i < list.nr; i++) {
-		struct object *real_obj;
-		real_obj = deref_tag(list.objects[i].item, NULL, 0);
-		if (grep_object(&opt, paths, real_obj, list.objects[i].name)) {
-			hit = 1;
-			if (opt.status_only)
-				break;
-		}
-	}
+	hit = grep_objects(&opt, paths, &list);
 
 	if (use_threads)
 		hit |= wait_all();
-- 
1.7.1
