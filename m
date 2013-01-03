From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] Allow generating a non-default set of documentation
Date: Thu,  3 Jan 2013 11:05:19 -0800
Message-ID: <1357239920-2201-2-git-send-email-gitster@pobox.com>
References: <1357239920-2201-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 20:05:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqq6x-0003wE-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 20:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab3ACTFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 14:05:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab3ACTFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 14:05:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 849DBAC3F;
	Thu,  3 Jan 2013 14:05:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VjFE
	IP5csj8pE+lqG5r+mJNpE4U=; b=Wl7tPebfrrjvhltntQNntt6ZwoILmpDbCTXm
	o1mRGD3TqC0Eha7uz6jGx4pzZ5N0GWO2wLgQ9H/0tq8SgtwNsGpTCFNiZqgC1UuI
	HBP9S5qMA4kv91W0EI4ASdgoIAVTVedCqV0fK57jkTUKmjDJL/02HUIIQ6lFLivW
	MBOZO1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	uCfgRF1vm53hD3JAdbVLtZwpSNsvmyDMuU/o/D+00GzndWsMKuQe/WtQpF0felGJ
	7rSSsDH2M1t4NZK/6AvW582nx5RGGC0dLf7w95DOU1eqPsXP6KZ2TALJcdaVdwap
	KITh8i3t2FZPpQ00K85zXV779XFmWfdjMyRWQTRHJRw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B07AC3E;
	Thu,  3 Jan 2013 14:05:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B79BEAC3C; Thu,  3 Jan 2013
 14:05:23 -0500 (EST)
X-Mailer: git-send-email 1.8.1.293.g4a210a9
In-Reply-To: <1357239920-2201-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 86CFA718-55D8-11E2-B64B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212602>

By default, "make doc" generates the manpages and htmldocs in the
Documentation directory, but you may want to change this depending
on the target environment, e.g. to include 'pdf'.  Introduce a new
Makefile variable DEFAULT_DOC_TARGET to allow customizing this.

The primary motivation is to let us check documentation patches with

    $ DEFAULT_DOC_TARGET=git-push.1 make doc

but it is not so far-fetched to imagine that Windows users may want to
omit manpages with

    $ DEFAULT_DOC_TARGET=html make doc

or somesuch.  It won't be useful without additional support to tweak
the format installed by default via DEFAULT_DOC_INSTALL_TARGET, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile |  7 ++++++-
 Makefile               | 10 +++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 063fa69..0f8fdf8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
@@ -65,6 +68,8 @@ endif
 -include ../config.mak.autogen
 -include ../config.mak
 
+DEFAULT_DOC_TARGET ?= html man
+
 #
 # For docbook-xsl ...
 #	-1.68.1,	no extra settings are needed?
@@ -151,7 +156,7 @@ ifndef V
 endif
 endif
 
-all: html man
+all:: $(DEFAULT_DOC_TARGET)
 
 html: $(DOC_HTML)
 
diff --git a/Makefile b/Makefile
index 6b0c961..71655a7 100644
--- a/Makefile
+++ b/Makefile
@@ -281,6 +281,12 @@ all::
 #   DEFAULT_EDITOR='$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork'
 #
+# You can define DEFAULT_DOC_TARGET to change it from the built-in
+# default of generating manpages and htmldocs.  e.g.
+#
+#   DEFAULT_DOC_TARGET='man html info pdf'
+#   DEFAULT_DOC_TARGET='html'
+#
 # Define COMPUTE_HEADER_DEPENDENCIES to "yes" if you want dependencies on
 # header files to be automatically computed, to avoid rebuilding objects when
 # an unrelated header file changes.  Define it to "no" to use the hard-coded
@@ -1421,6 +1427,8 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
+DEFAULT_DOC_TARGET ?= html man
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -2371,7 +2379,7 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
-export DEFAULT_EDITOR DEFAULT_PAGER
+export DEFAULT_EDITOR DEFAULT_PAGER DEFAULT_DOC_TARGET
 
 doc:
 	$(MAKE) -C Documentation all
-- 
1.8.1.293.g4a210a9
