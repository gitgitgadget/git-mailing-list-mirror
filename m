From: Jacob Kroon <jacob.kroon@gmail.com>
Subject: Re: Fixing author/email fields in commit messages
Date: Mon, 20 Feb 2006 02:21:25 +0100
Message-ID: <43F91995.10304@gmail.com>
References: <43F8BCB1.2010701@gmail.com> <Pine.LNX.4.63.0602191634480.6352@gheavc.wnzcbav.cig> <Pine.LNX.4.63.0602191651340.6352@gheavc.wnzcbav.cig> <43F9005E.30901@gmail.com> <Pine.LNX.4.63.0602191729100.6352@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080801090603040306040403"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 02:15:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAzdu-000522-B3
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 02:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWBTBPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 20:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWBTBPG
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 20:15:06 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:47661 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932498AbWBTBPF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 20:15:05 -0500
Received: by xproxy.gmail.com with SMTP id t14so623765wxc
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 17:15:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=lubBH7Spf9L7ZKj84XWUCvYYpnobe30lMZ5VhtB4Ad5qXpRmI4lLntj+i5keWFEvWwp7yM/0DdHzWnO+eCTQzAojHGu+GMp7AXizRJbKRHUI1TujlUMczOAy7UZy7/HsKFD+UaurJX6I32g0oJlV+RsUpwKR0pRpR+41Gf7dkq4=
Received: by 10.70.15.5 with SMTP id 5mr3224978wxo;
        Sun, 19 Feb 2006 17:15:04 -0800 (PST)
Received: from ?192.168.0.3? ( [83.249.217.43])
        by mx.gmail.com with ESMTP id h13sm3609977wxd.2006.02.19.17.15.01;
        Sun, 19 Feb 2006 17:15:03 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jon Nelson <jnelson-git@jamponi.net>
In-Reply-To: <Pine.LNX.4.63.0602191729100.6352@gheavc.wnzcbav.cig>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16462>

This is a multi-part message in MIME format.
--------------080801090603040306040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

After some more private discussion (I forgot to CC the mailing list) 
with Jon Nelson,
he came up with this strategy for fixing the author/email part of commit 
messages:

0. Make a backup copy of the repository, just in case.

1. Setup your GIT_AUTHOR_xxx/GIT_COMMITTER_xxx env. variables correctly.

2. Apply the attached patch to recent git sources. (patch made by Jon 
Nelson).

3. Run the patched git-convert-objects, passing HEAD as argument.

4. Run "git-update-ref HEAD 'newsha1'", where 'newsha1' is the output 
from the previous command.

5. Run "git-prune" to get rid of the old stale object files.

This worked for me, but I guess there are no warranties 8)
In case you have multiple branches you might need to repeat the 
procedure for each branch.

thanks Jon

//Jacob

--------------080801090603040306040403
Content-Type: text/x-patch;
 name="convert-objects.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="convert-objects.diff"

