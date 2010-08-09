From: "Schalk, Ken" <ken.schalk@intel.com>
Subject: [PATCH] Avoid rename/add conflict when contents are identical
Date: Mon, 9 Aug 2010 14:00:31 -0700
Message-ID: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 09 23:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZSZ-0006pq-6G
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 23:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab0HIVAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 17:00:33 -0400
Received: from mga14.intel.com ([143.182.124.37]:13974 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860Ab0HIVAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 17:00:33 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 09 Aug 2010 14:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.55,345,1278313200"; 
   d="scan'208";a="309952374"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by azsmga001.ch.intel.com with ESMTP; 09 Aug 2010 14:00:32 -0700
Received: from azsmsx503.amr.corp.intel.com ([10.2.121.76]) by
 azsmsx601.amr.corp.intel.com ([10.2.121.193]) with mapi; Mon, 9 Aug 2010
 14:00:32 -0700
Thread-Topic: [PATCH] Avoid rename/add conflict when contents are identical
Thread-Index: Acs4BTW0FPMG8wQsTZe56UdnS0gknw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153023>

Skip the entire rename/add conflict case if the file added on the
other branch has the same contents as the file being renamed.  This
avoids giving the user an extra copy of the same file and presenting a
conflict that is confusing and pointless.

Here's a simple sequence that generates this kind of conflict:

  git init
  echo content > fileA
  git add fileA
  git commit -m Initial
  git checkout -b abranch
  mv fileA fileB
  git add fileB
  rm fileA
  ln -s fileB fileA
  git add fileA
  git commit -m Linked
  git checkout master
  git mv fileA fileB
  git add fileB
  git commit -m Moved
  git merge --no-commit abranch

Signed-off-by: Ken Schalk <ken.schalk@intel.com>
---
 merge-recursive.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fb6aa4a..57c7a85 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -955,6 +955,18 @@ static int process_renames(struct merge_options *o,
                                                        ren1->pair->two : NULL,
                                                        branch1 == o->branch1 ?
                                                        NULL : ren1->pair->two, 1);
+                       } else if ((dst_other.mode == ren1->pair->two->mode) &&
+                                  sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
+                               /* Added file on the other side
+                                  identical to the file being
+                                  renamed: clean merge */
+                               update_file(o, 1, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
+                               if (!o->call_depth)
+                                       update_stages(ren1_dst, NULL,
+                                                       branch1 == o->branch1 ?
+                                                       ren1->pair->two : NULL,
+                                                       branch1 == o->branch1 ?
+                                                       NULL : ren1->pair->two, 1);
                        } else if (!sha_eq(dst_other.sha1, null_sha1)) {
                                const char *new_path;
                                clean_merge = 0;
--
1.7.0
