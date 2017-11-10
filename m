Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28D81F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbdKJSGI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:06:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57233 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752625AbdKJSGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:06:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D6869E5C7;
        Fri, 10 Nov 2017 13:06:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N55c1RBAcOQcZpAUKp0xnerG6jg=; b=aXa/j3
        FZT8KElGxqYOys/kGwsAkFJ0cX+IEqJbU8sUGs98r2xdjDjNa0sC1fR2W36jr0gv
        ev4+K4fIEIT5n1rK9OQUXdzdYhIVss0MYpMut4LFqOyPQvdqlGrUE9+Cv814oyYD
        Hl9ZAt6EaMyPAlpFGwkFpZhS2BpcvHEB5v4XE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sHw/7m2I6x+BHsWHZFjIM1eH1Haex2/J
        tIyb4q4uSiH+pgdiAkJi/K9egiiRbZbi9oeCCebZ6eTx+Z2tj6i23rid4iYiitxd
        uEvTCBzTr73PbSI1epgeB78uyf9sOnY0YiMoO54GQ9Z30ZbEj4nUZ3TKeSbhN0Dw
        aOSCewTP+3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 751209E5C6;
        Fri, 10 Nov 2017 13:06:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9857E9E5BE;
        Fri, 10 Nov 2017 13:06:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 5/8] sequencer: don't die in print_commit_summary()
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-6-phillip.wood@talktalk.net>
        <xmqq8tfig1rr.fsf@gitster.mtv.corp.google.com>
        <xmqq7ev2dsv2.fsf@gitster.mtv.corp.google.com>
        <072b0edb-7a30-77f3-2ac5-893c28c0a695@talktalk.net>
Date:   Sat, 11 Nov 2017 03:05:59 +0900
In-Reply-To: <072b0edb-7a30-77f3-2ac5-893c28c0a695@talktalk.net> (Phillip
        Wood's message of "Fri, 10 Nov 2017 14:53:01 +0000")
Message-ID: <xmqqk1yyf1q0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFC13F34-C641-11E7-BC1D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 07/11/17 15:13, Junio C Hamano wrote:
> ...
>> Another possibility perhaps is that the function is safe to reuse
>> already even without this patch, of course ;-).
>> 
> Hmm, maybe it is. Looking at pick_commits() and do_pick_commit() if the
> sequencer dies in print_commit_summary() (which can only happen when
> cherry-picking or reverting) then neither the todo list or the abort
> safety file are updated to reflect the commit that was just made.
> 
> As I understand it print_commit_summary() dies because: (i) it cannot
> resolve HEAD either because some other process is updating it (which is
> bad news in the middle of a cherry-pick); (ii) because something went
> wrong HEAD is corrupt; or (iii) log_tree_commit() cannot read some
> objects. In all those cases dying will leave the sequencer in a sane
> state for aborting - 'git cherry-pick --abort' will rewind HEAD to the
> last successful commit before there was a problem with HEAD or the
> object database. If the user somehow fixes the problem and runs 'git
> cherry-pick --continue' then the sequencer will try and pick the same
> commit again which may or may not be what the user wants depending on
> what caused print_commit_summary() to die.

The above is all good analysis---thanks for your diligence.  Perhaps
some if not all of it can go to the log message?

