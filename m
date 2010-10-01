From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 04/15] t4002 (diff-basic): use test_might_fail for
 commands that might fail
Date: Fri, 1 Oct 2010 05:35:14 -0500
Message-ID: <20101001103514.GC6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-5-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 12:38:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1d0V-0005DT-Io
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 12:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab0JAKiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 06:38:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39352 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab0JAKiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 06:38:21 -0400
Received: by gwj17 with SMTP id 17so1074007gwj.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=f9JUVNvm4FFHdCuFT7BCA8uIyUpMuf0W5fqorPW2/Bs=;
        b=cauIJmDYESFZyaOhLIyPBDBGMS2bS+l0cQmG9bLA/Nt99AHqD8iNyeFf7lFXCLfnBK
         1KaMeYywnScayyOFJAQeULOWpE02/szoM2VbrukDTSUyfjra/Ud4OOGLZoG24u5aXi1w
         7T8R8i3ax/GLVginMXjunYlfJ6DdeKitqEoOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O2QfOPu73LUSOkS07PzekT6YxuU524VwdnFqVjf1UdGdyRlo9qJs0vRFxJay9wTkvC
         cj/cfnL44Dz9cMo3O9KBd6CO7+kEBiRbzm79hEmdx1iUpbtwDgBqPxwRu7TwEhh1UBOp
         uCw01YHfMJ4PxGPtS1qGTBkfNHHMSyhqaX1nI=
Received: by 10.100.236.25 with SMTP id j25mr326598anh.182.1285929500731;
        Fri, 01 Oct 2010 03:38:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l7sm1633586ane.19.2010.10.01.03.38.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 03:38:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285542879-16381-5-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157740>

Elijah Newren wrote:

> --- a/t/t4002-diff-basic.sh
> +++ b/t/t4002-diff-basic.sh
> @@ -205,8 +205,8 @@ test_expect_success \
>      'rm -fr Z [A-Z][A-Z] &&
>       git read-tree $tree_A &&
>       git checkout-index -f -a &&
> -     git read-tree --reset $tree_O || return 1
> -     git update-index --refresh >/dev/null ;# this can exit non-zero
> +     git read-tree --reset $tree_O &&
> +     test_might_fail git update-index --refresh >/dev/null &&
>       git diff-files >.test-a &&

Makes sense; thanks.  But aren't we actually guaranteed that it will
fail, since the index does not match the work tree?

Meanwhile, what was the point of refreshing the index like this?
I would guess it was to make sure that files that match the work tree
are marked as matching, but if so, this is not guaranteed if
update-index --refresh exits early.  Adding -q would fix that.

Why redirect to /dev/null?  I would think the extra output would
be useful while debugging with -v.
---
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 340aa7d..9fb8ca0 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -206,7 +206,7 @@ test_expect_success \
      git read-tree $tree_A &&
      git checkout-index -f -a &&
      git read-tree --reset $tree_O &&
-     test_might_fail git update-index --refresh >/dev/null &&
+     test_must_fail git update-index --refresh -q &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OA'
 
@@ -216,7 +216,7 @@ test_expect_success \
      git read-tree $tree_B &&
      git checkout-index -f -a &&
      git read-tree --reset $tree_O &&
-     test_might_fail git update-index --refresh >/dev/null &&
+     test_must_fail git update-index --refresh -q &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OB'
 
@@ -226,7 +226,7 @@ test_expect_success \
      git read-tree $tree_B &&
      git checkout-index -f -a &&
      git read-tree --reset $tree_A &&
-     test_might_fail git update-index --refresh >/dev/null &&
+     test_must_fail git update-index --refresh -q &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-AB'
 
-- 
