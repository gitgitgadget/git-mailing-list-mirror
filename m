From: imyousuf@gmail.com
Subject: [PATCH] - Added pre command and custom argument support to git submodule recurse command
Date: Thu,  6 Mar 2008 13:33:37 +0600
Message-ID: <1204788817-22720-5-git-send-email-imyousuf@gmail.com>
References: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-2-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-3-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-4-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 08:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXAdJ-00087L-0R
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 08:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879AbYCFHef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 02:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758863AbYCFHee
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 02:34:34 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:41464 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758807AbYCFHed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 02:34:33 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1229660hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 23:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nPNrkoXYliNJJkRXlo9Nr5s9b6m8fwjqTzqt24hgPZY=;
        b=ZVdX0wtNBjY71zWgyo70JxyIFdp/iSLEA4OqRtCJQWBBGsY/VMJHJ5l3T0kcxgVkwHrny03IdpvwbUbxQAL4PO7Hpdxwq6cecDrt//cy0HCrKTs8xIP2PrmyVsFh6mJSEMVQEDeXpLW5Mq4CNbVTcfZVkf2AGwXZbzvLcvRObAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SpBF/QHmb2jJ1R3ATm0F2rs9NAymSFGo6/7R7x52UGjc7Xly1tuLzEzc6Fiic/onVkFYDQFw9zMMojDhk6VRUvZITF5JSkKLrh5Fq7EaarChl2CPdctpWEH8HGHwAv1Zn0y351EtuvGNRLEHQyk3yqN19/cUhETYJ92N5QZgiRg=
Received: by 10.86.28.5 with SMTP id b5mr4306500fgb.47.1204788872965;
        Wed, 05 Mar 2008 23:34:32 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id p10sm3107352gvf.8.2008.03.05.23.34.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 23:34:32 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204788817-22720-4-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76351>

    $ git submodule add init update

which is meant to add a submodule called 'init' at path 'update'
was misinterpreted as a request to invoke more than one mutually
incompatible subcommands and incorrectly rejected.

This patch fixes the issue by stopping the subcommand parsing at
the first subcommand word, to allow the sample command line
above to work as expected.

It also introduces the usual -- option disambiguator, so that a
submodule at path '-foo' can be updated with

    $ git submodule update -- -foo

without triggering an "unrecognized option -foo" error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the second part to fix the real issue.

 git-submodule.sh |  157 ++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 116 insertions(+), 41 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3c104e3..a6aaf40 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,11 +9,8 @@ OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree

-add=
+command=
 branch=
-init=
-update=
-status=
 quiet=
 cached=

@@ -123,6 +120,32 @@ module_clone()
 #
 cmd_add()
 {
+       # parse $args after "submodule ... add".
+       while test $# -ne 0
+       do
+               case "$1" in
+               -b | --branch)
+                       case "$2" in '') usage ;; esac
+                       branch=$2
+                       shift
+                       ;;
+               -q|--quiet)
+                       quiet=1
+                       ;;
+               --)
+                       shift
+                       break
+                       ;;
+               -*)
+                       usage
+                       ;;
+               *)
+                       break
+                       ;;
+               esac
+               shift
+       done
+
        repo=$1
        path=$2

@@ -176,6 +199,27 @@ cmd_add()
 #
 cmd_init()
 {
+       # parse $args after "submodule ... init".
+       while test $# -ne 0
+       do
+               case "$1" in
+               -q|--quiet)
+                       quiet=1
+                       ;;
+               --)
+                       shift
+                       break
+                       ;;
+               -*)
+                       usage
+                       ;;
+               *)
+                       break
+                       ;;
+               esac
+               shift
+       done
+
        git ls-files --stage -- "$@" | grep -e '^160000 ' |
        while read mode sha1 stage path
        do
@@ -209,6 +253,27 @@ cmd_init()
 #
 cmd_update()
 {
+       # parse $args after "submodule ... update".
+       while test $# -ne 0
+       do
+               case "$1" in
+               -q|--quiet)
+                       quiet=1
+                       ;;
+               --)
+                       shift
+                       break
+                       ;;
+               -*)
+                       usage
+                       ;;
+               *)
+                       break
+                       ;;
+               esac
+               shift
+       done
+
        git ls-files --stage -- "$@" | grep -e '^160000 ' |
        while read mode sha1 stage path
        do
@@ -268,6 +333,30 @@ set_name_rev () {
 #
 cmd_status()
 {
+       # parse $args after "submodule ... status".
+       while test $# -ne 0
+       do
+               case "$1" in
+               -q|--quiet)
+                       quiet=1
+                       ;;
+               --cached)
+                       cached=1
+                       ;;
+               --)
+                       shift
+                       break
+                       ;;
+               -*)
+                       usage
+                       ;;
+               *)
+                       break
+                       ;;
+               esac
+               shift
+       done
+
        git ls-files --stage -- "$@" | grep -e '^160000 ' |
        while read mode sha1 stage path
        do
@@ -293,20 +382,17 @@ cmd_status()
        done
 }

-while test $# != 0
+# This loop parses the command line arguments to find the
+# subcommand name to dispatch.  Parsing of the subcommand specific
+# options are primarily done by the subcommand implementations.
+# Subcommand specific options such as --branch and --cached are
+# parsed here as well, for backward compatibility.
+
+while test $# != 0 && test -z "$command"
 do
        case "$1" in
-       add)
-               add=1
-               ;;
-       init)
-               init=1
-               ;;
-       update)
-               update=1
-               ;;
-       status)
-               status=1
+       add | init | update | status)
+               command=$1
                ;;
        -q|--quiet)
                quiet=1
@@ -335,30 +421,19 @@ do
        shift
 done

-case "$add,$branch" in
-1,*)
-       ;;
-,)
-       ;;
-,*)
+# No command word defaults to "status"
+test -n "$command" || command=status
+
+# "-b branch" is accepted only by "add"
+if test -n "$branch" && test "$command" != add
+then
        usage
-       ;;
-esac
-
-case "$add,$init,$update,$status,$cached" in
-1,,,,)
-       cmd_add "$@"
-       ;;
-,1,,,)
-       cmd_init "$@"
-       ;;
-,,1,,)
-       cmd_update "$@"
-       ;;
-,,,*,*)
-       cmd_status "$@"
-       ;;
-*)
+fi
+
+# "--cached" is accepted only by "status"
+if test -n "$cached" && test "$command" != status
+then
        usage
-       ;;
-esac
+fi
+
+"cmd_$command" "$@"
--
1.5.4.rc3.11.g4e67
