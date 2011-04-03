From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] tree-walk: micro-optimization in
 tree_entry_interesting
Date: Sun, 3 Apr 2011 11:01:19 +0700
Message-ID: <20110403040119.GA18104@do>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
 <1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 06:03:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6EXa-0006zh-J9
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 06:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823Ab1DCEDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 00:03:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab1DCEDt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 00:03:49 -0400
Received: by iwn34 with SMTP id 34so4717660iwn.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=u7TlNRV81uCgHQthLEVexk0Ig8IkLXU4tHkBhtkHj5o=;
        b=QyC1V9UgWKNH8dqV5LLRH7TR4M3wOA25IpFA6UeUOrgUFw7W1Wnm2Bk99H5EjVYDv3
         JfYXgpnzLTQksrw1IwqovZXbpZt5NIiCIsDngb4TN/bv7t9XY3O+B7z5l0f3SyysXCsW
         CZT+LLlq9ahV0fpysF64mOqZfMYGGQJXnEO00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bhB8cVHsBfUMjX8Gh64a9muhn0fJ0t8pBnTYviQXEBGmpYso54D3isQfE6VSlN0fRM
         grlHYa/2VwGErlqIoHpvkCIiZPCQg3wXh1ilHep47jiPqrKGDy+YS/ZpjFhn6RWL+byb
         RGc8yrqCCMURXY7IJWhLQ18djBuHxKU1ECb1k=
Received: by 10.43.52.193 with SMTP id vn1mr8477323icb.460.1301803428831;
        Sat, 02 Apr 2011 21:03:48 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.209.201])
        by mx.google.com with ESMTPS id 8sm2679561iba.55.2011.04.02.21.03.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Apr 2011 21:03:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 03 Apr 2011 11:01:19 +0700
Content-Disposition: inline
In-Reply-To: <1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170674>

On Wed, Mar 30, 2011 at 08:37:59PM -0500, Dan McGee wrote:
> In the case of a wide breadth top-level tree (~2400 entries, all trees
> in this case), we can see a noticeable cost in the profiler calling
> strncmp() here. Most of the time we are at the base level of the
> repository, so base is "" and baselen == 0, which means we will always
> test true. Break out this one tiny case so we can short circuit the
> strncmp() call.
> 
> This resulted in an ~11% improvement (43 to 38 secs) for a reasonable
> log operation on the Arch Linux Packages SVN clone repository, which
> contained 117220 commits and the aforementioned 2400 top-level objects:
>     git log -- autogen/trunk pacman/trunk/ wget/trunk/
> 
> Negligible slowdown was noted with other repositories (e.g. linux-2.6).
> 
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

Ack.

On my (slower) laptop, the same command with vanilla git -O3 takes
95 secs. Your patch cuts it down to 82 secs.

I tried inlining strncmp with a version from glibc. Without your patch
it takes 88 secs. With your patch, it takes 86 secs (still worse than
your patch alone). A better strncmp version must be used on my system,
I suspect.

--8<--
diff --git a/tree-walk.c b/tree-walk.c
index 322becc..0859b5c 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -457,6 +457,55 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 	return retval;
 }
 
+static inline int inline_strncmp(const char *s1, const char *s2, size_t n)
+{
+	unsigned char c1 = '\0';
+	unsigned char c2 = '\0';
+
+	if (n == 0)
+		return 0;
+
+	if (n >= 4) {
+		size_t n4 = n >> 2;
+		do {
+			c1 = (unsigned char) *s1++;
+			c2 = (unsigned char) *s2++;
+			if (c1 == '\0' || c1 != c2)
+				return c1 - c2;
+			c1 = (unsigned char) *s1++;
+			c2 = (unsigned char) *s2++;
+			if (c1 == '\0' || c1 != c2)
+				return c1 - c2;
+			c1 = (unsigned char) *s1++;
+			c2 = (unsigned char) *s2++;
+			if (c1 == '\0' || c1 != c2)
+				return c1 - c2;
+			c1 = (unsigned char) *s1++;
+			c2 = (unsigned char) *s2++;
+			if (c1 == '\0' || c1 != c2)
+				return c1 - c2;
+		} while (--n4 > 0);
+		n &= 3;
+	}
+
+	while (n > 0) {
+		c1 = (unsigned char) *s1++;
+		c2 = (unsigned char) *s2++;
+		if (c1 == '\0' || c1 != c2)
+			return c1 - c2;
+		n--;
+	}
+
+	return c1 - c2;
+}
+
+#if 1
+#ifdef strncmp
+#undef strncmp
+#endif
+#define strncmp inline_strncmp
+#endif
+
 static int match_entry(const struct name_entry *entry, int pathlen,
 		       const char *match, int matchlen,
 		       int *never_interesting)
--8<--
-- 
Duy
