Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB581F859
	for <e@80x24.org>; Tue,  9 Aug 2016 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbcHIQwW (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 12:52:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752672AbcHIQwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 12:52:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABCAF31822;
	Tue,  9 Aug 2016 12:52:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fgfbo/e56mSAnz6KAwwjy79z/Sc=; b=ZJdE0V
	o6WXpALCbPYEeGuSSlJGU2X+gVHmeXcxP5pKEtv+t4bDEkmqOTPthUNhsjdIZx1P
	TBu458hPAn5gejAfuJDWrcmZmLEQLBWZOFcoXNLmgdc05Nd0wKNiI+DmD3Hu9vEF
	qmF5kaTeQvlRtkCbkU06Vxow6iYlNZg1+rcvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T/cVbfSwjap9KNzoVBIhcaS5HJ+mymon
	XR1FzmdtrxiiXfDlKTxhdykUmLDFzoUgQxKX9j1KkA6dUM4kv+RM93dPgLbpdHaI
	eLNUKz9N1Y0jM/JSHuJCGa6XbxDyz+qRwsn74EQppV33YUTQD+5mtQ0EiOr87N8z
	U2pzg3U/udo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2B7F3181F;
	Tue,  9 Aug 2016 12:52:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 161C23181E;
	Tue,  9 Aug 2016 12:52:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to respect --local, --honor-pack-keep and --incremental
References: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
	<20160808181942.GD3995@teco.navytux.spb.ru>
	<xmqqoa53dpue.fsf@gitster.mtv.corp.google.com>
	<20160809112123.GA14273@teco.navytux.spb.ru>
Date:	Tue, 09 Aug 2016 09:52:18 -0700
In-Reply-To: <20160809112123.GA14273@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Tue, 9 Aug 2016 14:21:27 +0300")
Message-ID: <xmqqtwetc2bh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A303E662-5E51-11E6-B22A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> Would you please explain why we should not use touch if we do not care
> about timestamps? Simply style?

To help readers.

"touch A" forcess the readers wonder "does the timestamp of A
matter, and if so in what way?" and "does any later test care what
is _in_ A, and if so in what way?"  Both of them is wasting their
time when there is no reason why "touch" should have been used. 

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index cce95d8..44914ac 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -8,16 +8,15 @@ objpath () {
>  }
>  
>  # show objects present in pack ($1 should be associated *.idx)
> -packobjects () {
> -	git show-index <$1 | cut -d' ' -f2
> +pack_list_objects () {
> +	git show-index <"$1" | cut -d' ' -f2
>  }

pack-list-objects still sounds as if you are packing "list objects",
though.  If you are listing packed objects (or objects in a pack),
list-packed-objects (or list-objects-in-pack) reads clearer and more
to the point, at least to me.

> -# hasany pattern-file content-file
> +# has_any pattern-file content-file
>  # tests whether content-file has any entry from pattern-file with entries being
>  # whole lines.
> -hasany () {
> -	# NOTE `grep -f` is not portable
> -	git grep --no-index -qFf $1 $2
> +has_any () {
> +	grep -qFf "$1" "$2"

Omitting "-q" would help those who have to debug breakage in this
test or the code that this test checks.  What test_expect_success
outputs is not shown by default, and running the test script with
"-v" would show them as a debugging aid.

Thanks.
