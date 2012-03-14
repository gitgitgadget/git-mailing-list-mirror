From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 5/5 v2] contrib/diffall: fix cleanup trap on Windows
Date: Wed, 14 Mar 2012 12:38:06 -0400
Message-ID: <1331743086-32304-6-git-send-email-tim.henigan@gmail.com>
References: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 14 17:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rFY-0005CA-DW
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360Ab2CNQk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:40:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44337 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030328Ab2CNQk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:40:26 -0400
Received: by yhmm54 with SMTP id m54so1982024yhm.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/eDr22hpNmNWyKHKlO4MeJxDEyCDlwxrwtP+rli57iE=;
        b=jKvpVXjtnov0M4NJZ2NYGtyVFM1LuufIW9+sGWF9wmA002KV0ZxrjN5e1IP7GDhrjm
         FYdScfcd9qaSKee3h11N5LzgMiMQeU4K9VgdZd8/J1dm/Uz8fedx5N7vzEpQKgiPfWVc
         lQHuQoNZ2tGAhmZxhhKovu6uAVXd2qnb6WZsKlqncPz0pfRc+qDKM3yvI+AGX9YqqbN+
         5v+bE51cGxk9CDiwYgLlxewR1t4TvWPDgm237lTHDtV6sFSuJbIEKKPHJT4P7WZ4R1aB
         K3yTtr0mEl4tpANpFueAbc0ge/x/NpxIchqJfXrc7j5bicb28YnC43umxvWOC91r4IPn
         1ZiA==
Received: by 10.224.202.66 with SMTP id fd2mr3982142qab.9.1331743226217;
        Wed, 14 Mar 2012 09:40:26 -0700 (PDT)
Received: from localhost ([99.38.69.118])
        by mx.google.com with ESMTPS id ec5sm9610438qab.21.2012.03.14.09.40.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 09:40:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193132>

Prior to this commit, the cleanup trap that removes the tmp dir
created by the script would fail on Windows. The error was silently
ignored by the script.

On Windows, a directory cannot be removed while it is the working
directory of the process (thanks to Johannes Sixt on the Git list
for this info [1]).

This commit eliminates the 'cd' into the tmp directory that caused
the error.

[1]: http://article.gmane.org/gmane.comp.version-control.git/193086

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This patch was added in v2 of the series.


 contrib/diffall/git-diffall |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index 91a31c8..84f2b65 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -49,7 +49,7 @@ cd "$cdup" || {
 tmp=$(perl -e 'use File::Temp qw(tempdir);
 	$t=tempdir("/tmp/git-diffall.XXXXX") or exit(1);
 	print $t') || exit 1
-trap 'rm -rf "$tmp" 2>/dev/null' EXIT
+trap 'rm -rf "$tmp"' EXIT
 
 left=
 right=
@@ -233,9 +233,8 @@ do
 	fi
 done < "$tmp/filelist"
 
-cd "$tmp"
-LOCAL="$left_dir"
-REMOTE="$right_dir"
+LOCAL="$tmp/$left_dir"
+REMOTE="$tmp/$right_dir"
 
 if test -n "$diff_tool"
 then
-- 
1.7.10.rc0
