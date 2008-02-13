From: Alberto Bertogli <albertito@gmail.com>
Subject: [PATCH] Fix "git submodule status" output when "git describe" is not possible
Date: Tue, 12 Feb 2008 22:19:46 -0200
Message-ID: <1202861986-1159-1-git-send-email-albertito@gmail.com>
Cc: gitster@pobox.com, Alberto Bertogli <albertito@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 01:21:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP5N6-0007E4-Sh
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 01:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496AbYBMAU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 19:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757187AbYBMAU0
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:20:26 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:36207 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYBMAUY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 19:20:24 -0500
Received: by py-out-1112.google.com with SMTP id u52so7556660pyb.10
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 16:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=g8y3wulLEh0ZwL1lqcn2SaJYVcDIoorVK3LZItnbHAA=;
        b=asz3BbaYp9m0wZpNlzk1tE9QKj4ERlEMiZJo8cLLHP0tNzXp/oFvemD/w7e8wwuQQ7y8+K7YMdgPb1sX6cBsno5qQi5lyyATzJUFh4vriqabZnNKZBgEntIOpGdNYXSO7puxCEHPcxlGJGSau++5tq1kcMY6vN3iVJdWonOAoik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fWtk0SuyxTBKTVzS72viTRTsxpp+vUE1dz4kDEa2k2nIyXn0Qs3v2osmmm+Jw0SteZdnVLg518Fwz4BXvxga0xQpLDl2DaWWEP4voKvTA3JcDS6kgwtjjP3mBetro2KHwb5YqJo32LVZjegFBNC+JD4BKNhmeIi9q9MKLLABV+w=
Received: by 10.65.83.18 with SMTP id k18mr2317529qbl.23.1202862023366;
        Tue, 12 Feb 2008 16:20:23 -0800 (PST)
Received: from gmail.com ( [200.117.160.120])
        by mx.google.com with ESMTPS id g3sm1246275wra.7.2008.02.12.16.20.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Feb 2008 16:20:22 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1279.g0d205f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73719>

When a submodule cannot be described, doing a "git submodule status" on
the supermodule produces unnecesary and scary output, for example:

    fatal: cannot describe 'cac575f1bccf0c6942d11962cf4d44ba974d3e8e'
     cac575f1bccf0c6942d11962cf4d44ba974d3e8e megaco/megaco_tipc

Where it should just show:

     cac575f1bccf0c6942d11962cf4d44ba974d3e8e megaco/megaco_tipc

The culprit (after manual inspection of git log) seems to be commit
a2cf9f4.

This patch fixes this by making git submodule aware of that behaviour
change.

Signed-off-by: Alberto Bertogli <albertito@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..5e8b84f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -315,7 +315,7 @@ set_name_rev () {
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains --tags "$2"
+			git describe --contains --tags "$2" 2>/dev/null
 		}
 	) )
 	test -z "$revname" || revname=" ($revname)"
-- 
1.5.4.1.1279.g0d205f-dirty
