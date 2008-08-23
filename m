From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Install templates directory using mkdir -p, not
 install -d
Date: Sat, 23 Aug 2008 12:44:51 -0700
Message-ID: <7vsksvy0qz.fsf@gitster.siamese.dyndns.org>
References: <1219519746-7438-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 21:46:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWz46-0003cV-GV
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYHWTpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbYHWTpN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:45:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbYHWTpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:45:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 819A76BFB8;
	Sat, 23 Aug 2008 15:45:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A8466BFB7; Sat, 23 Aug 2008 15:45:04 -0400 (EDT)
In-Reply-To: <1219519746-7438-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 23 Aug 2008 21:29:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD2ED8BE-714B-11DD-AE53-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93480>

I have the attached patch queued for about 36 hours already, but I ended
up wasting a lot of time fixing other people's bugs last night and haven't
had a chance to push out the result yet.

I think using mkdir in blt/ area is fine, but I have doubts about not
using $(INSTALL), which is designed to be a standard "marker" in Makefiles
and meant to be replaceable on deficient platforms, for installing to real
final destination directories.  IOW, I do not think the last hunk in your
patch is a good idea.

>From 96cda0b1067b4b5a2f87785cc49e1e648d68ae1d Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 21 Aug 2008 19:31:50 -0500
Subject: [PATCH] templates/Makefile: install is unnecessary, just use mkdir -p

The native install on some platforms (namely IRIX 6.5) treats non-absolute
paths as being relative to the root directory rather than relative to
the current directory. Work around this by avoiding install in this case
since it is unnecessary, and instead depend on the local umask setting
and use mkdir.

Tested-by: Brandon Casey <casey@nrlssc.navy.mil>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 templates/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index cc3fc30..0722a92 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -23,13 +23,13 @@ all: boilerplates.made custom
 
 bpsrc = $(filter-out %~,$(wildcard *--*))
 boilerplates.made : $(bpsrc)
-	$(QUIET)ls *--* 2>/dev/null | \
+	$(QUIET)umask 022 && ls *--* 2>/dev/null | \
 	while read boilerplate; \
 	do \
 		case "$$boilerplate" in *~) continue ;; esac && \
 		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
 		dir=`expr "$$dst" : '\(.*\)/'` && \
-		$(INSTALL) -d -m 755 blt/$$dir && \
+		mkdir -p blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
 		*) cp -p $$boilerplate blt/$$dst ;; \
-- 
1.6.0.51.g078ae
