From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/6] Retain caches of submodule refs
Date: Sat, 13 Aug 2011 00:36:23 +0200
Message-ID: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:37:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs0Lz-0005Kf-6X
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab1HLWhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:37:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41135 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab1HLWhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:37:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CMaXJN010513;
	Sat, 13 Aug 2011 00:36:36 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179260>

...and work towards storing refs hierarchically.

Currently, the refs for submodules are put into a cache when accessed
but the cache is never reused.  Whenever the refs for a submodule are
accessed, the cache is cleared and refilled, even if the submodule
cache already contains data for that submodule.  Essentially, the
submodule cache only controls the lifetime of the data structures.
The main module is currently stored in a separate cache that is reused
properly.

This patch series institutes proper caching of submodule refs:
maintain a linked list of caches for each submodule, and add a new
entry whenever the refs for a new submodule are accessed.  Also store
the cache for the main project in the same linked list for uniformity.

This change accomplishes two things:

* Proper caching of submodule refs.  I'm not sure whether this is a
  significant win by itself; it depends on the usage patterns and I'm
  not too familiar with how submodules are used.  But it seems pretty
  clear that this is an improvement on the old kludge.

* It is a first step towards storing refs hierarchically *within*
  modules.  My plan is to build out "struct cached_refs" into a
  hierarchical data structure mimicking the reference namespace
  hierarchy, with one cached_ref instance for each "directory" of
  refs.  Then (the real goal) change the code to only populate the
  parts of the cache hierarchy that are actually accessed.

I believe that this change is useful by itself, self-contained, and
ready to be committed.  I plan to build the hierarchical-refs changes
on top of it.  But if it is preferred, I can submit this series plus
the hierarchical-refs patches as a single patch series (once the
latter is done, which will still take some time).

This patch series applies on top of "next" rather than "master"
because it would otherwise conflict with the changes made by
js/ref-namespaces.

I am on vacation and don't know when I will have internet access, so
please don't be offended if I don't respond quickly to feedback.

Michael Haggerty (6):
  Extract a function clear_cached_refs()
  Access reference caches only through new function get_cached_refs().
  Change the signature of read_packed_refs()
  Allocate cached_refs objects dynamically
  Store the submodule name in struct cached_refs.
  Retain caches of submodule refs

 refs.c |  106 ++++++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 73 insertions(+), 33 deletions(-)

-- 
1.7.6.8.gd2879
