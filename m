Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FBF2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbcHHT0p (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 15:26:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752789AbcHHT0m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 15:26:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A412F333DA;
	Mon,  8 Aug 2016 15:26:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y3mv4V85hrymc6ECX/3kj9tYYb4=; b=wgCh42
	XeoPDpd1bEXtur0RAGNQbcta70ImwhBRo3w+uL5twLs339qrp2G7qnSa6jnlH0vp
	1063e1pHhsAApol+U9AN30/ElOfDsWAOl2R2oMuG4P7lWxrCP+Wrnh5EouusiOku
	A2buw7VzjvNPbzttXdtnVeDkLiq/axXi2h9Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v46eVN9kb048vwR8CBMn4UnK7GRNlbjD
	CeGzOOI2A73Pn1aU3VgQBgCCpKe5KgtTzRU9lDkiHtoxydMCd3XwgW9pD/63kilq
	gQRVM1kclKBGakuRgShjZsIpwEDAqZAerSIidzar7TMox6h9xVUhNlkMiaHScPDL
	GLSbmxSuCTA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BAED333D8;
	Mon,  8 Aug 2016 15:26:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F4110333D6;
	Mon,  8 Aug 2016 15:26:35 -0400 (EDT)
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
Date:	Mon, 08 Aug 2016 12:26:33 -0700
In-Reply-To: <20160808181942.GD3995@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Mon, 8 Aug 2016 21:19:42 +0300")
Message-ID: <xmqqoa53dpue.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0584345E-5D9E-11E6-8892-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> ---- 8< ----
> From: Kirill Smelkov <kirr@nexedi.com>
> Subject: [PATCH v3] pack-objects: Teach --use-bitmap-index codepath to respect
>  --local, --honor-pack-keep and --incremental

(Not a question to Kirill)

Hmph.  I suspect that handling of in-body header by mailinfo not
prepared to see RFC2822 header folding.  "am -c" gives a single line
subject with " --local ..." as its first line in the body.

I'll leave it as a low-hanging fruit for somebody to fix ;-)

	Subject: pack-objects: respect --local, etc. when bitmap is in use

might be shorter and more to the point, anyway.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c4c2a3c..e06c1bf 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -944,13 +944,45 @@ static int have_duplicate_entry(const unsigned char *sha1,
>  	return 1;
>  }
>  
> +static int want_found_object(int exclude, struct packed_git *p)
> +{
> +	if (exclude)
> +		return 1;
> +	if (incremental)
> +		return 0;
> +
> +	/*
> +	 * When asked to do --local (do not include an
> +	 * object that appears in a pack we borrow
> +	 * from elsewhere) or --honor-pack-keep (do not
> +	 * include an object that appears in a pack marked
> +	 * with .keep), we need to make sure no copy of this
> +	 * object come from in _any_ pack that causes us to
> +	 * omit it, and need to complete this loop.  When
> +	 * neither option is in effect, we know the object
> +	 * we just found is going to be packed, so break
> +	 * out of the search loop now.
> +	 */

The blame is mine, but "no copy of this object appears in _any_ pack"
would be more correct and easier to read.

This code is no longer in a search loop; its caller is.  Further
rephrasing is needed.  "When asked to do ...these things..., finding
a pack that matches the criteria is sufficient for us to decide to
omit it.  However, even if this pack does not satisify the criteria,
we need to make sure no copy of this object appears in _any_ pack
that makes us to omit the object, so we need to check all the packs.
Signal that by returning -1 to the caller." or something along that
line.

>  /*
>   * Check whether we want the object in the pack (e.g., we do not want
>   * objects found in non-local stores if the "--local" option was used).
>   *
> - * As a side effect of this check, we will find the packed version of this
> - * object, if any. We therefore pass out the pack information to avoid having
> - * to look it up again later.
> + * As a side effect of this check, if object's pack entry was not already found,
> + * we will find the packed version of this object, if any. We therefore pass
> + * out the pack information to avoid having to look it up again later.

The reasoning leading to "We therefore" is understandable, but "pass
out the pack information" is not quite.  Is this meant to explain
the fact that *found_pack and *found_offset are in-out parameters?

The explanation to justify why *found_pack and *found_offset that
used to be out parameters are made in-out parameters belongs to the
log message.  We do not want this in-code comment to explain the
updated code relative to what the code used to do; that is not
useful to those who read the code for the first time in the context
of the committed state.

        /* 
         * Check whether we want to pack the object in the pack (e.g. ...).
         *
         * If the caller already knows an existing pack it wants to
         * take the object from, that is passed in *found_pack and
         * *found_offset; otherwise this function finds if there is
         * any pack that has the object and returns the pack and its
         * offset in these variables.
         */

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 3893afd..e71caa4 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -7,6 +7,19 @@ objpath () {
>  	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
>  }
>  
> +# show objects present in pack ($1 should be associated *.idx)
> +packobjects () {
> +	git show-index <$1 | cut -d' ' -f2
> +}

That is a misleading name for a helper function that produces a list
of objects that were packed.  "list_packed_objects", perhaps.

> +# hasany pattern-file content-file
> +# tests whether content-file has any entry from pattern-file with entries being
> +# whole lines.
> +hasany () {
> +	# NOTE `grep -f` is not portable
> +	git grep --no-index -qFf $1 $2
> +}

I doubt "grep -f pattern_file" is not portable, but in any case, it
is probably a good idea to have this helper function to make the
caller easier to read.  Please name it "has_any", though, and quote
"$1" and "$2" as they are meant to be able to take any filename.

> +test_expect_success 'pack-objects respects --local (non-local loose)' '
> +	mkdir -p alt_objects/pack &&

I'd really really prefer to see an empty repository created for
this.  Even though the original intent was .git/objects/ alone,
i.e. GIT_OBJECT_DIRECTORY can exist without associated refs, we
discovered that it is in general not a good idea (think: "gc").

> +	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
> +	echo content1 >file1 &&
> +	# non-local loose object which is not present in bitmapped pack
> +	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&

Don't say "sha" when you mean "object name".  Otherwise you would
end up introducing funky variable names like $objsha2 we see below
that is confusing (we don't use SHA-2).

> +	# non-local loose object which is also present in bitmapped pack
> +	git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&
> +	git add file1 &&
> +	test_tick &&
> +	git commit -m commit_file1 &&
> +	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
> +	git index-pack 1.pack &&
> +	packobjects 1.idx >1.objects &&
> +	printf "$objsha1\n$blob\n" >nonlocal-loose &&

I think Peff meant to suggest this instead:

	printf "%s\n" "$objsha1" "$blob"

> +	if hasany nonlocal-loose 1.objects; then
> +		echo "Non-local object present in pack generated with --local"
> +		return 1
> +	fi

Just saying

	! has_any nonlocal-loose 1.objects

is sufficient.  Same comment for all other uses of these verbose
output.

Besides, we spell "if/then/fi" like this:

	if condition
        then
        	body
	fi

without a semicolon.

> +test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
> +...
> +	touch .git/objects/pack/pack2-$pack2.keep &&

Please don't do "touch" _unless_ you care about the timestamp of the
file.  Redirect an empty command into it, i.e.

	>.git/objects/pack/pack2-$pack2.keep

or

	echo "reason to keep it" >.git/objects/pack/pack2-$pack2.keep

instead.

> +test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
> +	ls .git/objects/pack/ | grep bitmap >output &&
> +	test_line_count = 1 output &&
> +	packbitmap=$(basename $(cat output) .bitmap) &&
> +	packobjects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
> +	touch .git/objects/pack/$packbitmap.keep &&
> +	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
> +	git index-pack 3a.pack &&
> +	packobjects 3a.idx >3a.objects &&
> +	if hasany packbitmap.objects 3a.objects; then
> +		echo "Object from .keeped bitmapped pack present in pack generated with --honour-pack-keep"
> +		return 1
> +	fi &&
> +	rm .git/objects/pack/$packbitmap.keep

Arrange this removal to happen even when any earlier step fails, so
that later tests will not get affected by stray existence of this
file, by using test_when_finished.  E.g.

	list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
	test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
	>.git/objects/pack/$packbitmap.keep" &&

> +test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
> +	mv .git/objects/pack/$packbitmap.* alt_objects/pack/ &&
> +	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
> +	git index-pack 3b.pack &&
> +	packobjects 3b.idx >3b.objects &&
> +	if hasany packbitmap.objects 3b.objects; then
> +		echo "Non-local object from bitmapped pack present in pack generated with --local"
> +		return 1
> +	fi &&
> +	mv alt_objects/pack/$packbitmap.* .git/objects/pack/

Ditto on potential use of test_when_finished.

