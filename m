Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA6C63799
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F84A6100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384185AbhGSSY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 14:24:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383855AbhGSSN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 14:13:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BC2B148B10;
        Mon, 19 Jul 2021 14:54:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GGhk5TyGSAQy
        PLwHOsYAKhkJqg9fnEa0RHqaWvxhtA8=; b=niwayBJc4IwCZryPTcOnFe1p9iyQ
        ZNWJNOxEwWZfkPRfyvkQ/lVX6vVWVDpYVGBlW6+KecFW/zzlUIEFdQAVUc6dyfmU
        Eg0TwBarrGp7xXYylc4CNIpY+rwWtPBjMGf4/zWPfIVgQqI+9z/a1nRV47GIrLVM
        hhFeCdaqUIvBT+E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2427F148B0E;
        Mon, 19 Jul 2021 14:54:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66F62148B0B;
        Mon, 19 Jul 2021 14:54:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] test-lib-functions: use test-tool for [de]packetize()
References: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
        <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
Date:   Mon, 19 Jul 2021 11:54:32 -0700
In-Reply-To: <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 16 Jul
 2021 17:41:33 +0200")
Message-ID: <xmqqh7gqkuc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C232C93A-E8C2-11EB-AA12-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The shell+perl "[de]packetize()" helper functions were added in
> 4414a150025 (t/lib-git-daemon: add network-protocol helpers,
> 2018-01-24), and around the same time we added the "pkt-line" helper
> in 74e70029615 (test-pkt-line: introduce a packet-line test helper,
> 2018-03-14).
>
> For some reason it seems we've mostly used the shell+perl version
> instead of the helper since then. There were discussions around
> 88124ab2636 (test-lib-functions: make packetize() more efficient,
> 2020-03-27) and cacae4329fa (test-lib-functions: simplify packetize()
> stdin code, 2020-03-29) to improve them and make them more efficient.
>
> There was one good reason to do so, we needed an equivalent of
> "test-tool pkt-line pack", but that command wasn't capable of handling
> input with "\n" (a feature) or "\0" (just because it happens to be
> printf-based under the hood).
>
> Let's add a "pkt-line-raw" helper for that, and expose is at a
> packetize_raw() to go with the existing packetize() on the shell
> level, this gives us the smallest amount of change to the tests
> themselves.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> I ejected changing/adding test code for this v4. This keeps the
> compatibility wrappers and just narrowly changes the things that need
> a packetize_raw() to use that new helper.
>
> I left the simpler packetize() case as a "printf", it could also use
> the test tool, but in case someone cares about process overhead on say
> Windows this entire change should be strictly better than the status
> quo.

Thanks, all.  Will replace.  Let me mark this for 'next'.



> Range-diff against v3:
> 1:  67aa8141153 < -:  ----------- serve tests: add missing "extra delim=
" test
> 2:  64dfd14865c < -:  ----------- serve tests: use test_cmp in "protoco=
l violations" test
> 3:  92bfd8a87b8 < -:  ----------- tests: replace [de]packetize() shell+=
perl test-tool pkt-line
> 4:  9842c85d1f3 ! 1:  546974eed59 tests: replace remaining packetize() =
with "test-tool pkt-line"
>     @@ Metadata
>      Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>     =20
>       ## Commit message ##
>     -    tests: replace remaining packetize() with "test-tool pkt-line"
>     +    test-lib-functions: use test-tool for [de]packetize()
>     =20
>     -    Move the only remaining users of "packetize()" over to "test-t=
ool
>     -    pkt-line", for this we need a new "pack-raw-stdin" subcommand =
in the
>     -    test-tool. The "pack" command takes input on stdin, but splits=
 it by
