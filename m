From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH resend] gitk: Skip over AUTHOR/COMMIT_DATE when searching all
 fields
Date: Thu, 8 Mar 2012 06:35:50 -0600
Message-ID: <20120308123539.GA5862@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ca8-0007pa-4j
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143Ab2CHMf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 07:35:59 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42086 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756370Ab2CHMf6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:35:58 -0500
Received: by obbuo6 with SMTP id uo6so604098obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=yVwmaTpnfZUASEFF31tyoIutXXmBkvyIcgLv8Pdt7xM=;
        b=jakrmjoIJ7Ydg3w1H38k9p5qbKaEWWyTxhcgsr/MoSvlZbGPMwuStxEiZaIFAs3AuA
         1bMUueYs12lc4V3stwwOIyavbOnxk1YHlBU7vt/hOtEVuxdjMZ/rhzkOMNShgPUC3qOn
         7uZzTxwVODRIUgANDIKfdN0DUEjfOx3C4noLmGzgWiTyAGxeeGJpRRgbnIHTWEPCGFAT
         Uwa8Eiws4wthw6D0zliwEZOx6wZd8SAZZWOmnfFFVz8S01i89YAtFy5i+s0ejY0agw+s
         eWc7lCHg0KdEnbpHNO/wx8ho9zC6oNVDRkWNodbDbsu+kBox6iS8rbFwN/MxNVzVTsnw
         sX6g==
Received: by 10.182.17.100 with SMTP id n4mr2254235obd.45.1331210158174;
        Thu, 08 Mar 2012 04:35:58 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j9sm1294036obl.21.2012.03.08.04.35.56
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 04:35:57 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192585>

=46rom: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Date: Sun, 14 Mar 2010 18:59:09 -0400

This prevents a search for a number like "105" on "All Fields" from
matching against the raw author and commit timestamps.  These
timestamps were already not searchable by themselves, and the
displayed format does not match the query string anyway.

Signed-off-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Last seen at [1].  Since then, the commit message was tweaked for
clarity but not other changes.

[1] http://thread.gmane.org/gmane.comp.version-control.git/142160

 gitk-git/gitk |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 6981cb20..17ba10a8 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4630,8 +4630,9 @@ proc askfindhighlight {row id} {
     }
     set info $commitinfo($id)
     set isbold 0
-    set fldtypes [list [mc Headline] [mc Author] [mc Date] [mc Committ=
er] [mc CDate] [mc Comments]]
+    set fldtypes [list [mc Headline] [mc Author] "" [mc Committer] "" =
[mc Comments]]
     foreach f $info ty $fldtypes {
+	if {$ty eq ""} continue
 	if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
 	    [doesmatch $f]} {
 	    if {$ty eq [mc "Author"]} {
@@ -6492,7 +6493,7 @@ proc findmore {} {
     if {![info exists find_dirn]} {
 	return 0
     }
-    set fldtypes [list [mc "Headline"] [mc "Author"] [mc "Date"] [mc "=
Committer"] [mc "CDate"] [mc "Comments"]]
+    set fldtypes [list [mc "Headline"] [mc "Author"] "" [mc "Committer=
"] "" [mc "Comments"]]
     set l $findcurline
     set moretodo 0
     if {$find_dirn > 0} {
@@ -6553,6 +6554,7 @@ proc findmore {} {
 	    }
 	    set info $commitinfo($id)
 	    foreach f $info ty $fldtypes {
+		if {$ty eq ""} continue
 		if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
 		    [doesmatch $f]} {
 		    set found 1
--=20
1.7.9.2
