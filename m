From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: git pull issues...
Date: Mon, 25 Apr 2005 17:07:12 -0400
Message-ID: <118833cc05042514076221624d@mail.gmail.com>
References: <118833cc050423142573729ce2@mail.gmail.com>
	 <20050423220049.GC13222@pasky.ji.cz>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:04:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQAkE-0006wt-0p
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 23:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDYVIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 17:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDYVIN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 17:08:13 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:30025 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261196AbVDYVHO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 17:07:14 -0400
Received: by rproxy.gmail.com with SMTP id a41so998326rng
        for <git@vger.kernel.org>; Mon, 25 Apr 2005 14:07:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OQ4DYTZ7k4+cmZEynM/SlDXLm4AWBmcfo/Ie6vT2M9WcQIGxSsvckWHh2s0ehdOSgZA/+6+aQBIChy8O7bNOa5Gr1S3ldyQc6eEyPGE1iBL3TKx/9hb4LJ2RYhLGB8TzhuIvw4CpDTej4FPmxs7M/dFO5V1VSwxdI/8SN+Kh2+o=
Received: by 10.38.24.45 with SMTP id 45mr6673711rnx;
        Mon, 25 Apr 2005 14:07:13 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Mon, 25 Apr 2005 14:07:12 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050423220049.GC13222@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/23/05, Petr Baudis <pasky@ucw.cz> wrote:
> > 1. Multiple rsync call might connect to different servers (with
> > round-robin DNS).  The effect
> >    will be interesting.  One call, if possible, would be better.
> 
> If you can do it without overwriting HEAD, please go ahead and send me
> the patch. :-)

This ought to work.  It basically saves to a different directory while
still ignoring
all the files we have.

Morten




Index: gitpull.sh
===================================================================
--- 7de71a831508e51e0985cea173f3f7a7012c82b7/gitpull.sh  (mode:100755
sha1:6abc7f5c00fd3e082d0a34a238a53b67c38b8a7f)
+++ uncommitted/gitpull.sh  (mode:100775)
@@ -37,28 +37,32 @@
 	[ -s ".git/heads/$name" ] && orig_head=$(cat ".git/heads/$name")
 fi
 
-
-mkdir -p .git/heads
-rsyncerr=
-rsync $RSYNC_FLAGS -Lr "$uri/heads/$rembranch" ".git/heads/$name"
2>/dev/null || rsyncerr=1
-if [ "$rsyncerr" ] && [ "$rembranch" = "master" ]; then
-	rsyncerr=
-	rsync $RSYNC_FLAGS -Lr "$uri/HEAD" ".git/heads/$name" | grep -v
'^MOTD:' || rsyncerr=1
+dotgit=dot-git
+test -d "$dotgit" && die "$dotgit already exists -- please clean up."
+mkdir -p "$dotgit" "$dotgit/objects" "$dotgit/tags" \
+	|| die "failed to create $dotgit."
+
+(cd .git && find objects -type f -print0 && find tags -type f -print0) | \
+	rsync $RSYNC_FLAGS --from0 --exclude-from=- --whole-file -Lrv
"$uri/" "$dotgit" || \
+	{ rm -rf "$dotgit"; die "rsync from $uri/ failed."; }
+
+# Move new files into place
+find "$dotgit/objects" -type f -print0 | \
+	perl -n0e 'chomp; $src=$_; s{^[^/]+/}{.git/}; rename $src, $_ or die
"failed to move $src into place: $!\n";'
+find "$dotgit/tags" -type f -print0 | \
+	perl -n0e 'chomp; $src=$_; s{^[^/]+/}{.git/}; rename $src, $_ or die
"failed to move $src into place: $!\n";'
+
+mkdir -p .git/heads || die "failed to create .git/heads"
+if [ -r "$dotgit/heads/$rembranch" ]; then
+	mv "$dotgit/heads/$rembranch" ".git/heads/$name"
+elif [ "$rembranch" = "master" -a -r "$dotgit/HEAD" ]; then
+	mv "$dotgit/HEAD" ".git/heads/$name"
+else
+	rm -rf "$dotgit"
+	die "unable to get the head pointer of branch $rembranch"
 fi
-[ "$rsyncerr" ] && die "unable to get the head pointer of branch $rembranch"
-
-[ -d .git/objects ] || mkdir -p .git/objects
-# We already saw the MOTD, thank you very much.
-rsync $RSYNC_FLAGS --ignore-existing --whole-file \
-	-v -Lr "$uri/objects/." ".git/objects/." | grep -v '^MOTD:' || die
"rsync error"
-
-# FIXME: Warn about conflicting tag names?
-# XXX: We now throw stderr to /dev/null since not all repositories
-# may have tags/ and users were confused by the harmless errors.
-[ -d .git/tags ] || mkdir -p .git/tags
-rsync $RSYNC_FLAGS --ignore-existing \
-	-v -Lr "$uri/tags/." ".git/tags/." 2>/dev/null | grep -v '^MOTD:' ||
die "rsync error"
 
+rm -rf "$dotgit"
 
 new_head=$(cat ".git/heads/$name")
