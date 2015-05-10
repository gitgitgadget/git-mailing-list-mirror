From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/8] Fix atomicity and avoid fd exhaustion in ref transactions
Date: Sun, 10 May 2015 04:45:29 +0200
Message-ID: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 04:46:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHFs-0001a1-Qw
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 04:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbbEJCp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 22:45:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63099 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbbEJCpz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 22:45:55 -0400
X-AuditID: 12074412-f79e46d0000036b4-83-554ec65d216d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 35.D5.14004.D56CE455; Sat,  9 May 2015 22:45:49 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxY015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:47 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqBt7zC/U4MA3MYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8b6D1MYCy6KVaw4sZm5gXGzUBcjJ4eEgInE6uXdLBC2mMSFe+vZQGwh
	gcuMEk+PV0PYx5kk9s0VALHZBHQlFvU0M3UxcnCICHhJtM0s7mLk4mAW6GWUeLT4FSNIjbBA
	oMTfpnlgc1gEVCU+r5sEZvMKuEjcPTKVGWKXnMT54z+ZJzByL2BkWMUol5hTmqubm5iZU5ya
	rFucnJiXl1qka6aXm1mil5pSuokREjBCOxjXn5Q7xCjAwajEw/thm1+oEGtiWXFl7iFGSQ4m
	JVFem4VAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8J9cD5XhTEiurUovyYVLSHCxK4rw/F6v7
	CQmkJ5akZqemFqQWwWRlODiUJHhjjwI1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZk
	xIPCPL4YGOggKR6gvVtB2nmLCxJzgaIQracYFaXEeb1AEgIgiYzSPLixsDTwilEc6EthXhGQ
	Kh5gCoHrfgU0mAlo8N9iH5DBJYkIKakGxo6pu3wjgxhCV+jbGJYcMTr71/7us8qtZ3UyJv1e
	5RGWMemlVcCTyst15zmUFtUtFrLQnfP1+Eyx3kWaGRf+THUSErr7QmRTVN712O6PHap7/FZd
	SlNcXL1Z+v5XryOhmVd7n5Yd5Pu07TVbae5lzi9r8rYF5R4Vvj0/7oz+xvWm3a6+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268717>

This is v2 of [1], formerly called

    Avoid file descriptor exhaustion in ref_transaction_commit()

As a reminder, this patch series fixes some cases where `git
update-ref --stdin` (and, on 2.4+, `git push --atomic`) could fail to
be atomic, and avoids file descriptor exhaustion while carrying out
ref transactions by closing lockfiles promptly.

Thanks to Peff, Stefan, Junio, and Eric for their comments on v1.

The main change is that this version is rebased onto maint-2.2 as per
Junio's wish [2]. This was not trivial because of the changes in the
area between 2.3 and 2.4, especially 'mh/expire-updateref-fixes',
'mh/refs-have-new', and 'mh/reflog-expire'.

Other changes:

* Remove Stefan's

      bc31f46 refs.c: remove lock_fd from struct ref_lock (2015-04-16)

  from the series, as it is not needed for this fix and was causing
  extra conflicts when backporting and merging forward. This patch is
  still a good idea, but there is no need to backport it.

* Change log message of the last patch to describe both of the bugs
  that it fixes.

* Many other small tweaks.

This patch series is available from my GitHub account [3] as branch
'write-refs-sooner'. Please note that the branch there is applied on
top of a cherry-pick of

      f6786c8 http-push: trim trailing newline from remote symref (2015-01-12)

, which was needed to get test t5540 to pass.

The following other branches, also from my GitHub repo, might be
useful:

* 'write-refs-sooner-2.3' -- suggested merge of the change to 'maint'.

* 'write-refs-sooner-master' -- suggested merge of the change to
  'master'.

* 'write-refs-sooner-rebased-2.3' and
  'write-refs-sooner-rebased-master' -- rebases of 'write-refs-sooner'
  onto 'maint' and 'master' respectively, in case anybody is
  interested to see how the individual patches would look if
  implemented natively on these branches.

[1] http://thread.gmane.org/gmane.comp.version-control.git/267735
[2] http://article.gmane.org/gmane.comp.version-control.git/267799
[3] https://github.com/mhagger/git

Michael Haggerty (6):
  write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
  commit_ref_update(): new function, extracted from write_ref_sha1()
  rename_ref(): inline calls to write_ref_sha1() from this function
  ref_transaction_commit(): inline calls to write_ref_sha1()
  ref_transaction_commit(): remove the local flags variable
  ref_transaction_commit(): fix atomicity and avoid fd exhaustion

Stefan Beller (2):
  update-ref: test handling large transactions properly
  t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE

 refs.c                | 99 +++++++++++++++++++++++++++++++++++++--------------
 t/t1400-update-ref.sh | 28 +++++++++++++++
 t/t7004-tag.sh        |  4 +--
 3 files changed, 103 insertions(+), 28 deletions(-)

-- 
2.1.4
