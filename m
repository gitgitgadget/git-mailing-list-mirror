From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] merge-recursive --patience
Date: Thu, 26 Aug 2010 00:50:45 -0500
Message-ID: <20100826055045.GF9708@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:52:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVO9-0003b7-3r
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab0HZFwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:52:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44813 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0HZFwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:52:31 -0400
Received: by iwn5 with SMTP id 5so1280260iwn.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=06x0OJOurBBt3miPOeMwiWZvmPh9jcMX380q1qmORtY=;
        b=UsU9sEM6LBw3jdnfiD7pUyxtT/IT7rpljx51F5NRqJ0MOnvad+rSJi9UOLwxzIOSM4
         AmMi6TH9o+yqJJ6Ee56S9O2yR8ONkyIumz5gyD+/e4zYHVXvIRWEVbJ8bZ8Zh+lHLS9C
         /A6tFyxLBUW9nRy2Fun00oszs38NWWiAGWWYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=m9ZqM21lmJIgooyEPEi1iHtw99IXxz+2wdTepynjF5k9V6MH1GXIK8XmBlgw4/v2cZ
         s76Jd8T/LmaUHY/Rfau6SGJWPaus3WhAbDB8ccLdPCaNjA04Srzj7pPTnlT0n60tfRAN
         5zZfrpkMGk//XXhxu/aC/xM+wBFjyobyPtrWA=
Received: by 10.231.146.129 with SMTP id h1mr11290480ibv.181.1282801950822;
        Wed, 25 Aug 2010 22:52:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm2142595ibk.7.2010.08.25.22.52.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:52:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100826054158.GB9708@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154514>

From: Justin Frankel <justin@cockos.com>

Teach the merge-recursive strategy a --patience option to use the
"patience diff" algorithm, which tends to improve results when
cherry-picking a patch that reorders functions at the same time as
refactoring them.

To support this, struct merge_options and ll_merge_options gain an
xdl_opts member, so programs can use arbitrary xdiff flags (think
"XDF_IGNORE_WHITESPACE") in a git-aware merge.

git merge and git rebase can be passed the -Xpatience option to
use this.

[jn: split from --ignore-space patch; with documentation]

Signed-off-by: Justin Frankel <justin@cockos.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/merge-strategies.txt |    7 +++++++
 builtin/merge-recursive.c          |    1 +
 ll-merge.c                         |    1 +
 ll-merge.h                         |    1 +
 merge-recursive.c                  |    3 +++
 merge-recursive.h                  |    1 +
 6 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 049313d..a5ae14f 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -40,6 +40,13 @@ the other tree did, declaring 'our' history contains all that happened in it.
 theirs;;
 	This is opposite of 'ours'.
 
+patience;;
+	With this option, 'merge-recursive' spends a little extra time
+	to avoid mismerges that sometimes occur due to unimportant
+	matching lines (e.g., braces from distinct functions).  Use
+	this when the branches to be merged have diverged wildly.
+	See also linkgit:git-diff[1] `--patience`.
+
 renormalize;;
 	This runs a virtual check-out and check-in of all three stages
 	of a file when resolving a three-way merge.  This option is
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 5a52f3d..70e1d25 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "merge-recursive.h"
+#include "xdiff-interface.h"
 
 static const char *better_branch_name(const char *branch)
 {
diff --git a/ll-merge.c b/ll-merge.c
index 9bd3732..dea6f2f 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -86,6 +86,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	memset(&xmp, 0, sizeof(xmp));
 	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
+	xmp.xpp.flags = opts->xdl_opts;
 	if (git_xmerge_style >= 0)
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
diff --git a/ll-merge.h b/ll-merge.h
index 4b707f0..244a31f 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -9,6 +9,7 @@ struct ll_merge_options {
 	unsigned virtual_ancestor : 1;
 	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
 	unsigned renormalize : 1;
+	long xdl_opts;
 };
 
 int ll_merge(mmbuffer_t *result_buf,
diff --git a/merge-recursive.c b/merge-recursive.c
index 0e9a29d..3e67f81 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -613,6 +613,7 @@ static int merge_3way(struct merge_options *o,
 	int merge_status;
 
 	ll_opts.renormalize = o->renormalize;
+	ll_opts.xdl_opts = o->xdl_opts;
 
 	if (o->call_depth) {
 		ll_opts.virtual_ancestor = 1;
@@ -1512,6 +1513,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->subtree_shift = "";
 	else if (!prefixcmp(s, "subtree="))
 		o->subtree_shift = s + strlen("subtree=");
+	else if (!strcmp(s, "patience"))
+		o->xdl_opts |= XDF_PATIENCE_DIFF;
 	else if (!strcmp(s, "renormalize"))
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
diff --git a/merge-recursive.h b/merge-recursive.h
index 37ff99a..d21b446 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -15,6 +15,7 @@ struct merge_options {
 	const char *subtree_shift;
 	unsigned buffer_output : 1;
 	unsigned renormalize : 1;
+	long xdl_opts;
 	int verbosity;
 	int diff_rename_limit;
 	int merge_rename_limit;
-- 
1.7.2.2
