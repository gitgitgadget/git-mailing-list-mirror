From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge-file: correctly find files when called in subdir
Date: Sat, 16 Oct 2010 20:30:05 -0500
Message-ID: <20101017013005.GB26656@burratino>
References: <33ab2f03ed522e1a9be202017b7bbfe35e6d7a99.1287228637.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 17 03:33:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7I88-000483-CT
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 03:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183Ab0JQBdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 21:33:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52924 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab0JQBdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 21:33:38 -0400
Received: by gyg13 with SMTP id 13so451333gyg.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cqjA0c/wnAJRO//7bvECxhuY1Iv71YxqpBuyctvE8JY=;
        b=Smw+cC8Lf4EFMe45mu7oI9A+5wuFmqkxGeI+R/FO5psZGyyipwGz7HQLKlLYnXaruf
         WoMGTsflZLzKAZVtxYS4Lnnp5PIH+SrtZgIoqSuRswL7+bCa7OHq1uBHdf/PVOwTm8YN
         YJuliGExJDrpk0GFXHNwxOIf17WufFs1XRFJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Nz3VBTtiXy2unnwz25jUouTKampBfcXFFl+Q8Kft3IOMUpHTpx1hxsLas+1ztYhTyM
         IUxwM9EFF46sO048j8z94gLgmqryEkufGDPaXbo+nWURl0m88BMQpN+MCAlOa0ggkRva
         k5P1dfW6y6nHwnREPmQLKMgkI6yGnIF5n7wXg=
Received: by 10.150.186.6 with SMTP id j6mr1601071ybf.125.1287279217534;
        Sat, 16 Oct 2010 18:33:37 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r6sm2942606yba.23.2010.10.16.18.33.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 18:33:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <33ab2f03ed522e1a9be202017b7bbfe35e6d7a99.1287228637.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159184>

Thomas Rast wrote:

> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -65,10 +66,18 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  				     "%s\n", strerror(errno));
>  	}
>  
> +	if (prefix)
> +		prefixlen = strlen(prefix);
> +
>  	for (i = 0; i < 3; i++) {
> +		const char *name;
> +		if (prefix)
> +			name = prefix_filename(prefix, prefixlen, argv[i]);

Provokes a warning (silly gcc) which can be suppressed with

	int prefixlen = prefixlen;

(or = 0 to fit with the surrounding style).

> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -64,6 +64,14 @@ cp new1.txt test.txt
>  test_expect_success "merge without conflict" \
>  	"git merge-file test.txt orig.txt new2.txt"
>  
> +test_expect_success 'works in subdirectory' '
> +	mkdir dir &&
> +	cp new1.txt dir/a.txt &&
> +	cp orig.txt dir/o.txt &&
> +	cp new2.txt dir/b.txt &&
> +	( cd dir && git merge-file a.txt o.txt b.txt )

Thanks!  Here's a backport to maint-1.6.1 for kicks.

-- 8< --
From: Thomas Rast <trast@student.ethz.ch>
Subject: merge-file: correctly find files when called in subdir

Since b541248 (merge.conflictstyle: choose between "merge" and "diff3
-m" styles, 2008-08-29), git-merge-file uses setup_directory_gently(),
thus cd'ing around to find any possible config files to use.

This broke merge-file when it is called from within a subdirectory of
a repository, and the arguments are all relative paths.

Fix by prepending the prefix, as passed down from the main git
executable, if there is any.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-merge-file.c  |   11 ++++++++++-
 t/t6023-merge-file.sh |    8 ++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 96edb97..848e3de 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -27,6 +27,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
 	int ret = 0, i = 0, to_stdout = 0;
+	int prefixlen = 0;
 	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
 	int merge_style = 0, quiet = 0;
 	int nongit;
@@ -57,10 +58,18 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 				     "%s\n", strerror(errno));
 	}
 
+	if (prefix)
+		prefixlen = strlen(prefix);
+
 	for (i = 0; i < 3; i++) {
+		const char *name;
+		if (prefix)
+			name = prefix_filename(prefix, prefixlen, argv[i]);
+		else
+			name = argv[i];
 		if (!names[i])
 			names[i] = argv[i];
-		if (read_mmfile(mmfs + i, argv[i]))
+		if (read_mmfile(mmfs + i, name))
 			return -1;
 		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
 			return error("Cannot merge binary files: %s\n",
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index f8942bc..f09430a 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -58,6 +58,14 @@ cp new1.txt test.txt
 test_expect_success "merge without conflict" \
 	"git merge-file test.txt orig.txt new2.txt"
 
+test_expect_success 'works in subdirectory' '
+	mkdir dir &&
+	cp new1.txt dir/a.txt &&
+	cp orig.txt dir/o.txt &&
+	cp new2.txt dir/b.txt &&
+	( cd dir && git merge-file a.txt o.txt b.txt )
+'
+
 cp new1.txt test2.txt
 test_expect_success "merge without conflict (missing LF at EOF)" \
 	"git merge-file test2.txt orig.txt new2.txt"
-- 
1.7.2.3
