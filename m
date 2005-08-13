From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sat, 13 Aug 2005 22:39:41 +0200
Message-ID: <200508132239.41445.Josef.Weidendorfer@gmx.de>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de> <200508132031.27668.Josef.Weidendorfer@gmx.de> <7voe81myc4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 22:42:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E42oD-0003j0-92
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 22:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVHMUka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 16:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVHMUka
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 16:40:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:30946 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932280AbVHMUka (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 16:40:30 -0400
Received: (qmail invoked by alias); 13 Aug 2005 20:40:28 -0000
Received: from p54968113.dip0.t-ipconnect.de (EHLO linux) [84.150.129.19]
  by mail.gmx.net (mp010) with SMTP; 13 Aug 2005 22:40:28 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7voe81myc4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Saturday 13 August 2005 21:27, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> > Or is there already an easy way to detect the fast-forward situation in
> > the script?
>
> Since you are given old and new, presumably you can do
> merge-base in the hook to see what it yields?

Ah, yes, thanks.
A proposed update for the example hook (one change actually is a fix):

Fixed/Extended example for update hook
---

diff --git a/templates/hooks--update b/templates/hooks--update
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to mail out commit update information.
+# Called by git-receive-pack with arguments: refname sha1-old sha1-new
 #
 # To enable this hook:
 # (1) change the recipient e-mail address
@@ -12,10 +13,15 @@ recipient="commit-list@mydomain.xz"
 if expr "$2" : '0*$' >/dev/null
 then
        echo "Created a new ref, with the following commits:"
-       git-rev-list --pretty "$2"
+       git-rev-list --pretty "$3"
 else
-       echo "New commits:"
-       git-rev-list --pretty "$3" "^$2"
+       $base=$(git-merge-base "$2" "$3")
+       if [ $base == "$2" ]; then
+               echo "New commits:"
+       else
+               echo "Rebased ref, commits from common ancestor:"
+       fi
+       git-rev-list --pretty "$3" "^$base"
 fi |
 mail -s "Changes to ref $1" "$recipient"
 exit 0
