From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mergetool: check return value from read
Date: Fri, 01 Jul 2011 16:11:16 -0700
Message-ID: <7vaacxoauj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 01:11:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcmrs-0002qJ-BI
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 01:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014Ab1GAXLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 19:11:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914Ab1GAXLT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 19:11:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35B7B5133;
	Fri,  1 Jul 2011 19:13:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	+SpO7O9SSOG1B0FEAcAWT4gf8U=; b=nScvnL1qNjx9IAxUQCj3CR+WxW7XHe3iG
	sZm12v6Jbph0xl+MgEYDNvZdMOEc4EX9lreAmgnoxAP4pOHAdrKmQAiPUaNsdqz2
	C5+uVcXinFOAvV8E1+zCka2Gh8bgf6RJyhN0O65XUBMCt9ucMElHXiKNJk2c0k/w
	qe+nZMEtXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=tcU
	5+cGtHVW48FYBZHUzOoEQIG0CJOUQg+1XfGm24AyCg1JrI2+R84MudEhj7/DvMuw
	SM5uItGq/iFm0HlEJEjxqc8Hd0chJfxDY5FoaRa/TH5oHGojQgCzWHdZ4kQOkCYQ
	7NDFM9QwYuyRZVdp6ieZyJHR9VJDh8YvjUDOs3s0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E0B85132;
	Fri,  1 Jul 2011 19:13:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 834EA5131; Fri,  1 Jul 2011
 19:13:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC99B27A-A437-11E0-8C02-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176541>

The process may not even have the standard input open in which case it
will get stuck in an infinite loop to prompt and read nothing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-mergetool.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 3aab5aa..3c157bc 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -100,7 +100,7 @@ resolve_deleted_merge () {
 	else
 	    printf "Use (c)reated or (d)eleted file, or (a)bort? "
 	fi
-	read ans
+	read ans || return 1
 	case "$ans" in
 	    [mMcC]*)
 		git add -- "$MERGED"
@@ -122,7 +122,7 @@ resolve_deleted_merge () {
 resolve_submodule_merge () {
     while true; do
 	printf "Use (l)ocal or (r)emote, or (a)bort? "
-	read ans
+	read ans || return 1
 	case "$ans" in
 	    [lL]*)
 		if ! local_present; then
@@ -249,7 +249,7 @@ merge_file () {
     describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" = true; then
 	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-	read ans
+	read ans || return 1
     fi
 
     if base_present; then
@@ -320,7 +320,7 @@ done
 prompt_after_failed_merge() {
     while true; do
 	printf "Continue merging other unresolved paths (y/n) ? "
-	read ans
+	read ans || return 1
 	case "$ans" in
 
 	    [yY]*)
