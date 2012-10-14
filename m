From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/12] Integrate wildmatch to git
Date: Sat, 13 Oct 2012 22:06:22 -0700
Message-ID: <7vlif9zl2n.fsf@alter.siamese.dyndns.org>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 07:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGcz-00005F-FK
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab2JNFUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 01:20:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab2JNFUT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:20:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A569C6643;
	Sun, 14 Oct 2012 01:20:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=f9oTBwnVSr2JOkOJ12YaL2T/S
	sg=; b=FaVrLNNFuEN7W+TXm6ab4Pi2VI+zstNPTTBuutliFRVOQZrbYPyEWc72a
	cbGAUxVIJxZwgrAGVJc8M6TciQPsDoJsYILuQAphs+0F98KevOBJc/Ms1z0lP2py
	UZUM8xYAAUI3TK1HHo/9raSFL2yHDHInMb7HPqWgP4ui9yKTwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=VV4F8fcRdqa+D4EYAc2
	I++FqAsrfhGGZs/DnPVZyd7NxTqODBEPc+8wBZ57rUjpJ5kDKtXst3kRJyYBD4e6
	ipwJ3irdSmXjR8p6uxL53qsQmcs/tXZNFGrCEqSZdGBLvveye6qSd/NJoqHkhx9k
	ZZ9GskAMBkOtlcaBfJzuzeCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E306642;
	Sun, 14 Oct 2012 01:20:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF92A6641; Sun, 14 Oct 2012
 01:20:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D792DC60-15BE-11E2-A696-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207616>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +++ b/t/t3070-wildmatch.sh
> @@ -0,0 +1,188 @@
> +#!/bin/sh
> +
> +test_description=3D'wildmatch tests'
> +
> +. ./test-lib.sh
> +
> +match() {
> +    if [ $1 =3D 1 ]; then
> +	test_expect_success "wildmatch:    match '$3' '$4'" "
> +	    test-wildmatch wildmatch '$3' '$4'
> +	"
> +    else
> +	test_expect_success "wildmatch: no match '$3' '$4'" "
> +	    ! test-wildmatch wildmatch '$3' '$4'
> +	"
> +    fi
> +    if [ $2 =3D 1 ]; then
> +	test_expect_success "fnmatch:      match '$3' '$4'" "
> +	    test-wildmatch fnmatch '$3' '$4'
> +	"
> +    elif [ $2 =3D 0 ]; then
> +	test_expect_success "fnmatch:   no match '$3' '$4'" "
> +	    ! test-wildmatch fnmatch '$3' '$4'
> +	"
> +#    else
> +#	test_expect_success BROKEN_FNMATCH "fnmatch:       '$3' '$4'" "
> +#	    ! test-wildmatch fnmatch '$3' '$4'
> +#	"
> +    fi

Heh, broken can be two-way.  Either it may succeed matching what it
shouldn't, or it may not match what it should.