>     -    "\n", furthermore we'll format the output using C-strings, so =
the
>     -    embedded "\0" being tested for here would cause the string to =
be
>     -    truncated.
>     +    The shell+perl "[de]packetize()" helper functions were added i=
n
>     +    4414a150025 (t/lib-git-daemon: add network-protocol helpers,
>     +    2018-01-24), and around the same time we added the "pkt-line" =
helper
>     +    in 74e70029615 (test-pkt-line: introduce a packet-line test he=
lper,
>     +    2018-03-14).
>     =20
>     -    So we need another mode that just calls packet_write() on the =
raw
>     -    input we got on stdin.
>     +    For some reason it seems we've mostly used the shell+perl vers=
ion
>     +    instead of the helper since then. There were discussions aroun=
d
>     +    88124ab2636 (test-lib-functions: make packetize() more efficie=
nt,
>     +    2020-03-27) and cacae4329fa (test-lib-functions: simplify pack=
etize()
>     +    stdin code, 2020-03-29) to improve them and make them more eff=
icient.
>     +
>     +    There was one good reason to do so, we needed an equivalent of
>     +    "test-tool pkt-line pack", but that command wasn't capable of =
handling
>     +    input with "\n" (a feature) or "\0" (just because it happens t=
o be
>     +    printf-based under the hood).
>     +
>     +    Let's add a "pkt-line-raw" helper for that, and expose is at a
>     +    packetize_raw() to go with the existing packetize() on the she=
ll
>     +    level, this gives us the smallest amount of change to the test=
s
>     +    themselves.
>     =20
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>     =20
>     @@ t/t5411/once-0010-report-status-v1.sh: test_expect_success "proc=
-receive: report
>       		then
>       			printf "%s %s refs/heads/main\0report-status\n" \
>      -				$A $B | packetize
>     -+				$A $B | test-tool pkt-line pack-raw-stdin
>     ++				$A $B | packetize_raw
>       		else
>       			printf "%s %s refs/heads/main\0report-status object-format=3D$=
GIT_DEFAULT_HASH\n" \
>      -				$A $B | packetize
>     -+				$A $B | test-tool pkt-line pack-raw-stdin
>     ++				$A $B | packetize_raw
>       		fi &&
>     - 		test-tool pkt-line pack <<-EOF &&
>     - 		$ZERO_OID $A refs/for/main/topic1
>     + 		printf "%s %s refs/for/main/topic1\n" \
>     + 			$ZERO_OID $A | packetize &&
>     =20
>       ## t/t5562-http-backend-content-length.sh ##
>      @@ t/t5562-http-backend-content-length.sh: test_expect_success 'se=
tup' '
>     @@ t/t5562-http-backend-content-length.sh: test_expect_success 'set=
up' '
>       	{
>       		printf "%s %s refs/heads/newbranch\\0report-status object-forma=
t=3D%s\\n" \
>      -			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
>     -+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" |
>     -+			test-tool pkt-line pack-raw-stdin &&
>     ++			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw
>       		printf 0000 &&
>       		echo "$hash_next" | git pack-objects --stdout
>       	} >push_body &&
>     @@ t/t5570-git-daemon.sh: test_expect_success 'hostname cannot brea=
k out of directo
>       test_expect_success FAKENC 'hostname interpolation works after LF=
-stripping' '
>       	{
>      -		printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" | pack=
etize
>     --		printf "0000"
>     -+		printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" |
>     -+		test-tool pkt-line pack-raw-stdin &&
>     -+		test-tool pkt-line pack <<-\EOF
>     -+		0000
>     -+		EOF
>     ++		printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" | pack=
etize_raw
>     + 		printf "0000"
>       	} >input &&
>     -+
>       	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
>     - 	test-tool pkt-line unpack <output >actual &&
>     +
>     + ## t/test-lib-functions.sh ##
>     +@@ t/test-lib-functions.sh: nongit () {
>     + 	)
>     + } 7>&2 2>&4
>     +=20
>     +-# convert function arguments or stdin (if not arguments given) to=
 pktline
