From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some Documentation/Usage Notes
Date: Mon, 05 Dec 2005 22:25:48 -0800
Message-ID: <7vvey268sz.fsf@assigned-by-dhcp.cox.net>
References: <E1EjVGk-00015M-Np@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:27:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjWHB-0001iJ-0N
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 07:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVLFGZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 01:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVLFGZv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 01:25:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:46247 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965031AbVLFGZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 01:25:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206062458.FKOO20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 01:24:58 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EjVGk-00015M-Np@jdl.com> (Jon Loeliger's message of "Mon, 05
	Dec 2005 23:21:38 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13256>

Jon Loeliger <jdl@freescale.com> writes:

> o   --help  doesn't work on:
>         git-hash-object
> 	git-init-db
> 	git-write-tree

Something like this?

-- >8 --
[PATCH] misc fixes.

 - It was cumbersome to feed hash-object the file '-t' (you
   could have said "./-t", though).  Teach it '--' that
   terminates the option list, like everybody else.  There is no
   way to extract usage string from the command either, so teach
   it "--help" as well.

 - "git-init-db junk" does not complain but just ignores "junk".
   Die with the usage string in such a case.

 - "git-write-tree junk" complains and dies, but it does not say
   what option it supports.  Die with the usage string in such a
   case.

---
diff --git a/hash-object.c b/hash-object.c
index ccba11c..6227936 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -31,19 +31,30 @@ int main(int argc, char **argv)
 	int write_object = 0;
 	const char *prefix = NULL;
 	int prefix_length = -1;
+	int no_more_flags = 0;
 
 	for (i = 1 ; i < argc; i++) {
-		if (!strcmp(argv[i], "-t")) {
-			if (argc <= ++i)
-				die(hash_object_usage);
-			type = argv[i];
-		}
-		else if (!strcmp(argv[i], "-w")) {
-			if (prefix_length < 0) {
-				prefix = setup_git_directory();
-				prefix_length = prefix ? strlen(prefix) : 0;
+		if (!no_more_flags && argv[i][0] == '-') {
+			if (!strcmp(argv[i], "-t")) {
+				if (argc <= ++i)
+					die(hash_object_usage);
+				type = argv[i];
+			}
+			else if (!strcmp(argv[i], "-w")) {
+				if (prefix_length < 0) {
+					prefix = setup_git_directory();
+					prefix_length =
+						prefix ? strlen(prefix) : 0;
+				}
+				write_object = 1;
 			}
-			write_object = 1;
+			else if (!strcmp(argv[i], "--")) {
+				no_more_flags = 1;
+			}
+			else if (!strcmp(argv[i], "--help"))
+				usage(hash_object_usage);
+			else
+				die(hash_object_usage);
 		}
 		else {
 			const char *arg = argv[i];
@@ -51,6 +62,7 @@ int main(int argc, char **argv)
 				arg = prefix_filename(prefix, prefix_length,
 						      arg);
 			hash_object(arg, type, write_object);
+			no_more_flags = 1;
 		}
 	}
 	return 0;
diff --git a/init-db.c b/init-db.c
index 8195b68..ead37b5 100644
--- a/init-db.c
+++ b/init-db.c
@@ -237,9 +237,7 @@ int main(int argc, char **argv)
 
 	for (i = 1; i < argc; i++, argv++) {
 		char *arg = argv[1];
-		if (arg[0] != '-')
-			break;
-		else if (!strncmp(arg, "--template=", 11))
+		if (!strncmp(arg, "--template=", 11))
 			template_dir = arg+11;
 		else
 			die(init_db_usage);
diff --git a/write-tree.c b/write-tree.c
index 0aac32f..18507db 100644
--- a/write-tree.c
+++ b/write-tree.c
@@ -83,6 +83,8 @@ static int write_tree(struct cache_entry
 	return nr;
 }
 
+static const char write_tree_usage[] = "git-write-tree [--missing-ok]";
+
 int main(int argc, char **argv)
 {
 	int i, funny;
@@ -95,8 +97,10 @@ int main(int argc, char **argv)
 	if (argc == 2) {
 		if (!strcmp(argv[1], "--missing-ok"))
 			missing_ok = 1;
+		else if (!strcmp(argv[1], "--help"))
+			usage(write_tree_usage);
 		else
-			die("unknown option %s", argv[1]);
+			die(write_tree_usage);
 	}
 	
 	if (argc > 2)
