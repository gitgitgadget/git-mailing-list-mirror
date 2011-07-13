From: Yggy King <yggy@zeroandone.ca>
Subject: gitk: make "touching paths" search support backslashes
Date: Wed, 13 Jul 2011 01:30:26 -0700
Message-ID: <CAE2ZgT1W1ugfjY4fXdSsa8LzSgwYXhNOT=8jD5AZf5J3+FX9HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 10:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qguq0-0002aP-S5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064Ab1GMIa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 04:30:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35113 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964995Ab1GMIa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 04:30:27 -0400
Received: by gwaa18 with SMTP id a18so2280906gwa.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=p7LNs8BJp1e3YmOAekUD8jLHcXJKijbJ3Jgs/l5mUvY=;
        b=x77TU6OeOXRdn5pwiuya6Rn6EFdUvqQ9B5m+RfxPV+Nu3iUxCXz4InR7RhHeLH3uqW
         9+32q2/1SPvoXgVB49UIlszAVrdmam8IfvFHwJ1kNCNoQTC/J0JnG0GFAcvVl2FmTcfj
         BIRY8fgxzEyLhqsu8g8CDIoNMyzaZX1iPlOI8=
Received: by 10.236.155.36 with SMTP id i24mr1178943yhk.280.1310545826288;
 Wed, 13 Jul 2011 01:30:26 -0700 (PDT)
Received: by 10.236.60.231 with HTTP; Wed, 13 Jul 2011 01:30:26 -0700 (PDT)
X-Google-Sender-Auth: mB3efaNsoS3pkNh-2z4kKK4UkJU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177012>

>From bf31f7cf6faa7b786e231345b69826cc114001e0 Mon Sep 17 00:00:00 2001
From: Yggy King <yggy@zeroandone.ca>
Date: Wed, 13 Jul 2011 01:15:51 -0700
Subject: [PATCH] gitk: make "touching paths" search support backslashes

Gitk can search for commits touching a specified path. The search text is
always treated as a regular expression, regardless of the matching option
selected (Exact, IgnCase, or Regexp). In particular, backslashes escape
the next character. This is inconvenient on Windows systems, where backslashes
are then norm for path specifiers, for example when copy/pasting from
Windows Explorer or a cmd shell -- these copy-pasted paths must be manually
modified in the gitk search text edit box before they will work.

This change uses the match option "Exact" to mean that a slash is a slash,
not part of a regular expression. Backslashes are converted to frontslashes
before searching, thus allowing easy copy/pasting of paths on Windows
systems. If the previous behaviour of "touching paths" search is desired,
simply select the "Regexp" search mode.

One potential drawback is that the default setting for the match option
($findtype in the code) is "Exact", and so this change alters the default
behaviour, which may confuse users and lead to bug reports.

(This is my first submission to the list -- please be gentle if I've
violated protocol. :-)

Signed-off-by: Yggy King <yggy@zeroandone.ca>
---
 gitk-git/gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..d5f604e 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4528,9 +4528,14 @@ proc makepatterns {l} {
 }

 proc do_file_hl {serial} {
-    global highlight_files filehighlight highlight_paths gdttype fhl_list
+    global highlight_files filehighlight highlight_paths gdttype
findtype fhl_list

     if {$gdttype eq [mc "touching paths:"]} {
+    # If "exact" match then convert backslashes to frontslashes. Most useful
+    # to support Windows-flavoured file paths.
+    if {$findtype eq [mc "Exact"]} {
+        set highlight_files [string map {"\\" "/"} $highlight_files]
+    }
 	if {[catch {set paths [shellsplit $highlight_files]}]} return
 	set highlight_paths [makepatterns $paths]
 	highlight_filelist
-- 
1.7.6.msysgit.0
