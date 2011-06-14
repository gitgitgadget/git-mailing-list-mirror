From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 13:30:47 -0700
Message-ID: <7vaadkkvew.fsf@alter.siamese.dyndns.org>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 22:30:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWaGG-0006Yz-Ib
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 22:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab1FNUav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 16:30:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab1FNUau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 16:30:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D03485E2B;
	Tue, 14 Jun 2011 16:33:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bl3Usgvpp6lAF3Vfb9qI4XprncM=; b=YBD/D/
	ZEGaaTvqSdwrgLIueZOR3CV0Eq0ktSfZS/s2jXIo0yRjTxl3PfEfHmiXP01rozmx
	vUISn8Wu/YW5bJQ6afjCcSu1xUaMDQ085COd3O1muVtIvr9d4woH8xSrNGTkzNwk
	2yJOuMMP/dV97p1UFRm/ph7b5glZ4IGMbE9Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rf83f+XHYHKboQ4iQyw5Q990mvrAcFCD
	5CeV7R0XLP3rwfMXBUlxZ+XJuH1DSdz8JE45osuPlA3BT07DChmh53FWyGB+Q3y9
	wNUrTd0rDyK3iUK8SIB7R3fRIVzw//FWPTpYZ/4tgCBYCf1NZoKx9mui98FAhiWk
	Lp7v/Y9VboM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C72565E2A;
	Tue, 14 Jun 2011 16:33:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B71F5E24; Tue, 14 Jun 2011
 16:33:00 -0400 (EDT)
In-Reply-To: <20110614181821.GA32685@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Jun 2011 14:18:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7ECD4CB0-96C5-11E0-890B-2C88C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175798>

Jeff King <peff@peff.net> writes:

I didn't know it was that easy (primarily because I didn't know zlib had a
ready-to-eat interface to do this).

> +	if (!strcasecmp(ext, "tgz"))
> +		return "--format=tgz";
> +	if (!strcasecmp(ext, "gz") &&
> +	    ext - 4 >= filename &&
> +	    !strcasecmp(ext - 4, "tar.gz"))

Shouldn't this be

	if (!strcasecmp(ext, "gz") && filename < ext - 5 &&
            !strcasecmp(ext - 5, ".tar.gz"))

to exclude "hellotar.gz" and possibly ".tar.gz" ("<=" vs "<")?

> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index cff1b3e..faf2784 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -26,6 +26,7 @@ commit id embedding:
>  
>  . ./test-lib.sh
>  UNZIP=${UNZIP:-unzip}
> +GUNZIP=${GUNZIP:-gunzip}

Just a personal preference but I find myself using "gzip -d" more often
than "gunzip".
