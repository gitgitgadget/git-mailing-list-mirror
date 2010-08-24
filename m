From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH jn/merge-renormalize] merge-recursive: expose merge
 options for builtin merge
Date: Mon, 23 Aug 2010 22:39:22 -0500
Message-ID: <20100824033922.GA19628@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100824022820.GE17406@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 05:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnkNy-0003cC-DL
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 05:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0HXDlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 23:41:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44502 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab0HXDlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 23:41:12 -0400
Received: by gyd8 with SMTP id 8so2399689gyd.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 20:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WGEoT5aw49YMEYPw3Kfp0TUBttLJKsq9+5Bn6Pdf4hY=;
        b=RDhSM5JaBGHsctr3GFwYg6hKJMJ0lBqf+xCqmmTTc4oZ9bJC2X287/AmfeynQgcO3d
         oF/odCABJNJzBCFLdVXKbdMR/7u2cwX+CevPMOEK/1ZBIoChKJ1ZZxCngiH8nV2DwpVS
         SBatY9RW96nFEIDIecZPlTJdkYcDVRXOBL40I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SS/5LF2hHclWlmiyMFsOUpf/Tkqusmh8mEEjZbNYahwkqvHIoNoK/J+oiswqMMsTBI
         RdalpuISVRULsysNP/+HwXHH8BEpG4HSR8efKneNlLIfLBn5Si9UuhZwLSyR85ONNtYG
         TViKpGl27atyRtGLT2LMgTWGgb7NEts1IG8oI=
Received: by 10.100.42.13 with SMTP id p13mr6557896anp.54.1282621269434;
        Mon, 23 Aug 2010 20:41:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id p12sm12007328ane.34.2010.08.23.20.41.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 20:41:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100824022820.GE17406@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154281>

There are two very similar blocks of code that recognize options for
the "recursive" merge strategy.  Unify them.

No functional change intended.

Cc: Avery Pennarun <apenwarr@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> Justin Frankel wrote:

>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -647,6 +648,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>>  				o.renormalize = 1;
>>  			else if (!strcmp(xopts[x], "no-renormalize"))
>>  				o.renormalize = 0;
>> +			else if (!strcmp(xopts[x], "ignore-all-space"))
>> +				o.xdl_opts |= XDF_IGNORE_WHITESPACE;
[...]
> It's tempting to fix this code duplication once and for all.

 builtin/merge-recursive.c |   14 +-------------
 builtin/merge.c           |   20 ++------------------
 merge-recursive.c         |   21 +++++++++++++++++++++
 merge-recursive.h         |    2 ++
 4 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c2d4677..a610b68 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -37,19 +37,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		if (!prefixcmp(arg, "--")) {
 			if (!arg[2])
 				break;
-			if (!strcmp(arg+2, "ours"))
-				o.recursive_variant = MERGE_RECURSIVE_OURS;
-			else if (!strcmp(arg+2, "theirs"))
-				o.recursive_variant = MERGE_RECURSIVE_THEIRS;
-			else if (!strcmp(arg+2, "subtree"))
-				o.subtree_shift = "";
-			else if (!prefixcmp(arg+2, "subtree="))
-				o.subtree_shift = arg + 10;
-			else if (!strcmp(arg+2, "renormalize"))
-				o.renormalize = 1;
-			else if (!strcmp(arg+2, "no-renormalize"))
-				o.renormalize = 0;
-			else
+			if (parse_merge_opt(&o, arg + 2) <= 0)
 				die("Unknown option %s", arg);
 			continue;
 		}
diff --git a/builtin/merge.c b/builtin/merge.c
index 037cd47..8dd81bf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -629,25 +629,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		o.renormalize = option_renormalize;
 
-		/*
-		 * NEEDSWORK: merge with table in builtin/merge-recursive
-		 */
-		for (x = 0; x < xopts_nr; x++) {
-			if (!strcmp(xopts[x], "ours"))
-				o.recursive_variant = MERGE_RECURSIVE_OURS;
-			else if (!strcmp(xopts[x], "theirs"))
-				o.recursive_variant = MERGE_RECURSIVE_THEIRS;
-			else if (!strcmp(xopts[x], "subtree"))
-				o.subtree_shift = "";
-			else if (!prefixcmp(xopts[x], "subtree="))
-				o.subtree_shift = xopts[x]+8;
-			else if (!strcmp(xopts[x], "renormalize"))
-				o.renormalize = 1;
-			else if (!strcmp(xopts[x], "no-renormalize"))
-				o.renormalize = 0;
-			else
+		for (x = 0; x < xopts_nr; x++)
+			if (parse_merge_opt(&o, xopts[x]) <= 0)
 				die("Unknown option for merge-recursive: -X%s", xopts[x]);
-		}
 
 		o.branch1 = head_arg;
 		o.branch2 = remoteheads->item->util;
diff --git a/merge-recursive.c b/merge-recursive.c
index ee52581..063d623 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1499,3 +1499,24 @@ void init_merge_options(struct merge_options *o)
 	memset(&o->current_directory_set, 0, sizeof(struct string_list));
 	o->current_directory_set.strdup_strings = 1;
 }
+
+int parse_merge_opt(struct merge_options *o, const char *s)
+{
+	if (!s || !*s)
+		return 0;
+	if (!strcmp(s, "ours"))
+		o->recursive_variant = MERGE_RECURSIVE_OURS;
+	else if (!strcmp(s, "theirs"))
+		o->recursive_variant = MERGE_RECURSIVE_THEIRS;
+	else if (!strcmp(s, "subtree"))
+		o->subtree_shift = "";
+	else if (!prefixcmp(s, "subtree="))
+		o->subtree_shift = s + strlen("subtree=");
+	else if (!strcmp(s, "renormalize"))
+		o->renormalize = 1;
+	else if (!strcmp(s, "no-renormalize"))
+		o->renormalize = 0;
+	else
+		return 0;
+	return 1;
+}
diff --git a/merge-recursive.h b/merge-recursive.h
index c5fbe79..37ff99a 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -55,6 +55,8 @@ int merge_recursive_generic(struct merge_options *o,
 void init_merge_options(struct merge_options *o);
 struct tree *write_tree_from_memory(struct merge_options *o);
 
+int parse_merge_opt(struct merge_options *out, const char *s);
+
 /* builtin/merge.c */
 int try_merge_command(const char *strategy, struct commit_list *common, const char *head_arg, struct commit_list *remotes);
 
-- 
1.7.2.2
