From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/2] Allow side-effects in second argument to ALLOC_GROW
Date: Fri, 8 Oct 2010 12:02:24 -0500
Message-ID: <20101008170224.GF9212@burratino>
References: <20101008005256.GA21738@headley>
 <20101008074320.GB4671@burratino>
 <20101008164536.GB9212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4GO6-00089t-DE
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758737Ab0JHRFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 13:05:36 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59406 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab0JHRFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:05:35 -0400
Received: by qyk10 with SMTP id 10so1536922qyk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T4QlrzdTmeQPDGBuessZ7qpVNSnpD8s4PkWXWbJO7/0=;
        b=ZjHuJRXwWCWpK4Uv1fFKGyfRc9Ft5d9yx/FKGEF+Vl7Brwcph8neFwK5vqtHHmlMa2
         iAfy4M9+rG/SHozkg31odA2ePEf5hn3e+lpMJfDubxUxBEQ6qdLjsKR7izHxfYgJ7pZY
         0kO1hxfa2OqCgGdOGlYj5GPxs9OMLqQ08tXnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k8IPCayMGvI8rheE21jxbIg3jXZVXGyy7nEl5AtRIdyIwrzzQTZjB7t1WodB4cS1hW
         7z4nzOAJJ7XCyq1HMIrnPUu/YMDkdeVhx5j/gUi1cjnrdA5J/ik5HhNI8vcppOvBI4/n
         +7Npybk6rCI+KEdYBibAH2wEh4uVd4Z6rlCI8=
Received: by 10.224.187.78 with SMTP id cv14mr1754668qab.263.1286557534545;
        Fri, 08 Oct 2010 10:05:34 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p10sm2695849qcu.35.2010.10.08.10.05.33
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:05:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101008164536.GB9212@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158506>

One might be tempted to try

	ALLOC_GROW(ary, ++nr, alloc);

to increase the size of an array by one, and if one tries, the
compiler will happily accept it.  Unfortunately ALLOC_GROW evaluates
its argument at least twice, so the results are generally not what the
caller wanted.

Luckily, it is simple enough to do what the caller meant by storing
the value of the second argument in a temporary.

The first and third arguments still need to be side-effect-free.  The
name of the temporary is nr_ to avoid conflicting with variables the
caller might use in the expansion of ary, nr, or alloc.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 23d6d45..5c9e338 100644
--- a/cache.h
+++ b/cache.h
@@ -438,13 +438,14 @@ extern int init_db(const char *template_dir, unsigned int flags);
  * at least 'nr' entries; the number of entries currently allocated
  * is 'alloc', using the standard growing factor alloc_nr() macro.
  *
- * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
+ * DO NOT USE any expression with side-effect for 'x' or 'alloc'.
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
-		if ((nr) > alloc) { \
-			if (alloc_nr(alloc) < (nr)) \
-				alloc = (nr); \
+		const size_t nr_ = (nr); \
+		if (nr_ > (alloc)) { \
+			if (alloc_nr(alloc) < nr_) \
+				alloc = nr_; \
 			else \
 				alloc = alloc_nr(alloc); \
 			x = xrealloc((x), alloc * sizeof(*(x))); \
-- 
1.7.2.3
