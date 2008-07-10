From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 09 Jul 2008 19:02:49 -0700
Message-ID: <7v1w225wdy.fsf@gitster.siamese.dyndns.org>
References: <1215638942-25010-2-git-send-email-robertshearman@gmail.com>
 <7v8wwa5ycf.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807091825500.11076@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Shearman <robertshearman@gmail.com>, git@vger.kernel.org,
	Robert Shearman <rob@codeweavers.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 04:04:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGlVq-00057c-Ty
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 04:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYGJCDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 22:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYGJCDB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 22:03:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbYGJCDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 22:03:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E2011A491;
	Wed,  9 Jul 2008 22:02:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0D8A1A48F; Wed,  9 Jul 2008 22:02:52 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807091825500.11076@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 9 Jul 2008 18:31:02 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51098CA4-4E24-11DD-A83E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87930>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We should be able to safely include <ctype.h> as-is.
>
> It should just happen _before_ including git-compat-util.h. That's why 
> git-compat-util.h does all those #undef's - exactly because ctype.h does 
> get included on various systems by various header files when 
> git-compat-util.h includes all those other files.

Eh, that's true,... although I am not convinced we should keep doing this.

With and without NO_OPENSSL, on top of Robert's patch, these seem to pass
compile test.

--

 git-compat-util.h |    5 +++++
 imap-send.c       |    4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 545df59..65c4671 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -99,6 +99,11 @@
 #include <iconv.h>
 #endif
 
+#ifndef NO_OPENSSL
+#include <openssl/ssl.h>
+#include <openssl/err.h>
+#endif
+
 /* On most systems <limits.h> would have given us this, but
  * not on some systems (e.g. GNU/Hurd).
  */
diff --git a/imap-send.c b/imap-send.c
index 9dc5d08..8026334 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,9 +25,6 @@
 #include "cache.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
-#else
-# include <openssl/ssl.h>
-# include <openssl/err.h>
 #endif
 
 typedef struct store_conf {
