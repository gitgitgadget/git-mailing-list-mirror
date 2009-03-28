From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Resolve double chmod() in move_temp_to_file()
Date: Fri, 27 Mar 2009 23:21:00 -0700
Message-ID: <7viqlu1837.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
 <49CB51E2.9010903@viscovery.net> <200903261602.37857.johan@herland.net>
 <200903261617.48362.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Mar 28 07:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnRwI-0005si-9y
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 07:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbZC1GVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 02:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbZC1GVM
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 02:21:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbZC1GVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 02:21:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 08B1992B0;
	Sat, 28 Mar 2009 02:21:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 13F9A92AF; Sat,
 28 Mar 2009 02:21:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9FD868BE-1B60-11DE-A3F5-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114937>

Johan Herland <johan@herland.net> writes:

> diff --git a/sha1_file.c b/sha1_file.c
> index 87ac53b..05af3c5 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2252,7 +2252,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
>  		/* FIXME!!! Collision check here ? */
>  	}
>  
> -	if (chmod(filename, 0444) || adjust_shared_perm(filename))
> +	if (chmod(filename, get_shared_perm(0444)))

Your get_shared_perm() will end up feeding 0444 to S_ISDIR(), which would
most likely say "no" and cause real harm, but there is no guarantee that
we won't start checking S_ISREG() or other things in get_shared_perm()
later.  I do not like this.

How about doing it this way instead?

One thing to note is that we seem to have been passing what we read from
st.st_mode, together with S_IFMT bits, to chmod(2); I do not think I've
seen any breakage reports on exotic systems (glibc on Linux seems to
ignore the higher bits), but from my reading of POSIX, I would not be
surprised if somebody's chmod(2) returned EINVAL.

-- >8 --
set_shared_perm(): sometimes we know what the final mode bits should look like

adjust_shared_perm() first obtains the mode bits from lstat(2), expecting
to find what the result of applying user's umask is, and then tweaked it
as necessary.  When the file to be adjusted is created with mkstemp(3),
however, the mode thusly obtained does not have anything to do with usre's
umask, and we would need to start from 0444 in such a case and there is no
point running lstat(2) for such a path.

This introduces a new API set_shared_perm() to bypass the lstat(2) and
instead force setting the mode bits to the desired value directly.
adjust_shared_perm() becomes a thin wrapper to the function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    3 ++-
 path.c      |   25 ++++++++++++++++---------
 sha1_file.c |    4 ++--
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index 189151d..e283bbe 100644
--- a/cache.h
+++ b/cache.h
@@ -613,7 +613,8 @@ enum sharedrepo {
 	PERM_EVERYBODY      = 0664,
 };
 int git_config_perm(const char *var, const char *value);
-int adjust_shared_perm(const char *path);
+int set_shared_perm(const char *path, int mode);
+#define adjust_shared_perm(path) set_shared_perm((path), 0)
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
 char *enter_repo(char *path, int strict);
diff --git a/path.c b/path.c
index 42898e0..8a0a674 100644
--- a/path.c
+++ b/path.c
@@ -311,16 +311,23 @@ char *enter_repo(char *path, int strict)
 	return NULL;
 }
 
-int adjust_shared_perm(const char *path)
+int set_shared_perm(const char *path, int mode)
 {
 	struct stat st;
-	int mode, tweak, shared;
+	int tweak, shared, orig_mode;
 
-	if (!shared_repository)
+	if (!shared_repository) {
+		if (mode)
+			return chmod(path, mode & ~S_IFMT);
 		return 0;
-	if (lstat(path, &st) < 0)
-		return -1;
-	mode = st.st_mode;
+	}
+	if (!mode) {
+		if (lstat(path, &st) < 0)
+			return -1;
+		mode = st.st_mode;
+		orig_mode = mode;
+	} else
+		orig_mode = 0;
 	if (shared_repository < 0)
 		shared = -shared_repository;
 	else
@@ -344,9 +351,9 @@ int adjust_shared_perm(const char *path)
 	}
 
 	if (((shared_repository < 0
-	      ? (st.st_mode & (FORCE_DIR_SET_GID | 0777))
-	      : (st.st_mode & mode)) != mode) &&
-	    chmod(path, mode) < 0)
+	      ? (orig_mode & (FORCE_DIR_SET_GID | 0777))
+	      : (orig_mode & mode)) != mode) &&
+	    chmod(path, (mode & ~S_IFMT)) < 0)
 		return -2;
 	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 8869488..5bfc36c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2263,7 +2263,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	 *
 	 * The same holds for FAT formatted media.
 	 *
-	 * When this succeeds, we just return 0. We have nothing
+	 * When this succeeds, we just return; we have nothing
 	 * left to unlink.
 	 */
 	if (ret && ret != EEXIST) {
@@ -2280,7 +2280,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	}
 
 out:
-	if (chmod(filename, 0444) || adjust_shared_perm(filename))
+	if (set_shared_perm(filename, (S_IFREG|0444)))
 		return error("unable to set permission to '%s'", filename);
 	return 0;
 }
