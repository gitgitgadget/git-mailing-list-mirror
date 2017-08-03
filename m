Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369AB1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbdHCUHe (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:07:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61981 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751236AbdHCUHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:07:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DFA88AA49;
        Thu,  3 Aug 2017 16:07:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SnC8q01eDLcr3wr10KOb3mtpa88=; b=NPBgkN
        xBJ6zyZo9d7gXDgHzgJDp2/4j2ASwVpW9Vah3bMJ6AjPkUFqVNbkfnQ7L9jC7j0p
        9yY47D+fMJrwNkO1uBiuSM5+FZW5Tvn9DbYHViil5p6U8iSNM/9R0NCahtvLkKXd
        yHyE5Nv5fcTpFgGZWpB8f2yAvirNXJL8MICwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c+ZQc34RyZRgq8L4dT0cEJg8Fe+WNsbd
        J3SWXjvfqW2X3XvVqhcRSSX9cHT7PXxBMGoW+jImRdius4aycvb24/JlScFGHfU7
        EluHWbAdkypXA/89BXuUrYsyzwg2xHTt0sMnXfc2TsKSOYf0Q6c0KYEJhmDGyM/q
        tftBNb49bRU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36D558AA48;
        Thu,  3 Aug 2017 16:07:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67F108AA47;
        Thu,  3 Aug 2017 16:07:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 19/40] lib-httpd: add upload.sh
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-20-chriscool@tuxfamily.org>
Date:   Thu, 03 Aug 2017 13:07:19 -0700
In-Reply-To: <20170803091926.1755-20-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 3 Aug 2017 11:19:05 +0200")
Message-ID: <xmqq3798xvns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B42AAA6-7887-11E7-93BF-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +OLDIFS="$IFS"
> +IFS='&'
> +set -- $QUERY_STRING
> +IFS="$OLDIFS"
> +
> +while test $# -gt 0
> +do
> +    key=${1%=*}
> +    val=${1#*=}

When you see that ${V%X*} and ${V#*X} appear in a pair for the same
variable V and same delimiter X, it almost always indicates a bug
waiting to happen.

What's the definition of "key" here?  A member of known set of short
tokens, all of which consists only of alphanumeric, or something?
Even if you do not currently plan to deal with a value with '=' in
it, it may be prudent to double '%' above (and do not double '#').

Style: indent your shell script with tabs.

> +
> +    case "$key" in
> +	"sha1") sha1="$val" ;;
> +	"type") type="$val" ;;
> +	"size") size="$val" ;;
> +	"delete") delete=1 ;;
> +	*) echo >&2 "unknown key '$key'" ;;
> +    esac

Indent your shell script with tabs; case/esac and the labels used
for each case arms all align at the same column.

> +
> +    shift
> +done
> +
> +case "$REQUEST_METHOD" in
> +  POST)

Likewise.

> +    if test "$delete" = "1"
> +    then
> +	rm -f "$FILES_DIR/$sha1-$size-$type"
> +    else
> +	mkdir -p "$FILES_DIR"
> +	cat >"$FILES_DIR/$sha1-$size-$type"
> +    fi
> +
> +    echo 'Status: 204 No Content'
> +    echo
> +    ;;
> +
> +  *)
> +    echo 'Status: 405 Method Not Allowed'
> +    echo
> +esac
