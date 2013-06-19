From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/12] Fix some reference-related races
Date: Wed, 19 Jun 2013 09:51:21 +0200
Message-ID: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDBJ-00025g-QU
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615Ab3FSHvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:51:49 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57198 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422Ab3FSHvs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:48 -0400
X-AuditID: 12074411-b7f296d000001209-d9-51c163141bdd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C5.5B.04617.41361C15; Wed, 19 Jun 2013 03:51:48 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWS002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:46 -0400
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsUixO6iqCuSfDDQYOIVFouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZzT37WIqmM9fcX9LbQNjM08XIyeHhICJxI8Jk9ggbDGJC/fWA9lc
	HEIClxklumYvZ4FwbjNJ/Gv5zwRSxSagK7GopxnMFhFQk5jYdgisiFlgN6PE8tOn2EESwgJW
	Em1dpxhBbBYBVYnLZ2aDNfAKuEgc2tjICLFOQWLKw/fMExi5FzAyrGKUS8wpzdXNTczMKU5N
	1i1OTszLSy3SNdXLzSzRS00p3cQICRzBHYwzTsodYhTgYFTi4b2x+kCgEGtiWXFl7iFGSQ4m
	JVFe9qSDgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEePUcgHK8KYmVValF+TApaQ4WJXFeviXq
	fkIC6YklqdmpqQWpRTBZGQ4OJQneMJChgkWp6akVaZk5JQhpJg5OEMEFsoEHaMORRJANxQWJ
	ucWZ6RBFpxgVpcR5I0EmCIAkMkrz4AbAYvwVozjQP8K8diBVPMD0ANf9CmgwE9Bgoe/7QAaX
	JCKkpBoYFx3ZVlb/wb8zhels3bsrMouXTa788+vb7zZO51vyqaEcYvc21dkdvGxhGzD5dHCl
	9NrrJaEHTTb5XRP79+v+tc2vW8WFvgu/+37grH5928njP6aa9+bNZnlSJb/wg/yNC2suCl2L
	qd3LZpb/t7dW4QwfT7PesXnr5WY3pS033t4uHVse/uprmBJLcUaioRZzUXEiAPx+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228358>

Re-roll of mh/ref-races.  Thanks to Peff, Junio, and Ramsay for
reviewing v1.

Changes since v1:

* mh/reflife has graduated to master, so this patch series now applies
  directly to master.

* Some trivial constness adjustments were necessary because of

    21a6b9fa read-cache: mark cache_entry pointers const

* Better explain (in comments and log message) patch 01/12.

* In 04/12, access struct lock_file::fd directly instead of keeping
  a separate copy in struct packed_ref_cache.

Please note that this patch series's usage of stat()/fstat() causes
breakages under cygwin, pointed out by Ramsay Jones.  He has
graciously offered to work on this issue.

The last patch is still optional--it avoids a little bit of work when
rewriting the packed-refs file, but relies on the stat-based freshness
check not giving a false negative.

Jeff King (2):
  get_packed_ref_cache: reload packed-refs file when it changes
  for_each_ref: load all loose refs before packed refs

Michael Haggerty (10):
  repack_without_ref(): split list curation and entry writing
  pack_refs(): split creation of packed refs and entry writing
  refs: wrap the packed refs cache in a level of indirection
  refs: implement simple transactions for the packed-refs file
  refs: manage lifetime of packed refs cache via reference counting
  do_for_each_entry(): increment the packed refs cache refcount
  packed_ref_cache: increment refcount when locked
  Extract a struct stat_data from cache_entry
  add a stat_validity struct
  refs: do not invalidate the packed-refs cache unnecessarily

 builtin/clone.c    |   7 +-
 builtin/ls-files.c |  12 +-
 cache.h            |  60 ++++++++--
 read-cache.c       | 181 ++++++++++++++++++------------
 refs.c             | 314 ++++++++++++++++++++++++++++++++++++++++++++---------
 refs.h             |  27 ++++-
 6 files changed, 469 insertions(+), 132 deletions(-)

-- 
1.8.3.1
