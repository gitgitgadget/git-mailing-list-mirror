From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] pretty: Add failing tests: user format ignores
 i18n.logOutputEncoding setting
Date: Tue, 20 Sep 2011 12:12:50 -0700
Message-ID: <7vaa9z6n9p.fsf@alter.siamese.dyndns.org>
References: <7v1uvptjhr.fsf@alter.siamese.dyndns.org>
 <1316506892-6072-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R65kX-0001vr-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab1ITTMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:12:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab1ITTMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:12:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F10045752;
	Tue, 20 Sep 2011 15:12:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=btoItyMEkuz0h4Dy/Fq8MbAk43Y=; b=qw4OhPtkTpDGHVdcAWjI
	FK9KpfIdSGRca9poNJSKiJXaEHv+/QrZetHTauDev6RsCi3NHTlfesdHXqX8APs0
	CMEJITW8k4+xITYYZwxwm9e5iCSexARSiF26cKYAEr2KqfaHixHRXiE87lh0JkAk
	4dLCnqw758GEPwttslX1YBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MZ5LGaz985vAfGzZhRkj+5gKvT0jEZ2FG6/XXAfIwokMAN
	92Txt6xIqdEb+ivH9zMZpti+QfTn2Ix1/8rFWS2bNz2Y3t44AIFjJr2CyHZdaWME
	UveYwpRf6Q2MpDCIcT/pSLH/zHgzMmXtbkdmAfpFIFoT59IfgDN5G//cYXaX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E86155751;
	Tue, 20 Sep 2011 15:12:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79516574F; Tue, 20 Sep 2011
 15:12:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89207202-E3BC-11E0-9C11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181779>

Alexey Shumkin <zapped@mail.ru> writes:

> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> ...
> @@ -48,28 +53,25 @@ head2=$(add_file sm1 foo3)
>  
>  test_expect_success 'modified submodule(forward)' "

As this is [PATCH 1/2], doesn't this patch make this test fail, calling
for test_expect_failure here (and then later in 2/2 to be flipped back to
test_expect_success)?

>  	git diff-index -p --submodule=log HEAD >actual &&
> -	cat >expected <<-EOF &&
> -Submodule sm1 $head1..$head2:
> -  > Add foo3
> -EOF
> +	printf \"Submodule sm1 $head1..$head2:\n\
> +  > Add foo3 ($added foo3)\n\
> +\" > expected &&
>  	test_cmp expected actual
>  "

Hmmm... why printf?  Is it worth to force reviewers wonder what would
happen if any of these $variables happened to have "%" in them?  Are you
benefiting from any printf features that you cannot achieve with the
original cat?

This hunk and others throughout your patch that change cat with here doc
into printf seem to make the tests less legible, at least to me.

Perhaps like this instead, if the "flushed left" of the original looked
ugly to your eyes?

@@ -49,27 +54,25 @@ head2=$(add_file sm1 foo3)
 test_expect_success 'modified submodule(forward)' "
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 $head1..$head2:
-  > Add foo3
-EOF
+	Submodule sm1 $head1..$head2:
+	  > Add foo3 ($added foo3)
+	EOF
 	test_cmp expected actual
 "
