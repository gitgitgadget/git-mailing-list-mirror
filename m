From: Darrin Thompson <darrint@progeny.com>
Subject: Re: git-ls-files -o no recurse?
Date: Sat, 07 Jan 2006 13:23:27 -0500
Message-ID: <1136658207.6141.4.camel@localhost.localdomain>
References: <1136400692.5919.11.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601041330550.3668@g5.osdl.org>
	 <7vk6ddq8x2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 19:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvIj8-0001oD-GA
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 19:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbWAGSXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 13:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbWAGSXg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 13:23:36 -0500
Received: from zealot.progeny.com ([216.37.46.162]:21721 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1752581AbWAGSXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 13:23:35 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 74528636AE; Sat,  7 Jan 2006 13:23:30 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ddq8x2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14266>

Here's a rejiggered version of the original Linus patch. The names have
been changed a little.

Enjoy.

It prevents git from recursing into "other" directories when used with
the -o option.

---

 ls-files.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

applies-to: 4e7e791ecc24975530de1f2855cf5f17f112140b
741ec8ad5b7f3717bb462c2becfd00974da7ec16
diff --git a/ls-files.c b/ls-files.c
index 5e9ac71..cba8ca1 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -19,6 +19,7 @@ static int show_stage = 0;
 static int show_unmerged = 0;
 static int show_modified = 0;
 static int show_killed = 0;
+static int show_other_directories = 0;
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
+				if (show_other_directories) {
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
+			show_other_directories = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
 			/* There's no point in showing unmerged unless
 			 * you also show the stage information.
---
0.99.9i
