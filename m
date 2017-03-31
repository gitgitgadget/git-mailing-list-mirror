Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9FA20969
	for <e@80x24.org>; Fri, 31 Mar 2017 15:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbdCaPww (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 11:52:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58174 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933217AbdCaPwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 11:52:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F206479D5A;
        Fri, 31 Mar 2017 11:52:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1BPyw0/4uwBawG29hpfJpyWgV8=; b=LECqTU
        PY25e2yGsZ99eJWjEX+QntShz/W8pVXX5Ja0Wq1lJruXHOD4G2SpZphEQA8vccYY
        UB4CXXINg6E7OV1XeQTvO7fP4ZgMTVDJk6qgBQG21juzejYZsgTDWMke1s7K1+f6
        tGBgwddEt2LfBk0hHidXeFczA+PMIqpdcUxuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=navqsDVYHfvYaa+HveDl8iR0mZhxiQG+
        XeQzEl1/3bW68uXPm5dK7DHi6yx/g+B3hKEYAdhWlo1ZU6HvjSiN2iKon3fRNBpm
        7Bd8SDxcBlEung3dxzdRF56t2dnRG28JrlPw9YRxPZqck6S5yQpqxZzccy5LQT3j
        Sl8xAPgu6eg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E758A79D58;
        Fri, 31 Mar 2017 11:52:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C4A979D57;
        Fri, 31 Mar 2017 11:52:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Terrible bad performance for it blame --date=iso -C -C master -- <file>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
        <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
Date:   Fri, 31 Mar 2017 08:52:48 -0700
In-Reply-To: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de> (Ulrich
        Windl's message of "Fri, 31 Mar 2017 09:30:32 +0200")
Message-ID: <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1735CB0A-162A-11E7-B487-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> I was running "vc-annotate" in Emacs for a file from a large
> repository (>40000 files, a big percentage being binary, about 10
> commits). For the first file the result was presented rather soon, but
> for a second file the command did not finish even after about 10
> minutes!
>
> The file in question is a rather short text file (124 kB), and
> according to git log it has one commit.
>
> While being bored, I did an strace of the command to find out that a
> huge number of files is inspected.

With -C -C the user (vc-annotate?) is asking to inspect huge number
of files, to find if the contents of the file (except for the part
that came from its own previous version) came from other existing
files.  So this is very much expected.

It might not be a bad idea to teach "blame" not to pay attention to
any path that is marked as "-diff" (e.g. binary files) when trying
to see if remaining contents appeared by borrowing from them.  We do
not have that heuristics (yet).
