Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F611FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 21:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932160AbcIKVmn (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 17:42:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60570 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753839AbcIKVmm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 17:42:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2EF23E283;
        Sun, 11 Sep 2016 17:42:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JAaQMibklCDNZymBBmW5eNfnV60=; b=ks4Jpf
        eqY0WzhqCWe3IJqhYXDxPtxnL6Lhr4X8YSmZqwA3FvZdWoS8PbuPFwegHVDvmy6M
        kdqaFJaDg0KuwY2b90WkwpRDdDh+BtgVGCb77DusCVIFl/dn69U0cM5+tPSBgjTh
        fXPhTNaptEjsdbGTjH1/6O5Is9Bl2KqD5adRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YxSMWJYHpdcsOa5m5tifj4u6/fWuRUxx
        MsWvb+Vt6XLmp9gmcLOteOs3g1dKXkGLTloRC9o2EC4LvrBMxBGx/LWnfZGcHqcr
        nNVZgYxAIOMmGCJWvASde22yd2lIdjn0+sdn95sN66sQ1nrBMt+NKPLIOya5WCHg
        5QE39cHeKdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C948A3E282;
        Sun, 11 Sep 2016 17:42:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4ED583E281;
        Sun, 11 Sep 2016 17:42:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 06/10] pkt-line: add functions to read/write flush terminated packet streams
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-7-larsxschneider@gmail.com>
        <CAGZ79kYHX6-hhKW_6JEd1hBNi8R+sBY-RjZARfHDMnyLKFZnsQ@mail.gmail.com>
Date:   Sun, 11 Sep 2016 14:42:38 -0700
In-Reply-To: <CAGZ79kYHX6-hhKW_6JEd1hBNi8R+sBY-RjZARfHDMnyLKFZnsQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 8 Sep 2016 14:49:32 -0700")
Message-ID: <xmqq4m5m865t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9EA186C-7868-11E6-AD64-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So as a caller the strbuf is in a different state in case of error
> depending whether
> the strbuf already had some data in it. I think it would be better if
> we only did
> `strbuf_setlen(sb_out, oldlen);` here, such that the caller can
> strbuf_release it
> unconditionally.

If the caller _knows_ that the strbuf is no longer needed, it can
unconditionally call strbuf_release() on it, whether its buffer was
already released or only its length was set to 0, no?

The callee is merely trying to be nice by resetting the strbuf to a
state close to the original in the error return codepath, I would
think.  It may be debatable if such a niceness is needed, but it is
a different matter that does not relate to the burden imposed on the
caller.