>     +-# representation. If multiple arguments are given, they are separ=
ated by
>     +-# whitespace and put in a single packet. Note that data containin=
g NULs must be
>     +-# given on stdin, and that empty input becomes an empty packet, n=
ot a flush
>     +-# packet (for that you can just print 0000 yourself).
>     ++# These functions are historical wrappers around "test-tool pkt-l=
ine"
>     ++# for older tests. Use "test-tool pkt-line" itself in new tests.
>     + packetize () {
>     + 	if test $# -gt 0
>     + 	then
>     + 		packet=3D"$*"
>     + 		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
>     + 	else
>     +-		perl -e '
>     +-			my $packet =3D do { local $/; <STDIN> };
>     +-			printf "%04x%s", 4 + length($packet), $packet;
>     +-		'
>     ++		test-tool pkt-line pack
>     + 	fi
>     + }
>     +=20
>     +-# Parse the input as a series of pktlines, writing the result to =
stdout.
>     +-# Sideband markers are removed automatically, and the output is r=
outed to
>     +-# stderr if appropriate.
>     +-#
>     +-# NUL bytes are converted to "\\0" for ease of parsing with text =
tools.
>     ++packetize_raw () {
>     ++	test-tool pkt-line pack-raw-stdin
>     ++}
>     ++
>     + depacketize () {
>     +-	perl -e '
>     +-		while (read(STDIN, $len, 4) =3D=3D 4) {
>     +-			if ($len eq "0000") {
>     +-				print "FLUSH\n";
>     +-			} else {
>     +-				read(STDIN, $buf, hex($len) - 4);
>     +-				$buf =3D~ s/\0/\\0/g;
>     +-				if ($buf =3D~ s/^[\x2\x3]//) {
>     +-					print STDERR $buf;
>     +-				} else {
>     +-					$buf =3D~ s/^\x1//;
>     +-					print $buf;
>     +-				}
>     +-			}
>     +-		}
>     +-	'
>     ++	test-tool pkt-line unpack
>     + }
>      =20
>     + # Converts base-16 data into base-8. The output is given as a seq=
uence of
> 5:  7ca83c5a551 < -:  ----------- test-lib-functions.sh: remove unused =
[de]packetize() functions
>
>  t/helper/test-pkt-line.c               | 12 ++++++++
>  t/t5411/once-0010-report-status-v1.sh  |  4 +--
>  t/t5562-http-backend-content-length.sh |  2 +-
>  t/t5570-git-daemon.sh                  |  2 +-
>  t/test-lib-functions.sh                | 38 ++++++--------------------
>  5 files changed, 24 insertions(+), 34 deletions(-)
>
> diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
> index 5e638f0b970..c5e052e5378 100644
> --- a/t/helper/test-pkt-line.c
> +++ b/t/helper/test-pkt-line.c
> @@ -26,6 +26,16 @@ static void pack(int argc, const char **argv)
>  	}
>  }
> =20
> +static void pack_raw_stdin(void)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +	if (strbuf_read(&sb, 0, 0) < 0)
> +		die_errno("failed to read from stdin");
> +	packet_write(1, sb.buf, sb.len);
> +	strbuf_release(&sb);
> +}
> +
>  static void unpack(void)
>  {
>  	struct packet_reader reader;
> @@ -110,6 +120,8 @@ int cmd__pkt_line(int argc, const char **argv)
> =20
>  	if (!strcmp(argv[1], "pack"))
>  		pack(argc - 2, argv + 2);
> +	else if (!strcmp(argv[1], "pack-raw-stdin"))
> +		pack_raw_stdin();
>  	else if (!strcmp(argv[1], "unpack"))
>  		unpack();
>  	else if (!strcmp(argv[1], "unpack-sideband"))
> diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-=
report-status-v1.sh
> index 1233a46eac5..297b10925d5 100644
> --- a/t/t5411/once-0010-report-status-v1.sh
> +++ b/t/t5411/once-0010-report-status-v1.sh
> @@ -28,10 +28,10 @@ test_expect_success "proc-receive: report status v1=
" '
>  		if test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" =3D "sha1=
"
>  		then
>  			printf "%s %s refs/heads/main\0report-status\n" \
> -				$A $B | packetize
> +				$A $B | packetize_raw
>  		else
>  			printf "%s %s refs/heads/main\0report-status object-format=3D$GIT_D=
EFAULT_HASH\n" \
> -				$A $B | packetize
> +				$A $B | packetize_raw
>  		fi &&
>  		printf "%s %s refs/for/main/topic1\n" \
>  			$ZERO_OID $A | packetize &&
> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-back=
end-content-length.sh
> index e5d3d15ba8d..05a58069b0c 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -63,7 +63,7 @@ test_expect_success 'setup' '
>  	hash_next=3D$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
>  	{
>  		printf "%s %s refs/heads/newbranch\\0report-status object-format=3D%=
s\\n" \
> -			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
> +			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw
>  		printf 0000 &&
>  		echo "$hash_next" | git pack-objects --stdout
>  	} >push_body &&
> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index 82c31ab6cd8..b87ca06a585 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -194,7 +194,7 @@ test_expect_success 'hostname cannot break out of d=
irectory' '
> =20
>  test_expect_success FAKENC 'hostname interpolation works after LF-stri=
pping' '
>  	{
> -		printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" | packetize
> +		printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" | packetize=
_raw
>  		printf "0000"
>  	} >input &&
>  	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b2810478a21..e5b80e0f88e 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1453,46 +1453,24 @@ nongit () {
>  	)
>  } 7>&2 2>&4
> =20
> -# convert function arguments or stdin (if not arguments given) to pktl=
ine
> -# representation. If multiple arguments are given, they are separated =
by
> -# whitespace and put in a single packet. Note that data containing NUL=
s must be
> -# given on stdin, and that empty input becomes an empty packet, not a =
flush
> -# packet (for that you can just print 0000 yourself).
> +# These functions are historical wrappers around "test-tool pkt-line"
> +# for older tests. Use "test-tool pkt-line" itself in new tests.
>  packetize () {
>  	if test $# -gt 0
>  	then
>  		packet=3D"$*"
>  		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
>  	else
> -		perl -e '
> -			my $packet =3D do { local $/; <STDIN> };
> -			printf "%04x%s", 4 + length($packet), $packet;
> -		'
> +		test-tool pkt-line pack
>  	fi
>  }
> =20
> -# Parse the input as a series of pktlines, writing the result to stdou=
t.
> -# Sideband markers are removed automatically, and the output is routed=
 to
> -# stderr if appropriate.
> -#
> -# NUL bytes are converted to "\\0" for ease of parsing with text tools=
.
> +packetize_raw () {
> +	test-tool pkt-line pack-raw-stdin
> +}
> +
>  depacketize () {
> -	perl -e '
> -		while (read(STDIN, $len, 4) =3D=3D 4) {
> -			if ($len eq "0000") {
> -				print "FLUSH\n";
> -			} else {
> -				read(STDIN, $buf, hex($len) - 4);
> -				$buf =3D~ s/\0/\\0/g;
> -				if ($buf =3D~ s/^[\x2\x3]//) {
> -					print STDERR $buf;
> -				} else {
> -					$buf =3D~ s/^\x1//;
> -					print $buf;
> -				}
> -			}
> -		}
> -	'
> +	test-tool pkt-line unpack
>  }
> =20
>  # Converts base-16 data into base-8. The output is given as a sequence=
 of
