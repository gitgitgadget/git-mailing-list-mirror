Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0313120196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbcGNSRt (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:17:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751098AbcGNSRs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 14:17:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40C5A2B6E1;
	Thu, 14 Jul 2016 14:17:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vGDRKFcoAJlP
	yzrRz+d3aQ2Y47I=; b=c+lSLU0LisTqAx83kLg3opncY3lDiKvI12YenMgc88/K
	x2m7Giz10Wc8ochMK4vCrMN100NrDbTOjrUMvN7o8xLB2eFGiZMYDyYZ5pXnSKmN
	C8jom676oezt3ovcZUvZeqlyEraz4f8qs9J2SK4zlN2WVcTK4Znde1BAbsIcWNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kgwYRA
	pTIfxxU5GuW7Xr+ucU9jx/4XePrbqd11PJZOApfTWaO9UKCpx3NwlJ4Jtx37W+3i
	QDT9B1yqhL/9YbAY7P1V/doA8Cs9cLL4ruitQMDffSYGU37h8VrQclne9m33vvXl
	Mz4qDOhRmiYOztkvZzLmlv6tNgYTVWRCJalXY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 391922B6DF;
	Thu, 14 Jul 2016 14:17:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4BA62B6DE;
	Thu, 14 Jul 2016 14:17:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<18617acb-bcdb-607d-007e-552dabd352cb@web.de>
	<20160622210958.GA24618@kitenet.net>
	<1f76a4d3-68b1-db33-5c7b-dc5ab104a3ef@web.de>
	<20160712222054.GA10128@kitenet.net>
	<af41e13f-0320-2e55-a6ac-3fdb46f0bb35@web.de>
Date:	Thu, 14 Jul 2016 11:17:44 -0700
In-Reply-To: <af41e13f-0320-2e55-a6ac-3fdb46f0bb35@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 14 Jul 2016 04:09:02
 +0200")
Message-ID: <xmqqtwfsqe2f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 43F4D454-49EF-11E6-805D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> There's less redundant work going on than at first seems, because
>> .gitattribute files are only read once and cached. Verified by strace.
>>
> OK, I think I missed that work (not enough time for Git at the moment)
> Junio, please help me out, do we have a cache here now?

The call convert_attrs() makes to the attribute subsystem is:

    git_check_attr(path, NUM_CONV_ATTRS, ccheck)

Conceptually, this call has to do the following, and for the very
first call that is actually what it does:

 1. Read all the relevant attrubutes files.  If you are asking for
    "a/x/1", we need to read $GIT_DIR/info/attributes,
    ".gitattributes", "a/.gitattributes" and "a/x/.gitattributes".

 2. Find matching patterns that cover "a/x/1", and pick up the
    attribute definition from the above.

If you have asked for "a/x/1", it is very likely that you would next
ask for "a/x/2" (think: "git checkout a/x"), and we can realize that
exactly the same set of attributes files apply to that path.  So an
obvious optimization is to cache the result of the first step.

In addition, it is also likely that you would later ask for "a/y/3"
before asking for "b/z/4" (think: "git add .").  A part of the step
1. that was done when you asked for "a/x/1" and then was reused when
you asked for "a/x/2" can further be reused for this request, by
discarding only what was read from "a/x/.gitattributes" and reading
only from "a/y/.gitattributes".

The above two optimizations are done in prepare_attr_stack().

Unfortunately this is one of the three reasons why the attribute
subsystem is not thread-ready.  I.e. there is only one global cache,
so if you spawn two threads to speed up "git add ." by handing paths
[a-m]* to one and [n-z]* to the other, they would thrash the cache
and making it ineffective (even if we protect the cache with mutex,
which obviously has not been done).

I earlier started looking into this, but the effort stalled.  But
for a single-thread use, the attributes read from the filesystem are
cached, and the cache is designed to perform well as long as you
make requests in-order.

To make the attribute look-up thread-ready, the attribute cache
needs to become per-thread.

Orthogonal of the threading issue, there is another posssible
optimization that is not there yet.  The cache can be tied to what
is in ccheck[] to further reduce the size of the cache, making step
2. a lot cheaper.  Currently in step 1. we read and keep everything,
but if we tie the cache to the contents of ccheck[], we can read and
ignore entries we read in step 1. that does not talk about the
attributes ccheck[] is interested in.  My plan is to either

 (1) make the cache per-thread, limit the reading done in 1. to
     ccheck[], but invalidate the cache when a different set of
     attributes are asked; or

 (2) make the cache per <thread, ccheck[]>.
