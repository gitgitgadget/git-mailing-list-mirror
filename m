From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Redirect to appropriate view if 'a=' parameter is missing
Date: Fri,  7 Mar 2008 22:03:18 +0100
Message-ID: <1204923800-5923-2-git-send-email-jnareb@gmail.com>
References: <1204923800-5923-1-git-send-email-jnareb@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 22:04:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXjkA-0003vg-66
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759760AbYCGVDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 16:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759515AbYCGVDe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:03:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:1331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbYCGVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 16:03:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so703927fga.17
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 13:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ErlurzmnXV7SW4UnJBG+o/nA3+CHXVF+MtO9RlTzKYo=;
        b=XnwWNbnzJNQ2CGiB460X09xe8Th2CeDoDQaDcDVgSSBTUHRYSvXRzS1BNUsYEYsQ/5Fy7iS6/upMDkG1yWT5SEunXL3zwAMaKq4JAdMTqUyfP4ofIezJ1OShVsOpL1uy5ULdElyc+n7Gyp7rsgFIbCkoGubTdX7Yc2C6I01diw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MD1Q/+gEDWn3ZV07k8IQYxDojotf/XZnP3gz3myLrtSBZdBwN0AwsDeMm40hRGqSgmoFBf/SaZQmz88riBrJxa2UR3OEFqJ/5j5FTs2uZr0c1NuIpF5jTNnKC+X1Zmc/Bh89KopSEH9awRaji45rdrZaYq3rrD9DLG11hwKA0D0=
Received: by 10.86.31.18 with SMTP id e18mr2012471fge.35.1204923809299;
        Fri, 07 Mar 2008 13:03:29 -0800 (PST)
Received: from localhost.localdomain ( [83.8.243.158])
        by mx.google.com with ESMTPS id l19sm4932810fgb.0.2008.03.07.13.03.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 13:03:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27L3Pji005946;
	Fri, 7 Mar 2008 22:03:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27L3PYH005945;
	Fri, 7 Mar 2008 22:03:25 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204923800-5923-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76523>

Instead of finding the type of object specified by 'h',
or 'hb' and 'f' parameters and substituting it for action
(view), as it was done since commit 7f9778b by Gerrit Pape,
use 'object' view which would find type and REDIRECT to URL
with 'a' parameter filled in.

This way user will have URL with action filled in the browser
history, or when adding bookmark. This hopefully would make
server get less requests without 'a' parameter set, thus
reducing a bit load on server.


Note that the code to find object type in git_object() subroutine
is a bit more complicated than was used for URL without 'a='
parameter.

Cc: Gerrit Pape <pape@smarden.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The fact that using 'object' view changes a bit behavior is addressed
in second commit in this series, where git_commit() is made to do what
dispatch for URL without a=, but with h= or hb= and f= did before.

 gitweb/gitweb.perl |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec73cb1..a76c4ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -564,10 +564,9 @@ my %actions = (
 );
 
 if (!defined $action) {
-	if (defined $hash) {
-		$action = git_get_type($hash);
-	} elsif (defined $hash_base && defined $file_name) {
-		$action = git_get_type("$hash_base:$file_name");
+	if (defined $hash ||
+	    (defined $hash_base && defined $file_name)) {
+		$action = 'object';
 	} elsif (defined $project) {
 		$action = 'summary';
 	} else {
-- 
1.5.4.3.453.gc1ad83

