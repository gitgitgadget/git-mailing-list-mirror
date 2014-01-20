From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Mon, 20 Jan 2014 20:22:20 +0000
Message-ID: <52DD857C.6060005@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 21:22:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5LMl-0004VJ-Il
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 21:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbaATUW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 15:22:28 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:39302 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750773AbaATUW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 15:22:27 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5520CA647FE;
	Mon, 20 Jan 2014 20:22:25 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 16B19A64773;
	Mon, 20 Jan 2014 20:22:25 +0000 (GMT)
Received: from [192.168.254.12] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Mon, 20 Jan 2014 20:22:24 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240725>


If the git version number consists of less than three period
separated numbers, then the windows resource file compilation
issues a syntax error:

  $ touch git.rc
  $ make V=1 git.res
  GIT_VERSION = 1.9.rc0
  windres -O coff \
            -DMAJOR=1 -DMINOR=9 -DPATCH=rc0 \
            -DGIT_VERSION="\\\"1.9.rc0\\\"" git.rc -o git.res
  C:\msysgit\msysgit\mingw\bin\windres.exe: git.rc:2: syntax error
  make: *** [git.res] Error 1
  $

[Note that -DPATCH=rc0]

In order to fix the syntax error, we replace any rcX with zero and
include some additional 'zero' padding to the version number list.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This patch is marked RFC because, as I was just about to send this
email, I realized it wouldn't always work:

    $ touch git.rc
    $ make V=1 GIT_VERSION=1.9.dirty git.res
    windres -O coff \
              -DMAJOR=1 -DMINOR=9 -DPATCH=dirty \
              -DGIT_VERSION="\\\"1.9.dirty\\\"" git.rc -o git.res
    C:\msysgit\msysgit\mingw\bin\windres.exe: git.rc:2: syntax error
    make: *** [git.res] Error 1
    $

:-D

I suspect it would be easier to change GIT-VERSION-GEN to also set, say,
GIT_VERSION_MAJOR, GIT_VERSION_MINOR and GIT_VERSION_PATCH ...

ATB,
Ramsay Jones

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b4af1e2..308baaa 100644
--- a/Makefile
+++ b/Makefile
@@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
-	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
+	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(patsubst rc%,0,$(subst -, ,$(subst ., ,$(GIT_VERSION))) 0 0))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
 ifndef NO_PERL
-- 
1.8.5
