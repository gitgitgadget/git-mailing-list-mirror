From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Mon, 16 Dec 2013 13:32:29 -0800
Message-ID: <xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 22:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsfmH-0002gQ-1e
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 22:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab3LPVcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 16:32:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab3LPVcc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 16:32:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 966F65BF22;
	Mon, 16 Dec 2013 16:32:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t+7i1iZGd7mv7U5b01NmHaAW+gw=; b=ycLtq8
	uffj/9io9+bXxkjNPdEtCqV7KyBQzhzBSE/aeSF5wLDG8X3xn89jYE/nt4KEEBa3
	zJQ7ivJ9UZAGtl0nu1aHxH1f+f0gQPbbgFDDiU7pEt2jCrYDtYy1upqL/ISqmKTD
	VoHid6D1MsUwb5oyq8EtrCBGVB/LLxFvGnfe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MTtAwoGFNbG1uil+ECKLEPNXN574maII
	ipBIiDmYJvtwvyPK4d/WXTfNClUNl+oVflhHs+itPKReJso9IJKxCE1yDAEZysP3
	SQ/RTksRqycqH5eHRUhD0sgW4TgqaeIsPm49SPhmuOole5t1ThTaZXP4udPCQZlq
	ga6tMEG2XrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FC8F5BF21;
	Mon, 16 Dec 2013 16:32:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B32585BF1F;
	Mon, 16 Dec 2013 16:32:30 -0500 (EST)
In-Reply-To: <1387224586-10169-3-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Mon, 16 Dec 2013 15:09:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9171B3AA-6699-11E3-B30A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239369>

Samuel Bronson <naesten@gmail.com> writes:

>  for i in 1 2
>  do
>  	test_expect_success "orderfile using option ($i)" '
>  	git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
>  	test_cmp expect_$i actual
>  '

This funny indentation in the previous step needs to be fixed, and
the added block below should match.

> +
> +	test_expect_success PIPE "orderfile is fifo ($i)" '
> +	rm -f order_fifo &&

> +	mkfifo order_fifo &&
> +	cat order_file_$i >order_fifo &
> +	git diff -O order_fifo --name-only HEAD^..HEAD >actual &&

I think this part can be racy depending on which between cat and
"git diff" are scheduled first, no?  Try running this test under
load and I think you will see it deadlocked.

Besides, the above breaks && chain; even if mkfifo breaks (hence not
allowing cat to run), "git diff" will go ahead and run, no?

> +	test_cmp expect_$i actual
> +'
>  done
>  
>  test_done
