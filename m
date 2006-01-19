From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Support precise tracking of file modes
Date: Thu, 19 Jan 2006 10:41:56 +0100
Message-ID: <20060119094156.GY28365@pasky.or.cz>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com> <7vlkxckf7o.fsf@assigned-by-dhcp.cox.net> <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com> <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net> <43CF3061.2030504@michonline.com> <7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, Adam Hunt <kinema@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 10:41:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzWHi-0001kD-Qh
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 10:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWASJkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 04:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWASJkj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 04:40:39 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2441 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751389AbWASJki (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 04:40:38 -0500
Received: (qmail 8503 invoked by uid 2001); 19 Jan 2006 10:41:56 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14895>

Dear diary, on Thu, Jan 19, 2006 at 08:50:22AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > Junio C Hamano wrote:
> >> Adam Hunt <kinema@gmail.com> writes:
> >> 
> >> 
> >>>Do you have any more details by chance?  Does it work?  Does it work
> >>>well?  How does one do it?
> >> 
> >> 
> >> I personally feel it is a horrible and stupid thing to do, if by
> >> "version control /etc" you mean to have /.git which controls
> >> /etc/hosts and stuff in place.  It would work (git does not
> >> refuse to run as root).  But being a *source* control system, we
> >> deliberately refuse to store the full permission bits, so if
> >> your /etc/shadow is mode 0600 while /etc/hosts is mode 0644, you
> >> have to make sure they stay that way after checking things out.
> >
> > This is, admittedly, a major problem.
> 
> An SCM is not a replacement of a backup.

It seems that this is mostly an artificial imposition and it's annoying.
Hey, I need to leave for an exam in 15 minutes and I have few urgent
items in my Cogito TODO (sorry, Pavel!), but I couldn't resist.

Taking "quick'n'dirty" to the extreme _and_ combining it with Linus'
attitude to testing and documentation... ;-)

diff --git a/cache.h b/cache.h
index 29c9e81..0311066 100644
--- a/cache.h
+++ b/cache.h
@@ -94,7 +94,9 @@ struct cache_entry {
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
 #define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
 
-#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
+extern int track_filemode;
+
+#define ce_permissions(mode) (track_filemode ? (mode) : (((mode) & 0100) ? 0755 : 0644))
 static inline unsigned int create_ce_mode(unsigned int mode)
 {
 	if (S_ISLNK(mode))
diff --git a/checkout-index.c b/checkout-index.c
index 53dd8cb..b073baa 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -115,6 +115,8 @@ int main(int argc, char **argv)
 	int newfd = -1;
 	int all = 0;
 
+	git_config(git_default_config);
+
 	prefix = setup_git_directory();
 	prefix_length = prefix ? strlen(prefix) : 0;
 
diff --git a/config.c b/config.c
index 8355224..a92ee0f 100644
--- a/config.c
+++ b/config.c
@@ -222,6 +222,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.trackallfilemodes")) {
+		track_filemode = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.symrefsonly")) {
 		only_use_symrefs = git_config_bool(var, value);
 		return 0;
diff --git a/entry.c b/entry.c
index 410b758..493f2b9 100644
--- a/entry.c
+++ b/entry.c
@@ -87,6 +87,11 @@ static int write_entry(struct cache_entr
 			return error("git-checkout-index: unable to create file %s (%s)",
 				path, strerror(errno));
 		}
+		if (track_filemode) {
+			if (fchmod(fd, ntohl(ce->ce_mode)) < 0)
+				return error("git-checkout-index: unable to chmod file %s (%s)",
+					path, strerror(errno));
+		}
 		wrote = write(fd, new, size);
 		close(fd);
 		free(new);
diff --git a/environment.c b/environment.c
index 0596fc6..53248ec 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,7 @@
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
+int track_filemode = 0;
 int only_use_symrefs = 0;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
diff --git a/fsck-objects.c b/fsck-objects.c
index 90e638e..719add2 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -174,7 +174,8 @@ static int fsck_tree(struct tree *item)
 			if (!check_strict)
 				break;
 		default:
-			has_bad_modes = 1;
+			if (!track_filemode || (entry->mode & ~(S_IFREG|0777)))
+				has_bad_modes = 1;
 		}
 
 		if (last) {
diff --git a/read-cache.c b/read-cache.c
index c5474d4..624d2c3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -98,7 +98,7 @@ static int ce_match_stat_basic(struct ca
 		 * "mode changes"
 		 */
 		if (trust_executable_bit &&
-		    (0100 & (ntohl(ce->ce_mode) ^ st->st_mode)))
+		    ((track_filemode ? 0777 : 0100) & (ntohl(ce->ce_mode) ^ st->st_mode)))
 			changed |= MODE_CHANGED;
 		break;
 	case S_IFLNK:


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
