Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAFBE207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942309AbcJFRG4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 13:06:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58861 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942124AbcJFRGy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 13:06:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A16E43898;
        Thu,  6 Oct 2016 13:06:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PjEXWauIjhjLhnlEErgOIStmKdc=; b=hz/7gX
        M1Rm1f40Y232yTdO+IhD5kB150jkcRhqi+Tnk+7uKzd9R+szRDDxnj4mpZ7Wp8St
        VL+ClquERUhnw8H+ezqrIZNLlhSGUQd6wtmwqGV3TmDZbJYLdvkEbSedImkCI7OT
        n0RprtbIiy2ddWKGgJJyHpTmz0UzrdR2rTc7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SNjZvAp2GcZdScabppQH1xg2V7KKn/Sc
        hFPa4oY8jAC/q0hngBOCpVaCF0FmWgSg9neMM3wrG7TeatCKYihOc9y/Az/itnQC
        s9W3Kd0ZeVNww1e+ATO6FeusJ1hegzrOs+5nanMO4rlW9BeFWvTE3OdtrPD6htVr
        Fz9QLuks5lw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21FF643897;
        Thu,  6 Oct 2016 13:06:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 987DD43896;
        Thu,  6 Oct 2016 13:06:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josef Ridky <jridky@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Feature Request: user defined suffix for temp files created by git-mergetool
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
        <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
        <e3306f5a-1fb3-bd66-48ac-72b75fc7681c@kdbg.org>
        <1214659824.1976049.1475738509473.JavaMail.zimbra@redhat.com>
        <1911899288.2172724.1475757782111.JavaMail.zimbra@redhat.com>
        <255814448.2197583.1475759366093.JavaMail.zimbra@redhat.com>
Date:   Thu, 06 Oct 2016 10:06:50 -0700
In-Reply-To: <255814448.2197583.1475759366093.JavaMail.zimbra@redhat.com>
        (Josef Ridky's message of "Thu, 6 Oct 2016 09:09:26 -0400 (EDT)")
Message-ID: <xmqq7f9lmmol.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47018504-8BE7-11E6-B4B7-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josef Ridky <jridky@redhat.com> writes:

> +	--local=*)
> +		temp_name=${1#--local=}
> +		if [ "$temp_name" != "" ] && [ "$temp_name" != "$REMOTE_NAME" ] && [ "$temp_name" != "$BASE_NAME" ] && [ "$temp_name" != "$BACKUP_NAME" ]
> +		then
> +			LOCAL_NAME=$temp_name
> +		fi

It is not a good idea to ignore an explicit user request without
giving any indication and without giving any explanation.

You may have noticed that we do not say "[ cond ]" in this shell
script (we say "test" instead; see Documentation/CodingGuidelines).

Instead of having such a test all over the place, I'd suggest doing
it outside the loop:

    while test $# != 0
    do
	case "$1" in
	...
	--local=*)
		LOCAL_NAME=${1#--local=} ;;
	--remote=*)                
		REMOTE_NAME=${1#--local=} ;;
	...
        esac
    done
    
    # sanity check _after_ parsing the command line
    case ",$LOCAL_NAME,$REMOTE_NAME,$BASE_NAME,$BACKUP_NAME," in
    *,,*) die "You cannot set --local/remote/... to empty" ;;
    esac
    ... similarly, duplicate check comes here ...

