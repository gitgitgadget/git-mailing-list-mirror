From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] t0060: Add test for manipulating symlinks via absolute paths
Date: Mon, 03 Feb 2014 11:52:33 -0800
Message-ID: <xmqqtxcgdldq.fsf@gitster.dls.corp.google.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-2-git-send-email-martinerikwerner@gmail.com>
	<xmqq7g9cf2ty.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, richih@debian.org, tboegi@web.de,
	pclouds@gmail.com, dak@gnu.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:52:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPZf-0001z8-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbaBCTwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:52:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbaBCTwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:52:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C988693C5;
	Mon,  3 Feb 2014 14:52:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7RCYUf3mtFgMttN1SMnwraGNd+w=; b=mvd6Va
	0FORtWyUhku+KkwlyehWTkbnMGHkpcNn++RNQv4UPQcXQVqxPL4Df74zuIcRjeBT
	KM6sCK8C/tX9CBhCFp0HMMnOubZwHi+5YtN9AjtiIGGqjAeNX36OxCjfyAAtt/iQ
	LmE1exMtI5pKJ5xvYXRfSr23CEMXwpCe7c5ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uonIBqwM1/IDGBMrZ9l2mCei0lxADye4
	nfYKmuASL7Bn+Cup7uILJ+1aJNVtjvf1AAtJoz7Ki95nLUaCOXWjamJMjPTjPgpm
	56EnIAHUpoWp0iCqaDwcQKwymYFdlTm8ezkoRNMacbktSYXbeODw8KWh4O218WrX
	S6J7zkkbzqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45AFB693C4;
	Mon,  3 Feb 2014 14:52:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74F9F693C0;
	Mon,  3 Feb 2014 14:52:37 -0500 (EST)
In-Reply-To: <xmqq7g9cf2ty.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 03 Feb 2014 10:50:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BB6D9568-8D0C-11E3-9052-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241462>

Junio C Hamano <gitster@pobox.com> writes:

> Can we have that "git foo $path" to the testsuite as well?  That is
> the breakage we do not want to repeat in the future by regressing.

Something like this, perhaps?

 t/t3004-ls-files-basic.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 8d9bc3c..d93089d 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -36,4 +36,21 @@ test_expect_success 'ls-files -h in corrupt repository' '
 	test_i18ngrep "[Uu]sage: git ls-files " broken/usage
 '
 
+test_expect_success SYMLINKS 'ls-files with symlinks' '
+	mkdir subs &&
+	ln -s nosuch link &&
+	ln -s ../nosuch subs/link &&
+	git add link subs/link &&
+	git ls-files -s link subs/link >expect &&
+	git ls-files -s "$(pwd)/link" "$(pwd)/subs/link" >actual &&
+	test_cmp expect actual &&
+
+	(
+		cd subs &&
+		git ls-files -s link >../expect &&
+		git ls-files -s "$(pwd)/link" >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
