From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-ls-files -o no recurse?
Date: Wed, 4 Jan 2006 13:31:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601041330550.3668@g5.osdl.org>
References: <1136400692.5919.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 04 22:31:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuGEM-00070s-8E
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 22:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWADVbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 16:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWADVbf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 16:31:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750871AbWADVbf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2006 16:31:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k04LVTDZ027388
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Jan 2006 13:31:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k04LVPEt016541;
	Wed, 4 Jan 2006 13:31:28 -0800
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1136400692.5919.11.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14180>



On Wed, 4 Jan 2006, Darrin Thompson wrote:
> 
> Would it be hard to make git-ls-files optionally do this?

Something like the appended may or may not be what you're looking for..

		Linus
---
diff --git a/ls-files.c b/ls-files.c
index 5e9ac71..2e3e2e8 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -19,6 +19,7 @@ static int show_stage = 0;
 static int show_unmerged = 0;
 static int show_modified = 0;
 static int show_killed = 0;
+static int show_ignored_directories = 0;
 static int line_terminator = '\n';
 
 static int prefix_len = 0, prefix_offset = 0;
@@ -233,6 +234,19 @@ static void add_name(const char *pathnam
 	dir[nr_dir++] = ent;
 }
 
+static int dir_exists(const char *dirname, int len)
+{
+	int pos = cache_name_pos(dirname, len);
+	if (pos >= 0)
+		return 1;
+	pos = -pos-1;
+	if (pos >= active_nr)
+		return 0;
+	if (strncmp(active_cache[pos]->name, dirname, len))
+		return 0;
+	return active_cache[pos]->name[len] == '/';
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -280,6 +294,10 @@ static void read_directory(const char *p
 					continue;
 				/* fallthrough */
 			case DT_DIR:
+				if (show_ignored_directories) {
+					if (!dir_exists(fullname, baselen + len))
+						break;
+				}
 				memcpy(fullname + baselen + len, "/", 2);
 				read_directory(fullname, fullname,
 					       baselen + len + 1);
@@ -622,6 +640,10 @@ int main(int argc, const char **argv)
 			show_killed = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--directory")) {
+			show_ignored_directories = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
 			/* There's no point in showing unmerged unless
 			 * you also show the stage information.
