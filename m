From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 20:57:09 -0800
Message-ID: <7v8v7fz0ii.fsf@alter.siamese.dyndns.org>
References: <1359183058-51835-1-git-send-email-davvid@gmail.com>
 <20130126121202.GH7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 05:57:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzKJC-0006Bm-Lt
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 05:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab3A0E5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 23:57:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571Ab3A0E5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 23:57:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 365ABBDED;
	Sat, 26 Jan 2013 23:57:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XmqShluML31IkvOQeBa3dQJ8Cuo=; b=REcbXj
	uIu1fXkrvAWOJ3e/NoY0e3lVclVAnbvmrymsBXo5eq7uFid9dWBu8D5bxVRXTmnX
	LAhwd7/k9TTFEX7oxqPuJIj91MFFyJxkEsoUWfoYQ0xzkfkF/IeWWPBe9CzWr/2v
	R1iPITk6OTmqkeiZnWX0cOobeQAdq2cVLJm84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xQYIx5WgXl6OU6ZQ77mdbs5YioSz1T4p
	w6mNgArAJ0rHVmFcjPmxC2HZWAJ46UT4tYRgUh9YuIre+cVmTg5yPhIVq1nqkTQD
	5q/uNLQWfrFb86txq2jqMxt6Wg3CEpOUsiLcKyc+l/6jBgfYv1DalFSD4Jr+F5j2
	q+b+zk7R1BM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 297C8BDEC;
	Sat, 26 Jan 2013 23:57:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4738FBDE8; Sat, 26 Jan 2013
 23:57:11 -0500 (EST)
In-Reply-To: <20130126121202.GH7498@serenity.lan> (John Keeping's message of
 "Sat, 26 Jan 2013 12:12:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0274E302-683E-11E2-9D25-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214676>

John Keeping <john@keeping.me.uk> writes:

> I'm not sure creating an 'include' directory actually buys us much over
> declaring that 'vimdiff' is the real script and the others just source
> it.

Is 'include' really used for such a purpose?  It only houses defaults.sh
as far as I can see.

As that defaults.sh file is used only to define trivially empty
shell functions, I wonder if it is better to get rid of it, and
define these functions in line in git-mergetool--lib.sh.  Such a
change would like the attached on top of the entire series.

 Makefile                       |  6 +-----
 git-mergetool--lib.sh          | 24 ++++++++++++++++++++++--
 mergetools/include/defaults.sh | 22 ----------------------
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 26f217f..f69979e 100644
--- a/Makefile
+++ b/Makefile
@@ -2724,11 +2724,7 @@ install: all
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	$(INSTALL) -m 644 $(filter-out mergetools/include,$(wildcard mergetools/*)) \
-		'$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
-	$(INSTALL) -m 644 mergetools/include/* \
-		'$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
+	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 7ea7510..1d0fb12 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -57,8 +57,28 @@ setup_tool () {
 		return 2
 	fi
 
-	# Load the default functions
-	. "$MERGE_TOOLS_DIR/include/defaults.sh"
+	# Fallback definitions, to be overriden by tools.
+	can_merge () {
+		return 0
+	}
+
+	can_diff () {
+		return 0
+	}
+
+	diff_cmd () {
+		status=1
+		return $status
+	}
+
+	merge_cmd () {
+		status=1
+		return $status
+	}
+
+	translate_merge_tool_path () {
+		echo "$1"
+	}
 
 	# Load the redefined functions
 	. "$MERGE_TOOLS_DIR/$tool"
diff --git a/mergetools/include/defaults.sh b/mergetools/include/defaults.sh
deleted file mode 100644
index 21e63ec..0000000
--- a/mergetools/include/defaults.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-# Redefined by builtin tools
-can_merge () {
-	return 0
-}
-
-can_diff () {
-	return 0
-}
-
-diff_cmd () {
-	status=1
-	return $status
-}
-
-merge_cmd () {
-	status=1
-	return $status
-}
-
-translate_merge_tool_path () {
-	echo "$1"
-}
