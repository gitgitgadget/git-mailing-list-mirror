From: Dmitri Gribenko <gribozavr@gmail.com>
Subject: Build system bugs related to handling of 'LIBS' environment variable
Date: Wed, 3 Apr 2013 18:16:22 +0300
Message-ID: <CA+Y5xYeghRA-Whtq6e-sskeow38jz+6UgYWP-ng3xdRn_XUHEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 03 17:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPR3-0006Aa-16
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761533Ab3DCPQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 11:16:44 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37533 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760644Ab3DCPQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:16:43 -0400
Received: by mail-vb0-f46.google.com with SMTP id 11so524276vbe.5
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=mU0w+5HWfZF98eGRKWA5yi5n6BgNJ+7+4Og62f6Yjjo=;
        b=rUvzm1qAO8Ky202dma4j8dqtDbEjvxM8diAI8VvglG7UHZHXhchr97yF8beD6TIfyn
         JN3n9AEje5Q+Y03r+6T4hSVYYYjSGuimFbo6QW+AopLhm8FLj7dktXNxUw3YfPVr0e45
         WK6+L622Te6KW4+n8B1ev/LVE5bJf8v9DAzyH/rghHlHt2zM4qoXV9+prpLMguPO0Zh9
         k5GP+nqSVZQy1tRaG70vPGMtOuZVtSGv2IkDM3gEBZyy1m8sCCu18O3Ih2dVezDooQV3
         JyUcCDlc9AJAUyprNP9ez1NYhY4z/WBs0p1tPRzDb4pS7HbdaT6jXjmGcquRp8UAYhkF
         3npw==
X-Received: by 10.58.11.133 with SMTP id q5mr1527812veb.47.1365002202650; Wed,
 03 Apr 2013 08:16:42 -0700 (PDT)
Received: by 10.220.122.129 with HTTP; Wed, 3 Apr 2013 08:16:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219946>

Hello,

Git fails to build if LIBS contains -lpthread.  To reproduce:

  export LIBS=-lpthread
  ./configure
  make V=1 git-credential-store

The bug is that linker command line does not contain -lpthread, so
linking fails.

configure respects LIBS and finds that it does not have to add
anything for pthread:

checking for POSIX Threads with ''... yes

But (first bug) configure does not pass the LIBS variable in
config.mak.autogen.  Even if it did, Makefile would overwrite (second
bug) LIBS with:

  LIBS = $(GITLIBS) $(EXTLIBS)

Makefile should rather append to LIBS.

Dmitri Gribenko

--
main(i,j){for(i=2;;i++){for(j=2;j<i;j++){if(!(i%j)){j=0;break;}}if
(j){printf("%d\n",i);}}} /*Dmitri Gribenko <gribozavr@gmail.com>*/
