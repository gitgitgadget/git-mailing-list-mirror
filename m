From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Tue, 24 Aug 2010 23:40:06 -0500
Message-ID: <20100825044006.GJ11619@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100824022820.GE17406@burratino>
 <5F681E95-9369-490A-84FE-55B99EA8FE63@cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 06:42:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo7oQ-0002Zm-Ro
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 06:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab0HYElz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 00:41:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65090 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0HYEly (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 00:41:54 -0400
Received: by ywe9 with SMTP id 9so70774ywe.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ba44C1Nu6nMEHX8kVde25+sMPxIFB+pPIKutb1n9J1M=;
        b=UGMhifNAkFLelf3E0ucCnxVMgrXg0fUhHktdzPy51SXb5H7I0TJQJlqrjASnGQ47yH
         tUOw4ZFDbFR8T8FrpQbBuxk4e2jtVSZEX1BtrnMxB8ioFmuuZ7ZDZSjeQGKmpYPTLSBr
         zNXMi7fy4LD0NXQJyeippNYFM9bACtobyXrjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lQtcOztOmgVtRxc9QHK7BpmS+ml5bdEYjWC5zirBkQajsdHCfvDJnmF+e9v4TevSY2
         bw9hCLhi6vIdu3fJ/iL8LC01Sz5nTIyhPPtTPfHnZ+7m8Ek3mcxcUe4Son6o2pZAJ8OJ
         Qk+r93wqA29nesHqim0yid+Rzv7StOWR7wZQo=
Received: by 10.100.153.5 with SMTP id a5mr8527909ane.112.1282711311017;
        Tue, 24 Aug 2010 21:41:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h5sm1305497anb.28.2010.08.24.21.41.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 21:41:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5F681E95-9369-490A-84FE-55B99EA8FE63@cockos.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154415>

Justin Frankel wrote:

> Fine by me... (ok if I were to nitpick I would probably make most of
> the internal static functions check that opts was non-NULL before
> dereferencing, in case the calling code ever changed

Not a bad idea.  I'll squash in something like this.

A real BUG_ON macro would make this less ugly.

-- 8< --
Subject: ll-merge: BUG_ON(!opts) in internal functions

If one of the functions used to implement ll_merge() gets exposed,
callers would be likely to pass a NULL options argument, resulting in
segfaults.  Die with a more meaningful message in that case.

Suggested-by: Justin Frankel <justin@cockos.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 ll-merge.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 98f353a..8ff0b27 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -42,12 +42,17 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   const struct ll_merge_options *opts,
 			   int marker_size)
 {
+	mmfile_t *stolen;
+
+	if (!opts)
+		die("BUG: !opts in binary merge driver");
+
 	/*
 	 * The tentative merge result is "ours" for the final round,
 	 * or common ancestor for an internal merge.  Still return
 	 * "conflicted merge" status.
 	 */
-	mmfile_t *stolen = opts->virtual_ancestor ? orig : src1;
+	stolen = opts->virtual_ancestor ? orig : src1;
 
 	result->ptr = stolen->ptr;
 	result->size = stolen->size;
@@ -66,6 +71,9 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 {
 	xmparam_t xmp;
 
+	if (!opts)
+		die("BUG: !opts in xdiff merge driver");
+
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
 	    buffer_is_binary(src2->ptr, src2->size)) {
@@ -102,7 +110,10 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  int marker_size)
 {
 	/* Use union favor */
-	struct ll_merge_options o = *opts;
+	struct ll_merge_options o;
+	if (!opts)
+		die("BUG: !opts in union merge driver");
+	o = *opts;
 	o.variant = XDL_MERGE_FAVOR_UNION;
 	return ll_xdl_merge(drv_unused, result, path_unused,
 			    orig, NULL, src1, NULL, src2, NULL,
@@ -149,6 +160,9 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	int status, fd, i;
 	struct stat st;
 
+	if (!opts)
+		die("BUG: !opts in custom merge driver");
+
 	dict[0].placeholder = "O"; dict[0].value = temp[0];
 	dict[1].placeholder = "A"; dict[1].value = temp[1];
 	dict[2].placeholder = "B"; dict[2].value = temp[2];
-- 
1.7.2.2
