From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 07/16] t3600 (rm): add lots of missing &&
Date: Sun, 3 Oct 2010 09:28:55 -0500
Message-ID: <20101003142855.GC17084@burratino>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 16:34:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2PeH-0004HP-5i
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 16:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab0JCOcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 10:32:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39239 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0JCOcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 10:32:13 -0400
Received: by iwn5 with SMTP id 5so5809479iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iiCcr7Yjdr8oCkViSoeUuz5jz8jAgriM9TFpKlB/6xQ=;
        b=Ry6bapHLwI6rs07SbnG8lIVbvsVWmz0UmZ0yMHOUttD+NZJIAfzUBed/UI8tVTS0uM
         xSL/GRIPCCx+BgzLwNtKYGPEiTnSnLHei5sKnJ8qkLgjduCoTzxqRf01OevtuOdK1Rp7
         Z+6XqhSuu78atvVO/HWzqujBw88pVUlCexLgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DuMZBRbYvt66lVFC3Sv3lOXX02lAqAv38b2IDNLlZ7yRzj2GTI6tW9w5MeU6pEXw1L
         7/8DMgBzNe1TnO2aFOkM5C7POUFLh+i2GlbmkLA9OZIShJpr4n3bDKXHKL2R+aZcluhG
         UWxSv1OdbKIzE6toxqdBHqlif6B0DEdHQA/2Q=
Received: by 10.231.155.7 with SMTP id q7mr8651423ibw.105.1286116332890;
        Sun, 03 Oct 2010 07:32:12 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id h8sm3772355ibk.9.2010.10.03.07.32.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 07:32:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286082644-31595-8-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157875>

Elijah Newren wrote:

> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -38,37 +38,33 @@ test_expect_success \
[...]
>  test_expect_success \
>      'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
> -     echo content > foo
> -     git add foo
> -     git commit -m foo
> +     git checkout HEAD -- foo &&
[...]

Why not

	-	echo content > foo
	-	git add foo
	-	git commit -m foo
	+	echo content > foo &&
	+	git add foo &&
	+	git commit --allow-empty -m foo &&

?

Likewise for the next case.  Though in the long run, a helper function
to prepare the HEAD, index, and work tree would probably be the way to
go for this test.

With the change below (or whatever else is deemed appropriate),
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Sorry to draw this out so.
---
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 9660ae0..53add72 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -46,13 +46,15 @@ test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
     'echo content > foo &&
      git add foo &&
-     git commit -m foo &&
+     git commit --allow-empty -m foo &&
      echo "other content" > foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     git checkout HEAD -- foo &&
+     echo content > foo &&
+     git add foo &&
+     git commit --allow-empty -m foo &&
      echo "other content" > foo &&
      git add foo &&
      echo "yet another content" > foo &&
@@ -61,7 +63,9 @@ test_expect_success \
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'git checkout HEAD -- foo &&
+    'echo content > foo &&
+     git add foo &&
+     git commit --allow-empty -m foo &&
      echo "other content" > foo &&
      git add foo &&
      echo "yet another content" > foo &&
-- 
