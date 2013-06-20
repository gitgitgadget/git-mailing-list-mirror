From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/12] Fix some reference-related races
Date: Thu, 20 Jun 2013 10:37:42 +0200
Message-ID: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:44:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaTZ-0001vt-LY
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124Ab3FTIoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:44:12 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57456 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755509Ab3FTIiH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:07 -0400
X-AuditID: 12074413-b7f136d000006de1-5f-51c2bf6e31f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A7.03.28129.E6FB2C15; Thu, 20 Jun 2013 04:38:06 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0s8001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:04 -0400
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqJu3/1CgwcsphhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzljcfpKp4AN/xYp9XYwNjCd5uhg5OCQETCT+fnLpYuQEMsUkLtxb
	z9bFyMUhJHCZUeLD9O3sEM45JolHa4+xgFSxCehKLOppZgKxRQTUJCa2HWIBKWIW2M0osfz0
	KXaQhLCAlcSKYweYQWwWAVWJDwvWsYHYvAIuEo82n2SCWKcgMeXhe+YJjNwLGBlWMcol5pTm
	6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoQEjvAOxl0n5Q4xCnAwKvHwal4+GCjEmlhW
	XJl7iFGSg0lJlHfuvkOBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4U+cA5XhTEiurUovyYVLS
	HCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxpIEMFi1LTUyvSMnNKENJMHJwgw7mkRIpT
	81JSixJLSzLiQaEeXwwMdpAUD9DeZSDtvMUFiblAUYjWU4y6HJPPbnnPKMSSl5+XKiXOuwqk
	SACkKKM0D24FLE28YhQH+liYNxqkigeYYuAmvQJawgS0ZM9qsCUliQgpqQbGSQwV0crzjq/T
	WlbDvPUCX1KEPJvKmxTmW22vv6RaCZvXemkXPm1WkJiWVzZbQzmdRWGLx+I119f8YKo/IB+6
	y2rJM5ulZ19l+dwtefD7WJ3sfOv/IlumHo+vbzCwtr3+Zl70hbfnH6cmvdokn2W/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228464>

v3 of mh/ref-races.  Thanks to Junio for the suggestion implemented in
this version.

Change since v2:

* Change lock_packed_refs() to use its own struct lock_file rather
  than requiring the caller to supply its own.

Please note that this patch series's usage of stat()/fstat() causes
breakages under cygwin, pointed out by Ramsay Jones.  He has
graciously offered to work on this issue.

Patch 12/12 is still optional--it avoids a little bit of work when
rewriting the packed-refs file (including when deleting a reference
that has a packed version), but relies on the stat-based freshness
check not giving a false negative.  Peff seems to lean slightly
against merging the last patch and AFAIK nobody else has expressed an
opinion.  (Of course, if the test cannot be relied upon in the check
before writing, then we should not forget that its failure in a check
before reading can also cause problems, however rarely.)

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

 builtin/clone.c    |   5 +-
 builtin/ls-files.c |  12 +-
 cache.h            |  60 ++++++++--
 read-cache.c       | 181 ++++++++++++++++++------------
 refs.c             | 319 ++++++++++++++++++++++++++++++++++++++++++++---------
 refs.h             |  26 ++++-
 6 files changed, 469 insertions(+), 134 deletions(-)

-- 
1.8.3.1
