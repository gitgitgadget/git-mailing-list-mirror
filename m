From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Sat, 13 Oct 2012 11:32:59 +0700
Message-ID: <20121013043259.GA7011@do>
References: <7vd30si665.fsf@alter.siamese.dyndns.org>
 <1349864466-28289-1-git-send-email-pclouds@gmail.com>
 <7vy5jb33sq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 06:34:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMtQi-0006iS-HX
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 06:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab2JMEdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 00:33:14 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:52947 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab2JMEdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 00:33:14 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1637618dak.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vOyfs3gDxI//brFbW8LY6g+NMebPNpYEzyFKpqvGCDU=;
        b=0udhVrhK3lso2dN5C/qHYnrewdn6VkN48+Mr6ShjDuPE0B8/nWaUrU5eYD7s57Mqw5
         ufu3OclOV951h5lo908eqL9n2gBM/QLvEiLzOgzi8RFdC13MbVEXdeoQpfXeXRI3zAwJ
         gYL+eKzVIPo8ulf4wM/BvsvJA5X7kJYlq0WhRzLZM7dZwkVYA0y3KMuYZ64YI/RXUNiW
         ZWu6LlA8wUFCGZUYlppXwNfMMOw4dsanlqAIK5SIIKpC8pDHhbVy6V07JUb8ajrnnzm5
         mYWCh4/G1rwKr0hyas55zjS0Xoteu7hIakalIhJWgdSrzLeh1r+FMBJztE5xXbNEt9q2
         lJ6g==
Received: by 10.68.212.74 with SMTP id ni10mr19412593pbc.20.1350102793402;
        Fri, 12 Oct 2012 21:33:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id rr6sm5460464pbc.47.2012.10.12.21.33.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Oct 2012 21:33:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 13 Oct 2012 11:32:59 +0700
Content-Disposition: inline
In-Reply-To: <7vy5jb33sq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207571>

On Fri, Oct 12, 2012 at 12:09:57PM -0700, Junio C Hamano wrote:
> This is not entirely your fault, but please don't do that "cd ..".
> 
> The original test had "cd bare", made an assumption that step will
> never fail (which is mostly correct), and ran everything afterward
> in that subdirectory.
> 
> Adding "Do a 'cd ..' to come back" is a horrible way to build on
> it.  Imagine what happens when another person also did the same
> thing, and both changes need to be merged.  You will end up going up
> two levels, which is not what you want.
> 
> I think the right fix is to make each of the test that wants to run
> in "bare" chdir in its own subshell, or not append these new tests
> that do not run in the "bare" to the end of this file, but before
> the execution goes down to "bare".
> 

The reason I put these tests at the end was because I destroy
.gitattributes and it might affect the following tests. But obviously
the bare tests run in its own repository (and I have not committed
anything till the repo is cloned) so my .gitattributes changes can't
affect them.

Please squash this in

-- 8< --
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 4a1402f..f6c21ea 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -206,6 +206,16 @@ test_expect_success 'root subdir attribute test' '
 	attr_check subdir/a/i unspecified
 '
 
+test_expect_success 'negative patterns' '
+	echo "!f test=bar" >.gitattributes &&
+	test_must_fail git check-attr test -- f
+'
+
+test_expect_success 'patterns starting with exclamation' '
+	echo "\!f test=foo" >.gitattributes &&
+	attr_check "!f" foo
+'
+
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git &&
 	cd bare.git
@@ -242,18 +252,4 @@ test_expect_success 'bare repository: test info/attributes' '
 	attr_check subdir/a/i unspecified
 '
 
-test_expect_success 'leave bare' '
-	cd ..
-'
-
-test_expect_success 'negative patterns' '
-	echo "!f test=bar" >.gitattributes &&
-	test_must_fail git check-attr test -- f
-'
-
-test_expect_success 'patterns starting with exclamation' '
-	echo "\!f test=foo" >.gitattributes &&
-	attr_check "!f" foo
-'
-
 test_done
-- 8< --
-- 
Duy
