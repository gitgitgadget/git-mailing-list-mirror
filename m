Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A034C1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 22:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754634AbcIKWKS (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 18:10:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57092 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750912AbcIKWKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 18:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 555493B76D;
        Sun, 11 Sep 2016 18:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HyK8hsBkmiRmHQR2p4RftHFqeg4=; b=wDKZcD
        IxhvWQxvIEdymdDb3fvgywB+gortsF1myN5cJ43ilWwPE17TMnXP+kMPSCcKHP+p
        42vIfhD7bMN4cbnF8+mbXOgg+H1vPToqqqC3MRHikd1qL0JrwEXioExsqjmEGVQa
        l4ES5Y2nj8GiMy0Yp6GKHX4FKj/aftz9MOrOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQugktwA2mQQWHjPNUKPC2ZKksXRtAUX
        lFTwnFyRcwzREkcBNEPd0bHZj0PCNf90BPBdmz8FQ1UEfzG/sj7R8UTavkfhgc/b
        d168kScqLId51zLrhlBK2ufsQoehtiwhDrM1vr5hHjrtpkaRGIKe9hPKpaWj/MoU
        w4VCel9TI+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EFD33B76C;
        Sun, 11 Sep 2016 18:10:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD1AD3B769;
        Sun, 11 Sep 2016 18:10:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaWNykEAZcjZ2Y19j2_3TF+qcz+vb8zSi1U+me3k+06LA@mail.gmail.com>
Date:   Sun, 11 Sep 2016 15:10:13 -0700
In-Reply-To: <CAGZ79kaWNykEAZcjZ2Y19j2_3TF+qcz+vb8zSi1U+me3k+06LA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 9 Sep 2016 16:47:45 -0700")
Message-ID: <xmqqmvje6qbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84A412F2-786C-11E6-A4DA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The plan is to hook the ls-files machinery into
> git-grep as the way of obtaining files to grep for a pattern.

That does not make much sense to me for exactly the same reason why
the "grab the list of paths and run 'git add' on them" example in
the message you are responding to does not make sense.  The use of
the thread-pool would still need to honor the submodule boundary so
that one thread may be assigned files in the top-level superproject
while another may be assigned files in lib/ submodule repository,
and the latter would be doing a rough equivalent of "git -C lib
grep" perhaps with a new option "--output-path-prefix=lib/" that
makes any and all paths that are reported from the command prefixed
with the specified string, so the result of its grepping in Makefile
may be reported as findings in lib/Makefile.

For that, it is not sufficient for the enumeration of paths done in
the top-level to just list lib/Makefile and lib/hello.py along with
Makefile and main.py, is it?  You would somehow need to have a way
to tell that 'lib/' and everything in there is inside a separate
repository.  Without knowing that "lib/" is its own repository, you
would not even know which files under "lib/" hierarchy in the
filesystem are actually tracked files, which you would learn only by
reading lib/.git/index, or what textconv filtering needs to be done
on them, which you would learn only by reading lib/.gitattributes
and/or lib/.git/config.

So a "ls-files" that is done internally in the end-user facing "git
grep --recurse-submodules" needs to be run _without_ recursing
itself at least once to learn "lib/" is a submodule.  A flat "here
are everything we have" does not sound like a good building block.
