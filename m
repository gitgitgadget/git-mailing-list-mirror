From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] update-hook-example: optionally allow non-fast-forward
Date: Thu, 26 Jun 2008 03:14:31 +0400
Message-ID: <20080625231431.GD5737@dpotapov.dyndns.org>
References: <1214382416-6687-1-git-send-email-dpotapov@gmail.com> <1214382416-6687-2-git-send-email-dpotapov@gmail.com> <7vtzfhz3fb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeDC-0004tZ-2k
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbYFYXOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbYFYXOm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:14:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:8722 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbYFYXOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:14:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1463414fgg.17
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=P51p7tDgDA9swcMtRoem20U/OSUe1V3ac9kBXHcg9Zk=;
        b=PvLjWQ6H671Ja6Rh8uMnMsMLAe4yeYHopoEsgfu1LXD5QbYJHZLOdSMdCN4c5Hha4G
         SNKMnvv+PJMU1SZ8Jp3x/jvQzpelr3c21jA9gsRc5V5EtYSZ5zHlxU+H0q4/58WxG4Yf
         +ZKj5Vo4lJcQqPJKYjVgQMBewx6R/Mtw4hmFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OvXnyaES0vjas8z8lKed0kHhte6dKpiwpiJA+/HDHK1GD4VjNDyHkeb3GF89WNw/XE
         gpzrFiDQ6XxV0LrBjU/T87VC1mCEcQlHcyE4mnTMJa2jD+7rDCswHJI9sWseEwsNSJwT
         QptZPsLAmVs8R83WwfRoj/RQ9mc8x28k2IcUc=
Received: by 10.86.9.8 with SMTP id 8mr11214511fgi.22.1214435676158;
        Wed, 25 Jun 2008 16:14:36 -0700 (PDT)
Received: from localhost ( [85.141.151.43])
        by mx.google.com with ESMTPS id e20sm15532240fga.1.2008.06.25.16.14.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 16:14:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtzfhz3fb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86368>

Sometimes it is desirable to have non-fast-forward branches in a
shared repository. A typical example of that is the 'pu' branch.
This patch extends the format of allowed-users and allow-groups
files by using the '+' sign at the beginning as the mark that
non-fast-forward pushes are permitted to the branch.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Wed, Jun 25, 2008 at 01:04:56PM -0700, Junio C Hamano wrote:
> 
> I'd probably write this part like so:
<snip>

Thank you for advice. I have corrected the patch.

 Documentation/howto/update-hook-example.txt |   75 ++++++++++++++++-----------
 1 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index a8d3bae..7f430a0 100644
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
@@ -97,19 +97,25 @@ info "The user is: '$username'"
 
 if [ -f "$allowed_users_file" ]; then
   rc=$(cat $allowed_users_file | grep -v '^#' | grep -v '^$' |
-    while read head_pattern user_patterns; do
-      matchlen=$(expr "$1" : "$head_pattern")
-      if [ "$matchlen" == "${#1}" ]; then
-        info "Found matching head pattern: '$head_pattern'"
-        for user_pattern in $user_patterns; do
-          info "Checking user: '$username' against pattern: '$user_pattern'"
-          matchlen=$(expr "$username" : "$user_pattern")
-          if [ "$matchlen" == "${#username}" ]; then
-            grant "Allowing user: '$username' with pattern: '$user_pattern'"
-          fi
-        done
-        deny "The user is not in the access list for this branch"
-      fi
+    while read heads user_patterns; do
+      #  does this rule apply to us?
+      head_pattern=${heads#+}
+      matchlen=$(expr "$1" : "${head_pattern#+}")
+      test "$matchlen" = ${#1} || continue
+
+      # if non-ff, $heads must be with the '+' prefix
+      test -n "$noff" &&
+      test "$head_pattern" = "$heads" && continue
+
+      info "Found matching head pattern: '$head_pattern'"
+      for user_pattern in $user_patterns; do
+        info "Checking user: '$username' against pattern: '$user_pattern'"
+        matchlen=$(expr "$username" : "$user_pattern")
+        if [ "$matchlen" == "${#username}" ]; then
+          grant "Allowing user: '$username' with pattern: '$user_pattern'"
+        fi
+      done
+      deny "The user is not in the access list for this branch"
     done
   )
   case "$rc" in
@@ -127,20 +133,27 @@ info "'$groups'"
 if [ -f "$allowed_groups_file" ]; then
   rc=$(cat $allowed_groups_file | grep -v '^#' | grep -v '^$' |
     while read head_pattern group_patterns; do
-      matchlen=$(expr "$1" : "$head_pattern")
-      if [ "$matchlen" == "${#1}" ]; then
-        info "Found matching head pattern: '$head_pattern'"
-        for group_pattern in $group_patterns; do
-          for groupname in $groups; do
-            info "Checking group: '$groupname' against pattern: '$group_pattern'"
-            matchlen=$(expr "$groupname" : "$group_pattern")
-            if [ "$matchlen" == "${#groupname}" ]; then
-              grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
-            fi
-          done
+
+      #  does this rule apply to us?
+      head_pattern=${heads#+}
+      matchlen=$(expr "$1" : "${head_pattern#+}")
+      test "$matchlen" = ${#1} || continue
+
+      # if non-ff, $heads must be with the '+' prefix
+      test -n "$noff" &&
+      test "$head_pattern" = "$heads" && continue
+
+      info "Found matching head pattern: '$head_pattern'"
+      for group_pattern in $group_patterns; do
+        for groupname in $groups; do
+          info "Checking group: '$groupname' against pattern: '$group_pattern'"
+          matchlen=$(expr "$groupname" : "$group_pattern")
+          if [ "$matchlen" == "${#groupname}" ]; then
+            grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
+          fi
         done
-        deny "None of the user's groups are in the access list for this branch"
-      fi
+      done
+      deny "None of the user's groups are in the access list for this branch"
     done
   )
   case "$rc" in
@@ -159,6 +172,7 @@ allowed-groups, to describe which heads can be pushed into by
 whom.  The format of each file would look like this:
 
         refs/heads/master	junio
+        +refs/heads/pu		junio
         refs/heads/cogito$	pasky
         refs/heads/bw/.*	linus
         refs/heads/tmp/.*	.*
@@ -166,7 +180,8 @@ whom.  The format of each file would look like this:
 
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
