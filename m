From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Avoid file descriptor exhaustion in ref_transaction_commit()
Date: Fri, 24 Apr 2015 13:35:44 +0200
Message-ID: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:36:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlbuA-0004Xt-ET
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 13:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966383AbbDXLgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 07:36:15 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42038 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933551AbbDXLgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 07:36:09 -0400
X-AuditID: 1207440e-f79bc6d000000c43-04-553a2a9ec100
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 31.C1.03139.E9A2A355; Fri, 24 Apr 2015 07:35:58 -0400 (EDT)
Received: from michael.fritz.box (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OBZt8W008846
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 07:35:56 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqDtPyyrUYM87HouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ6ydsIm14ANfxcwfe5gaGLt4uhg5OSQETCTeL2pghbDFJC7cW8/WxcjFISRwmVFiTe9V
	VgjnJJPE3GOvGEGq2AR0JRb1NDN1MXJwiAh4SbTNLAYJMwukSHQ87wYrERYIlPh9eQY7iM0i
	oCrxrfUGI0g5r4CLxOPnVhC75CTOH//JPIGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQi
	XWO93MwSvdSU0k2MkPDg28HYvl7mEKMAB6MSD++MOZahQqyJZcWVuYcYJTmYlER5O6WsQoX4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8CYKAeV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNT
	UwtSi2CyMhwcShK8DZpAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgMI8vBgY6
	SIoHaO82kHbe4oLEXKAoROspRkUpcd4tIAkBkERGaR7cWFjUv2IUB/pSmFcWpIoHmDDgul8B
	DWYCGjxzqQXI4JJEhJRUA6OyfcLTOYXyhqH7NUPuMsjMOro4NUSLRXyNgv6CVNMv0uE7pCxu
	3jrCLVsk672cLW++9OnFrq7MLDaeW1ay72NhVsyymSLrIH8wy3vG2u+OzpPYPnlOuHlqwqyD
	bQV2TELlvf+jbtseuHu+aNGH6LMB7MlfTTO2fZ58OMX9FJ93YGeTdqcIoxJLcUai 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267735>

In ref_transaction_commit(), close the reference lockfiles immediately
to avoid keeping too many file descriptors open at a time. This is
pretty easy, because in the first loop (where we create the locks) we
already know what, if anything, has to be written into the lockfile.
So write it and close the lockfile immediately. In the second loop,
rename the lockfiles for reference updates into place, and in the
cleanup loop, unlock any references that are still locked (i.e., those
that were only being verified or deleted).

I think this is a cleaner solution than Stefan's approach [1] of
closing and reopening fds based on an estimate of how many fds we can
afford to waste--we only need a single file descriptor at a time, and
we never have to close then reopen a lockfile. But it is a bit more
intrusive, so it might still be preferable to use Stefan's approach
for release 2.4.0, if indeed any fix for this problem is still being
considered for that release.

This patch series applies on top of Stefan's

    c1f0ca9 refs.c: remove lock_fd from struct ref_lock (2015-04-16)

and it fixes two tests that Stefan introduced earlier in that series.

It is also available from my GitHub account:

    https://github.com/mhagger/git branch close-ref-locks-promptly

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/267548

Michael Haggerty (5):
  write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
  commit_ref_update(): new function, extracted from write_ref_sha1()
  write_ref_sha1(): inline function at callers
  ref_transaction_commit(): remove the local flags variables
  ref_transaction_commit(): only keep one lockfile open at a time

 refs.c                | 107 ++++++++++++++++++++++++++++++++++----------------
 t/t1400-update-ref.sh |   4 +-
 2 files changed, 75 insertions(+), 36 deletions(-)

-- 
2.1.4
