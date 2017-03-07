Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DB11FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756490AbdCGXTe (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:19:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53646 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756291AbdCGXTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 18:19:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F6FC7F509;
        Tue,  7 Mar 2017 18:04:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HREid9IGgewVy3PKMczeEqVV5Pk=; b=sAnecl
        KkMG778tv/mfo1Yp9t+iprdW9Tc31wdJHRUWVcwP0fMRmiW3bJ+tMXiwGmRMbUaz
        q1mujSTHjKoaVHRRQSoHTgRhquMC8FPM3RZPHvjQcFQYJ7jEZSSEQkEqPyKHQ9tE
        geg/d6wFbQ4MYRhCyYwMsILMY3LOVgmjIvTqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wVRTf7kNicOD+z6dRahrMD47RBiNTq0+
        A6D6kBYCa/LSjqWE0ZOAySCHSpvM13CsDxk9WOZSXLRjeFwZMSo5oNa1gxW0isHj
        34UT7X0L9ntarbfbsSjfdDo0HQNZHms/N2ubTScy/diawtLnXKYPfhIzzVxC6Htf
        C0FTxxLfdzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 682627F508;
        Tue,  7 Mar 2017 18:04:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B56F67F507;
        Tue,  7 Mar 2017 18:04:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 16/18] entry.c: update submodules when interesting
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-17-sbeller@google.com>
        <xmqqtw746758.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 07 Mar 2017 15:04:07 -0800
In-Reply-To: <xmqqtw746758.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 07 Mar 2017 14:42:27 -0800")
Message-ID: <xmqqy3wg4rko.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC1B5D6-038A-11E7-A2E1-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +			if (!is_submodule_populated_gently(ce->name, &err)) {
>> +				struct stat sb;
>> +				if (lstat(ce->name, &sb))
>> +					die(_("could not stat file '%s'"), ce->name);
>> +				if (!(st.st_mode & S_IFDIR))
>> +					unlink_or_warn(ce->name);
>
> We found that the path ce->name is supposed to be a submodule that
> is checked out, we found that the submodule is not yet populated, we
> tried to make sure what is on that path, and its failure would cause
> us to die().  All that is sensible.
> ...
> But if that unlink fails, shouldn't we die, just like the case where
> we cannot tell what is at the path ce->name?
>
> And if that unlink succeeds, instead of having an empty directory,
> we start the "move-head" call to switch from NULL to ce->oid without
> having any directory.  Wouldn't we want to mkdir() here (and remove
> mkdir() in submodule_move_head() if there is one---if there isn't
> then I do not think this codepath would work)?

In addition to mkdir(), would we also need the .git file that point
into superproject's .git/modules/ too?
