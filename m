From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 15:14:17 -0500
Message-ID: <CAPig+cSx2dw7DsZgiebHqZUG7DbnQtpgxKbi2883Z42VajeAJA@mail.gmail.com>
References: <20141209174958.GA26167@peff.net>
	<20141209180916.GA26873@peff.net>
	<xmqqa92wla34.fsf@gitster.dls.corp.google.com>
	<20141210073447.GA20298@peff.net>
	<CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
	<20141210094702.GA8917@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:14:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyneS-0007km-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 21:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbaLJUOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 15:14:20 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:64511 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870AbaLJUOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 15:14:19 -0500
Received: by mail-yh0-f41.google.com with SMTP id a41so1653548yho.14
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 12:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XLi4/BtSjMVy7IgddEoeIWuB0wtp8QBomccJGiSJlBw=;
        b=Sa0KuzPBteIxImqhyJjM4yb3bj8QIpOIb9J6T/jqacqyj23m7oc09l4UKufbe2QA+i
         vU8FEBmCoBD4BTQRcz8elGHyxroPVyASgfMQdzDj8i0n/+A1yKPMqCf07V7v0fCeA8NA
         vEt4iZFInWhT5/h1RI71Gnfvj5sRMxlRAkGflzuWz5Ramy1bhh19TTfz/LgQltPZwpYy
         OXsnTZWmnaqgwb4JGYBXvQyq3Qk/71f5P0Nyh5UuxYpOl03xe+HXJ4Gr/CA8VJr9owpJ
         FWfZ6tca1Sx2fokPXI51D6WKAq4lZ/tKqEfhXzEec6RCVqWF2eS2imtNDaRV2VoON1iy
         4VrQ==
X-Received: by 10.236.206.74 with SMTP id k50mr4925572yho.180.1418242458202;
 Wed, 10 Dec 2014 12:14:18 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Wed, 10 Dec 2014 12:14:17 -0800 (PST)
In-Reply-To: <20141210094702.GA8917@peff.net>
X-Google-Sender-Auth: W4rKUp1XEs_ucvR9N98rffThyWo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261245>

On Wed, Dec 10, 2014 at 4:47 AM, Jeff King <peff@peff.net> wrote:
> Subject: pkt-line: allow writing of LARGE_PACKET_MAX buffers
>
> When we send out pkt-lines with refnames, we use a static
> 1000-byte buffer. This means that the maximum size of a ref
> over the git protocol is around 950 bytes (the exact size
> depends on the protocol line being written, but figure on a sha1
> plus some boilerplate).
>
> This is enough for any sane workflow, but occasionally odd
> things happen (e.g., a bug may create a ref "foo/foo/foo/..."
> accidentally).  With the current code, you cannot even use
> "push" to delete such a ref from a remote.
>
> Let's switch to using a strbuf, with a hard-limit of
> LARGE_PACKET_MAX (which is specified by the protocol).  This
> matches the size of the readers, as of 74543a0 (pkt-line:
> provide a LARGE_PACKET_MAX static buffer, 2013-02-20).
> Versions of git older than that will complain about our
> large packets, but it's really no worse than the current
> behavior. Right now the sender barfs with "impossibly long
> line" trying to send the packet, and afterwards the reader
> will barf with "protocol error: bad line length %d", which
> is arguably better anyway.
>
> Note that we're not really _solving_ the problem here, but
> just bumping the limits. In theory, the length of a ref is
> unbounded, and pkt-line can only represent sizes up to
> 65531 bytes. So we are just bumping the limit, not removing
> it.  But hopefully 64K should be enough for anyone.
>
> As a bonus, by using a strbuf for the formatting we can
> eliminate an unnecessary copy in format_buf_write.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
> index edea9f9..85bcb2e 100755
> --- a/t/t5527-fetch-odd-refs.sh
> +++ b/t/t5527-fetch-odd-refs.sh
> @@ -26,4 +26,37 @@ test_expect_success 'suffix ref is ignored during fetch' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'try to create repo with absurdly long refname' '
> +       ref240=$_z40/$_z40/$_z40/$_z40/$_z40/$_z40

Maybe you want to keep the &&-chain intact here?

> +       ref1440=$ref240/$ref240/$ref240/$ref240/$ref240/$ref240 &&
> +       git init long &&
> +       (
> +               cd long &&
> +               test_commit long &&
> +               test_commit master
> +       ) &&
> +       if git -C long update-ref refs/heads/$ref1440 long; then
> +               test_set_prereq LONG_REF
> +       else
> +               echo >&2 "long refs not supported"
> +       fi
> +'
> +
> +test_expect_success LONG_REF 'fetch handles extremely long refname' '
> +       git fetch long refs/heads/*:refs/remotes/long/* &&
> +       cat >expect <<-\EOF &&
> +       long
> +       master
> +       EOF
> +       git for-each-ref --format="%(subject)" refs/remotes/long >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success LONG_REF 'push handles extremely long refname' '
> +       git push long :refs/heads/$ref1440 &&
> +       git -C long for-each-ref --format="%(subject)" refs/heads >actual &&
> +       echo master >expect &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.2.0.454.g7eca6b7
>
