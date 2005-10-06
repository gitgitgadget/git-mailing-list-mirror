From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Thu, 6 Oct 2005 11:05:57 +0200
Message-ID: <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
References: <433B3B10.5050407@zytor.com>
	 <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
	 <434299DB.7020805@zytor.com>
	 <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
	 <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com>
	 <20051005155457.GA30303@trixie.casa.cgf.cx>
	 <20051005191741.GA25493@steel.home>
	 <20051005202947.GA6184@trixie.casa.cgf.cx>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17588_28708107.1128589557674"
Cc: Christopher Faylor <me@cgf.cx>, Junio C Hamano <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 11:08:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENRho-0007rL-OS
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 11:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVJFJF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 05:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVJFJF7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 05:05:59 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:50701 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750749AbVJFJF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 05:05:58 -0400
Received: by nproxy.gmail.com with SMTP id n15so136889nfc
        for <git@vger.kernel.org>; Thu, 06 Oct 2005 02:05:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=bVe4/guDE/iipNHzIcZHWSals0xinwlND5shXPp9z78wlAsKjKeTccfWrRN7jWjcoBxWm3ET9FRCy/YyE7j+V8+yEF6jnIJVwSJzxL7gRiHVNcESj7JxgxIFz7aY/8LmC9yG2dhJOCSlUmyVLP62tARU3obwEpCbISSDX4wFbPM=
Received: by 10.48.226.10 with SMTP id y10mr91556nfg;
        Thu, 06 Oct 2005 02:05:57 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Thu, 6 Oct 2005 02:05:57 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20051005202947.GA6184@trixie.casa.cgf.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9765>

------=_Part_17588_28708107.1128589557674
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/5/05, Christopher Faylor <me@cgf.cx> wrote:
> >Don't think so, but will check in about 10 hrs. The code in question
> >is in index.c, commit_index_file.
>
> Ok.  Looks pretty simple.  FWIW, I've just built git on windows and I
> don't see this behavior.  For the most part, it "just works".

Thanks for the hint. There are open files involved (both index.lock and ind=
ex).
I attach the patch which closes index.lock (this is not really needed, btw:
rename works even without closing index.lock) and unmaps the index
(a bit too intrusive). The patch fixes only update-index.c (the one I had
problems with), there probably are other places were the situation is alike=
.

I don't like the patch (and win32 at all; hence the offending comment),
so use it only unless there is no other possibility to workaround.
I specifically do not request its inclusion into official branch
(even though Junio is cc'ed).

------=_Part_17588_28708107.1128589557674
Content-Type: application/xxxxx; name=unmap_active_cache.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="unmap_active_cache.patch"

Workaround Win32 problems with rename(2) applied to open/mapped
files (it fails with EPERM). Thanks to Christopher Faylor for the
hint regarding open files.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

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

------=_Part_17588_28708107.1128589557674--
