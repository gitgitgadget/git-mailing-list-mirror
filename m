From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Git submodule enhancements
Date: Wed, 24 Sep 2008 11:13:59 +0200
Message-ID: <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com>
References: <200809241100.30758.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "P. Christeas" <p_christ@hol.gr>
X-From: git-owner@vger.kernel.org Wed Sep 24 11:15:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiQSp-0005OP-1Q
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 11:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYIXJOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 05:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYIXJOB
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 05:14:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:35950 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYIXJOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 05:14:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2613895rvb.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WmakSNLSTTB+obw4mNirNg1sQQIeURvf1KP+KbMKryk=;
        b=CA0FUOCbKfDiaomUGyzKio+oJma8wRWpMM/dBaCIrWaVrD2NEYSJo/YdnnpXNlpPyS
         wh7wsNRZ1L9NWmzGy6VcDgQGdSNEF8afhZekxlGoS3+DIiZ1K9UPV7BtI2OcRHB4Bu8n
         /MtyJaMyYE3HL8GVGzdkk6CMqPRcU7/b2CMsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xx4GWTT5lhkFijx+mhBaUL4knlYCs5jG4tLALpzpPj3FL+UitTjZdobvJZvP9cY+Ia
         Qklhw0yzHxs0PoYkiZRpRUHviHuC+VoFEN2xmdP16wnZkwJ/zIE1Fxr5nOtqjF2mSCQE
         XpdiV7jgyBVG9qYz7OEo1BMVg1H2bXkeW18pU=
Received: by 10.114.170.1 with SMTP id s1mr7740096wae.127.1222247639278;
        Wed, 24 Sep 2008 02:13:59 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Wed, 24 Sep 2008 02:13:59 -0700 (PDT)
In-Reply-To: <200809241100.30758.p_christ@hol.gr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96622>

On Wed, Sep 24, 2008 at 10:00 AM, P. Christeas <p_christ@hol.gr> wrote:
> In my attempt to take some source off a submoduled repo, I tried writting a
> few lines of code into git-submodule.

Thanks, but please also send this to git@vger.kernel.org. And please
try do inline the patches, it makes it much easier to review; I've
pasted the patches below and inserted a few comments prefixed with
'lh>'.


>From 9edad86468933a21264ab7bed4608ea8a6e992e4 Mon Sep 17 00:00:00 2001
From: P. Christeas <p_christ@hol.gr>
Date: Wed, 24 Sep 2008 10:05:45 +0300
Subject: [PATCH] Git submodule archive: create series of archives, for
each module

This is a temporary solution to creating archives from repos
containing submodules. It will just create a series of archives,
each named after the name of the submodule.
---
 git-submodule.sh |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 86 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1c39b59..2bce7f9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -602,6 +602,91 @@ cmd_status()
 		fi
 	done
 }
+
+cmd_archive() {
+	# parse $args after "submodule ... archive".
+	smodules=""
+	verbose=""
+	format=tar
+	do_exec=
+	base_prefix=""
+	outname=
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			quiet=1
+			;;
+		-m|--module)
+			shift
+			smodules+="$1 "
+			;;

lh> Other submodule commands take optional module paths as final
lh> arguments. Why not use the same for `archive`?


+		--format)
+			shift
+			format="$1"
+			;;
+		--exec)
+			shift
+			do_exec="--exec=$1"
+			;;
+		--prefix)
+			shift
+			base_prefix="$1"
+			;;
+		-v|--verbose)
+			verbose="-v"
+			;;
+		-o|--output)
+			shift
+			outname="$1"
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	if [ -z $outname ] ; then
+		outname=$(basename $(pwd))-%m.$format
+	fi
+
+	if ! (echo $outname | grep '%m') > /dev/null  ; then
+		outname+="-%m"
+	fi
+	if ! (echo $outname | grep '^/') > /dev/null  ; then
+		outname=$(pwd)/"$outname"
+	fi
+	
+	#echo "Modules: $smodules"
+	#echo "Params: $@"
+	#echo "Outname: $outname"

lh> Please remove debug comments.


+	
+	module_list "$smodules" |
+	while read mode sha1 stage path
+	do
+		name=$(module_name "$path") || exit
+# 		url=$(git config submodule."$name".url)
+# 		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
+# 		then
+# 			say "-$sha1 $path"
+# 			continue;
+# 		fi

lh> This should probably work similar to `update`, i.e. exit
lh> with an error if a submodule path is explicitly specified
lh> and the submodule isn't registered in .git/config, and
lh> silently skip any non-registered submodules if no
lh> paths were specified. And if the submodule is not
lh> skipped it probably should be an error if the submodule
lh>  isn't checked out.


+		
+		fname=$(echo $outname |sed 's/%m/'$name'/')

lh> This should probably be documented ;-)


+		say $fname
+		pushd "$path" > /dev/null
+		git archive --format=$format $do_exec $verbose
--prefix="$base_prefix$path/" $sha1 > \
+			"$fname"
+		popd > /dev/null

lh> What does `git archive` do when --exec is specified without
lh> --remote? What about error checking?


+	done
+}
 #
 # Sync remote urls for submodules
 # This makes the value for remote.$remote.url match the value
@@ -656,7 +741,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | foreach | init | update | status | summary | sync | archive)
 		command=$1
 		;;
 	-q|--quiet)
--
1.6.0.1



>From 87b75f003d31994d0de6502342e4d0ad68665e80 Mon Sep 17 00:00:00 2001
From: P. Christeas <p_christ@hol.gr>
Date: Wed, 24 Sep 2008 10:48:04 +0300
Subject: [PATCH] Submodule init: cloned mode

If we try to clone a repo with git submodules, the 'submodule init'
command should bind the submodules to the source repo, rather than
the source's origin.

Signed-off-by: P. Christeas <p_christ@hol.gr>
---
 git-submodule.sh |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2bce7f9..df5fcac 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,6 +241,12 @@ cmd_init()
 		-q|--quiet)
 			quiet=1
 			;;
+		-f|--force)
+			force=1
+			;;
+		--cloned)
+			cloned=1
+			;;
 		--)
 			shift
 			break
@@ -261,19 +267,26 @@ cmd_init()
 		# Skip already registered paths
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		test -z "$url" || continue
-
-		url=$(git config -f .gitmodules submodule."$name".url)
-		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
-
-		# Possibly a url relative to parent
-		case "$url" in
-		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
-			;;
-		esac
+		test -z "$url" || test -n "$force" || continue

+		if [ "x$cloned" != "x1" ] ; then
+			url=$(git config -f .gitmodules submodule."$name".url)
+			test -z "$url" &&
+			die "No url found for submodule path '$path' in .gitmodules"
+	
+			# Possibly a url relative to parent
+			case "$url" in
+			./*|../*)
+				url=$(resolve_relative_url "$url") || exit
+				;;
+			esac
+		else
+			# Cloned mode: we try to figure out the submodule
+			# path in the remote origin.
+			# FIXME: we do use "../" because the remote is the .git/
+			url=$(resolve_relative_url "../$path/.git")
+		fi
+		
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
--
1.6.0.1


It looks like --cloned requires the downstream to know which
submodules are available from the same remote as the supermodule (and
with the same path as registered in the supermodule), i.e. quite a
specific configuration. Is this really common enough to justify a
special option to `submodule init`?

Maybe the .gitmodules file could be extended to contain multiple urls
instead (i.e. both absolute and relative ones)? Then `submodule init`
could get options like --prefer-relative-url, --prefer-absolute-url
and --interactive. What do you think?

--
larsh
