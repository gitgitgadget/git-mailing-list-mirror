From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Improve git-update-index error reporting
Date: Sun, 18 Sep 2005 21:09:22 +0200
Message-ID: <20050918190922.GC22391@pasky.or.cz>
References: <200509171309.46893.alan@chandlerfamily.org.uk> <20050918145958.GB22391@pasky.or.cz> <7virwy46uz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 21:11:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH4Xb-0006lE-E3
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 21:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVIRTJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 15:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVIRTJ3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 15:09:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2188 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751319AbVIRTJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 15:09:28 -0400
Received: (qmail 5701 invoked by uid 2001); 18 Sep 2005 21:09:22 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virwy46uz.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8806>

Dear diary, on Sun, Sep 18, 2005 at 07:35:00PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Two reports about this error message in one day, and I've seen more in
> > the past. Heh. ;-) I'd submit a patch, but I'm still staying at the last
> > git release because of the command renames.
> 
> That should not be a reason to stay at the last release; the old
> command names should be supported as well in the current
> "master" branch -- unless something is broken (missing backward
> compatible old-name symlinks, for example), which I hope is not
> the case.

You are obviously right. I don't make install, but running
./cmd-rename.sh manually seemed to work fine.

--

This makes git-update-index error reporting much less confusing. The
user will know what went wrong with better precision, and will be given
a hopefully less confusing advice.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit c758513532d4077630977fd0ee86ad1ba37c250a
tree db9476c44cb74ea98ebec31cf7431cd012d5db94
parent 7f4b3d9fef3f1855005e243de43776d8015ca737
author Petr Baudis <pasky@suse.cz> Sun, 18 Sep 2005 21:08:35 +0200
committer Petr Baudis <xpasky@machine.(none)> Sun, 18 Sep 2005 21:08:35 +0200

 update-index.c |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/update-index.c b/update-index.c
--- a/update-index.c
+++ b/update-index.c
@@ -50,11 +50,20 @@ static int add_file_to_cache(char *path)
 		 * case just fine without --force-remove.
 		 */
 		if (status == 0 || (errno == ENOENT || errno == ENOTDIR)) {
-			if (allow_remove)
-				return remove_file_from_cache(path);
+			if (allow_remove) {
+				if (remove_file_from_cache(path))
+					return error("%s: cannot remove from the index",
+					             path);
+				else
+					return 0;
+			} else if (status < 0) {
+				return error("%s: does not exist and --remove not passed",
+				             path);
+			}
 		}
 		if (0 == status)
-			return error("%s: is a directory", path);
+			return error("%s: is a directory - add files inside instead",
+			             path);
 		else
 			return error("lstat(\"%s\"): %s", path,
 				     strerror(errno));
@@ -71,15 +80,17 @@ static int add_file_to_cache(char *path)
 	case S_IFREG:
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
-			return -1;
+			return error("open(\"%s\"): %s", path, strerror(errno));
 		if (index_fd(ce->sha1, fd, &st, !info_only, NULL) < 0)
-			return -1;
+			return error("%s: failed to insert into database", path);
 		break;
 	case S_IFLNK:
 		target = xmalloc(st.st_size+1);
 		if (readlink(path, target, st.st_size+1) != st.st_size) {
+			char *errstr = strerror(errno);
 			free(target);
-			return -1;
+			return error("readlink(\"%s\"): %s", path,
+			             errstr);
 		}
 		if (info_only) {
 			unsigned char hdr[50];
@@ -87,15 +98,18 @@ static int add_file_to_cache(char *path)
 			write_sha1_file_prepare(target, st.st_size, "blob",
 						ce->sha1, hdr, &hdrlen);
 		} else if (write_sha1_file(target, st.st_size, "blob", ce->sha1))
-			return -1;
+			return error("%s: failed to insert into database", path);
 		free(target);
 		break;
 	default:
-		return -1;
+		return error("%s: unsupported file type", path);
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	return add_cache_entry(ce, option);
+	if (add_cache_entry(ce, option))
+		return error("%s: cannot add to the index - missing --add option?",
+			     path);
+	return 0;
 }
 
 static int compare_data(struct cache_entry *ce, struct stat *st)
@@ -393,11 +407,11 @@ int main(int argc, char **argv)
 		}
 		if (force_remove) {
 			if (remove_file_from_cache(path))
-				die("git-update-index: --force-remove cannot remove %s", path);
+				die("git-update-index: unable to remove %s", path);
 			continue;
 		}
 		if (add_file_to_cache(path))
-			die("Unable to add %s to database; maybe you want to use --add option?", path);
+			die("Unable to process file %s", path);
 	}
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_index_file(&cache_file))

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
