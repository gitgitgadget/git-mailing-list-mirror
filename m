From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] git.c: make sure we do not leak GIT_* to alias scripts
Date: Tue, 08 Dec 2015 15:55:24 -0800
Message-ID: <xmqq1tawjy1f.fsf@gitster.mtv.corp.google.com>
References: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
	<1449329538-18623-1-git-send-email-pclouds@gmail.com>
	<xmqqzixmm6na.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BHT2+_i4SoG6xv40wGX_gxwZFk=3WYOH196ZiHA7raWQ@mail.gmail.com>
	<20151208172010.GA12886@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:55:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6S6V-00044B-UU
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 00:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbbLHXz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 18:55:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751033AbbLHXz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 18:55:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0975E3264F;
	Tue,  8 Dec 2015 18:55:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHqDG6TPRE0W5OQzAWQA3FT7pZw=; b=mBMgah
	maguhv8uKAkE2NqZxhezHwI1IgNtOkycpNGtC/VWWyYyMnYmRCJczBU5dgZtWxJt
	43xFuFsc4TnYxRR7Fh8qF3gTyVCls5+MhdNuSWknTxZ1tAUEYg89n49IRYtFJPtc
	ogE+LTTaTzknJoSTJJmLEBGHYYeHcf34SeGtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nH6P2N6M59gbK8z1owupraZX2AfASXlk
	v3NYC8paPDtxONUvmM1Q6GrpKwWG4rDvW+JV/zmLg5zvePRNrN4JZLNAsasjcX4+
	fd+aZW5uwEvROEPK9jskMazfNplcOsjDJQ4+jcnGupD34XBt1KYQyeQUfI5tQygx
	jjFvdvZKlwE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 006AF3264E;
	Tue,  8 Dec 2015 18:55:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7905A3264D;
	Tue,  8 Dec 2015 18:55:25 -0500 (EST)
In-Reply-To: <20151208172010.GA12886@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Dec 2015 12:20:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26A6BBD6-9E07-11E5-833B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282180>

Jeff King <peff@peff.net> writes:

> It fails for me when run via "make" (with prove or without) but not as
> "./t0001-init.sh". Looks like extra variables from my config.mak leak
> through:
>
>   $ make t0001-init.sh GIT_TEST_OPTS="-v -i"
>   [...]
>   --- expected    2015-12-08 17:18:06.304699181 +0000
>   +++ actual      2015-12-08 17:18:06.312699180 +0000
>   @@ -9,5 +9,9 @@
>    GIT_MERGE_VERBOSITY
>    GIT_PREFIX
>    GIT_TEMPLATE_DIR
>   +GIT_TEST_GIT_DAEMON
>   +GIT_TEST_HTTPD
>   +GIT_TEST_OPTS
>    GIT_TEXTDOMAINDIR
>    GIT_TRACE_BARE
>   +MAKEFLAGS
>   not ok 6 - No extra GIT_* on alias scripts
>
> Any GIT_TEST_* is allowed through by test-lib.sh.

Also GIT_PROVE_OPTS (which caused false positive for me).

Perhaps grab "env" output outside the alias to create the expected
(instead of a random handcrafted list that you have to maintain as
the test suite evolves), and compare it from within the alias, or
something?
