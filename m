From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH
 compatibility
Date: Mon, 11 Mar 2013 10:23:49 -0700
Message-ID: <7v8v5talzu.fsf@alter.siamese.dyndns.org>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v38w1c3ms.fsf@alter.siamese.dyndns.org> <513E0FB4.40607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 18:24:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF6SR-0001Z0-7t
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 18:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab3CKRXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 13:23:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab3CKRXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 13:23:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61E8FA069;
	Mon, 11 Mar 2013 13:23:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=93zKK6awPob65uAHaFrp5qt4a+g=; b=fZY7B6
	CfL8XLVQirlarNqivELRPUdev0FA5eaag+EBJGbbD8Rp1ayiONDPYZSox+43IGF+
	3kMKtsRwkHTbJKgZUfCgImP38KHH8R9vQihiKl+oUgkdC5E3qDAuz6Y5RuwBLPTP
	lmdw1+MManvBBZbKfg56+gYULTnMvW1372D08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mpa6g8+OTprs/d61pb+E0kCaBV2zIS6Q
	2KFXElO/8oybHVEonNcgAwpMn+p3YyeXKfLXUCbgp6ihRTz45at8spARRkouwZ9r
	x062Q7noVh7PgavCDZYklltX4XJAtf0hagezHFa0nyPzLV+NvRz8D4Y6GTJ5cXqK
	GAnTYFiHsRM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5635AA068;
	Mon, 11 Mar 2013 13:23:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A268A064; Mon, 11 Mar 2013
 13:23:50 -0400 (EDT)
In-Reply-To: <513E0FB4.40607@gmail.com> (Manlio Perillo's message of "Mon, 11
 Mar 2013 18:09:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70AAD2F6-8A70-11E2-AC15-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217895>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Yes, I was plainning to send another patch to fix this (and your other
> suggestion regarding the CDPATH environment variable, if I remember
> correctly),...

Ahh, thanks for reminding me of this.  You are right; these two
functions are broken when the user has CDPATH set, I think.

Here is a reroll.

-- >8 --
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 11 Mar 2013 13:21:27 +0100
Subject: [PATCH] git-completion.bash: zsh does not implement function
 redirection correctly

A recent change added functions whose entire standard error stream
is redirected to /dev/null using a construct that is valid POSIX.1
but is not widely used:

	funcname () {
		cd "$1" && run some command "$2"
	} 2>/dev/null

Even though this file is "git-completion.bash", zsh completion
support dot-sources it (instead of asking bash to grok it like tcsh
completion does), and zsh does not implement this redirection
correctly.

With zsh, trying to complete an inexistant directory gave this:

  git add no-such-dir/__git_ls_files_helper:cd:2: no such file or directory: no-such-dir/

Also these functions use "cd" to first go somewhere else before
running a command, but the location the caller wants them to go that
is given as an argument to them should not be affected by CDPATH
variable the users may have set for their interactive session.

To fix both of these, wrap the body of the function in a subshell,
unset CDPATH at the beginning of the subshell, and redirect the
standard error stream of the subshell to /dev/null.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51b8b3b..430566d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -299,9 +299,12 @@ __git_index_file_list_filter ()
 # the second argument.
 __git_ls_files_helper ()
 {
-	# NOTE: $2 is not quoted in order to support multiple options
-	cd "$1" && git ls-files --exclude-standard $2
-} 2>/dev/null
+	(
+		test -n "${CDPATH+set}" && unset CDPATH
+		# NOTE: $2 is not quoted in order to support multiple options
+		cd "$1" && git ls-files --exclude-standard $2
+	) 2>/dev/null
+}
 
 
 # Execute git diff-index, returning paths relative to the directory
@@ -309,8 +312,11 @@ __git_ls_files_helper ()
 # specified in the second argument.
 __git_diff_index_helper ()
 {
-	cd "$1" && git diff-index --name-only --relative "$2"
-} 2>/dev/null
+	(
+		test -n "${CDPATH+set}" && unset CDPATH
+		cd "$1" && git diff-index --name-only --relative "$2"
+	) 2>/dev/null
+}
 
 # __git_index_files accepts 1 or 2 arguments:
 # 1: Options to pass to ls-files (required).
-- 
1.8.2-rc3-219-ge56455f
