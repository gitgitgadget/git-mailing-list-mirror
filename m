From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 6/6] gitk: Fallback to selecting the head commit upon load.
Date: Sun, 27 Jul 2008 10:22:42 +0400
Organization: TEPKOM
Message-ID: <200807271022.42476.angavrilov@gmail.com>
References: <200807271017.23272.angavrilov@gmail.com> <200807271020.53171.angavrilov@gmail.com> <200807271021.46661.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 08:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzfc-0003gC-8t
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYG0GWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbYG0GWw
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:22:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:56564 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYG0GWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:22:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1893331fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fJJ+TWKvXiTfzCfR1t9JJ3AOm+vbpIvKukNJ13H4df0=;
        b=qXUdf5VK4tE7msg1PmWbPZde823QT1FhmRPIu4lF5JcrQN89E0J9QqxVlSE47E/YRX
         IaaokGqs5Z4duFQNfna3/x+mmytRNavIUqODGOyCN7n3zPACqJV9isG1Y5xQf4Hs26Gy
         RxYJut7dYq+IWs0Bge2E9lwelwGnyO8Yk9ITQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bAJ2s2PQJciIAzHN/lcwChW/MyJi1rtwbfUnh/tG9SavaDKAXvftAHCIFYwZ5sU4jw
         kolsnO8wSeHNJNu4b+mliWaDtFe/WKjLrYaAn75xANEgYFbIxgpGLOyQP/EZ0YvCuso7
         PRN05kHBKxd//yd4ZbYVGHYjk65UwIujflzKA=
Received: by 10.86.74.15 with SMTP id w15mr1424106fga.8.1217139770479;
        Sat, 26 Jul 2008 23:22:50 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id d6sm16234091fga.2.2008.07.26.23.22.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:22:49 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807271021.46661.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90320>

Date: Sat, 26 Jul 2008 20:15:54 +0400

Try selecting the head, if the previously selected commit
is not available in the new view.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 5021437..d093a39 100755
--- a/gitk
+++ b/gitk
@@ -1506,8 +1506,15 @@ proc chewcommits {} {
 	global numcommits startmsecs
 
 	if {[info exists pending_select]} {
-	    set row [first_real_row]
-	    selectline $row 1
+	    update
+	    reset_pending_select {}
+
+	    if {[commitinview $pending_select $curview]} {
+		selectline [rowofcommit $pending_select] 1
+	    } else {
+		set row [first_real_row]
+		selectline $row 1
+	    }
 	}
 	if {$commitidx($curview) > 0} {
 	    #set ms [expr {[clock clicks -milliseconds] - $startmsecs}]
@@ -3372,14 +3379,18 @@ proc showview {n} {
     drawvisible
     if {$row ne {}} {
 	selectline $row 0
-    } elseif {$mainheadid ne {} && [commitinview $mainheadid $curview]} {
-	selectline [rowofcommit $mainheadid] 1
     } elseif {!$viewcomplete($n)} {
 	reset_pending_select $selid
     } else {
-	set row [first_real_row]
-	if {$row < $numcommits} {
-	    selectline $row 0
+	reset_pending_select {}
+
+	if {[commitinview $pending_select $curview]} {
+	    selectline [rowofcommit $pending_select] 1
+	} else {
+	    set row [first_real_row]
+	    if {$row < $numcommits} {
+		selectline $row 0
+	    }
 	}
     }
     if {!$viewcomplete($n)} {
-- 
1.5.6.3.18.gfe82
