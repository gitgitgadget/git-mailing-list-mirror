From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/12] ll-merge: make flag easier to populate
Date: Thu, 5 Aug 2010 06:17:38 -0500
Message-ID: <20100805111738.GI13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyTX-0005UX-8j
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127Ab0HELS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:18:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47582 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759028Ab0HELS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:18:57 -0400
Received: by iwn33 with SMTP id 33so84919iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=v5RWaOsWnWg5jGHvduzWB+trS21/eWUKMdJ78nxz3Ao=;
        b=amBLA3Xs1ZnDEA4tG3xWEEXgDrAjzFXIpfYkkOutFYhefNn35rL9hoswf++hCLvqHW
         nXV+zv50PtF0lRKZDlpl2OOaMUcLMfwC9qewJVkkfSQAZc119ahN2mnk6AoXww78k4o2
         L+bf3/pg+g028R5PmhiH67tj6upLtvEqIbyh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OzbM3CBZ1PIRh0xbdgMXqS+JuVq0IfZD/t3C0IztyfRVeD6o0anGjvVFq57aHzam2k
         vwee2BNFTPxQ0s+mIcmdIXXsrUUebYo3MAesnHADCTiUb7AAxrL6p53378RPnLyNjQrL
         32jz14oI2vWyFH7L38DCH46YHA14ZIJnw8Ybs=
Received: by 10.231.36.13 with SMTP id r13mr11981427ibd.75.1281007136686;
        Thu, 05 Aug 2010 04:18:56 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 34sm48257ibi.18.2010.08.05.04.18.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:18:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152639>

ll_merge() takes its options in a flag word, which has a few
advantages:

 - options flags can be cheaply passed around in registers, while
   an option struct passed by pointer cannot;

 - callers can easily pass 0 without trouble for no options,
   while an option struct passed by value would not allow that.

The downside is that code to populate and access the flag word can be
somewhat opaque.  Mitigate that with a few macros.

Cc: Avery Pennarun <apenwarr@gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-merge.txt |   11 +++++++----
 ll-merge.c                            |    9 +++++----
 ll-merge.h                            |   14 ++++++++++++++
 merge-recursive.c                     |    3 ++-
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index 01a89d6..a7e050b 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -49,12 +49,15 @@ supports this.
 
 The `flag` parameter is a bitfield:
 
- - The least significant bit indicates whether this is an internal
-   merge to consolidate ancestors for a recursive merge.
+ - The `LL_OPT_VIRTUAL_ANCESTOR` bit indicates whether this is an
+   internal merge to consolidate ancestors for a recursive merge.
 
- - The next two bits allow local conflicts to be automatically
+ - The `LL_OPT_FAVOR_MASK` bits allow local conflicts to be automatically
    resolved in favor of one side or the other (as in 'git merge-file'
-   `--ours`/`--theirs`/`--union` for 01, 10, and 11, respectively).
+   `--ours`/`--theirs`/`--union`).
+   They can be populated by `create_ll_flag`, whose argument can be
+   `XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`, or
+   `XDL_MERGE_FAVOR_UNION`.
 
 Everything else
 ---------------
diff --git a/ll-merge.c b/ll-merge.c
index 5068fe0..290f764 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -46,7 +46,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	 * or common ancestor for an internal merge.  Still return
 	 * "conflicted merge" status.
 	 */
-	mmfile_t *stolen = (flag & 01) ? orig : src1;
+	mmfile_t *stolen = (flag & LL_OPT_VIRTUAL_ANCESTOR) ? orig : src1;
 
 	result->ptr = stolen->ptr;
 	result->size = stolen->size;
@@ -79,7 +79,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 
 	memset(&xmp, 0, sizeof(xmp));
 	xmp.level = XDL_MERGE_ZEALOUS;
-	xmp.favor= (flag >> 1) & 03;
+	xmp.favor = ll_opt_favor(flag);
 	if (git_xmerge_style >= 0)
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
@@ -99,7 +99,8 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  int flag, int marker_size)
 {
 	/* Use union favor */
-	flag = (flag & 1) | (XDL_MERGE_FAVOR_UNION << 1);
+	flag = (flag & LL_OPT_VIRTUAL_ANCESTOR) |
+	       create_ll_flag(XDL_MERGE_FAVOR_UNION);
 	return ll_xdl_merge(drv_unused, result, path_unused,
 			    orig, NULL, src1, NULL, src2, NULL,
 			    flag, marker_size);
@@ -342,7 +343,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
-	int virtual_ancestor = flag & 01;
+	int virtual_ancestor = flag & LL_OPT_VIRTUAL_ANCESTOR;
 
 	if (merge_renormalize) {
 		normalize_file(ancestor, path);
diff --git a/ll-merge.h b/ll-merge.h
index 57754cc..5990271 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -5,6 +5,20 @@
 #ifndef LL_MERGE_H
 #define LL_MERGE_H
 
+#define LL_OPT_VIRTUAL_ANCESTOR	(1 << 0)
+#define LL_OPT_FAVOR_MASK	((1 << 1) | (1 << 2))
+#define LL_OPT_FAVOR_SHIFT 1
+
+static inline int ll_opt_favor(int flag)
+{
+	return (flag & LL_OPT_FAVOR_MASK) >> LL_OPT_FAVOR_SHIFT;
+}
+
+static inline int create_ll_flag(int favor)
+{
+	return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OPT_FAVOR_MASK);
+}
+
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
diff --git a/merge-recursive.c b/merge-recursive.c
index 8a49844..c0c9f0c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -647,7 +647,8 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
-				(!!o->call_depth) | (favor << 1));
+				((o->call_depth ? LL_OPT_VIRTUAL_ANCESTOR : 0) |
+				 create_ll_flag(favor)));
 
 	free(name1);
 	free(name2);
-- 
1.7.2.1.544.ga752d.dirty
