From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: NO_INSTALL_HARDLINKS
Date: Wed, 02 May 2012 15:12:10 -0700
Message-ID: <7vmx5qgrlx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 00:12:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPhmX-0001Yx-5T
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 00:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2EBWMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 18:12:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148Ab2EBWMN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 18:12:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BFE480BA;
	Wed,  2 May 2012 18:12:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	tsGFz9yNhGs4hiZ/OGE4fvxl2Y=; b=A6Cw6L4GuplPaf6IcY53TmdXazEeCbfmU
	+dkBxXvN4bZPEGlfH622B788cSntA+xOGJelO7yEh8OrRYYDga0PHseEFLq0tsXQ
	UXfUD9ldQfXKPkAu16iJuy1RsApQE0l97WhhGaDnMK62y9ufy12QRAanWzxWlNxv
	dax8sWpfuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=I5n
	KxnacfTpwNwHViFzIYxVGTyAKUOooBXqwQghqbeKRlEqlL6ZsLm5lzpe9q4YmqNB
	uxQvKgVwzhnNRpTIZ3UH9OUZeaai3A0vghOE/WmFsvSjcDAhS3lEoYZVg7CC60NB
	+7CP58qvEdYFienlGCIBMZaHdBE3xMrGmH9PCmGE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 229CC80B9;
	Wed,  2 May 2012 18:12:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B3F380B8; Wed,  2 May 2012
 18:12:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD88EDCC-94A3-11E1-BDF3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196865>

Your filesystem may support hardlinks, but you may choose not to use them
when installing git-foo builtins and favor symblic links or copies for
whatever reason.

The installation procedure of git-gui/ directory is not touched with this
patch and git-citool still ends up being a hardlink to git-gui, but it
needs to be addressed separately.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/Makefile b/Makefile
index e4f8e0e..05d34b3 100644
--- a/Makefile
+++ b/Makefile
@@ -244,6 +244,9 @@ all::
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 #
+# Define NO_INSTALL_HARDLINKS if you prefer to use either symbolic links or
+# copies to install built-in git commands e.g. git-cat-file.
+#
 # Define USE_NED_ALLOCATOR if you want to replace the platforms default
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
@@ -2482,19 +2485,21 @@ endif
 	{ test "$$bindir/" = "$$execdir/" || \
 	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
 		$(RM) "$$execdir/$$p" && \
-		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
+		test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
 		ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
 	  done; \
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
+		test -z "$(NO_INSTALL_HARDLINKS)" && \
 		ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
 		ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
 		cp "$$bindir/git$X" "$$bindir/$$p" || exit; \
 	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
+		test -z "$(NO_INSTALL_HARDLINKS)" && \
 		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
@@ -2502,6 +2507,7 @@ endif
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
 		$(RM) "$$execdir/$$p" && \
+		test -z "$(NO_INSTALL_HARDLINKS)" && \
 		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
