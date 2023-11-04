Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C57FF
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cCb3p9LD"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043FD4C
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 18:47:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 587CF1A551;
	Fri,  3 Nov 2023 21:47:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LRmO/lGgdptGokhStx9SPOGU+nDR4BCIORp4Aj
	rc9l0=; b=cCb3p9LDN11lAR9eDffHRRgq52VlzuVLxzB0PgyHpxiODovecGTS4n
	mQWlS9YRhXTex/yKjQ/9/ICVVbQiDBtdpTIcOiOeLKTnFPnopHzNWk6/sDwaRiJ/
	kVeZZxkh0ptpqNwb7cVOO3sh8ELZpif6UbXFGW7G1nqaG1IOyyT7c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 43BE51A550;
	Fri,  3 Nov 2023 21:47:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C88B81A54E;
	Fri,  3 Nov 2023 21:47:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: [PATCH] t: avoid perl's pack/unpack "Q" specifier
In-Reply-To: <20231103162019.GB1470570@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 Nov 2023 12:20:19 -0400")
References: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com>
	<007101da0e65$13e3c170$3bab4450$@nexbridge.com>
	<20231103155220.GA1470570@coredump.intra.peff.net>
	<007c01da0e6f$014e2c30$03ea8490$@nexbridge.com>
	<20231103162019.GB1470570@coredump.intra.peff.net>
Date: Sat, 04 Nov 2023 10:47:30 +0900
Message-ID: <xmqq5y2ii91p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E6EF400-7AB4-11EE-90B7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> +# Some platforms' perl builds don't support 64-bit integers, and hence do not
> +# allow packing/unpacking quadwords with "Q". The chunk format uses 64-bit file
> +# offsets to support files of any size, but in practice our test suite will
> +# only use small files. So we can fake it by asking for two 32-bit values and
> +# discarding the first (most significant) one, which is equivalent as long as
> +# it's just zero.
> +sub unpack_quad {
> +	my $bytes = shift;
> +	my ($n1, $n2) = unpack("NN", $bytes);
> +	die "quad value exceeds 32 bits" if $n1;
> +	return $n2;
> +};

Is this an unnecessary ';' at the end?

> +sub pack_quad {
> +	my $n = shift;
> +	my $ret = pack("NN", 0, $n);
> +	# double check that our original $n did not exceed the 32-bit limit.
> +	# This is presumably impossible on a 32-bit system (which would have
> +	# truncated much earlier), but would still alert us on a 64-bit build
> +	# of a new test that would fail on a 32-bit build (though we'd
> +	# presumably see the die() from unpack_quad() in such a case).
> +	die "quad round-trip failed" if unpack_quad($ret) != $n;
> +	return $ret;
> +}

Nice.  Both sub are done carefully.

>  # read until we find table-of-contents entry for chunk;
>  # note that we cheat a bit by assuming 4-byte alignment and
>  # that no ToC entry will accidentally look like a header.
>  #
>  # If we don't find the entry, copy() will hit EOF and exit
>  # (which should cause the caller to fail the test).
>  while (copy(4) ne $chunk) { }
> -my $offset = unpack("Q>", copy(8));
> +my $offset = unpack_quad(copy(8));
>  
>  # In clear mode, our length will change. So figure out
>  # the length by comparing to the offset of the next chunk, and
> @@ -38,11 +62,11 @@ sub copy {
>  	my $id;
>  	do {
>  		$id = copy(4);
> -		my $next = unpack("Q>", get(8));
> +		my $next = unpack_quad(get(8));
>  		if (!defined $len) {
>  			$len = $next - $offset;
>  		}
> -		print pack("Q>", $next - $len + length($bytes));
> +		print pack_quad($next - $len + length($bytes));
>  	} while (unpack("N", $id));
>  }
