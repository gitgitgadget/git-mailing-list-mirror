From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 1/2] Fixes chooser not accepting gitfiles
Date: Fri,  6 Mar 2015 11:21:52 -0500
Message-ID: <1425658913-2721-2-git-send-email-remirampin@gmail.com>
References: <1425658913-2721-1-git-send-email-remirampin@gmail.com>
Cc: Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org, patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Mar 06 17:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTv15-00075s-Db
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbbCFQWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 11:22:16 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:40983 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbbCFQWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 11:22:15 -0500
Received: by qcvx3 with SMTP id x3so23550931qcv.8
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KZBz8jrqIun/dkYwx4qvY1dypqtke65ySqI1xheWXNU=;
        b=hqj5NFl+ntaw5SqZ8cmAmxrimKTW9P9mvO205QzcCNdUsyL7fbX7zW64olkLpQ4rOr
         syQsoJDreGSw3dmv1+4y26KQBsX7qaqLSTEW2nvbXg4YWNya+NSqpTW4fTv1MyEvFhKS
         T5MZI+T8W0UWSbeLIqqkO5lVUOjuYBVonTxnoR8Ncsjb9Ogu9MENp3CZP5FrW+HVzBm/
         RmNig6yLcFtHQxWrTFl6gawsK7Fd0BwUd8Z/1M0BwTq1ZoHHB3/ZkuFwbgddgniDgybx
         gp7/WgG4JxK3YI1Zld9pEQfe16xvoQlWbzFtuzxF6Vg+yc/u3hxYTx9Fx0uODbMnbhOn
         7jkw==
X-Received: by 10.55.25.26 with SMTP id k26mr30398559qkh.10.1425658934592;
        Fri, 06 Mar 2015 08:22:14 -0800 (PST)
Received: from debian-78-amd64.poly.edu (remram.poly.edu. [128.238.102.127])
        by mx.google.com with ESMTPSA id h85sm6037518qhc.6.2015.03.06.08.22.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 08:22:14 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1425658913-2721-1-git-send-email-remirampin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264938>

Makes _is_git handle the case where the path is a "gitdir: ..." file.

Signed-off-by: Remi Rampin <remirampin@gmail.com>
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
