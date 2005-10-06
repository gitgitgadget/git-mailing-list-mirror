From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Thu, 6 Oct 2005 12:07:53 +0200
Message-ID: <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
References: <433B3B10.5050407@zytor.com>
	 <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
	 <434299DB.7020805@zytor.com>
	 <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
	 <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com>
	 <20051005155457.GA30303@trixie.casa.cgf.cx>
	 <20051005191741.GA25493@steel.home>
	 <20051005202947.GA6184@trixie.casa.cgf.cx>
	 <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18124_538754.1128593273215"
Cc: Christopher Faylor <me@cgf.cx>, Junio C Hamano <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 12:08:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENSfT-0003Ty-Mx
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 12:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVJFKHz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 06:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVJFKHz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 06:07:55 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:27266 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750791AbVJFKHy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 06:07:54 -0400
Received: by nproxy.gmail.com with SMTP id n15so145207nfc
        for <git@vger.kernel.org>; Thu, 06 Oct 2005 03:07:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Q6sIPCN1HO8V6pp4nk5QLirjXmdJjwE1pICAiR/K9Vc9Tg+D0Z2B60hwW0lwwq5dWt6ydayxz7jIz7T88/87/Bfn4GGJxslxVYJ6ks7vWS2jThVJzgwBPZYReZRxyBP8i0m1sWyKyI7DmPKg0lgrRzAH759E60FzWpFrfMvf9NU=
Received: by 10.49.5.7 with SMTP id h7mr96655nfi;
        Thu, 06 Oct 2005 03:07:53 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Thu, 6 Oct 2005 03:07:53 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9766>

------=_Part_18124_538754.1128593273215
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/6/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> (a bit too intrusive). The patch fixes only update-index.c (the one I had
> problems with), there probably are other places were the situation is ali=
ke.

of course there are "other places". Please, try the attached patch instead.

For the record: the patch is supposed to help people with
"Unable to write new cachefile" kind of errors.

------=_Part_18124_538754.1128593273215
Content-Type: application/xxxxx; name=unmap_active_cache.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="unmap_active_cache.patch"

Workaround Win32 problems with rename(2) applied to open/mapped
files (it fails with EPERM). Thanks to Christopher Faylor for the
hint regarding open files. The more complete patch.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1453,9 +1453,12 @@ static int apply_patch(int fd)
 		write_out_results(list, skipped_patch);
 
 	if (write_index) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_index_file(&cache_file))
+		if (write_cache(newfd, active_cache, active_nr))
 			die("Unable to write new cachefile");
+		close(newfd);
+		unmap_active_cache();
+		if (commit_index_file(&cache_file))
+			die("Unable to commit new cachefile");
 	}
 
 	if (show_files)
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -166,6 +166,7 @@ extern int ce_modified(struct cache_entr
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
+extern void unmap_active_cache();
 
 struct cache_file {
 	struct cache_file *next;
diff --git a/checkout-index.c b/checkout-index.c
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -143,9 +143,13 @@ int main(int argc, char **argv)
 		checkout_file(arg);
 	}
 
-	if (0 <= newfd &&
-	    (write_cache(newfd, active_cache, active_nr) ||
-	     commit_index_file(&cache_file)))
-		die("Unable to write new cachefile");
+	if (0 <= newfd) {
+		if (write_cache(newfd, active_cache, active_nr))
+			die("Unable to write new cachefile");
+		close(newfd);
+		unmap_active_cache();
+		if (commit_index_file(&cache_file))
+			die("Unable to commit new cachefile");
+        }
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -454,6 +454,17 @@ static int verify_hdr(struct cache_heade
 	return 0;
 }
 
+static void* active_cache_map = MAP_FAILED;
+static size_t active_cache_map_size = 0;
+
+void unmap_active_cache()
+{
+	if ( active_cache_map != MAP_FAILED ) {
+		active_nr = 0;
+		munmap(active_cache_map, active_cache_map_size);
+	}
+}
+
 int read_cache(void)
 {
 	int fd, i;
@@ -490,6 +501,8 @@ int read_cache(void)
 	if (verify_hdr(hdr, size) < 0)
 		goto unmap;
 
+	active_cache_map = map;
+	active_cache_map_size = size;
 	active_nr = ntohl(hdr->hdr_entries);
 	active_alloc = alloc_nr(active_nr);
 	active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -690,8 +690,11 @@ int main(int argc, char **argv)
 	}
 
 	unpack_trees(fn);
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_index_file(&cache_file))
+	if (write_cache(newfd, active_cache, active_nr))
 		die("unable to write new index file");
+	close(newfd);
+	unmap_active_cache();
+	if (commit_index_file(&cache_file))
+		die("unable to commit new index file");
 	return 0;
 }
diff --git a/update-index.c b/update-index.c
--- a/update-index.c
+++ b/update-index.c
@@ -392,9 +392,13 @@ int main(int argc, const char **argv)
 		}
 	}
 	if (active_cache_changed) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_index_file(&cache_file))
+		if (write_cache(newfd, active_cache, active_nr))
 			die("Unable to write new cachefile");
+		/* close and unmap are just to workaround win32 stupidity */
+		close(newfd);
+		unmap_active_cache();
+		if (commit_index_file(&cache_file))
+			die("Unable to commit new cachefile");
 	}
 
 	return has_errors ? 1 : 0;


------=_Part_18124_538754.1128593273215--
