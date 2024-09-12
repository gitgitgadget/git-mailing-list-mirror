Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E3189516
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127804; cv=none; b=DksDLWEkyvbaa2sYkwxvjcAKNMvnDCOXJx+cX+oSW2kALLpWw7xUB2DtFiv+7n7pH/vzB9ZXwxjWKbXlMeTSfMSIqMR0BxX3PZXKJ/u7NIN7DEptxAHAkKJ1IqA4vaqoGolrv1Erlvh4ZPfIjonnYWmGvN2PePEZ4EDL840KQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127804; c=relaxed/simple;
	bh=XPDUsumqQ1yMGy3lT2nTSmRBOd6E7IXKj2eocayBaFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJyw4Cg9kXsma7j94yTJaQD1NvytDdqUBUuf6kJ2jbxkXaC3fNKzXPO/8SuxOfr+ilRc1KCxvNQwz6LHpN/f1ai2HD5nFGon3sFfSMJ6r3ixOVVfixp9U3Zhph/sJMBB4RbKVXYI5yNojwKhBPEtJ2elok6maf1kePzlcXcqPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16167 invoked by uid 109); 12 Sep 2024 07:56:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 07:56:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22274 invoked by uid 111); 12 Sep 2024 07:56:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 03:56:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 03:56:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: remove 'Upload failed tests' directories' step from
 linux32 jobs
Message-ID: <20240912075631.GA11676@coredump.intra.peff.net>
References: <xmqqy140o2kb.fsf@gitster.g>
 <xmqqv7z14y9d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7z14y9d.fsf@gitster.g>

On Wed, Sep 11, 2024 at 03:32:46PM -0700, Junio C Hamano wrote:

> I refrain from merging my own patches until somebody else at least
> comments on them, but I'll make an exception and merge this to 'next',
> as a few "container" jobs _always_ fail to start otherwise.  At least
> with the step removed, a run without any test failures would tell us
> that these container tasks are OK, which is much better.
> 
> If somebody finds a better solution (i.e., a way to extract trash
> directories of failed tests', with actions/upload-artifact@v1), that
> can be added later on top.

I looked at this a bit last night, but as I didn't come up with any
useful solution, I refrained from replying. I was going to do a brief
write-up of all of my dead ends, but after banging my head against the
wall a bit more, I think I might actually have something. ;)

I think a better path forward is to figure out how to keep up to date
with the upload-artifact action for all jobs. The root of the issue is
that all of the runner images are 64-bit, and the actions aren't
prepared to run inside a 32-bit container. They're written in javascript
and ship with their own node.js, but it doesn't work inside the
container due to dynamic linking issues.

So you probably saw a message like this:

  exec /__e/node20/bin/node: no such file or directory

in the job log. That funky path is the node binary that ships with the
action, and the ENOENT is because it can't find the runtime linker.

  Aside: I think the world would be a better place if they shipped a
  totally static build of node, but there may be some complications
  there. I found some discussion here:

    https://github.com/actions/setup-node/issues/922
    https://github.com/actions/runner/issues/2906

