Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0A820988
	for <e@80x24.org>; Wed, 19 Oct 2016 00:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbcJSAkj (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 20:40:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62074 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752528AbcJSAkh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 20:40:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77C1E49F4E;
        Tue, 18 Oct 2016 20:40:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5AmAhUcF31d9c2VZN3B4Hqei9uw=; b=j7jYoG
        w4b64RDreLDBQb+PQ385a/n02nB94D1xcsDYCpwrI6XU5HEUbJMMxfF4r/7nAem7
        U6jid3VZvVeL5nN5FxXrO/96+cYEKCExu8XkMiUtqVvreG9I+F1C7v32WP17dRi3
        Em7hUqRXrvy385SzvyEskcN3CDskX1pgvLEMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e3wPNvWbYk5cy8tF0RS2YV+i8mjKLA7k
        Je1DQyPmT2M9kUBSFtUsW9YS+T28IQBbQc10tG4/kDjEEoyglcdT3lgMZdK7bQdE
        ZkogUqgYGT1FSJBEQNIAKlAeAFeqKLEpEHYWs4CbPswJPqio44mMrsAhgntBZf+f
        L/kMW2o1kf4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FBE349F4D;
        Tue, 18 Oct 2016 20:40:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCDE549F4B;
        Tue, 18 Oct 2016 20:40:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
References: <20161012224109.23410-1-sbeller@google.com>
        <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
        <xmqq8ttr0wny.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbS4mP7sVTCM+QJXTwKsgZ40xvVDng-F3igZnJWLYek0A@mail.gmail.com>
        <CAPc5daVF2HBD2DfP=w2oG-2PMWQ+guXP_onQX+foSgVYH4N1Qg@mail.gmail.com>
        <CAGZ79kbq7m6s5s8OCXFwyonUdiaL3nVNCoGS40xkH2qKCkYzag@mail.gmail.com>
Date:   Tue, 18 Oct 2016 17:40:33 -0700
In-Reply-To: <CAGZ79kbq7m6s5s8OCXFwyonUdiaL3nVNCoGS40xkH2qKCkYzag@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Oct 2016 17:20:53 -0700")
Message-ID: <xmqqbmyhnpby.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A657AEE6-9594-11E6-AB2D-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I am not sure if I see the upside on wrapping a single value except for
> its future proofness,

I do not see anything other than future-proofing, either.  If we
need to touch all the code that uses the attributes to update the
API, I'd prefer to avoid having to do that again in the future.
