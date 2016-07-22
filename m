Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE6A203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbcGVVkC (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 17:40:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751230AbcGVVkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 17:40:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A649D2D9EF;
	Fri, 22 Jul 2016 17:39:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iQ5+pL3VleEZqqJzHRZVTUA7PsQ=; b=YFIm6m
	ZT5Wzi4sqKGtSWYDpCHgURq1WNmeL41CO7db+WTrGLc22CtlLDCw318XuxxrSfDA
	ROd6NqYng2aRcl9Vm536xkWU6G7oH1wNEGwXPuEVX7CpFp2CI8hZf3Prs1V6BkLD
	3CO3nJZ/MTAsM+H2Q8+xY7N20maJI0rRGBf8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QHuRxK5lzbgNc7OLHBdW34gNC8i9BO0K
	HdAkQv57l662moB/jLbkcGj2NL6kAegTguS9l6GQSDUNdSrYAOW/+fqFvlkUs6Xg
	E/pEaZhy53HcezL/fv5DuEZpoouIEc5seggYAZMXg3+NWKSbvi4TevR23+iheSnH
	eIGjpI8Vb9s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D5322D9EE;
	Fri, 22 Jul 2016 17:39:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24FD62D9ED;
	Fri, 22 Jul 2016 17:39:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, peff@peff.net, jnareb@gmail.com, tboegi@web.de
Subject: Re: [PATCH v1 0/3] Git filter protocol
References: <20160722154900.19477-1-larsxschneider@gmail.com>
Date:	Fri, 22 Jul 2016 14:39:57 -0700
In-Reply-To: <20160722154900.19477-1-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 22 Jul 2016 17:48:57
	+0200")
Message-ID: <xmqqshv18i8i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6BDEBAC-5054-11E6-997D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com writes:

> The first two patches are cleanup patches which are not really necessary
> for the feature.

These two looked trivially good.

I think I can agree with what 3/3 wants to do in principle, but

 * "protocol" is not quite the right word.  The current way to
   interact with clean and smudge filters can be considered using a
   different "protocol", that conveys the data and the options via
   the command line and pipe.  The most distinguishing feature that
   differentiates the old way and the new style this change allows
   is that it allows you to have a single instance of the process
   running that can be reused?

 * I am not sure what's the pros-and-cons in forcing people writing
   a single program that can do both cleaning and smudging.  You
   cannot have only "smudge" side that uses the long-running process
   while "clean" side that runs single-shot invocation with this
   design, which I'd imagine would be a downside.  If you are going
   to use a long-running process interface for both sides, this
   design allows you to do it with fewer number of processes, which
   may be an upside.

 * The way the serialized access to these long-running processes
   work in 3/3 would make it harder or impossible to later
   parallelize conversion?  I am imagining a far future where we
   would run "git checkout ." using (say) two threads, one
   responsible for active_cache[0..active_nr/2] and the other
   responsible for the remainder.

> You will notice that I do not check the exact number of "clean" filter
> invocations in the tests.

That is a good thing to do.  You shouldn't really care for the
proper operation of the feature, reducing the number of them would
be an independent topic (see the work of Peff earlier today), and we
may even find a need to make _more_ calls for correctness (again,
see the work of Peff earlier today -- to a person who wants to keep
the number of requests to the attribute system low, the change may
look like a regression, but it is necessary for the overall system;
you may find a similar need to running "clean" more for some need of
the overall system that you do not anticipate right now).

