From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 4/4] short i/o: fix config updates to use write_in_full
Date: Mon, 08 Jan 2007 15:58:38 +0000
Message-ID: <260688736d18821c694cf54e11de60e7@pinky>
References: <45A2699F.5060100@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 16:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3wtY-0001My-B9
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 16:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXAHP6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 10:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161326AbXAHP6l
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 10:58:41 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:55596
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750888AbXAHP6k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jan 2007 10:58:40 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1H3wtS-0003bm-LF
	for git@vger.kernel.org; Mon, 08 Jan 2007 15:58:38 +0000
To: git@vger.kernel.org
InReply-To: <45A2699F.5060100@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36271>


We need to check that the writes we perform during the update of
the users configuration work.  Convert to using write_in_full().

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/config.c b/config.c
index 5cbd130..2c9d07c 100644
--- a/config.c
+++ b/config.c
@@ -464,7 +464,15 @@ static int store_aux(const char* key, const char* value)
 	return 0;
 }
 
-static void store_write_section(int fd, const char* key)
+static int write_error()
+{
+	fprintf(stderr, "Failed to write new configuration file\n");
+	
+	/* Same error code as "failed to rename". */
+	return 4;
+}
+
+static int store_write_section(int fd, const char* key)
 {
 	const char *dot = strchr(key, '.');
 	int len1 = store.baselen, len2 = -1;
@@ -478,37 +486,60 @@ static void store_write_section(int fd, const char* key)
 		}
 	}
 
-	write(fd, "[", 1);
-	write(fd, key, len1);
+	if (write_in_full(fd, "[", 1) != 1 ||
+	    write_in_full(fd, key, len1) != len1)
+		return 0;
 	if (len2 >= 0) {
-		write(fd, " \"", 2);
+		if (write_in_full(fd, " \"", 2) != 2)
+			return 0;
 		while (--len2 >= 0) {
 			unsigned char c = *++dot;
 			if (c == '"')
-				write(fd, "\\", 1);
-			write(fd, &c, 1);
+				if (write_in_full(fd, "\\", 1) != 1)
+					return 0;
+			if (write_in_full(fd, &c, 1) != 1)
+				return 0;
 		}
-		write(fd, "\"", 1);
+		if (write_in_full(fd, "\"", 1) != 1)
+			return 0;
 	}
-	write(fd, "]\n", 2);
+	if (write_in_full(fd, "]\n", 2) != 2)
+		return 0;
+
+	return 1;
 }
 
-static void store_write_pair(int fd, const char* key, const char* value)
+static int store_write_pair(int fd, const char* key, const char* value)
 {
 	int i;
+	int length = strlen(key+store.baselen+1);
 
-	write(fd, "\t", 1);
-	write(fd, key+store.baselen+1,
-		strlen(key+store.baselen+1));
-	write(fd, " = ", 3);
+	if (write_in_full(fd, "\t", 1) != 1 ||
+	    write_in_full(fd, key+store.baselen+1, length) != length ||
+	    write_in_full(fd, " = ", 3) != 3)
+		return 0;
 	for (i = 0; value[i]; i++)
 		switch (value[i]) {
-		case '\n': write(fd, "\\n", 2); break;
-		case '\t': write(fd, "\\t", 2); break;
-		case '"': case '\\': write(fd, "\\", 1);
-		default: write(fd, value+i, 1);
-	}
-	write(fd, "\n", 1);
+		case '\n':
+			if (write_in_full(fd, "\\n", 2) != 2)
+				return 0;
+			break;
+		case '\t':
+			if (write_in_full(fd, "\\t", 2) != 2)
+				return 0;
+			break;
+		case '"':
+		case '\\':
+			if (write_in_full(fd, "\\", 1) != 1)
+				return 0;
+		default:
+			if (write_in_full(fd, value+i, 1) != 1)
+				return 0;
+			break;
+		}
+	if (write_in_full(fd, "\n", 1) != 1)
+		return 0;
+	return 1;
 }
 
 static int find_beginning_of_line(const char* contents, int size,
@@ -648,8 +679,11 @@ int git_config_set_multivar(const char* key, const char* value,
 		}
 
 		store.key = (char*)key;
-		store_write_section(fd, key);
-		store_write_pair(fd, key, value);
+		if (!store_write_section(fd, key) ||
+		    !store_write_pair(fd, key, value)) {
+			ret = write_error();
+			goto out_free;
+		}
 	} else{
 		struct stat st;
 		char* contents;
@@ -729,10 +763,10 @@ int git_config_set_multivar(const char* key, const char* value,
 
 			/* write the first part of the config */
 			if (copy_end > copy_begin) {
-				write(fd, contents + copy_begin,
+				write_in_full(fd, contents + copy_begin,
 				copy_end - copy_begin);
 				if (new_line)
-					write(fd, "\n", 1);
+					write_in_full(fd, "\n", 1);
 			}
 			copy_begin = store.offset[i];
 		}
@@ -740,13 +774,19 @@ int git_config_set_multivar(const char* key, const char* value,
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
 			if (store.state == START)
-				store_write_section(fd, key);
-			store_write_pair(fd, key, value);
+				if (!store_write_section(fd, key)) {
+					ret = write_error();
+					goto out_free;
+				}
+			if (!store_write_pair(fd, key, value)) {
+				ret = write_error();
+				goto out_free;
+			}
 		}
 
 		/* write the rest of the config */
 		if (copy_begin < st.st_size)
-			write(fd, contents + copy_begin,
+			write_in_full(fd, contents + copy_begin,
 				st.st_size - copy_begin);
 
 		munmap(contents, st.st_size);
@@ -800,6 +840,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 
 	while (fgets(buf, sizeof(buf), config_file)) {
 		int i;
+		int length;
 		for (i = 0; buf[i] && isspace(buf[i]); i++)
 			; /* do nothing */
 		if (buf[i] == '[') {
@@ -830,15 +871,22 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 				/* old_name matches */
 				ret++;
 				store.baselen = strlen(new_name);
-				store_write_section(out_fd, new_name);
+				if (!store_write_section(out_fd, new_name)) {
+					ret = write_error();
+					goto out;
+				}
 				continue;
 			}
 		}
-		write(out_fd, buf, strlen(buf));
+		length = strlen(buf);
+		if (write_in_full(out_fd, buf, length) != length) {
+			ret = write_error();
+			goto out;
+		}
 	}
 	fclose(config_file);
 	if (close(out_fd) || commit_lock_file(lock) < 0)
-		ret = error("Cannot commit config file!");
+			ret = error("Cannot commit config file!");
  out:
 	free(config_filename);
 	return ret;
