From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Support stdio access to lockfiles
Date: Wed,  1 Oct 2014 13:14:46 +0200
Message-ID: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:15:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHs6-0005Ts-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 13:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaJALO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 07:14:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62829 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbaJALO5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 07:14:57 -0400
X-AuditID: 12074412-f792e6d000005517-7f-542be22ffb28
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A2.FA.21783.F22EB245; Wed,  1 Oct 2014 07:14:55 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91BEp6j028682
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 07:14:53 -0400
X-Mailer: git-send-email 2.1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqKv/SDvE4MRzdouuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDMW7D7OWvBPsGJx73P2BsZ5fF2M
	nBwSAiYSP898YoWwxSQu3FvP1sXIxSEkcJlR4sm2uVDOcSaJifdegFWxCehKLOppZgKxRQTU
	JCa2HWIBKWIWWMwkMeHQJjaQhLCAmcTqlnlgDSwCqhJfvp9hAbF5BZwldh+6yg6xTk5iw+7/
	jBMYuRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAkvoR2M60/KHWIU
	4GBU4uFVSNAOEWJNLCuuzD3EKMnBpCTK6/gAKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN/sA
	UI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYKX9yFQo2BRanpqRVpm
	TglCmomDE2Q4l5RIcWpeSmpRYmlJRjwo2OOLgeEOkuIB2isE0s5bXJCYCxSFaD3FqMuxrvNb
	P5MQS15+XqqUOK87SJEASFFGaR7cClgyecUoDvSxMO9zkPd4gIkIbtIroCVMQEuS14AtKUlE
	SEk1MM49Z38v+7rj1eVtnx/v8/z1W2rzx7JJHEbLZ09ZssqHj7X1SO523YJ5G/+kHFa/xxjR
	+PVuI4toUsGNC/ovrrHK79pwiP/UpImPtOel3pq4S3BZl4clm+3uO1Z2EXO3blL4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257740>

This series applies on top of the series "Lockfile correctness and
refactoring" (Junio's branch mh/lockfile).

There are already two callers that write to lockfiles using stdio. But
they currently need intimate knowledge of the lockfile implementation
to work correctly; for example, they have to call fclose() themselves
and set lk->fd to -1 to prevent the file from being closed again. This
is awkward and error-prone.

So provide official API support for stdio-based access to lockfiles.
Add a new function fdopen_lock_file(), which returns a (FILE *)
associated with an open lockfile, and teach close_lock_file() (and
therefore also commit_lock_file(), rollback_lock_file(), etc.) to use
fclose() instead of close() on lockfiles for which fdopen_lock_file()
has been called.

...except in the signal handler, where calling fclose() is not
permitted. In the signal handler call close() on any still-open
lockfiles regardless of whether they have been fdopen()ed. Since the
very next step is to delete the file, this should be OK.

The second and third patches rewrite the two callers who currently
fdopen() lockfiles to use the new function. I didn't look around for
other lockfile users that might be simplified and/or sped up by
converting them to use stdio; probably there are some.

This improvement was initially discussed when the second fdopen()
callsite was added [1] and also when discussing inconsistencies
between the documentation and real life in the context of the
mh/lockfile patch series [2].

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/256729/focus=256734
[2] http://thread.gmane.org/gmane.comp.version-control.git/257504/focus=257553

Michael Haggerty (3):
  fdopen_lock_file(): access a lockfile using stdio
  dump_marks(): reimplement using fdopen_lock_file()
  commit_packed_refs(): reimplement using fdopen_lock_file()

 Documentation/technical/api-lockfile.txt | 34 +++++++++++++++--------
 fast-import.c                            | 21 ++-------------
 lockfile.c                               | 46 ++++++++++++++++++++++++++++----
 lockfile.h                               |  4 +++
 refs.c                                   |  5 +---
 5 files changed, 71 insertions(+), 39 deletions(-)

-- 
2.1.0
