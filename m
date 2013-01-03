From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] Allow installing a non-default set of documentation
Date: Thu,  3 Jan 2013 11:05:20 -0800
Message-ID: <1357239920-2201-3-git-send-email-gitster@pobox.com>
References: <1357239920-2201-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 20:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqq6y-0003wE-2G
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 20:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab3ACTFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 14:05:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698Ab3ACTF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 14:05:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8467AC44;
	Thu,  3 Jan 2013 14:05:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=g7Kj
	LKofewTxKDntwRfueGT93B8=; b=RXKu5b7EnxEheq4Qtm8QWdklCN7GEAk3MYuA
	xFumIgSLBiOOTEQbmouiO2MW+9vYVIfFKYhXQg4QMy/Afvkzz5E5m0K3TvPvHOGm
	hcnoDd18l6ZIA2JL9qDJ36KCWqcvstwlVPjZP3mrzQA1XrVlDNXIm5JSF/15Jj6G
	klKzVcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	jUswuH8bQZkjaJ2Wbh72K9dbCbnJkEIwmYuF1RNhFI73IWG0me5YSEvnOBom67yp
	kKup9FvDE9VNtp0UNnalx/ro48OvEVa36qM4E3YfbB5sPh8BzX0Kif3oHYHNefYW
	YUgyd/KyRRyX70clVlPRSJEqpcJPsypR68YyBwYuDgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AAC8AC43;
	Thu,  3 Jan 2013 14:05:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE2B4AC42; Thu,  3 Jan 2013
 14:05:25 -0500 (EST)
X-Mailer: git-send-email 1.8.1.293.g4a210a9
In-Reply-To: <1357239920-2201-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8818E986-55D8-11E2-B9A3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212601>

In a fashion similar to the previous DEFAULT_DOC_TARGET patch, teach
the build procedure to allow installing the documentation sets
specified via DEFAULT_DOC_INSTALL_TARGET.

These two symbols must be separate, as we should allow formatting
more than what will be installed.  The default has been to format
both html and manpages, and to install only the latter.

    $ make DEFAULT_DOC_INSTALL_TARGET='html man' install-doc

will format and install both html and manpages.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile | 3 ++-
 Makefile               | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f8fdf8..bd7800d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -69,6 +69,7 @@ endif
 -include ../config.mak
 
 DEFAULT_DOC_TARGET ?= html man
+DEFAULT_DOC_INSTALL_TARGET ?= $(DEFAULT_DOC_TARGET)
 
 #
 # For docbook-xsl ...
@@ -171,7 +172,7 @@ info: git.info gitman.info
 
 pdf: user-manual.pdf
 
-install: install-man
+install: $(patsubst %,install-%,$(DEFAULT_DOC_INSTALL_TARGET))
 
 install-man: man
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
diff --git a/Makefile b/Makefile
index 71655a7..422a15f 100644
--- a/Makefile
+++ b/Makefile
@@ -287,6 +287,8 @@ all::
 #   DEFAULT_DOC_TARGET='man html info pdf'
 #   DEFAULT_DOC_TARGET='html'
 #
+# DEFAULT_DOC_INSTALL_TARGET can be used in a similar way.
+#
 # Define COMPUTE_HEADER_DEPENDENCIES to "yes" if you want dependencies on
 # header files to be automatically computed, to avoid rebuilding objects when
 # an unrelated header file changes.  Define it to "no" to use the hard-coded
@@ -1428,6 +1430,7 @@ ifneq (,$(SOCKLEN_T))
 endif
 
 DEFAULT_DOC_TARGET ?= html man
+DEFAULT_DOC_INSTALL_TARGET ?= man
 
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
@@ -2379,7 +2382,7 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
-export DEFAULT_EDITOR DEFAULT_PAGER DEFAULT_DOC_TARGET
+export DEFAULT_EDITOR DEFAULT_PAGER DEFAULT_DOC_TARGET DEFAULT_DOC_INSTALL_TARGET
 
 doc:
 	$(MAKE) -C Documentation all
-- 
1.8.1.293.g4a210a9
