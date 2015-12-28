From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-send-email: do not double-escape quotes from mutt
Date: Mon, 28 Dec 2015 14:34:50 -0800
Message-ID: <xmqqlh8ejj79.fsf@gitster.mtv.corp.google.com>
References: <20151227020810.1450-1-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Dec 28 23:34:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDgNV-0000gm-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 23:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbbL1Wey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 17:34:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752594AbbL1Wew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 17:34:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0CEA382AA;
	Mon, 28 Dec 2015 17:34:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lOooKW3GYaLaWVQA5TMvMjICs+c=; b=E1vQ94
	IBxyIxOo5g1GRo3C0EzkK5ofI0R4RRuY5RqSfVyxWmpawn6acKphrhOE1wsem5gT
	xIzStVdEnuexPm5mDDJLxQw1EZ1WPUcKLfBg4KkHJcImgIW/Wk3T4KVQkwx+Kj4U
	i4dSUejfvdTGsmla4mnaK13GGHg40/uaT5KLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=czmqw84SN+W7A3gb7tT/MVzDMTqroQ3T
	+Eo+FlKA/eKhRP+iq+pyoZ3HMqoTqXFAsT4il7CdtCH1jbflYbc5XYnkXyfI+sYf
	I2J//eZqVVho41V27Q32GrrO4DkXcoLqr7fvSNKJzBD3Skg0YtCHsTub7SSLUNXV
	ohwAgOMCLbE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7198382A9;
	Mon, 28 Dec 2015 17:34:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 295C7382A7;
	Mon, 28 Dec 2015 17:34:51 -0500 (EST)
In-Reply-To: <20151227020810.1450-1-normalperson@yhbt.net> (Eric Wong's
	message of "Sun, 27 Dec 2015 02:08:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 356E2224-ADB3-11E5-B28B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283051>

Eric Wong <normalperson@yhbt.net> writes:

> -			 # commas delimit multiple addresses
> -			$aliases{$alias} = [ split_addrs($addr) ];
> +			# commas delimit multiple addresses
> +			my @addr = split_addrs($addr);
> +
> +			# quotes may be escaped in the file,
> +			# remove them if paired so we do not
> +			# double-escape them later.
> +			s/^\\"(.*)\\"/"$1"/g foreach @addr;
> +			$aliases{$alias} = \@addr

Can one address have two or more double-quoted string pieces in it?
If that is possible, (.*) above might want to become (.*?) or even
([^"]*) to make it less greedy, perhaps?

>  		}}},
>  	mailrc => sub { my $fh = shift; while (<$fh>) {
>  		if (/^alias\s+(\S+)\s+(.*)$/) {
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 3c49536..834d91a 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1527,6 +1527,21 @@ test_expect_success $PREREQ 'cccover adds Cc to all mail' '
>  	test_cover_addresses "Cc"
>  '
>  
> +test_expect_success $PREREQ 'escaped quotes in sendemail.aliasfiletype=mutt' '
> +	clean_fake_sendmail &&
> +	echo "alias sbd \\\"Dot U. Sir\\\" <somebody@example.org>" >.mutt &&
> +	git config --replace-all sendemail.aliasesfile "$(pwd)/.mutt" &&
> +	git config sendemail.aliasfiletype mutt &&
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=sbd \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		outdir/0001-*.patch \
> +		2>errors >out &&
> +	grep "^!somebody@example\.org!$" commandline1 &&
> +	grep -F "To: \"Dot U. Sir\" <somebody@example.org>" out
> +'
> +
>  test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
>  	clean_fake_sendmail &&
>  	echo "alias sbd  somebody@example.org" >.mailrc &&