diff --git a/convert-objects.c b/convert-objects.c
index b49bce2..109bfb0 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -263,7 +263,156 @@ static void convert_date(void *buffer, u
 	newlen += size;
 
 	write_sha1_file(new, newlen, "commit", result_sha1);
-	free(new);	
+	free(new);
+}
+
+static int convert_email_line(char *dst, void **buf, unsigned long *sp, const char *name, const char *new_email)
+{
+        unsigned long size = *sp;
+        char *line = *buf;
+        char *space = strchr(line, ' ');
+	char *next = strchr(line, '\n');
+	char *email_start = strchr(line, '<');
+        char *email_end = strchr(line, '>');
+        int len, total = 0;
+
+	// "author|committer xyz <xyz> date"
+        // "committer xyz <xyz> date"
+	if (!space || !next || !email_start || !email_end)
+            die("missing or bad author/committer line %s", line);
+
+        ++space;
+        ++email_start;
+        ++next;
+
+        //fprintf(stderr, "yikes: size; %lu \"%s\"\n", size, line);
+
+        *buf = next;
+        *sp = size - (next - line);
+
+        /* copy the stuff from before the name */
+        len = space - line;
+        memcpy(dst, line, len);
+        dst += len;
+        total += len;
+        size -= len;
+
+        /* copy the new name */
+        len = strlen(name);
+        memcpy(dst, name, len);
+        dst += len;
+        total += len;
+        size -= len;
+
+        /* put a space in there */
+        *dst = ' ';
+        ++dst;
+        ++total;
+        --size;
+
+        /* put a '<' in there */
+        *dst = '<';
+        ++dst;
+        ++total;
+        --size;
+
+        /* copy the new email */
+        len = strlen(new_email);
+        memcpy(dst, new_email, len);
+        dst += len;
+        total += len;
+        size -= len;
+
+        /* copy the rest of the line */
+        len = next - email_end;
+        memcpy(dst, email_end, len);
+        dst += len;
+        total += len;
+        size -= len;
+
+        return total;
+}
+
+static void convert_authorcommitter(void *buffer, unsigned long size, unsigned char *result_sha1)
+{
+	char *new = xmalloc(size + 100);
+        unsigned long newlen = 0;
+        char *author_info = strdup(git_author_info());
+        char *committer_info = strdup(git_committer_info());
+        char *author_name, *author_email;
+        char *committer_name, *committer_email;
+        char *temp;
+
+//#define TESTING
+#ifdef TESTING
+        fprintf(stderr, "author_info: \"%s\"\n",
+                author_info);
+        fprintf(stderr, "committer_info: \"%s\"\n",
+                committer_info);
+#endif
+        author_name = author_info;
+        temp = strchr(author_name, '<');
+        if (!temp)
+            die("Unable to find valid name address.");
+        --temp;
+        *temp = '\0';
+        temp += 2;
+
+        author_email = temp;
+        temp = strrchr(author_email, '>');
+        if (!temp)
+            die("Unable to find valid email address.");
+        *temp = '\0';
+
+        committer_name = committer_info;
+        temp = strchr(committer_name, '<');
+        if (!temp)
+            die("Unable to find valid name address.");
+        --temp;
+        *temp = '\0';
+        temp += 2;
+
+        committer_email = temp;
+        temp = strrchr(committer_email, '>');
+        if (!temp)
+            die("Unable to find valid email address.");
+        *temp = '\0';
+
+#ifdef TESTING
+        fprintf(stderr, "author_name: \"%s\"\n", author_name);
+        fprintf(stderr, "author_email: \"%s\"\n", author_email);
+        fprintf(stderr, "committer_name: \"%s\"\n", committer_name);
+        fprintf(stderr, "committer_email: \"%s\"\n", committer_email);
+        exit(0);
+#endif
+
+	// "tree <sha1>\n"
+	memcpy(new + newlen, buffer, 46);
+	newlen += 46;
+	buffer += 46;
+	size -= 46;
+
+	// "parent <sha1>\n"
+	while (!memcmp(buffer, "parent ", 7)) {
+		memcpy(new + newlen, buffer, 48);
+		newlen += 48;
+		buffer += 48;
+		size -= 48;
+	}
+
+	// "author xyz <xyz> date"
+	// "committer xyz <xyz> date"
+        newlen += convert_email_line(new + newlen, &buffer, &size, author_name, author_email);
+        newlen += convert_email_line(new + newlen, &buffer, &size, committer_name, committer_email);
+
+	// Rest
+	memcpy(new + newlen, buffer, size);
+	newlen += size;
+
+	write_sha1_file(new, newlen, "commit", result_sha1);
+        free(new);
+        free(author_info);
+        free(committer_info);
 }
 
 static void convert_commit(void *buffer, unsigned long size, unsigned char *result_sha1)
@@ -279,7 +428,117 @@ static void convert_commit(void *buffer,
 		convert_ascii_sha1(buffer+7);
 		buffer += 48;
 	}
