From: Orion Poplawski <orion@cora.nwra.com>
Subject: Using git apply inside a repository but on un-tracked files
Date: Thu, 10 May 2012 10:46:25 -0600
Message-ID: <4FABF0E1.1040902@cora.nwra.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040309010700020908030606"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 19:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWkU-0001iE-Os
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 19:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab2EJRBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 13:01:44 -0400
Received: from earth.cora.nwra.com ([4.28.99.180]:41117 "EHLO
	earth.cora.nwra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab2EJRBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 13:01:43 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 May 2012 13:01:43 EDT
Received: from orca.cora.nwra.com (orca.cora.nwra.com [10.10.20.2])
	(authenticated bits=0)
	by earth.cora.nwra.com (8.13.8/8.13.8) with ESMTP id q4AGkPKe002471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 10 May 2012 10:46:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cora.nwra.com;
	s=default; t=1336668386;
	bh=8pm/EDKs4H5Bu567qgtQpSxZP23Za2SOCj9+a9w7NKI=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type;
	b=oPclndBlFZ6d2Y8ZNc5TJbPOeQSkoKLTuDpSQyp6YYYzW1SiSmqHOhWVM1va1DyPq
	 wGtJuzCadt84w/1DumFr4qsTXvcMS7mniym+Z+n+zy/pnHKeNzWqLfZ32pRY5BedX7
	 YLQrJ5CZ1ILFrL99bZQ6S6G3gXeFXDfTKfZrI+ls=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197602>

This is a multi-part message in MIME format.
--------------040309010700020908030606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm a Fedora package which tracks the the package files in git.  When the 
package source is unpacked it is unpacked under the git directory, however 
these files are not tracked by git.

I tried to use git apply to apply a patch (because it is coming mercurial and 
has diff --git rename info in it) to the package source.  However, the 
presence of a .git repo in the parent tree caused git apply to refuse to apply 
the patch, unfortunately silently without any complaint or error return code, 
even with --verbose.  I got it to work by passing the  appropriate --directory 
option, but this took me a long time to figure out due to the lack of a 
warning messages.  Could one be added please?  Perhaps like in the attached patch?

TIA,

  Orion

-- 
Orion Poplawski
Technical Manager                     303-415-9701 x222
NWRA, Boulder Office                  FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                   http://www.nwra.com

--------------040309010700020908030606
Content-Type: text/x-patch;
 name="apply.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="apply.patch"

--- apply.c.orig	2012-05-01 22:50:38.000000000 -0600
+++ apply.c	2012-05-10 10:45:10.744088807 -0600
@@ -3631,8 +3631,12 @@
 	if (0 < prefix_length) {
 		int pathlen = strlen(pathname);
 		if (pathlen <= prefix_length ||
-		    memcmp(prefix, pathname, prefix_length))
+		    memcmp(prefix, pathname, prefix_length)) {
+			if (apply_verbosely)
+				error("path '%s' is outide of git repo '%s'",
+				      pathname, prefix);
 			return 0;
+		}
 	}
 
 	/* See if it matches any of exclude/include rule */

--------------040309010700020908030606--
