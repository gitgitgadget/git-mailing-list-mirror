From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/18] Improve handling of D/F conflicts
Date: Fri,  1 May 2015 14:25:40 +0200
Message-ID: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1N-0000qr-UT
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbbEAM0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:14 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52302 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393AbbEAM0N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:13 -0400
X-AuditID: 1207440f-f792a6d000001284-fe-554370dd3f2c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.CE.04740.DD073455; Fri,  1 May 2015 08:26:05 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zd004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:04 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqHu3wDnU4Og0bYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ9xbylKwQ6Ji81fHBsa7wl2MHBwSAiYSB/7WdjFyApliEhfurWfrYuTiEBK4zCjR8HIS
	O0hCSOAEk8SHd/ogNpuArsSinmYmEFtEQE1iYtshFpAGZoEORokLy7eBNQgLWEjsmdbGCmKz
	CKhK9KzsB7N5BVwkmhs6WSC2yUmcP/6TeQIj9wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealF
	uiZ6uZkleqkppZsYIcHBv4Oxa73MIUYBDkYlHl6Ok06hQqyJZcWVuYcYJTmYlER5bROcQ4X4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8N5TB8rxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGan
	phakFsFkZTg4lCR4GfKBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBQR5fDAxz
	kBQP0N63eSB7iwsSc4GiEK2nGBWlxHkfgyQEQBIZpXlwY2Ex/4pRHOhLYd4ukO08wHQB1/0K
	aDAT0ODztxxABpckIqSkGhg9dlevd7RYJXHSc7/kmvlT60wOvV0haMai6/HuluSeB/kPHQT2
	X8qZu7unUlBLx+JH3+Znuyx1j+y6sPffhv5XcXv7F0QtlVuS9dvO92vAo5nfDrD3vZnE/mV6
	J5e95Pl6M603Wlct2v/ZtwsErL7jI5+c1ep9+0vzxJkOJdZht6zK27Z0segrsRRn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268117>

We currently don't handle D/F conflicts very well.

A "D/F conflict" is what we call a conflict between references like
"refs/foo" and "refs/foo/bar". Such references cannot coexist because,
when stored as loose references, "refs/foo" would have to be both a
directory and a file.

The problems fixed by this series:

* We had no tests of D/F conflict handling within transactions.

* D/F conflicts between references being created in a single
  transaction used to be detected too late, possibly after part of the
  transaction had already been committed.

* D/F errors against loose references were typically reported as
  locking errors, which was not very illuminating. Also, D/F errors
  were typically reported in two separate error messages, like

      error: there are still refs under 'refs/foo'
      fatal: Cannot lock the ref 'refs/foo'.

  or

      error: unable to resolve reference refs/foo/bar: Not a directory
      fatal: Cannot lock the ref 'refs/foo/bar'.

  which was confusing.

There is probably still room for improving the error messages.

This patch series applies on top of
mh/ref-lock-avoid-running-out-of-fds. I did it that way because I
expected significant conflicts between the series, and the older
series is simple/mature enough that I expect it to be merged early in
the post-2.4 cycle. But in retrospect it turns out that there are only
minor conflicts between the two series. So if you would like me to
rebase this series to another starting point, please let me know.

This series is also available from my GitHub account,

    https://github.com/mhagger/git branch check-df-conflicts-earlier

Michael Haggerty (18):
  t1404: new tests of D/F conflicts within ref transactions
  is_refname_available(): explain the reason for an early exit
  is_refname_available(): avoid shadowing "dir" variable
  is_refname_available(): convert local variable "dirname" to strbuf
  entry_matches(): inline function
  report_refname_conflict(): inline function
  struct nonmatching_ref_data: store a refname instead of a ref_entry
  is_refname_available(): use dirname in first loop
  ref_transaction_commit(): use a string_list for detecting duplicates
  refs: check for D/F conflicts among refs processed in a transaction
  verify_refname_available(): rename function
  verify_refname_available(): report errors via a "struct strbuf *err"
  lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
  lock_ref_sha1_basic(): improve diagnostics for D/F conflicts
  rename_ref(): integrate lock_ref_sha1_basic() errors into ours
  ref_transaction_commit(): provide better error messages
  ref_transaction_commit(): delete extra "the" from error message
  reflog_expire(): integrate lock_ref_sha1_basic() errors into ours

 refs.c                             | 280 +++++++++++++++++++++++--------------
 t/t1400-update-ref.sh              |  14 +-
 t/t1404-update-ref-df-conflicts.sh | 107 ++++++++++++++
 3 files changed, 286 insertions(+), 115 deletions(-)
 create mode 100755 t/t1404-update-ref-df-conflicts.sh

-- 
2.1.4
