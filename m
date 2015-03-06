From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 2/2] Makes chooser set 'gitdir' to the resolved path
Date: Fri,  6 Mar 2015 11:21:53 -0500
Message-ID: <1425658913-2721-3-git-send-email-remirampin@gmail.com>
References: <1425658913-2721-1-git-send-email-remirampin@gmail.com>
Cc: Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org, patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Mar 06 17:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTv16-00075s-0r
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbbCFQWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 11:22:20 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:41060 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbCFQWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 11:22:16 -0500
Received: by qgea108 with SMTP id a108so13703600qge.8
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 08:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x4WvDLb58U4zVnL0zIiIMonKnIa40TRLf6G4pw5VWNI=;
        b=smzWXZuCmm3pNpf/HBqvRr3kWa39guxTELllt3c/Wgp3aqZE5v8wFZJGsMTFlFkFZy
         21Larf7tQ6qrPplWpaff/et7UQ18gao42Fl+gnSrvCN5SV5jxY93Y8OivI8XhqpPTxQX
         7fjaf6Igg5vIzVOIHEe49z0oZJp0IGxMr9Ije/O3z3Qi2wooy6aRWhFwatprw+jxu2d8
         I8HDmByFOHg0MmcqPkTDHDo4TKQqZ1XE/g1jAAjXMhvMamQ3V/CjAuPVVSlaeX/9JCFx
         mpw0/n/lzvvRj4eavhxI2kFTJmMZDxRDi6hXbQi4Ac/ZilGQm6gMReqXMSUAiZ4BFCYS
         Y/Fg==
X-Received: by 10.229.26.69 with SMTP id d5mr20705812qcc.9.1425658935773;
        Fri, 06 Mar 2015 08:22:15 -0800 (PST)
Received: from debian-78-amd64.poly.edu (remram.poly.edu. [128.238.102.127])
        by mx.google.com with ESMTPSA id h85sm6037518qhc.6.2015.03.06.08.22.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 08:22:14 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1425658913-2721-1-git-send-email-remirampin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264939>

If _is_git follows a "gitdir: ..." file link to get to the actual
repository, we want _gitdir to be set to that final path.

Signed-off-by: Remi Rampin <remirampin@gmail.com>
---
 lib/choose_repository.tcl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index abc6b1d..75d1da8 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -338,7 +338,10 @@ method _git_init {} {
 	return 1
 }
 
-proc _is_git {path} {
+proc _is_git {path {outdir_var ""}} {
+	if {$outdir_var ne ""} {
+		upvar 1 $outdir_var outdir
+	}
 	if {[file isfile $path]} {
 		set fp [open $path r]
 		gets $fp line
@@ -352,12 +355,14 @@ proc _is_git {path} {
 	if {[file exists [file join $path HEAD]]
 	 && [file exists [file join $path objects]]
 	 && [file exists [file join $path config]]} {
+		set outdir $path
 		return 1
 	}
 	if {[is_Cygwin]} {
 		if {[file exists [file join $path HEAD]]
 		 && [file exists [file join $path objects.lnk]]
 		 && [file exists [file join $path config.lnk]]} {
+			set outdir $path
 			return 1
 		}
 	}
@@ -1103,7 +1108,7 @@ method _open_local_path {} {
 }
 
 method _do_open2 {} {
-	if {![_is_git [file join $local_path .git]]} {
+	if {![_is_git [file join $local_path .git] actualgit]} {
 		error_popup [mc "Not a Git repository: %s" [file tail $local_path]]
 		return
 	}
@@ -1116,7 +1121,7 @@ method _do_open2 {} {
 	}
 
 	_append_recentrepos [pwd]
-	set ::_gitdir .git
+	set ::_gitdir $actualgit
 	set ::_prefix {}
 	set done 1
 }
-- 
1.9.5.msysgit.0
