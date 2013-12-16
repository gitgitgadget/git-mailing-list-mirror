From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v3 3/3] diff: Add diff.orderfile configuration variable
Date: Mon, 16 Dec 2013 10:53:56 -0800
Message-ID: <xmqqfvpspqyj.fsf@gitster.dls.corp.google.com>
References: <1387059521-23616-1-git-send-email-naesten@gmail.com>
	<1387059521-23616-4-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 19:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdIr-0004n4-Lm
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 19:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab3LPSyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 13:54:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728Ab3LPSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 13:53:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D7BE5B057;
	Mon, 16 Dec 2013 13:53:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IaYg0u1JE0w8x+eVefeSk78B6lM=; b=XyqVdm
	atnbp3VNERwnE1NOb3IhCcDtUE2ZQ90F31ULbVXjci8sCymykGTPuKoXWw+oSRFj
	7ULOUHeEsUzYq7Hj2bpBjEAlycYdVOnEoylplCBbB960bvTW7chMOc9PvG7u60V1
	Ch3yrSEGBfvEg1BacvfXnGeSa19Qi3bcBrkjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g53EaL8drbccPFc9qyaGhR7Jj+F/Ra4G
	nedvb7d/4PxWPdFWpqgJ/OvLf/EDOZOWRgNzGIUjKHGK47xdF/kpjd3Nqi3yUwTq
	8UR1ftolkOdQ/2od2aFwvf/XX/4QDCE1sH4MEKZKifCBqPUXUOSo0ZMRyG8NXLhp
	wog7YMp7h8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EF865B055;
	Mon, 16 Dec 2013 13:53:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39F2D5B052;
	Mon, 16 Dec 2013 13:53:58 -0500 (EST)
In-Reply-To: <1387059521-23616-4-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Sat, 14 Dec 2013 17:18:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6B8DF272-6683-11E3-9F1E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239343>

Samuel Bronson <naesten@gmail.com> writes:

> diff.orderfile acts as a default for the -O command line option.
>
> [sb: split up aw's original patch; reworked tests and docs]
>
> [FIXME: Relative paths should presumably be interpreted relative to
> repository root; how should this be accomplished?]

Do you mean something like this?

    $ cd docs
    $ edit orderfile
    $ git diff -Oordefile
    $ cd subdir
    $ git diff -O../orderfile

Path-like parameters and values given by the end user should be
relative to the directory where the end user is (i.e. both -O
parameters in the above example name docs/orderfile).  All Git
processes, even the ones that are capable of being run from a
subdirectory, are supposed to first chdir to the top level of the
working tree before doing anything else, and adjust the path-like
things they get from the end user from the command line accordingly.
By the time diffcore_order() to prepare_order() callchain is called,
we certainly should have passed that chdir already, so the value of
the option needs to be prepended with the "prefix" when parsed.

The value specified for the diff.orderfile configuration can just be
a path relative to the top level of the working tree, I think.
