Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26DAB207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 17:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942478AbcJFRZ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 13:25:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59975 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942412AbcJFRZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 13:25:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28F1A43B40;
        Thu,  6 Oct 2016 13:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FDEuYWXDTNbALHQUm3VfkiB2t3g=; b=xLvqR9
        5TOV+7wn60B9UPdWhBibEdQq9q86woSYZKS+j2g53S0nYerxWxZZ+LpnPPoNhW8d
        EbZh3h7CGWmBsF498D8ZJKIjDXQKYDj9raiQRFjpvi+YW3gGdG8ainI9j+DkcgdE
        3vAuRda7d0rCz3SSX6VWfD3U8gen92PaIvSA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1HM6WwOfiE9rl+Ll4SykRJly0zbswnh
        NSGofEhtMyz84JEyWf/AQyoYBB5x3Cz1GdeCZaSDxKD5DeNNR3GG/w/qRzx1LrlX
        zsonOyU/UgUHc6lRFWep6B/IfK/yrzsYFsnwvRh6pwlTlzk690tgUjjUn1VYu2bC
        9wqYL4esZog=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2189443B3F;
        Thu,  6 Oct 2016 13:25:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97A1043B3E;
        Thu,  6 Oct 2016 13:25:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 09/14] pkt-line: add packet_write_gently()
References: <20161004125947.67104-1-larsxschneider@gmail.com>
        <20161004125947.67104-10-larsxschneider@gmail.com>
        <xmqqd1jfucwo.fsf@gitster.mtv.corp.google.com>
        <B1968DDD-7EAA-477B-B088-5F2A83F29C8C@gmail.com>
Date:   Thu, 06 Oct 2016 10:25:45 -0700
In-Reply-To: <B1968DDD-7EAA-477B-B088-5F2A83F29C8C@gmail.com> (Lars
        Schneider's message of "Wed, 5 Oct 2016 21:06:23 +0200")
Message-ID: <xmqqy421l78m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB8E3CDC-8BE9-11E6-ACFB-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> You are right. Would the solution below be acceptable?
> I would like to keep the `packet_size` variable as it eases the rest
> of the function.
>
>  
>  	const size_t packet_size = size + 4;
>  
> -	if (packet_size > sizeof(packet_write_buffer))
> +	if (size > sizeof(packet_write_buffer) - 4)
>  		return error("packet write failed - data exceeds max packet size");

Sounds fine; packet_size may have invalid value if size is large
enough but in such a case the function would return without using
it, so no harm is expected, I would say.  I'd prefer to see the
definition of packet_size separate from the assignment of size + 4
to it in a case like this, though.

