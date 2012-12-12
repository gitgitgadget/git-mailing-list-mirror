From: Jaime Frey <jfrey@cs.wisc.edu>
Subject: directory permissions on AFS
Date: Wed, 12 Dec 2012 17:39:30 -0600
Message-ID: <0A6FA42F-986D-4C3C-BC50-9A7C0494C703@cs.wisc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 00:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiw1U-0001wx-OB
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab2LLXrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:47:16 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:34537 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab2LLXrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:47:15 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2012 18:47:15 EST
Received: from [128.105.24.245] ([128.105.24.245])
	(authenticated bits=0)
	by sabe.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id qBCNdU3G029160
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 12 Dec 2012 17:39:30 -0600
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211421>

Hi,

We have a shared bare git repository on AFS, which our developers
pull from and push to from their local repositories. Some developers
access the bare repository directly over AFS and others use ssh.
Every couple of months, all of the two-character directories under
the objects directory disappear. Afterwards, most pushes fail with an
error like this:

error: unable to create temporary sha1 filename ./objects/fb:
Permission denied

Stracing git revealed that it successfully recreated the ./objects/fb 
and then failed to chmod() it. It failed because it tried to set the
S_ISGID bit, which mere mortals cannot do on AFS. Manually recreating 
all of these directories solves the problem. 

I took a quick look at the git source and it appears git always tries 
to set the S_ISGID on a new directory if core.sharedrepository is 
enabled in the config. I don't know what other effects would result  
from setting core.sharedrepository to 0.

Would it be feasible to allow the setting of S_ISGID to disabled,
apart from modifying core.sharedrepository? Possibly a new config
parameter or detecting if the directory is on AFS?

 -- Jaime Frey
