From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH
 compatibility
Date: Mon, 11 Mar 2013 09:41:40 -0700
Message-ID: <7vobepany3.fsf@alter.siamese.dyndns.org>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v38w1c3ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:42:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5nf-00022n-1a
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab3CKQlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 12:41:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab3CKQln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 12:41:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF280AAE8;
	Mon, 11 Mar 2013 12:41:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4cBWisbWfWMAAsdTIzMRFlAG3b4=; b=r05P1n
	vx9cgYejlVA3iXYo+For25HzrXG40V3aUMfEhydmIZeFdh8hu3arLRej7mXdmscr
	XYFQwSCEZvVCh2b2BaCzz2IRppYAJTy4BV9kkSwMDTNCoWMGjbF6z4tH4FDylDLg
	E8/WEeC2Ti6OtRMZo1XahRvXDkaCMfDNgHHXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHAAEQDRg/mtts2uNmrPkyB9XVcM+bME
	rax/L+Acm/VFmc7NaNOZC5YzfYX/u0gh3dKlcFRXNINDw/bxoHDDWFlYE+Aup+Fb
	jwhfX3BnQlLnutFxMx2Y6zAwCc8/5g3KDp4qFeQUp0SuoCuAFCV4gKyc/dElgpO7
	Uvzv1ANULDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C48F9AAE5;
	Mon, 11 Mar 2013 12:41:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12495AAE4; Mon, 11 Mar 2013
 12:41:41 -0400 (EDT)
In-Reply-To: <7v38w1c3ms.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Mar 2013 09:17:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D918AC8-8A6A-11E2-86B5-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217887>

Junio C Hamano <gitster@pobox.com> writes:

> After all, I was right when I said that some implementations may get
> it wrong and we shouldn't use the construct X-<.
>
>> These two instances seem to be the only ones in the file.
>>
>> I'm not sure whether the 2>/dev/null would be needed for the command
>> on the RHS of the && too (git ls-files and git diff-index).
>
> It would not hurt to discard their standard error.

So here is an updated based on your patch.

-- >8 --
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 11 Mar 2013 13:21:27 +0100
Subject: [PATCH] git-completion.bash: zsh does not implement function
 redirection correctly

A recent change added functions whose entire standard error stream
is redirected to /dev/null using a construct that is valid POSIX.1
but is not widely used:

	funcname () {
		funcbody
	} 2>/dev/null

Even though this file is "git-completion.bash", zsh completion
support dot-sources it (instead of asking bash to grok it like tcsh
completion does), and zsh does not implement this redirection
correctly.

With zsh, trying to complete an inexistant directory gave this:

  git add no-such-dir/__git_ls_files_helper:cd:2: no such file or directory: no-such-dir/

It is easy to work around by refraining from using this construct.
The correct thing to do in the longer term may be to stop dot-sourcing
the source meant for bash into zsh, but this patch should suffice as
a band-aid in the meantime.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51b8b3b..3d4cc7c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -300,8 +300,8 @@ __git_index_file_list_filter ()
 __git_ls_files_helper ()
 {
 	# NOTE: $2 is not quoted in order to support multiple options
-	cd "$1" && git ls-files --exclude-standard $2
-} 2>/dev/null
+	cd "$1" 2>/dev/null && git ls-files --exclude-standard $2 2>/dev/null
+}
 
 
 # Execute git diff-index, returning paths relative to the directory
@@ -309,8 +309,8 @@ __git_ls_files_helper ()
 # specified in the second argument.
 __git_diff_index_helper ()
 {
-	cd "$1" && git diff-index --name-only --relative "$2"
-} 2>/dev/null
+	cd "$1" 2>/dev/null && git diff-index --name-only --relative "$2" 2>/dev/null
+}
 
 # __git_index_files accepts 1 or 2 arguments:
 # 1: Options to pass to ls-files (required).
-- 
1.8.2-rc3-271-g00e868e
