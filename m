From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/2] update-hook-example: optionally allow non-fast-forward
Date: Wed, 25 Jun 2008 12:26:56 +0400
Message-ID: <1214382416-6687-2-git-send-email-dpotapov@gmail.com>
References: <1214382416-6687-1-git-send-email-dpotapov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 10:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBQMF-0004aS-QR
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 10:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbYFYI1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbYFYI1J
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 04:27:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:35078 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbYFYI1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 04:27:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1328698fgg.17
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UICG6tm34cAp02mmV7mqrPQE7tKviHySLfPUrpheuEw=;
        b=l0WkUP2dtl2VUR0o5XmmuOv8n4brd1AOXrQeqdrgp5uky83i9bN1XZwDES9IvqVWQK
         9cURoSG9VtvAyA2hXsvS5oJv2r6CkmMevltF4Wic3aTwZE+mVhpi4caT4q+HaZ0HLpX3
         qQOk3Vhc1xX+bYjC86SDvrq0XWuBG+uhwGGoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tAqY2jqLLCFDyIaywPO7RW4rife0jbMBrzojj9pIZUHmbAV20dznn6+aVhx9mrCzXe
         1/a7TqC9t5GSwbqVqCcgun7gPbnkk2pvpbanFCFv/JjK0b1ARXQAZ8j7D19mVotW3CVT
         mNFjA9twkzQ3KJe+wy2pgQIHsmKHP6Kt4N1po=
Received: by 10.86.82.6 with SMTP id f6mr10026051fgb.73.1214382424565;
        Wed, 25 Jun 2008 01:27:04 -0700 (PDT)
Received: from localhost ( [85.140.171.249])
        by mx.google.com with ESMTPS id d6sm13665328fga.2.2008.06.25.01.27.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 01:27:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1214382416-6687-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86254>

Sometimes it is desirable to have non-fast-forward branches in a
shared repository. A typical example of that is the 'pu' branch.
This patch extends the format of allowed-users and allow-groups
files by using the '+' sign at the beginning as the mark that
non-fast-forward pushes are permitted to the branch.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/howto/update-hook-example.txt |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index a8d3bae..e1e2889 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -65,7 +65,7 @@ function info {
 
 # Implement generic branch and tag policies.
 # - Tags should not be updated once created.
-# - Branches should only be fast-forwarded.
+# - Branches should only be fast-forwarded unless their pattern starts with '+'
 case "$1" in
   refs/tags/*)
     git rev-parse --verify -q "$1" &&
@@ -80,7 +80,7 @@ case "$1" in
       mb=$(git-merge-base "$2" "$3")
       case "$mb,$2" in
         "$2,$mb") info "Update is fast-forward" ;;
-        *)        deny >/dev/null  "This is not a fast-forward update." ;;
+        *)        noff=y; info "This is not a fast-forward update.";;
       esac
     fi
     ;;
@@ -98,8 +98,9 @@ info "The user is: '$username'"
 if [ -f "$allowed_users_file" ]; then
   rc=$(cat $allowed_users_file | grep -v '^#' | grep -v '^$' |
     while read head_pattern user_patterns; do
-      matchlen=$(expr "$1" : "$head_pattern")
-      if [ "$matchlen" == "${#1}" ]; then
+      matchlen=$(expr "$1" : "${head_pattern#+}")
+      allow_noff=$(expr substr "$head_pattern" 1 1)
+      if [ "$matchlen" = "${#1}" -a \( -z "$noff" -o "$allow_noff" = '+' \) ]; then
         info "Found matching head pattern: '$head_pattern'"
         for user_pattern in $user_patterns; do
           info "Checking user: '$username' against pattern: '$user_pattern'"
@@ -127,8 +128,9 @@ info "'$groups'"
 if [ -f "$allowed_groups_file" ]; then
   rc=$(cat $allowed_groups_file | grep -v '^#' | grep -v '^$' |
     while read head_pattern group_patterns; do
-      matchlen=$(expr "$1" : "$head_pattern")
-      if [ "$matchlen" == "${#1}" ]; then
+      matchlen=$(expr "$1" : "${head_pattern#+}")
+      allow_noff=$(expr substr "$head_pattern" 1 1)
+      if [ "$matchlen" = "${#1}" -a \( -z "$noff" -o "$allow_noff" = '+' \) ]; then
         info "Found matching head pattern: '$head_pattern'"
         for group_pattern in $group_patterns; do
           for groupname in $groups; do
@@ -159,6 +161,7 @@ allowed-groups, to describe which heads can be pushed into by
 whom.  The format of each file would look like this:
 
         refs/heads/master	junio
+        +refs/heads/pu		junio
         refs/heads/cogito$	pasky
         refs/heads/bw/.*	linus
         refs/heads/tmp/.*	.*
@@ -166,7 +169,8 @@ whom.  The format of each file would look like this:
 
 With this, Linus can push or create "bw/penguin" or "bw/zebra"
 or "bw/panda" branches, Pasky can do only "cogito", and JC can
-do master branch and make versioned tags.  And anybody can do
-tmp/blah branches.
+do master and pu branches and make versioned tags.  And anybody
+can do tmp/blah branches. The '+' sign at the pu record means
+that JC can make non-fast-forward pushes on it.
 
 ------------
-- 
1.5.6
