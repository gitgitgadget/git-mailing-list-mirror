From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sat, 07 May 2005 18:50:34 -0700
Message-ID: <7vbr7m8p05.fsf@assigned-by-dhcp.cox.net>
References: <1115408460.32065.37.camel@localhost.localdomain>
	<20050506231447.GG32629@pasky.ji.cz>
	<1115421933.32065.111.camel@localhost.localdomain>
	<20050506233003.GJ32629@pasky.ji.cz>
	<1115423450.32065.138.camel@localhost.localdomain>
	<20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
	<7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
	<20050507224116.GF9495@pasky.ji.cz>
	<7vll6q8s4o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 03:45:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUaq3-0003Mt-WE
	for gcvg-git@gmane.org; Sun, 08 May 2005 03:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVEHBvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 21:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVEHBvH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 21:51:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49650 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262786AbVEHBug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 21:50:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508015034.UFZH8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 21:50:34 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7vll6q8s4o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 07 May 2005 17:43:03 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch makes git-update-cache --add refuse to create an
index where one entry is a file and another entry needs to have
that entry as its leading directory.

I am not quite sure the semantics is quite right, so I am
holding it off from putting it in git-jc repository for now, but
please review it, give it a try and tell me what you think.

Here is what I did.

    $ ls -a
    ./  ../
    $ git-init-db
    defaulting to local storage area
    $ date >path
    $ git-update-cache --add path
    $ rm -f path; mkdir path; date >path/file
    $ git-update-cache --add path/file
    fatal: Unable to add path/file to database
    $ git-update-cache --remove path           ;# *****
    fatal: Unable to add path to database
    $ git-update-cache --force-remove path
    $ git-update-cache --add path/file
    $ git-ls-files --stage
    100644 3e3f5e43a8e7baa7f0b1f2d7b99ed25fcbe582d2 0 path/file
    $ rm -fr path
    $ git-update-cache --remove path/file
    $ mkdir path; date >path/file
    $ git-update-cache --add path/file
    $ git-ls-files --stage
    100644 1b4e067c82b90419c2d2ce80e72079f926a49cc3 0 path/file
    $ rm -fr path; date >path
    $ git-update-cache --add path
    fatal: Unable to add path to database
    $ git-update-cache --remove path/file
    $ git-update-cache --add path
    $ git-ls-files --stage
    100644 b4509b7a4fed200befc45746061eb1d32ad6cbc9 0 path

The one marked with ***** is what I am debating myself about,
but that one would probably be an independent fix.

Not-signed-off-yet-by: Junio C Hamano <junkio@cox.net>
---
jit-diff 0:7 read-cache.c
# - HEAD: Notice tree objects with duplicate entries.
# + 7: Refuse to create file/dir conflict cache entry.
--- a/read-cache.c
+++ b/read-cache.c
@@ -123,6 +123,64 @@ int same_name(struct cache_entry *a, str
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
+/* We may be in a situation where we already have
+ * path/file and path is being added, or we already
+ * have path and path/file is being added.  Either one
+ * would result in a nonsense tree that has path twice
+ * when git-write-tree tries to write it out.  Prevent it.
+ */
+static int check_file_directory_conflict(const char *path)
+{
+	int pos;
+	int namelen = strlen(path);
+	char *pathbuf = xmalloc(namelen + 1);
+	char *cp;
+
+	memcpy(pathbuf, path, namelen + 1);
+
+	cp = pathbuf;
+	while (1) {
+		char *ep = strchr(cp, '/');
+		if (ep == 0)
+			break;
+		*ep = 0;
+		pos = cache_name_pos(pathbuf,
+				     htons(create_ce_flags(ep-cp, 0)));
+		if (0 <= pos) {
+			/* Our leading path component is registered as a file,
+			 * and we are trying to make it a directory.
+			 */
+			free(pathbuf);
+			return -1;
+		}
+		*ep = '/';
+		cp = ep + 1;
+	}
+	free(pathbuf);
+
+	/* Do we have an entry in the cache that makes our path a prefix
+	 * of it?  That is, are we creating a file where they expect a
+	 * directory there?
+	 */
+	pos = cache_name_pos(path,
+			     htons(create_ce_flags(namelen, 0)));
+
+	/* (0 <= pos) cannot happen because add_cache_entry()
+	 * should have taken care of that case.
+	 */
+	pos = -pos-1;
+
+	/* pos would point at an existing entry that would come immediately
+	 * after our path.  Does it have our path as a leading path prefix?
+	 */
+	if ((pos < active_nr) &&
+	    !strncmp(active_cache[pos]->name, path, namelen) &&
+	    active_cache[pos]->name[namelen] == '/')
+		return -1;
+
+	return 0;
+}
+
 int add_cache_entry(struct cache_entry *ce, int ok_to_add)
 {
 	int pos;
@@ -152,6 +210,9 @@ int add_cache_entry(struct cache_entry *
 	if (!ok_to_add)
 		return -1;
 
+	if (check_file_directory_conflict(ce->name))
+		return -1;
+
 	/* Make sure the array is big enough .. */
 	if (active_nr == active_alloc) {
 		active_alloc = alloc_nr(active_alloc);


