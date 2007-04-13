From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-quiltimport complaining yet still working
Date: Fri, 13 Apr 2007 14:34:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704131431040.28042@woody.linux-foundation.org>
References: <20070413203837.GA27660@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Greg KH <greg@kroah.com>, Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 23:34:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcTPV-00053t-Q9
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 23:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbXDMVeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 17:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbXDMVeW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 17:34:22 -0400
Received: from smtp.osdl.org ([65.172.181.24]:53360 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030505AbXDMVeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 17:34:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DLYJIs002117
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 14:34:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DLYITY009969;
	Fri, 13 Apr 2007 14:34:18 -0700
In-Reply-To: <20070413203837.GA27660@kroah.com>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44435>



On Fri, 13 Apr 2007, Greg KH wrote:
>
> In git 1.5.1 the quiltimport function started complaining in a new way:
> 
> 	libata-clear-tf-before-doing-request-sense.patch
> 	Patch is empty.  Was is split wrong?
> 	/usr/bin/git-quiltimport: line 78: stop_here: command not found

This is an *old* bug. It got fixed once already. Did it get re-introduced?

Ahh - somebody copied the bug from git-applymbox

> Any hints?  Or is it time to start bisecting?

This should fix it.

There were two bugs: "stop_here" doesn't exist, but the bug that causes 
this code to trigger in the *first* place is the wrong use of "$dotest". 
It should be ".dotest"

		Linus

---
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index edccd82..018cc75 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -73,9 +73,9 @@ mkdir $tmp_dir || exit 2
 for patch_name in $(cat "$QUILT_PATCHES/series" | grep -v '^#'); do
 	echo $patch_name
 	(cat $QUILT_PATCHES/$patch_name | git-mailinfo "$tmp_msg" "$tmp_patch" > "$tmp_info") || exit 3
-	test -s $dotest/patch || {
+	test -s .dotest/patch || {
 		echo "Patch is empty.  Was is split wrong?"
-		stop_here $this
+		exit 1
 	}
 
 	# Parse the author information
