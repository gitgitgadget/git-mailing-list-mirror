From: Kyle McKay <mackyle@gmail.com>
Subject: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Fri, 5 Jul 2013 20:41:58 -0700
Message-ID: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Shahaf <danielsh@apache.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 06 05:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvJO4-0004NE-Vo
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 05:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab3GFDmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 23:42:02 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:57934 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3GFDmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 23:42:00 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so4273912oag.30
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 20:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date:cc:x-mailer;
        bh=Oq0gBOLVnRqMMywVspdudcAJkBMjM//Ug+M2owB4TWE=;
        b=tyPOFhScidTZC6whJmzd+iZCS0+qPBcBXCsmemPliDrQoMNwIqN9jvnEPJzFqaeA/O
         Dx9myshyk6LBmXKBV4fQ9xEwfirqRE5xuoejA8CH4kajVRpZFZ0rsn5G5xrfrnGRitbX
         z1GV0ZC5xxSQMrZqlSGwJHd38huHJWMGFfS2WL/c5xNp3Ewso/UV/t+HYFsrrgMo031t
         iWAYDfmtU0vSrSfkIa/LP40meLakLd6ZE4ooh79B0hM5O+btvVQ75YA30VNTwP28cigL
         HQ9PAmVVsomqzujSLZ5NvCTZSPunK60PhczNmAKR5xHGYwlWqGS/TIWPeIY7uid1Vanw
         YWyQ==
X-Received: by 10.60.34.194 with SMTP id b2mr13859899oej.2.1373082120007;
        Fri, 05 Jul 2013 20:42:00 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id q4sm20111033obl.1.2013.07.05.20.41.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 20:41:59 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229691>

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

This patch may not be all that is required, but at least
it is a starting point.

Daniel Shahaf has suggested also setting "servers:global:http-bulk- 
updates=on".

Kyle J. McKay (2):
  Git.pm: add new temp_is_locked function
  git-svn: allow git-svn fetching to work using serf

perl/Git.pm             | 17 ++++++++++++++++-
perl/Git/SVN/Fetcher.pm |  6 ++++--
2 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.8.3
