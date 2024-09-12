Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958F18EFFB
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134341; cv=none; b=QTSErI5nnN0safthJjGoo263jZj94rxgoutPJBU/kvL1lmMnPhuGJHZNZglSDNqKUuAv/9qML0UKXSSezG3NvuzPc/VZN2/9ZOzEHAdT2yhoQc06pqO6VOvHW65VmXjab5A6lPBSR6jdXbLiuOyKdK71VFf2xch2wT+muMb0a4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134341; c=relaxed/simple;
	bh=Lmn/arMWC8Hgx39gu4T7pfyRIT08168VuWd53DoZ5xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIoFVHAYfhGBeoZmk5GrB8h124Bro6kkOVCKveue5eFykU8n9sAhvPvo7zucN6w/Y5xIiW74k1+/QtxIDPNnYNcGewXIOd1QTzdFVxMmX1ZI6cx4J/i3n0xn3KTYOcDTKfXEiYoSyiohr6NggiCDqsAnknSjqKtQndKl7J3DL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17308 invoked by uid 109); 12 Sep 2024 09:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 09:45:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23170 invoked by uid 111); 12 Sep 2024 09:45:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 05:45:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 05:45:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/4] ci: unify ubuntu and ubuntu32 dependencies
Message-ID: <20240912094537.GB589828@coredump.intra.peff.net>
References: <20240912094238.GA589050@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912094238.GA589050@coredump.intra.peff.net>

The script to install dependencies has two separate entries for 32-bit
and 64-bit Ubuntu systems. This increases the maintenance burden since
both should need roughly the same packages.

That hasn't been too bad so far because we've stayed on the same 32-bit
image since 2017. Trying to move to a newer image revealed several
problems with the linux32 job:

  - newer images complain about using "linux32 --32bit i386", due to
    seccomp restrictions. We can loosen these with a docker option, but
    I don't think running it is even doing anything. We use it only for
    pretending to "apt" that we're on a 32-bit machine, but inside the
    container image apt is already configured as a 32-bit system (even
    though the kernel outside the container is obviously 64-bit).  Using
    the same apt invocation for both architectures just gets rid of this
    call entirely.

  - we set DEBIAN_FRONTEND to avoid hanging on packages that ask the
    user questions. This wasn't a problem on the old image, but it is on
    newer ones. The 64-bit stanza handles this already.

    As a bonus, the 64-bit stanza uses "apt -q" instead of redirecting
    output to /dev/null. This would have saved me a lot of debugging
    time trying to figure out why it was hanging. :)

  - the old image seems to have zlib-dev installed by default, but newer
    ones do not.

In addition, there were probably many tests being skipped on the 32-bit
build because we didn't have support packages installed (e.g., gpg). Now
we'll run them.

We do need to keep some parts split off just for 64-bit systems: our p4
and lfs installs reference x86_64/amd64 binaries. The downloaded jgit
should work in theory, since it's just a jar file embedded in a shell
script that relies on the system java. But the system java in our image
is too old, so I've left it as 64-bit only for now.

Signed-off-by: Jeff King <peff@peff.net>
---
Patch is easier to read with "-w".

 ci/install-dependencies.sh | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4781cd20bb..00cb7df67a 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -33,7 +33,7 @@ fedora-*)
 	dnf -yq update >/dev/null &&
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
-ubuntu-*)
+ubuntu-*|ubuntu32-*)
 	# Required so that apt doesn't wait for user input on certain packages.
 	export DEBIAN_FRONTEND=noninteractive
 
@@ -45,25 +45,23 @@ ubuntu-*)
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
-	mkdir --parents "$CUSTOM_PATH"
-	wget --quiet --directory-prefix="$CUSTOM_PATH" \
-		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
-	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
+	case "$distro" in
+	ubuntu-*)
+		mkdir --parents "$CUSTOM_PATH"
 
-	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
-	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
-		-C "$CUSTOM_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
-	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+		wget --quiet --directory-prefix="$CUSTOM_PATH" \
+			"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
+		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
 
-	wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
-	chmod a+x "$CUSTOM_PATH/jgit"
-	;;
-ubuntu32-*)
-	sudo linux32 --32bit i386 sh -c '
-		apt update >/dev/null &&
-		apt install -y build-essential libcurl4-openssl-dev \
-			libssl-dev libexpat-dev gettext python >/dev/null
-	'
+		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
+			-C "$CUSTOM_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
+		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+
+		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
+		chmod a+x "$CUSTOM_PATH/jgit"
+		;;
+	esac
 	;;
 macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
-- 
2.46.0.918.gab30941bff

