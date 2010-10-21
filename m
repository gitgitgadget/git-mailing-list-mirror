From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config: treat non-existent config files as empty
Date: Thu, 21 Oct 2010 11:47:08 -0500
Message-ID: <20101021164708.GD3732@burratino>
References: <20101021144544.GA18901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 18:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8yPT-0003t1-G7
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 18:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab0JUQyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 12:54:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42780 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab0JUQyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 12:54:17 -0400
Received: by bwz18 with SMTP id 18so505448bwz.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ng2K6O0JIE2YlCg1EcoyxJIhfIuK1t5MXL5Wy/lE7sI=;
        b=u0Zy4ZwTp4kPhjrhRaSmV2+n0y98X/3sf35pGs0SbQfX+4L5LL/Msj7HrGqt0176dE
         eZJ5H/m5YG6WhuKZnTwUMrelQmF3QVbYUReRCVIxBnB7xK8Sq7zluDDAIaHjOT2FMh2c
         SaZ4XAmucrId3VQzLiGxc1FC0kvxEPWGYMv3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GWCvIkXGwT2bo6uOVKxbTzyfB3YvebprEdYrdudHLdE/XhkGuS11wZR6m7JyNMh/sr
         ySEnr1Gx3rnz3T9sO+1h3gfkUhEFoaq/w6aV1NSG3t5NUkit3tmzaLGBUx2ztUfEKzT6
         9OyVw6FBgbdyxEoVhFCs/dtQuv20UQZP68m4g=
Received: by 10.204.114.205 with SMTP id f13mr32859bkq.86.1287679855430;
        Thu, 21 Oct 2010 09:50:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s18sm916069fax.10.2010.10.21.09.50.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 09:50:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101021144544.GA18901@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159523>

Jeff King wrote:

>   1. Does it still error on GIT_CONFIG=/nonexistent? I said then I
>      hadn't tested. I just did, and it does still produce an error.

Maybe it would make sense to squash in something like this, then.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c703257..d0e5546 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -844,6 +844,27 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 
 '
 
+test_expect_success 'nonexistent configuration' '
+	(
+		GIT_CONFIG=doesnotexist &&
+		export GIT_CONFIG &&
+		test_must_fail git config --list &&
+		test_must_fail git config test.xyzzy
+	)
+'
+
+test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
+	ln -s doesnotexist linktonada &&
+	ln -s linktonada linktolinktonada &&
+	(
+		GIT_CONFIG=linktonada &&
+		export GIT_CONFIG &&
+		test_must_fail git config --list &&
+		GIT_CONFIG=linktolinktonada &&
+		test_must_fail git config --list
+	)
+'
+
 test_expect_success 'check split_cmdline return' "
 	git config alias.split-cmdline-fix 'echo \"' &&
 	test_must_fail git split-cmdline-fix &&
