From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Sat, 13 Oct 2012 10:49:34 +0700
Message-ID: <20121013034934.GA27791@do>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <7vd30panxo.fsf@alter.siamese.dyndns.org>
 <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
 <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
 <507848DF.6060301@web.de>
 <7vbog74o59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 05:50:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMsjq-0007PA-Sg
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 05:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab2JMDtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 23:49:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab2JMDtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 23:49:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3456377pbb.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 20:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B/DgMAlGwd6dcT9DbLrRgE/wRgpBkkPFj/yB+x2VCLc=;
        b=YbaKumTkgbV0BxHXbfdl87ixF97r7REMWXzZgMrnGgQl4FfsYDJGwd8CAqX2vbzY9V
         gGUQuNrI/rSlFVd7pKKzrIXPa/rWZgex+Nywy2rHQiRn2gM0hhvdMCk6FKoiFKwYPwFJ
         jk6e2M0/+72vRopdiIAveBuAaae30TP9joHkTieWEnVfPWCU+jxh47W/QHHpquoh/6+C
         atSsuqzKrZq0OgQCEoFd35WLm/KzXZe9TLNJaHNnWtihCnezMiJ5SNj/fnYUWyHTvaby
         58tgEL9T3/BwwpaLIZPYdBIgvDt4ASDWxPdFLSggN02lMHT+DDb5ktz8RQT1BOZBpaKV
         04fQ==
Received: by 10.68.204.2 with SMTP id ku2mr19226908pbc.59.1350100189135;
        Fri, 12 Oct 2012 20:49:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id v9sm5335881paz.6.2012.10.12.20.49.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Oct 2012 20:49:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 13 Oct 2012 10:49:34 +0700
Content-Disposition: inline
In-Reply-To: <7vbog74o59.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207567>

On Fri, Oct 12, 2012 at 10:05:06AM -0700, Junio C Hamano wrote:
> Nguyen, how about updating the match () shell function in 3070 so
> that it not just says not-ok, but indicates what failed (wildmatch
> failed, or wildmatch passed but fnmatch failed), at least when the
> test is run as "./t3070-*.sh -v -i"?

You could squash this to the "Integrate wildmatch to git" patch, or
just put it at the end of the series (I'll need to send a series
update anyway). This splits fnmatch and wildmatch tests separately so
we can easily identify which one fails.

-- 8< --
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index c3ee729..4f97923 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -5,20 +5,28 @@ test_description='wildmatch tests'
 . ./test-lib.sh
 
 match() {
-    test_expect_success "wildmatch $*" "
-	if [ $1 = 1 ]; then
+    if [ $1 = 1 ]; then
+	test_expect_success "wildmatch:    match $3 $4" "
 	    test-wildmatch wildmatch '$3' '$4'
-	else
+	"
+    else
+	test_expect_success "wildmatch: no match $3 $4" "
 	    ! test-wildmatch wildmatch '$3' '$4'
-	fi &&
-	if [ $2 = 1 ]; then
+	"
+    fi
+    if [ $2 = 1 ]; then
+	test_expect_success "fnmatch:      match $3 $4" "
 	    test-wildmatch fnmatch '$3' '$4'
-	elif [ $2 = x ]; then
-	    true
-	else
+	"
+    elif [ $2 = 0 ]; then
+	test_expect_success "fnmatch:   no match $3 $4" "
 	    ! test-wildmatch fnmatch '$3' '$4'
-	fi
-    "
+	"
+#    else
+#	test_expect_success BROKEN_FNMATCH "fnmatch:       $3 $4" "
+#	    test-wildmatch fnmatch '$3' '$4'
+#	"
+    fi
 }
 
 # Basic wildmat features
-- 8< --
-- 
Duy
