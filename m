From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] merge-recursive: expose merge options for builtin merge
Date: Thu, 26 Aug 2010 00:47:58 -0500
Message-ID: <20100826054758.GD9708@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:49:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVLO-0001IQ-Fj
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab0HZFtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:49:42 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51537 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0HZFtk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:49:40 -0400
Received: by ywh1 with SMTP id 1so194054ywh.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=p5946jgqDCgv0lS5FDMaO7k3P70qcKFH7UGF9ASmNUI=;
        b=St3VHrTh9ylERIxkHU0gL6QzevV8sOcTeLj3fudn1Z4cTjWkerj/dLOdNH0FJV0X2S
         ERK/bySxjHrTBbJYN8InjjrHO4L2owLFKhtY5uC9uA7q06yD2fMix1/AA7Y4myXh4Sb9
         Zu6ohhFIoXqWknzkCa0bYzUUIsMrPSOx2BQ6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ohqWso4N56+nuYLLhlqHlK6Hirg+yZH2GTSoXVvUVSZcPYNI7XcgUV0pzj840DAS0x
         DBGG0/PHE4oYiXEdHRdvi9HnxR9WPPGr30o6wI2Uy2XBWz821+Np1m5950ENDP0My0jZ
         p0GlhHDDirTIbgNZ6L7EzrzCIY+a1OhdFDIWs=
Received: by 10.101.155.15 with SMTP id h15mr10218072ano.162.1282801779869;
        Wed, 25 Aug 2010 22:49:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c38sm3453284anc.39.2010.08.25.22.49.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:49:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100826054158.GB9708@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154512>

There are two very similar blocks of code that recognize options for
the "recursive" merge strategy.  Unify them.

No functional change intended.

Cc: Avery Pennarun <apenwarr@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/merge-recursive.c |   14 +-------------
 builtin/merge.c           |   20 ++------------------
 merge-recursive.c         |   21 +++++++++++++++++++++
 merge-recursive.h         |    2 ++
 4 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c2d4677..5a52f3d 100644
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
+			if (parse_merge_opt(&o, arg + 2))
 				die("Unknown option %s", arg);
 			continue;
 		}
diff --git a/builtin/merge.c b/builtin/merge.c
index 037cd47..721c424 100644
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
+			if (parse_merge_opt(&o, xopts[x]))
 				die("Unknown option for merge-recursive: -X%s", xopts[x]);
-		}
 
 		o.branch1 = head_arg;
 		o.branch2 = remoteheads->item->util;
diff --git a/merge-recursive.c b/merge-recursive.c
index 762b549..44576b7 100644
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
+		return -1;
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
+		return -1;
+	return 0;
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
