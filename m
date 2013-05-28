From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] test: improve rebase -q test
Date: Tue, 28 May 2013 10:05:04 -0700
Message-ID: <7vvc6311dr.fsf@alter.siamese.dyndns.org>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
	<1369745671-22418-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:05:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNKl-0007BO-Pr
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934903Ab3E1RFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:05:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934848Ab3E1RFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:05:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A6B723DA6;
	Tue, 28 May 2013 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=OmCCypAMm7iovPdycAW4bi+LFP8=; b=ZPPi9D48yq4JFSvvXtC7
	pK7Np9gpzlkkn2EQn1y6IIy2YMFL4E2ofc+tHHx6/YZSYVKNv4Ip2emqMGIV8D9k
	Rv4df3l80XGRMC199VGEsycprHGsWTZGfmfMANOBJVRMM/zP/CMA3E9R92yeDxc/
	l3tHbnasJDsQTBq8aucsU3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gg9VOEijsujGWslpnAdjw7Cu5AtM3We4aB/f+Ly87WERBi
	/B8p4TT9EKy91R42k9wferBMboLDO9E2E/6mTxIjly892zxHnzQPkD3WSC4mlMQh
	iPKHVac//wzxnvK4pWRKAtqQW72QPDE+CaNVmdCRNVIaJtMclua0cHlsol8yk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E9323DA4;
	Tue, 28 May 2013 17:05:06 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F34423DA0;
	Tue, 28 May 2013 17:05:05 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE4F3B98-C7B8-11E2-A59B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225667>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Let's show the output so it's clear why it failed.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t3400-rebase.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index b58fa1a..fb39531 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -185,6 +185,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
>  test_expect_success 'rebase -q is quiet' '
>  	git checkout -b quiet topic &&
>  	git rebase -q master >output.out 2>&1 &&
> +	cat output.out &&
>  	test ! -s output.out
>  '

It is one thing to avoid squelching output that naturally comes out
of command being tested unnecessarily, so that "./txxxx-*.sh -v"
output can be used for debugging.  I however am not sure if adding
"cat" to random places like this is a productive direction for us to
go in.

A more preferrable alternative may be adding something like this to
test-lib.sh and call it from here and elsewhere (there are about 50
places that do "test ! -s <filename>"), perhaps?

        test_must_be_an_empty_file () {
                if test -s "$1"
                then
                        cat "$1"
                        false
                fi
        }
