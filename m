From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Disabling credential helper?
Date: Wed, 03 Dec 2014 22:07:54 -0800
Message-ID: <xmqq7fy8uev9.fsf@gitster.dls.corp.google.com>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
	<20141203005953.GB6527@google.com> <20141203012148.GB29427@peff.net>
	<20141203012950.GC6527@google.com> <20141203013607.GA30037@peff.net>
	<20141204013306.GA9406@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 07:08:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwPaB-0005li-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 07:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbaLDGH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 01:07:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750724AbaLDGH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 01:07:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F7C21E637;
	Thu,  4 Dec 2014 01:07:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O+So5F3p6+5modCVuEIWnLAXcAU=; b=k/O3eH
	LLvpHGuBwtnuACnbCCRsh6bznYlzPBKow5PbB7pCX/45GKUYHi476Xj4oio9Mn/s
	3VqwcPgQOBUbtuBWep4E8nvl0LRBz1Rcq+P2xHQtq+7kKUexjL70tcLfGGm1u8o5
	Lnf5PCNLTtQBRF21NVtpckQhoYhmCgOJh0ltk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=icBDa2Iww/afTgBEG2W+j/P+lwmEEPJU
	jXg2M85CJASSWjjvb+Bm8NtaMTDJ/+ob51RMRLGaWVZDvFUGtr0Dr84FY5PszVsM
	joNcWJhgoSWz3jU6zfe0zUhEZYZeZMab7p6hAcqU01j4ExyyNx1/Qe05AQR3B6qo
	lxjDO98568A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 751861E636;
	Thu,  4 Dec 2014 01:07:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD7B11E635;
	Thu,  4 Dec 2014 01:07:55 -0500 (EST)
In-Reply-To: <20141204013306.GA9406@peff.net> (Jeff King's message of "Wed, 3
	Dec 2014 20:33:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3B10196-7B7B-11E4-920E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260728>

Jeff King <peff@peff.net> writes:

>   1. I chose the value-less boolean as a token to reset the list (since
>      it is otherwise an unmeaningful error). The example above shows its
>      use with "-c", but you could also do:
>
>        [credential]
>        helper
>        helper = foo
>
>      in a config file itself.  This is probably rather unintuitive.

For this one, and I suspect all the "multi-valued" ones, I think it
actually is the most sensible syntax (another possiblity is to give
an empty string, assuming that all multi-valued variables we care
about take non-empty string or numeric values), as I do not see a
useful/valid use case for wanting to define boolean multi-valued
variable.

>      If we can accept stomping on an unlikely-used token, something
>      like:
>
>        git -c credential.helper=RESET fetch ...
>
>      is more sensible (and we can argue about the exact token used).

This unfortunately is unlikely to fly well if we are shooting for a
generic mechanism that is applicable for multi-valued ones in
general (your comment 2. below is very much relevant and true).

>      If we can accept new syntax and new config code, something like:
>
>        git -c '!credential.helper' fetch ...
>
>      is probably workable.

I think I suggested exactly this syntax (and "[credential] !helper"
in the config file) when this was brought up the last time, but it
was shot down because that would make the resulting configuration
file unparsable (not just ignored) by existing versions of Git.

But perhaps it is a good thing to break existing parser when "clear
the variable settings seen so far" is used.  It would not do us very
good to allow existing implementations to ignore it and continue as
if all other entries (and special token like RESET) matter will
silently give users incorrect result.
