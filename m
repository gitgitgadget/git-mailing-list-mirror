From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-config: Fix crash when using "-f <relative
 path>" from non-root dir
Date: Tue, 26 Jan 2010 12:02:23 -0800
Message-ID: <7v8wbkzlbk.fsf@alter.siamese.dyndns.org>
References: <201001261602.16876.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:02:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZrcS-0006C8-PD
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 21:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab0AZUCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 15:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106Ab0AZUCd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 15:02:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab0AZUCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 15:02:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 560EF918DF;
	Tue, 26 Jan 2010 15:02:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AcFHWFVtdjny688krpsJL3CaX48=; b=XecdXPkIzgC5/l2y2pM7xau
	/TsonqNvQ9bK1jJ2i6rhUAJiUC0Z9lItBuGiC9IRzQZ0a57d3y42QNDaiW/H+BKJ
	la1Obn8kBh7BqKH2+vRAiUGsaBLoyPaeHi6GCw+3yQ6yqyrx4xzyuIEWZ2e5rQNN
	7a3s9B5lT1TJOAoPYX8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=aVCrpdKp3Mw3tZbJ/7dHEz/s3fYM4DV4D1kCRRl6+ytySsSDD
	r+W+ypuyybm+H1BsT/dD11yBVJ8QH1pHnion3ZjtTgkbLkZMm2XfHmCi2ZxjSofz
	yqMmffExJi5N9nSmASRxnKZxK7XiLF6Gs5rIfxooIYLVn6jfS/9zHqkRbk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22D37918D8;
	Tue, 26 Jan 2010 15:02:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 503D3918D2; Tue, 26 Jan
 2010 15:02:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BB3DB6C8-0AB5-11DF-8C33-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138072>

Johan Herland <johan@herland.net> writes:

> When your current directory is not at the root of the working tree, and you
> use the "-f" option with a relative path, the current code segfaults since
> argv has already been parsed, and argv[2] is now is a NULL pointer.

Strictly speaking, the last sentence is not necessarily true.  argv[2] is
typically beyond the NULL pointer parseopt added to terminate the
resulting list.  E.g. with the attached patch to t1300 (which I will
squash in), argv[0] is ein.bahn, argv[1] is NULL (end of argument list
after parseopt stripped the options from it), and argv[2] is --file.

> This patch replaces the incorrect argv[2] with the variable holding the
> given config file name.
>
> The bug was introduced by d64ec16 (git config: reorganize to use parseopt).
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>
> This is probably v1.7.0 material, and maybe even suitable for 'maint'.
> AFAICS, d64ec16... has been with us since before v1.6.3-rc0.

Yup, this is maint worthy.  Even if argv[2] happens to be non-NULL, it
certainly is not given_config_file at all.

Thanks.

 t/t1300-repo-config.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 43ea283..c81ccf2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -398,6 +398,17 @@ test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
 test_expect_success 'alternative GIT_CONFIG (--file)' \
 	'git config --file other-config -l > output && cmp output expect'
 
+test_expect_success 'refer config from subdirectory' '
+	mkdir x &&
+	(
+		cd x &&
+		echo strasse >expect
+		git config --get --file ../other-config ein.bahn >actual &&
+		test_cmp expect actual
+	)
+
+'
+
 GIT_CONFIG=other-config git config anwohner.park ausweis
 
 cat > expect << EOF
