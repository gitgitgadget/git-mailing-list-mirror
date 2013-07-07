From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v3 0/2] allow git-svn fetching to work using serf
Date: Sat,  6 Jul 2013 21:20:47 -0700
Message-ID: <1373170849-9150-1-git-send-email-mackyle@gmail.com>
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 06:21:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvgTP-0003fc-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 06:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab3GGEU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 00:20:57 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:48426 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3GGEU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 00:20:56 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro2so3252622pbb.27
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 21:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5v4Hww6bkLmmAfWOJvbQQkB4cZ+uqKsNWOo8/NVXY+8=;
        b=RYhbVr2kk0VEHjre63mNREn0g+aze8XNR7Kx+DXCTHN0KhSedPNYOAscJZvzZ5X9Hj
         kOj9QhriyNh1QoKivMr4zHjimdxMPvbqRUvzuE0HphHrPmu3sfy3zZyl1UGA9ibIZKbO
         JfTXWjHLaRCUUqyxT0/cSgY6l+EK/OFgFlPqfRFiBqJqUNSVgqNXTiMe+zSLI8WMRi+a
         0XTB0Qb8eHnRlci8fFxlPRQjlabrBMnmQM2qPZOBVkoRHBwunOh5RNdxwScLVOgDehxD
         9F/x+q1ii7luA0U5alhHtmn0Qd3UvdkzUdjyB9BRBs4yvSSvG8djyWaMHucyXci+PO/Y
         vgCA==
X-Received: by 10.68.179.194 with SMTP id di2mr15816364pbc.203.1373170855997;
        Sat, 06 Jul 2013 21:20:55 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qe10sm15179401pbb.2.2013.07.06.21.20.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 21:20:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229728>

From: "Kyle J. McKay" <mackyle@gmail.com>

This patch allows git-svn to fetch successfully using the
serf library when given an https?: url to fetch from.

Unfortunately some svn servers do not seem to be configured
well for use with the serf library.  This can cause fetching
to take longer compared to the neon library or actually
cause timeouts during the fetch.  When timeouts occur
git-svn can be safely restarted to fetch more revisions.

A new temp_is_locked function has been added to Git.pm
to facilitate using the minimal number of temp files
possible when using serf.

The problem that occurs when running git-svn fetch using
the serf library is that the previously used temp file
is not always unlocked before the next temp file needs
to be used.

To work around this problem, a new temp name is used
if the temp name that would otherwise be chosen is
currently locked.

Version v2 of the patch introduced a bug when changing the _temp_cache
function to use the new temp_is_locked function at the suggestion of a
reviewer.  That has now been resolved.

Kyle J. McKay (2):
  Git.pm: add new temp_is_locked function
  git-svn: allow git-svn fetching to work using serf

 perl/Git.pm             | 33 +++++++++++++++++++++++++++++++--
 perl/Git/SVN/Fetcher.pm |  6 ++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

-- 
1.8.3
