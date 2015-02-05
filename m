From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 1/2] Fixes chooser not accepting gitfiles
Date: Thu,  5 Feb 2015 11:20:14 -0500
Message-ID: <1423153215-9706-2-git-send-email-remirampin@gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
 <1423153215-9706-1-git-send-email-remirampin@gmail.com>
Cc: patthoyts@users.sourceforge.net, Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 17:20:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJPAU-0006uZ-1H
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 17:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052AbbBEQU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 11:20:27 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38544 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbBEQUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 11:20:25 -0500
Received: by mail-qc0-f174.google.com with SMTP id s11so7157991qcv.5
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Smiflv8OIhNG1Y2jwu23FcAmsG9rPnxoeJGtMUE0Oj8=;
        b=amy/IWgUHLam4HNgU5d8lMoonMiY4RIT6z5I6iXI3ymKZcM+joA22Hom2sd8f7zPY/
         DACVExvc6pzWk2pELo0HpBmQ5o3Y4M8csCZRPPdQm/4BYGzm6kPcyHAUOOvw9JosQDZ7
         HeGSFB7uWQg2+T1RROL7LO0UJJRORqf88AFI+10KvJJYIr6f0b2mZmfJ0ipHYJcd5D+Q
         Fshu6e/LrsSJanIHm/5TrSPeW60sXK3pMy7pTaghbJ3NS1SJiK74c1aZKBqacghaXajB
         epMTK1111eyCWcZ38jgL93YdG2XZDIubeTm9Eaq5yh4WI9zR0zvg52vXibvTax7SaYdG
         j26Q==
X-Received: by 10.140.85.211 with SMTP id n77mr9151208qgd.17.1423153224916;
        Thu, 05 Feb 2015 08:20:24 -0800 (PST)
Received: from debian-78-amd64.poly.edu ([128.238.102.81])
        by mx.google.com with ESMTPSA id c16sm5333798qge.24.2015.02.05.08.20.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2015 08:20:24 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1423153215-9706-1-git-send-email-remirampin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263378>

Makes _is_git handle the case where the path is a "gitdir: ..." file.
---
 lib/choose_repository.tcl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 92d6022..abc6b1d 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -339,6 +339,16 @@ method _git_init {} {
 }
 
 proc _is_git {path} {
+	if {[file isfile $path]} {
+		set fp [open $path r]
+		gets $fp line
+		close $fp
+		if {[regexp "^gitdir: (.+)$" $line line link_target]} {
+			set path [file join [file dirname $path] $link_target]
+			set path [file normalize $path]
+		}
+	}
+
 	if {[file exists [file join $path HEAD]]
 	 && [file exists [file join $path objects]]
 	 && [file exists [file join $path config]]} {
-- 
1.9.5.msysgit.0
