From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/8] Fix some problems with reflog expiration
Date: Mon,  9 Feb 2015 10:12:36 +0100
Message-ID: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:20:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkVf-00025q-KD
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbbBIJT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:19:58 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60308 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932386AbbBIJT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:19:56 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2015 04:19:56 EST
X-AuditID: 1207440e-f79bc6d000000c43-fd-54d87a1483f9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D4.4E.03139.41A78D45; Mon,  9 Feb 2015 04:12:52 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQW026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:12:50 -0500
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqCtSdSPE4NZGLouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZk8/dZyv4Kl7xY/IzpgbGycJdjJwcEgImEkc3zGaCsMUkLtxbz9bF
	yMUhJHCZUeLvgcOsEM4JJonXV86xgFSxCehKLOppBusQEVCTmNh2CCzOLLCaSWLrXaBuDg5h
	AVuJW3tNQMIsAqoSa/7eYwQJ8wo4Syw9ZQmxS07i/PGfzBMYuRcwMqxilEvMKc3VzU3MzClO
	TdYtTk7My0st0jXWy80s0UtNKd3ECAkZvh2M7etlDjEKcDAq8fBWfLweIsSaWFZcmXuIUZKD
	SUmUd0HijRAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzfM4ByvCmJlVWpRfkwKWkOFiVxXrUl
	6n5CAumJJanZqakFqUUwWRkODiUJ3jkVQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYml
	JRnxoDCPLwYGOkiKB2jvDpB23uKCxFygKETrKUZFKXHefpCEAEgiozQPbiwsEbxiFAf6Upi3
	D6SKB5hE4LpfAQ1mAhpcUAA2uCQRISXVwDg/WVtz3Ze9zw76xRZPiOlz8pBm2nLlzyrG1m9J
	Ntlzt3/IvKZ30u2u9m7nbYlLGuWU183fsdJKPFxK9t/9myc71WcHf9ibfGLOntLbHUorox7z
	5O88O1WYtfybGU925v8io99himELrT+4Rr1uOiLl8l9UYLKwipbolg2Slk3f3yU3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263552>

In addition to a few cleanups, this patch series fixes some problems
that I noticed when working on mh/reflog-expire:

* Ignore '--updateref' when expiring the reflog of a symbolic
  reference, because the alternatives are all pretty silly. See the
  log message for commit 6/8 for more information.

* Ignore '--updateref' when *all* reflog entries are expired by "git
  reflog expire" or "git reflog delete". Currently, this sets the
  reference to 0{40}, which breaks the repository. (Another
  alternative would be to delete the reference in this situation, but
  that seemed too radical to me somehow.)

* When expiring the reflog for a symbolic reference, lock the symbolic
  reference rather than its referent.

This patch series applies on top of master merged together with
sb/atomic-push, like the "refs-have-new" patch series that I just
submitted. It is also available from my GitHub account [1] as branch
"expire-updateref-fixes".

There is a minor conflict between this patch series and
"mh/refs-have-new":

<<<<<<< HEAD
		if (!is_null_sha1(update->new_sha1)) {
			if (!update->lock->force_write &&
			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
				unlock_ref(update->lock);
				update->lock = NULL;
			} else if (write_ref_sha1(update->lock, update->new_sha1,
						  update->msg)) {
||||||| merged common ancestors
		if (!is_null_sha1(update->new_sha1)) {
			if (write_ref_sha1(update->lock, update->new_sha1,
					   update->msg)) {
=======
		if ((flags & REF_HAVE_NEW) && !is_null_sha1(update->new_sha1)) {
			if (write_ref_sha1(update->lock, update->new_sha1,
					   update->msg)) {
>>>>>>> refs-have-new

It can be resolved in the obvious way:

<<<<<<<
		if ((flags & REF_HAVE_NEW) && !is_null_sha1(update->new_sha1)) {
			if (!update->lock->force_write &&
			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
				unlock_ref(update->lock);
				update->lock = NULL;
			} else if (write_ref_sha1(update->lock, update->new_sha1,
						  update->msg)) {
>>>>>>>

By the way, both of these patch series conflict with
sb/atomic-push-fix, which is in pu. My understanding is that Stefan
wants to rework that patch series anyway, but if not I would be happy
to show how to resolve the conflicts.

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (8):
  write_ref_sha1(): remove check for lock == NULL
  write_ref_sha1(): Move write elision test to callers
  lock_ref_sha1_basic(): do not set force_write for missing references
  reflog: fix documentation
  reflog: rearrange the manpage
  reflog_expire(): ignore --updateref for symbolic references
  reflog_expire(): never update a reference to null_sha1
  reflog_expire(): lock symbolic refs themselves, not their referent

 Documentation/git-reflog.txt | 65 +++++++++++++++++++++++---------------------
 builtin/reflog.c             |  2 +-
 refs.c                       | 55 ++++++++++++++++++++-----------------
 3 files changed, 65 insertions(+), 57 deletions(-)

-- 
2.1.4
