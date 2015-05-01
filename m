From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Retry attempts to acquire the packed-refs lock
Date: Fri,  1 May 2015 16:52:55 +0200
Message-ID: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 16:53:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCJV-0002mT-RS
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 16:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbEAOxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 10:53:10 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53319 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753800AbbEAOxI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 10:53:08 -0400
X-AuditID: 1207440f-f792a6d000001284-48-55439352c851
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 03.E4.04740.25393455; Fri,  1 May 2015 10:53:06 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41Er33a011249
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 10:53:05 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqBs02TnU4NBuSYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ1w428hY0C5QcXlfA2MD4x2eLkZODgkBE4ltx26wQ9hiEhfurWfrYuTiEBK4zChx/cl8
	ZgjnBJPE/u5bTCBVbAK6Eot6msFsEQE1iYlth1hAipgFOhglLizfBjZKWMBZ4tzjH8wgNouA
	qsTm2+8ZQWxeAReJ6we+s0Csk5M4f/wn8wRG7gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKL
	dE30cjNL9FJTSjcxQoKEfwdj13qZQ4wCHIxKPLwcJ51ChVgTy4orcw8xSnIwKYnyttU5hwrx
	JeWnVGYkFmfEF5XmpBYfYpTgYFYS4X06ASjHm5JYWZValA+TkuZgURLnVV+i7ickkJ5Ykpqd
	mlqQWgSTleHgUJLg3TcRqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFOzxxcBw
	B0nxAO3dBdLOW1yQmAsUhWg9xagoJc77ACQhAJLIKM2DGwuL/VeM4kBfCvO+AKniAaYNuO5X
	QIOZgAafv+UAMrgkESEl1cDos+K+xxbPS3FFhuJvNM2XXj4jH/ddb/rJYlYnjfMn728O+NUg
	90basyYk/t3uK6mvDtVdKZHf3bYiNGrZ1OSLEjpf8pveOm5JeJxsaPaqNHeahXfjixK2sjUW
	XCs02WfGMPJ5Z+qecLbmiX4xy+2wSl7IAbfyt0tPr7j/REBl6dFnUttuTrFUYinO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268137>

At GitHub we were seeing occasional lock contention over packed-refs.
It wasn't very common, but when you have as much git traffic as we
have, anything that *can* happen *will* happen.

The problem is that Git only tries to acquire locks a single time. If
that attempt fails, the whole process fails. So, for example, if two
processes are trying to delete two different references, one of them
can fail due to inability to acquire the packed-refs lock, even though
it could have succeeded if it had just waited a moment.

This patch series adds a new function,
hold_lock_file_for_update_timeout(), which retries the lock
acquisition for a specified length of time. The retries necessarily
have to use polling, which it does using a quadratic backoff with a
random component. It might be a bit overengineered for this single
purpose, but I wanted it to be usable in other contexts without second
thoughts.

This patch series also changes lock_packed_refs() to call the new
function with a timeout of 1 second (by default; the timeout is
configurable) and adds some tests that the retry and timeout are
working.

It might be that there are other call sites that would benefit from
retrying lock acquisition (the index file?), but this patch series
only applies the new functionality to packed-refs.lock.

We have a patch similar to this one running on our servers at GitHub,
with no problems observed so far.

This series applies to master. It is also available from my GitHub
repository:

    https://github.com/mhagger/git branch lockfile-retry

Michael Haggerty (2):
  lockfile: allow file locking to be retried with a timeout
  lock_packed_refs(): allow retries when acquiring the packed-refs lock

 Documentation/config.txt |  6 ++++
 lockfile.c               | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 lockfile.h               | 16 ++++++++--
 refs.c                   | 12 +++++++-
 t/t3210-pack-refs.sh     | 17 +++++++++++
 5 files changed, 125 insertions(+), 5 deletions(-)

-- 
2.1.4
