From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Migrate git-clone to use git-parseopt(1)
Date: Fri, 2 Nov 2007 16:58:03 +0100
Message-ID: <20071102160124.DB2992E3A@madism.org>
References: <1194016162-23599-4-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inyxr-0002tT-5H
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 17:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbXKBQB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 12:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbXKBQB1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 12:01:27 -0400
Received: from pan.madism.org ([88.191.52.104]:37975 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXKBQB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 12:01:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 678EF27D65;
	Fri,  2 Nov 2007 17:01:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DB2992E3A; Fri,  2 Nov 2007 17:01:24 +0100 (CET)
In-Reply-To: <1194016162-23599-4-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63140>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-clone.sh |  101 ++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0ea3c24..b30005d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -8,15 +8,35 @@
 # See git-sh-setup why.
 unset CDPATH
 
+OPTIONS_SPEC="\
+git-clone [options] <repo> [<dir>]
+--
+n,no-checkout        don't create a checkout
+bare                 create a bare repository
+naked                create a bare repository
+l,local              to clone from a local repository
+no-hardlinks         don't use local hardlinks, always copy
+s,shared             setup as a shared repository
+template=            path to the template directory
+q,quiet              be quiet
+reference=           reference repository
+o,origin=            use <name> instead of 'origin' to track upstream
+u,upload-pack=       path to git-upload-pack on the remote
+depth=               create a shallow clone of that depth
+use-separate-remote  compatibility, do not use
+no-separate-remote   compatibility, do not use"
+
 die() {
 	echo >&2 "$@"
 	exit 1
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	exec "$0" -h
 }
 
+eval `echo "$OPTIONS_SPEC" | git parseopt $PARSEOPT_OPTS -- "$@" || echo exit $?`
+
 get_repo_base() {
 	(
 		cd "`/bin/pwd`" &&
@@ -106,64 +126,57 @@ depth=
 no_progress=
 local_explicitly_asked_for=
 test -t 1 || no_progress=--no-progress
-while
-	case "$#,$1" in
-	0,*) break ;;
-	*,-n|*,--no|*,--no-|*,--no-c|*,--no-ch|*,--no-che|*,--no-chec|\
-	*,--no-check|*,--no-checko|*,--no-checkou|*,--no-checkout)
-	  no_checkout=yes ;;
-	*,--na|*,--nak|*,--nake|*,--naked|\
-	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
-	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local)
-	  local_explicitly_asked_for=yes
-	  use_local_hardlink=yes ;;
-	*,--no-h|*,--no-ha|*,--no-har|*,--no-hard|*,--no-hardl|\
-	*,--no-hardli|*,--no-hardlin|*,--no-hardlink|*,--no-hardlinks)
-	  use_local_hardlink=no ;;
-        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
-          local_shared=yes; ;;
-	1,--template) usage ;;
-	*,--template)
+
+while test $# != 0
+do
+	case "$1" in
+	-n|--no-checkout)
+		no_checkout=yes ;;
+	--naked|--bare)
+		bare=yes ;;
+	-l|--local)
+		local_explicitly_asked_for=yes
+		use_local_hardlink=yes
+		;;
+	--no-hardlinks)
+		use_local_hardlink=no ;;
+	-s|--shared)
+		local_shared=yes ;;
+	--template)
 		shift; template="--template=$1" ;;
-	*,--template=*)
-	  template="$1" ;;
-	*,-q|*,--quiet) quiet=-q ;;
-	*,--use-separate-remote) ;;
-	*,--no-separate-remote)
+	-q|--quiet)
+		quiet=-q ;;
+	--use-separate-remote|--no-separate-remote)
 		die "clones are always made with separate-remote layout" ;;
-	1,--reference) usage ;;
-	*,--reference)
+	--reference)
 		shift; reference="$1" ;;
-	*,--reference=*)
-		reference=`expr "z$1" : 'z--reference=\(.*\)'` ;;
-	*,-o|*,--or|*,--ori|*,--orig|*,--origi|*,--origin)
-		case "$2" in
+	-o,--origin)
+		shift;
+		case "$1" in
 		'')
 		    usage ;;
 		*/*)
-		    die "'$2' is not suitable for an origin name"
+		    die "'$1' is not suitable for an origin name"
 		esac
-		git check-ref-format "heads/$2" ||
-		    die "'$2' is not suitable for a branch name"
+		git check-ref-format "heads/$1" ||
+		    die "'$1' is not suitable for a branch name"
 		test -z "$origin_override" ||
 		    die "Do not give more than one --origin options."
 		origin_override=yes
-		origin="$2"; shift
+		origin="$1"
 		;;
-	1,-u|1,--upload-pack) usage ;;
-	*,-u|*,--upload-pack)
+	-u|--upload-pack)
 		shift
 		upload_pack="--upload-pack=$1" ;;
-	*,--upload-pack=*)
-		upload_pack=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
-	1,--depth) usage;;
-	*,--depth)
+	--depth)
+		shift
+		depth="--depth=$1" ;;
+	--)
 		shift
-		depth="--depth=$1";;
-	*,-*) usage ;;
-	*) break ;;
+		break ;;
+	*)
+		usage ;;
 	esac
-do
 	shift
 done
 
-- 
1.5.3.5.1458.g2aa13-dirty
