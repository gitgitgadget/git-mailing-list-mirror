From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: Honor prepare-commit-msg return code
Date: Wed, 02 Jan 2013 12:40:01 -0800
Message-ID: <7v623f2uam.fsf@alter.siamese.dyndns.org>
References: <1357152170-5511-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 21:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqV7C-0002qJ-SX
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 21:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab3ABUkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 15:40:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab3ABUkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 15:40:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEAF1B6D0;
	Wed,  2 Jan 2013 15:40:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UWkfJcdOn+HTWCiW8u1U2ZszidQ=; b=ufzNJU
	RkDkTce1/bDoahDehApuEOu138szVKM09JTfP2GWDCTg+7yBIPavcZFAAo3ooGRK
	ARcOkBYymwlPYre1JY9Yww598O7BNxiwKPi91UFaUUJBjPXSUZ/wg5bIzTmhpo7p
	MHgDWwJYZiM2QfpwjNbd0i5CZ8wED9T/8djAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=So6Q70fsJcqphUGVPknY1Dg50V/kh6FW
	XeQvluJo3wSmpk+h0JaMw0U0E4qKgAxGnnK/cR7YyXMpTvNfVzKpkAzBXXVbAf35
	3799SNKBso5xLXJEEhF7eG5CpoEgpUD9ikoRs5AOWwV+Se+ezwm9vymkZrdQwGcn
	P/khi5d+J/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE5EB6CE;
	Wed,  2 Jan 2013 15:40:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E849BB6CD; Wed,  2 Jan 2013
 15:40:03 -0500 (EST)
In-Reply-To: <1357152170-5511-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Wed, 2 Jan 2013 19:42:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 960FABFE-551C-11E2-9F40-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212538>

Antoine Pelisse <apelisse@gmail.com> writes:

> prepare-commit-msg hook is run when committing to prepare the log
> message. If the exit-status is non-zero, the commit should be aborted.

I was scratching my head why you CC'ed Jay, until I dug up 65969d4
(merge: honor prepare-commit-msg hook, 2011-02-14).

> +test_expect_success 'with failing hook (merge)' '
> +
> +	git checkout -B other HEAD@{1} &&
> +	echo "more" >> file &&
> +	git add file &&
> +	chmod -x $HOOK &&

I have a feeling that this will break folks without POSIXPERM
prerequisite.

How about doing it this way instead?  This old test script seems to
want a lot of style clean-ups, but I refrained from doing any in
this fixlet.

Thanks.

 t/t7505-prepare-commit-msg-hook.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index bc497bc..3573751 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -172,11 +172,12 @@ test_expect_success 'with failing hook (merge)' '
 	git checkout -B other HEAD@{1} &&
 	echo "more" >> file &&
 	git add file &&
-	chmod -x $HOOK &&
+	rm -f "$HOOK" &&
 	git commit -m other &&
-	chmod +x $HOOK &&
+	write_script "$HOOK" <<-EOF
+	exit 1
+	EOF
 	git checkout - &&
-	head=`git rev-parse HEAD` &&
 	test_must_fail git merge other
 
 '
