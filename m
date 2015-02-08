From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/11] Allow reference values to be checked in a transaction
Date: Sun,  8 Feb 2015 17:13:54 +0100
Message-ID: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:21:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUbp-0005kw-QJ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbbBHQVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:21:18 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45011 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758495AbbBHQVR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:21:17 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2015 11:21:17 EST
X-AuditID: 1207440c-f79376d00000680a-6b-54d78b54af27
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F0.54.26634.45B87D45; Sun,  8 Feb 2015 11:14:12 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9l4014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:10 -0500
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqBvSfT3E4M4SPouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZl25MZSk4I1Tx8MZR5gbG2XxdjJwcEgImEjO6zzNB2GISF+6tZwOx
	hQQuM0ps21/excgFZJ9gkjjSdpMFJMEmoCuxqKcZrEFEQE1iYtshsDizwGomia13wZqFBXwk
	Nja+AKthEVCV+Nb7kx3E5hVwkVj9dyHUMjmJ88d/Mk9g5F7AyLCKUS4xpzRXNzcxM6c4NVm3
	ODkxLy+1SNdQLzezRC81pXQTIyRoeHYwflsnc4hRgINRiYe3Q+56iBBrYllxZe4hRkkOJiVR
	3qPhQCG+pPyUyozE4oz4otKc1OJDjBIczEoivIsOXwsR4k1JrKxKLcqHSUlzsCiJ86ouUfcT
	EkhPLEnNTk0tSC2CycpwcChJ8Bp2AQ0VLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmI
	BwV6fDEw1EFSPEB7t4G08xYXJOYCRSFaTzEqSonzJoMkBEASGaV5cGNhqeAVozjQl8K8qSBV
	PMA0Atf9CmgwE9DgxUuvgAwuSURISTUw6kl2tbbpHssU3bwhT2ePx6S6eQqCfMlThdsub7Kf
	8/DzhPQ/LxYv2LxHfK5IwrtZQpPmV/dutTrRqvqEwULE9dLid8u1EpK4tv8/yO981NGaa6t2
	pWAie1+dh8jKHakJuimlU37EJL+4c/6DPOeUqT6f19wXsl64y82dXa/M/Ns5po6s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263522>

The main purpose of this series is to simplify the interface to
reference transactions as follows:

* Remove the need to supply an explicit have_old parameter to
  ref_transaction_update() and ref_transaction_delete(). Instead,
  check the old_sha1 if and only if it is non-NULL.

* Allow NULL to be supplied to ref_transaction_update() as new_sha1,
  in which case old_sha1 will be verified under lock, but the
  reference's value will not be altered.

* Add a function ref_transaction_verify(), which verifies the current
  value of a reference without changing it.

* Make the similarity between ref_transaction_update() and
  update_ref() more obvious.

Along the way, it fixes a race that could happen if two processes try
to create an orphan commit at the same time.

This patch series applies on top of master merged together with
sb/atomic-push, which in turn depends on mh/reflog-expire. It is also
available from my GitHub account [1] as branch "refs-have-new":

It's nothing earth-shattering, but I think it is a worthwhile cleanup.

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (11):
  refs: move REF_DELETING to refs.c
  refs: remove the gap in the REF_* constant values
  struct ref_update: move "have_old" into "flags"
  ref_transaction_update(): remove "have_old" parameter
  ref_transaction_delete(): remove "have_old" parameter
  commit: add tests of commit races
  commit: avoid race when creating orphan commits
  ref_transaction_create(): check that new_sha1 is valid
  ref_transaction_delete(): check that old_sha1 is not null_sha1
  ref_transaction_verify(): new function to check a reference's value
  update_ref(): improve documentation

 branch.c                |   5 +-
 builtin/commit.c        |   4 +-
 builtin/fetch.c         |   6 ++-
 builtin/receive-pack.c  |   5 +-
 builtin/replace.c       |   2 +-
 builtin/tag.c           |   2 +-
 builtin/update-ref.c    |  17 +++----
 fast-import.c           |   6 +--
 refs.c                  | 130 +++++++++++++++++++++++++++++++++---------------
 refs.h                  |  61 ++++++++++++++++-------
 sequencer.c             |   2 +-
 t/t7516-commit-races.sh |  38 ++++++++++++++
 walker.c                |   2 +-
 13 files changed, 197 insertions(+), 83 deletions(-)
 create mode 100755 t/t7516-commit-races.sh

-- 
2.1.4
