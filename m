From: Steven Penny <svnpenn@gmail.com>
Subject: Re: Git commit path vs rebase path
Date: Tue, 8 May 2012 17:47:45 -0500
Message-ID: <CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
	<4FA8BBB0.1080406@viscovery.net>
	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
	<4FA8C5DB.5060002@viscovery.net>
	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>
	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 00:47:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRtCB-0001fV-MO
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 00:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab2EHWrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 18:47:47 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:38767 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab2EHWrq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 18:47:46 -0400
Received: by gglu4 with SMTP id u4so1200345ggl.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JDCFpjqMvWr5n0lxVG0ITh1bZc2GJbZYv+hLv2JdQLQ=;
        b=gUufCBHwkgsF5+zsF8vyndjv1W8x71azh07+WJplj2Ea5pVRrfmcwTGgQXBYD7hJRD
         qKjFmKHD8aQsuOSvrO1nYS7GT3wyZRsSOhjwtnuVeWyTjsPwobcIiIL53LLzKL63SpOF
         NSJ4ZoQAqPn0zG8UtkZiNE2Phutlx82u9Q47xQHd0BOEG6hA0Ezyo367MKYc3dew5vxM
         pjp/BCMK+h9VjORM3h+ThTvky+IWtkzwkQx8vD2bmkoRvR4AjD6LNdQcVYkz/YBj7QwL
         aG/dCbGJpSW6ESfvdWhzc6Ik6cHBNVuYi8swebRwYzt5yKxOtpQUcO4aW7bH1CM9vLLR
         3WSQ==
Received: by 10.50.41.226 with SMTP id i2mr304726igl.4.1336517265738; Tue, 08
 May 2012 15:47:45 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Tue, 8 May 2012 15:47:45 -0700 (PDT)
In-Reply-To: <7v1umuwpo9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197429>

Junio C Hamano wrote:
> Actually, the above is stated rather poorly. =A0The path that ends up=
 in
> $file must be usable by both Windows native and Cygwin programs, as t=
he
> user may be using "vi" from Cygwin, or "notepad" like your example.

Excellent point.

I ran some test and this is what I came up with

# VI
/cygdrive/c/test/hello.sh # works
C:\test\hello.sh # works
C:/test/hello/sh # works

# NOTEPAD
/cygdrive/c/test/hello.sh # does not work
C:\test\hello.sh # works
C:/test/hello.sh # works

so the best compromise would be "C:/test/hello.sh" which can be created=
 with

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7b3ae75..ba198d2 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -260,6 +260,11 @@ case $(uname -s) in
 		return 1
 	}
 	;;
+*CYGWIN*)
+    pwd () {
+        builtin cygpath -m
+    }
+    ;;
 *)
 	is_absolute_path () {
 		case "$1" in

http://github.com/svnpenn/git/commit/692bc