-	convert_date(orig_buffer, orig_size, result_sha1);
+	convert_authorcommitter(orig_buffer, orig_size, result_sha1);
+}
+
+static void convert_tag(void *buffer, unsigned long size, unsigned char *result_sha1)
+{
+	void *orig_buffer = buffer;
+
+	char *new = xmalloc(size + 100);
+        unsigned long newlen = 0;
+
+        char *author_info = strdup(git_author_info());
+        char *committer_info = strdup(git_committer_info());
+        char *author_name, *author_email;
+        char *committer_name, *committer_email;
+        char *temp;
+        unsigned long len = 0;
+        char *email_start;
+        char *email_end;
+        char *author_start;
+        int has_author = 1;
+
+        author_name = author_info;
+        temp = strchr(author_name, '<');
+        if (!temp)
+            die("Unable to find valid name address.");
+        --temp;
+        *temp = '\0';
+        temp += 2;
+
+        author_email = temp;
+        temp = strrchr(author_email, '>');
+        if (!temp)
+            die("Unable to find valid email address.");
+        *temp = '\0';
+
+        committer_name = committer_info;
+        temp = strchr(committer_name, '<');
+        if (!temp)
+            die("Unable to find valid name address.");
+        --temp;
+        *temp = '\0';
+        temp += 2;
+
+        committer_email = temp;
+        temp = strrchr(committer_email, '>');
+        if (!temp)
+            die("Unable to find valid email address.");
+        *temp = '\0';
+
+        //* START *//
+
+	if (memcmp(buffer, "object ", 7))
+		die("Bad tag '%s'", (char*) buffer);
+        convert_ascii_sha1(buffer+7);
+//        fprintf(stderr, "converting %s", (char *) (buffer + 7));
+        buffer += 7 + 40 + 1;    /* "object " + "hex sha1" + "\n" */
+        /* type commit
+           tag boa-0.94.14rc6
+           tagger...
+           */
+        /* with tagger, we check for tagger author_name <author_email>
+         * and if so, we convert that, too
+         */
+        temp = strchr(buffer, '\n'); /* end of commit line */
+        if (!temp) {
+            die("Bad tag '%s'", (char *) buffer);
+        }
+        ++temp;
+        temp = strchr(temp, '\n'); /* end of tag line */
+        if (!temp) {
+            die("Bad tag '%s'", (char *) buffer);
+        }
+        ++temp;
+        if (memcmp(temp, "tagger ", 7))
+            die("Bad tag '%s'", (char *) buffer);
+        temp += 7; /* just after 'tagger ' */
+
+        len = (temp - (char *) orig_buffer);
+        memcpy(new, orig_buffer, len);
+        newlen += len;
+        ++temp;
+
+        /* check to see if the next item looks like an name + email */
+        email_start = strchr(temp, '<');
+        if (email_start) {
+            email_end = strchr(email_start, '>');
+            if (email_end) {
+                author_start = strchr(temp, ' ');
+                if (author_start && author_start < email_start) {
+                    has_author = 1;
+                    newlen += sprintf(new + newlen,
+                                      "%s <%s>\n",
+                                      author_name,
+                                      author_email);
+                    len = (email_end - (char *) buffer) + 2;
+                }
+
+            }
+        }
+
+        if (len > size) {
+            memcpy(new + newlen, orig_buffer + len, size - len);
+            newlen += (size - len);
+        }
+//        fprintf(stderr, "About to write: %s", new);
+//        exit(0);
+
+        write_sha1_file(new, newlen, "tag", result_sha1);
+        free(new);
+        free(author_info);
+        free(committer_info);
 }
 
 static struct entry * convert_entry(unsigned char *sha1)
@@ -297,13 +556,15 @@ static struct entry * convert_entry(unsi
 
 	buffer = xmalloc(size);
 	memcpy(buffer, data, size);
-	
+
 	if (!strcmp(type, "blob")) {
 		write_sha1_file(buffer, size, "blob", entry->new_sha1);
-	} else if (!strcmp(type, "tree"))
-		convert_tree(buffer, size, entry->new_sha1);
-	else if (!strcmp(type, "commit"))
-		convert_commit(buffer, size, entry->new_sha1);
+        } else if (!strcmp(type, "tree"))
+            convert_tree(buffer, size, entry->new_sha1);
+        else if (!strcmp(type, "commit"))
+            convert_commit(buffer, size, entry->new_sha1);
+        else if (!strcmp(type, "tag"))
+            convert_tag(buffer, size, entry->new_sha1);
 	else
 		die("unknown object type '%s' in %s", type, sha1_to_hex(sha1));
 	entry->converted = 1;
@@ -318,6 +579,7 @@ int main(int argc, char **argv)
 	struct entry *entry;
 
 	setup_git_directory();
+	setup_ident();
 
 	if (argc != 2 || get_sha1(argv[1], sha1))
 		usage("git-convert-objects <sha1>");

--------------080801090603040306040403--
