From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] Makefile: regenerate assembler listings when asked
Date: Wed, 6 Jan 2010 02:04:20 -0600
Message-ID: <20100106080420.GB7298@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113709.GD10059@progeny.tock>
 <20100106080216.GA7298@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSQsS-0002Hb-6Z
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0AFIEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 03:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824Ab0AFIEU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:04:20 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:33044 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698Ab0AFIET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 03:04:19 -0500
Received: by iwn32 with SMTP id 32so1438274iwn.33
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 00:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XUMPR6JkmAtPFXVMTfIgal9DgE+I74AsdNxSjrLh6GY=;
        b=MDEgrSy0SVPdZSD4KTa92aQKkpQHNv8q2ExdfLIEYtcTrcG2rrMBhzsBl8OrGwx5ZG
         sfVhHpp/GeCMOFoYRs/G5WTPkbujQi2NqswdXHYTYI9DfzgQOcKVRzwdPsiSQFfPxLbb
         cy/gueU3YWAumcaRAuPYi8oAogEnKvjJvHHbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N55so2V7Gbsjsfp9eDFtXwaTyBPEM6XAAsYxzXJ2icnFqMsLOdcO6aHUWLllgsP2ac
         5ITSztJ38yXbwB3LiP912h5m/weOjLayh3sBvtag4aK/EMxkjzUTBTp9baR0ESO+a3UE
         vTibG/9557xodX80qD44yxK5fs6MdAnTXW5XM=
Received: by 10.231.122.103 with SMTP id k39mr3756265ibr.10.1262765058596;
        Wed, 06 Jan 2010 00:04:18 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm19247518iwn.3.2010.01.06.00.04.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 00:04:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100106080216.GA7298@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136245>

'make var.s' fails to regenerate an assembler listing if var.c
has not changed but a header it includes has:

	$ make var.s
	    CC var.s
	$ touch cache.h
	$ make var.s
	$

The corresponding problem for 'make var.o' does not occur because
the Makefile lists dependencies for each .o target explicitly;
analogous dependency rules for the .s targets are not present.
Rather than add some, it seems better to force 'make' to always
regenerate assembler listings, since the assembler listing
targets are only invoked when specifically requested on the make
command line.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c11719c..ba4d071 100644
--- a/Makefile
+++ b/Makefile
@@ -1633,7 +1633,7 @@ git.o git.spec \
 
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
-%.s: %.c GIT-CFLAGS
+%.s: %.c GIT-CFLAGS .FORCE-LISTING
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
@@ -1978,7 +1978,7 @@ endif
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
-.PHONY: .FORCE-GIT-BUILD-OPTIONS
+.PHONY: .FORCE-GIT-BUILD-OPTIONS .FORCE-LISTING
 
 ### Check documentation
 #
-- 
1.6.6.rc2
