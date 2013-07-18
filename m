From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v4 0/2] allow git-svn fetching to work using serf
Date: Thu, 18 Jul 2013 12:15:27 -0700
Message-ID: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rothenberger <daveroth@acm.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 21:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uztg0-0001zS-KJ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933509Ab3GRTPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:15:40 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34131 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119Ab3GRTPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:15:39 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so3571431pac.29
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BjuGPfkpk+r7ZdVBEiSIsMT2kxioneSzLmHLWRCBesI=;
        b=omfQwjhI+Epo4l66P2u/szDUe4YJ/lKl1O0OJTEsl1jN+y/TRA0KlPNw7EoWEWKNhx
         Duc3G9AvFe+JVkahmNTYmU6imfITChdnA10/ZvWDr9NZrmrdRuzsosufO2sfNB5tMFcl
         8dOBzEiXB8Zz4pBQze+3nz39vi99Kntl/qhtZuPH8yiNjbkxCkgEqt1medhLbh3mj/O1
         8oMuLReOwitt1AqVBmfaDFulxo+1Bu0KB9ueO35kolFzH7l7fdaVOrO2g77oe8I9WxCu
         JCnyT/CFhYfBMpVeWxjShyhDlvFQ3AY6/ZX8XHv03516wvhAH4lbebhG6WsY77ymAX6y
         pCng==
X-Received: by 10.68.172.34 with SMTP id az2mr13304505pbc.201.1374174938895;
        Thu, 18 Jul 2013 12:15:38 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id sq5sm18223018pab.11.2013.07.18.12.15.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 12:15:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230726>

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

Versions v2-v3 of the patch introduced a bug when attempting
to change the _temp_cache function to use the new
temp_is_locked function at the suggestion of a reviewer.

This version reverts that as the logic in _temp_cache isn't
really conducive to that change because of the tests it makes
and the change was causing problems.

This is the single change that is reverted in Git.pm 
compared to v3 of the patch:

diff --git a/perl/Git.pm b/perl/Git.pm
index 0ba15b9..204fdc6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1277,7 +1277,7 @@ sub _temp_cache {
 
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
-		if (temp_is_locked($name)) {
+		if ($TEMP_FILES{$$temp_fd}{locked}) {
 			throw Error::Simple("Temp file with moniker '" .
 				$name . "' already in use");
 		}


Other than that single change, this patch series is identical to v3,
and in particular the 0002 perl/Git/SVN/Fetcher.pm change is identical
to that of v3.

Kyle J. McKay (2):
  Git.pm: add new temp_is_locked function
  git-svn: allow git-svn fetching to work using serf

 perl/Git.pm             | 31 ++++++++++++++++++++++++++++++-
 perl/Git/SVN/Fetcher.pm |  6 ++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

-- 
1.8.3
