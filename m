Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF4C20288
	for <e@80x24.org>; Fri, 21 Jul 2017 14:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbdGUOde (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 10:33:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62279 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753473AbdGUOdd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 10:33:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08E1A98359;
        Fri, 21 Jul 2017 10:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9OJlPcIaId217rGhnvQ4t+lZjac=; b=o55RrE
        NmGXdflQGijU4x6DGT/oNWtPRDMQbIM1QtmYVyicKGjcQthNIXJQNrbJCE0gEqCJ
        mq+6I3mx9wsJzEv3ciNJ7gxWcdee46Cnfla9ty5gOUN+7K+Gdcnf1Ch3o3L2oyJZ
        ORrqb0GUgbIHwdXYl1nVekw7I3/+cLJu7s4wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ruuSmjlf8oPx6FSnP5jJuOPBKMQTvWGu
        nLSENUTqAJUNHgST30RZRjr4RLZBGR7TCUnCRz+a3iJjuKTQd9PfSJmL1R1/ACLj
        YCvCtJtBmf6yTVj1rKyzQc3wrgcg4yp6jPSC2rY0n6dVKTzuGw4atDeG73HsQ3R7
        8+vpkU0PXpw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00F4C98358;
        Fri, 21 Jul 2017 10:33:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E21098357;
        Fri, 21 Jul 2017 10:33:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uwe Hausbrand <uwe.hausbrand@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: fatal: bad numeric config value '60 days' for 'gc.rerereresolved': invalid unit
References: <CAHNyMp8xeye8EvtOdrX34QVCDsBCu3aLQVdyGRTVqyHXjZ4FFQ@mail.gmail.com>
Date:   Fri, 21 Jul 2017 07:33:31 -0700
In-Reply-To: <CAHNyMp8xeye8EvtOdrX34QVCDsBCu3aLQVdyGRTVqyHXjZ4FFQ@mail.gmail.com>
        (Uwe Hausbrand's message of "Fri, 21 Jul 2017 14:59:52 +0200")
Message-ID: <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 923468DA-6E21-11E7-A3D5-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Hausbrand <uwe.hausbrand@gmx.de> writes:

> seems like there is a bug with "git rerere gc" not understanding grace
> periods like "60 days" defined in the config.
>
> What I did:
>
> git config gc.rerereresolved "60 days"

Let's see how the variable is explained in the documentation.

    gc.rerereResolved::
            Records of conflicted merge you resolved earlier are
            kept for this many days when 'git rerere gc' is run.
            The default is 60 days.  See linkgit:git-rerere[1].

Notice that "for this many days" tries to (and probably
unsuccessfully) tell you that this variable is expected to be set to
an integer [*1*], counted in "days".  IOW, you'd want "60" instead.

Having said that, it may not be a bad idea to enumerate these
"expected to be an integer that counts in some unit" variables that
are described in a similar way (i.e. look for "this many" in
Documentation/config.txt), and then for each of them that could be
counted in different unit (e.g. it is not outrageously wrong to
expect that you could specify that rerere records that are older
than 3 months are expired):

 - decide what kind of quantity the variable specifies (e.g. "this
   many days" and "this many seconds" variables are giving a
   "timeperiod").

 - keep the code that reacts to an integer without any unit to
   behave the same (e.g. "[gc] rerereresolved = 30" will keep
   meaning "30 days");

 - extend the code so that when the value given is not an integer,
   it tries to parse it as a specification for the expected quantity
   (e.g. "this many days" and "this many seconds" variables would
   understand if you said "60 days" or "2 months")


[Footnote]

 *1* I think we actually expect a scaled integer whenever we expect
     an integral value, so you probably could say "6k" to specify
     "6,000 days"; "days" not being any of the recognised unit
     suffix like k, M, G, etc. is where "invalid unit" comes from.
