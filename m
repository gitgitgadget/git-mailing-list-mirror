From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: [PATCH] git-mergetool: Allow gvimdiff to be used as a mergetool
Date: Sat, 9 Jun 2007 13:17:24 -0400
Message-ID: <449c10960706091017m5d536295waa0fbcd05a6bbb73@mail.gmail.com>
References: <11810938823594-git-send-email-dpmcgee@gmail.com>
	 <20070606024545.GA32603@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 09 19:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx4Z7-0002Xs-Pb
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 19:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbXFIRR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbXFIRR1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 13:17:27 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:54355 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbXFIRR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 13:17:26 -0400
Received: by mu-out-0910.google.com with SMTP id i10so417441mue
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 10:17:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/fBIfTHsW2L5kbykD9rEh+CSG7X1G1KlC8cRgJ0iUL0NRr7PuykGH7kQsMokC8P13KXl6pB0c10UwYyNvdEJ0FygM2wxpGJv9jX7nzr5AoZn47y5ZzzFjQe1+VsI3DWYFl8EwfrE4mfxP+vXslyx8ywBbpdXR3foHnR8KQgFB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+gsKSeK66GxoizMG6uPYyXeMe6oQslkcEtF2dFb9lOvmdxY0x7qSwTZ2vhN2kBovwClJWDQ7S4a5ZqstI7NeUGz9YT6lx1GIj2k06B5l1T+Y4XAuDmVpWHnK6HQ26rQBVwfMYGC5r5KJpSiKGUIuxEv+vD8UV2sIz+AaYRVKUo=
Received: by 10.82.175.17 with SMTP id x17mr7513477bue.1181409444615;
        Sat, 09 Jun 2007 10:17:24 -0700 (PDT)
Received: by 10.82.135.2 with HTTP; Sat, 9 Jun 2007 10:17:24 -0700 (PDT)
In-Reply-To: <20070606024545.GA32603@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49582>

On 6/5/07, Theodore Tso <tytso@mit.edu> wrote:
> Dan, your patch didn't add a gvimdiff check to the code which
> determins which merge tool to use if one isn't specified in the config
> file:

Here is an updated patch with that fix, and another that I just
discovered. gvim by default forks and does not run in the foreground,
so we need to call it with the '-f' flag to prevent this.

-Dan

>From b9c8873d63365c55b75bb2ec3d76c208f327b620 Mon Sep 17 00:00:00 2001
From: Dan McGee <dpmcgee@gmail.com>
Date: Tue, 5 Jun 2007 21:19:47 -0400
Subject: [PATCH] git-mergetool: Allow gvimdiff to be used as a mergetool

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 Documentation/config.txt        |    2 +-
 Documentation/git-mergetool.txt |    2 +-
 git-mergetool.sh                |   12 ++++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5868d58..3ca01af 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -531,7 +531,7 @@ merge.summary::
 merge.tool::
 	Controls which merge resolution program is used by
 	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
-	"meld", "xxdiff", "emerge", "vimdiff", and "opendiff"
+	"meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and "opendiff".

 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index add01e8..34c4c1c 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,7 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, and opendiff
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index bb21b03..c9a90cd 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -215,6 +215,12 @@ merge_file () {
 	    check_unchanged
 	    save_backup
 	    ;;
+	gvimdiff)
+		touch "$BACKUP"
+		gvimdiff -f -- "$LOCAL" "$path" "$REMOTE"
+		check_unchanged
+		save_backup
+		;;
 	xxdiff)
 	    touch "$BACKUP"
 	    if base_present ; then
@@ -293,7 +299,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | "")
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -312,6 +318,8 @@ if test -z "$merge_tool" ; then
 	merge_tool=xxdiff
     elif type meld >/dev/null 2>&1 && test -n "$DISPLAY"; then
 	merge_tool=meld
+    elif type gvimdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
+	merge_tool=gvimdiff
     elif type opendiff >/dev/null 2>&1; then
 	merge_tool=opendiff
     elif type emacs >/dev/null 2>&1; then
@@ -325,7 +333,7 @@ if test -z "$merge_tool" ; then
 fi

 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff|opendiff)
+    kdiff3|tkdiff|meld|xxdiff|vimdiff|gvimdiff|opendiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
-- 
1.5.2.1
