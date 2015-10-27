From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with gdb
Date: Tue, 27 Oct 2015 09:34:48 -0700
Message-ID: <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
	<20151026191724.GE7881@google.com>
	<alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 17:35:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr7DK-0006Yy-Eu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 17:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbbJ0Qew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 12:34:52 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932394AbbJ0Qeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 12:34:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D09F245D9;
	Tue, 27 Oct 2015 12:34:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9dpZQgf2L58kHgobvrKvS0S3Qr0=; b=orwepl
	gLEyLZQ1Dc17IVI9XiKXwk40pgJpnAxU0/s99fNLfcOjloHlPXRcSoHT0bmQKJ/d
	6ApbTxWABI0z5waFuzMcb0JtnPhQK6OR9eFmKe4oWMz2Vi/9NPMjGqY7y+eKJ9ox
	fm6uXTqADbdMFrbB9eUMgYlHpgUzUlMfy5Yu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HLkR9WbKU1l66w6ud+NqIIEmapiy0va7
	m+mZM8OWNBDshIVBjhL/gq2+QY6XMN7oXwfgXRlCF5ErpwJ7kqOLu/R91xtBj80p
	S6PcdV8hEtV9bXcr7pX54uggEd/HNvJ1xhXjpjtKVLeJ6alTgLoLBVnEHCIr7eFH
	J8ISVQ8erC4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13119245D8;
	Tue, 27 Oct 2015 12:34:50 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 89967245D5;
	Tue, 27 Oct 2015 12:34:49 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 27 Oct 2015 10:42:29 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A441F3CC-7CC8-11E5-ABF6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280268>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Most TEST_ environment variables that git respects are under
>> GIT_TEST_* --- e.g., GIT_TEST_OPTS.  Should this match that pattern
>> as well, for easier debugging with commands like 'env | grep GIT_'?
>
> I dunno. This variable is most useful when inserted into the shell scripts
> in t/ themselves, not when specified via the command line. For example, if
> you have something like
>
> 	test_expect_success '123' '
> 		...
> 		# This Git call somehow fails and I have no clue why
> 		git push remote HEAD
> 		...
> 	'
>
> then prefixing the `git push` command with `TEST_GDB_GIT=1` lets you use
> `gdb` when running the test with the `-i` and `-v` flags.
>
> Please note that `TEST_GDB_GIT` is already a major step up from my initial
> `DDD`.

Yeah, that was my first reaction when I saw this patch.  Instead of
having to munge that line to "gdb -whatever-args git", you can do a
single-shot debugging in a convenient way.  And quite honestly,
because nobody sane will run:

     $ cd t && TEST_GDB_GIT=1 sh ./t1234-frotz.sh

and can drive all the "git" running under gdb at the same time, I
think what you showed would be the _only_ practical use case.  I
would have thought that TEST_GDB_GIT was way too long (and so is
GIT_TEST_GDB) and was about to suggest using something short and
sweet, even shorter than DDD, that you can easily add and remove.

It can be called GDB=1, perhaps?

I agree with all other points Jonathan made in his review, including
"Neat." part ;-)

Thanks.