There are two options here, I think:

  1. Instead of running everything inside the container, we can run the
     actions outside (on the normal 64-bit runner image), and just do
     the build/test steps inside the container by manually running
     docker with the appropriate mounts.

     This was the suggested here:

       https://github.com/actions/runner/issues/1491#issuecomment-970418408

     and apparently is how libgit2 works (I don't think it's too hard to
     do so, but their infrastructure wasn't totally trivial).

  2. After some tricky debugging via tmate[1], I found that we can
     install the necessary libc bits within the container. But there's
     another catch! They've moved to node20, which requires glibc2.28,
     and the eight-year-old xenial release we're using is too old for
     that. We have to move to Focal, which was released in 2020.

It feels like (1) is probably the more robust and flexible solution
overall. But we can get to (2) a lot more easily from where we are now.

Doing this:

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cbdb677258..6b45dcad9d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -347,8 +347,8 @@ jobs:
           image: alpine
           distro: alpine-latest
         - jobname: linux32
-          image: daald/ubuntu32:xenial
-          distro: ubuntu32-16.04
+          image: i386/ubuntu:focal
+          distro: ubuntu32-20.04
         - jobname: pedantic
           image: fedora
           distro: fedora-latest
@@ -358,27 +358,21 @@ jobs:
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
-    - uses: actions/checkout@v4
-      if: matrix.vector.jobname != 'linux32'
-    - uses: actions/checkout@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
+    - name: prepare libc6 for actions
+      run: apt update && apt install -y libc6-amd64 lib64stdc++6
       if: matrix.vector.jobname == 'linux32'
+    - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
-      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v4
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-    - name: Upload failed tests' directories
-      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname == 'linux32'
-      uses: actions/upload-artifact@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
-      with:
-        name: failed-tests-${{matrix.vector.jobname}}
-        path: ${{env.FAILED_TEST_ARTIFACTS}}
   static-analysis:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'

lets us eliminate the special cases and just work with the regular
versions of each action.

That gets us through the checkout action. There does seem to be some
fallout from using the more recent image.

Now running "linux32" to change the machine personality in
ci/install-dependencies runs afoul of some seccomp restrictions.
Loosening docker like this works:

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6b45dcad9d..ed66c0bea4 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -356,7 +356,9 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
       distro: ${{matrix.vector.distro}}
     runs-on: ubuntu-latest
-    container: ${{matrix.vector.image}}
+    container:
+      image: ${{matrix.vector.image}}
+      options: --security-opt=seccomp=unconfined
     steps:
     - name: prepare libc6 for actions
       run: apt update && apt install -y libc6-amd64 lib64stdc++6

but it's not at all clear to me why we need to run "linux32" in the
first place. Sure, it's a 64-bit kernel still (we're just in a userspace
container) but the system knows its 32-bit, and stuff like "getconf
LONG_BIT" returns 32.

So another solution may be just:

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2190c82313..8a8b832a35 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -60,11 +60,9 @@ ubuntu-*)
 	chmod a+x "$CUSTOM_PATH/jgit"
 	;;
 ubuntu32-*)
-	sudo linux32 --32bit i386 sh -c '
-		apt update >/dev/null &&
-		apt install -y build-essential libcurl4-openssl-dev \
-			libssl-dev libexpat-dev gettext python >/dev/null
-	'
+	sudo apt update >/dev/null &&
+	sudo apt install -y build-essential libcurl4-openssl-dev \
+		libssl-dev libexpat-dev gettext python >/dev/null
 	;;
 macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1

but I'm worried I'm missing something, as it's been a while since I
poked at multi-arch stuff.

After that, we need this:

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4781cd20bb..2190c82313 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -22,6 +22,9 @@ then
 	}
 fi
 
+# Required so that apt doesn't wait for user input on certain packages.
+export DEBIAN_FRONTEND=noninteractive
+
 case "$distro" in
 alpine-*)
 	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
@@ -34,8 +37,6 @@ fedora-*)
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 ubuntu-*)
-	# Required so that apt doesn't wait for user input on certain packages.
-	export DEBIAN_FRONTEND=noninteractive
 
 	sudo apt-get -q update
 	sudo apt-get -q -y install \

to cover the ubuntu32 job (I guess it just wasn't needed on the ancient
image we were using).

After that, we get all the way to the actual build. Looks like it fails
because we're missing zlib. Presumably that was included by default in
the old image, but not the new, and it needs to be added to package
install list.

Taken together, I suspect we could just treat "ubuntu32" the same as
"ubuntu" in the ci/install-dependencies script. That would fix all of
those issues, and simplify the script. Assuming I'm not missing
something.

-Peff

[1] Using tmate to diagnose failing "node" proved a bit tricky, because
    the tmate action also uses node, so it fails, too! For future
    reference, this is what I used to get it running manually:

    - name: Setup tmate
      if: always()
      run: |
        apt update && apt install -y xz-utils wget &&
        v=tmate-2.4.0-static-linux-i386 &&
        wget https://github.com/tmate-io/tmate/releases/download/2.4.0/$v.tar.xz &&
        xzcat $v.tar.xz | tar xvvf - &&
        cd $v &&
        ./tmate -F
