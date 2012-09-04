From: mhagger@alum.mit.edu
Subject: [PATCH 0/7] Fix some bugs in abspath.c
Date: Tue,  4 Sep 2012 10:14:23 +0200
Message-ID: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:22:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oOq-0003N5-NG
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab2IDIWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:22:12 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:65523 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab2IDIWH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:22:07 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2012 04:22:07 EDT
X-AuditID: 12074411-b7fa36d0000008cc-3e-5045b886e512
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D8.5F.02252.688B5405; Tue,  4 Sep 2012 04:15:02 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSU025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:00 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsUixO6iqNu2wzXAYMcRIYuuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGTcn9bAX
	XOWv+LNDv4HxKE8XIyeHhICJxIH1yxghbDGJC/fWs3UxcnEICVxmlPjetZsJwjnNJLFvwQsm
	kCo2ASmJl4097CC2iICaxMS2QywgNrNAusSJBe1gtrCAvsTaeRA1LAKqEj+brzB3MXJw8Aq4
	SLSt1IBYpijx4/sa5gmM3AsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5i
	hASD4A7GGSflDjEKcDAq8fBWfnIJEGJNLCuuzD3EKMnBpCTKa7fZNUCILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCO/t1UA53pTEyqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IE
	777tQI2CRanpqRVpmTklCGkmDk4QwQWygQdoQxZIIW9xQWJucWY6RNEpRkUpcd4VIAkBkERG
	aR7cAFjcvmIUB/pHmHc9SBUPMObhul8BDWYCGuz63gVkcEkiQkqqgXHhhkfS/D93bXn7RVNq
	hd3l+rADf+b7RevkbZp8X9sqR2DyqkMTrtXodmnO2DHJVV+mQ/xOVN4kk7sLkvrulN35813z
	8eXuHhuFnQvfvOe5MlnSr+vf3tRvgh+Tu5f9EAt9GX0vu/N3w6QrO96nBm/Za1QuxKy7leXV
	iX9Mt25va84LMV0SHXVWiaU4I9FQi7moOBEAdcdkMLYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204724>

From: Michael Haggerty <mhagger@alum.mit.edu>

I really just wanted to tidy up filter_refs(), but I've been sucked
into a cascade of recursive yak shaving.  This is my first attempt to
pop the yak stack.

I want to use real_path() for making the handling of
GIT_CEILING_DIRECTORIES more robust, but I noticed that it is broken
for some cases that will be important in this context.  This patch
series adds some new tests of that function and fixes the ones that
are broken, including a similar breakage in absolute_path().  It
applies to the current master.

Please note that both absolute_path("") and real_path("") used to
return the current directory followed by a slash.  I believe that this
was a bug, and that it is more appropriate for both functions to
reject the empty string.  The evidence is as follows:

* If this were intended behavior, presumably the return value would
  *not* have a trailing slash.

* I couldn't find any callers that appeared to depend on the old
  behavior.

* The test suite runs without errors after the change.

But I didn't do a thorough code review to ensure that no callers ever
rely on the old behavior.  The most likely scenario would be if one of
these functions were used to parse something like $PATH, where the
empty string denotes the current directory, but I didn't see any
callers that seemed to be doing anything like this.

Michael Haggerty (7):
  t0000: verify that absolute_path() fails if passed the empty string
  absolute_path(): reject the empty string
  t0000: verify that real_path() fails if passed the empty string
  real_path(): reject the empty string
  t0000: verify that real_path() works correctly with absolute paths
  real_path(): properly handle nonexistent top-level paths
  t0000: verify that real_path() removes extra slashes

 abspath.c        | 12 ++++++++++--
 t/t0000-basic.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 3 deletions(-)

-- 
1.7.11.3
