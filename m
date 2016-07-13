Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0152018F
	for <e@80x24.org>; Wed, 13 Jul 2016 19:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbcGMTdB (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:33:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750739AbcGMTdA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 15:33:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 030302CA78;
	Wed, 13 Jul 2016 15:32:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dW8ThQcDpomu
	Zd4R+4oRFq158nk=; b=nLocuVmgE6+X9Lwc4pAE7IdaupPezKPgBs681BgQUNfq
	VE3iLd77M3/TNqj0zwdZ41yunaBcVTAR7Oas3WUONy8IwTvUQZ7faV7RkdoqwJpT
	IP5OnZnHvH1yrKWeAoNvT+V7odN4CL/zKry0nzsX5lw2cfUnqgnbms0L8lfXVrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jGd5YI
	AzDI5ZJ247ChwrOHEJM0huHb0u7YQ0TV/Z6vLsVPY9VQMRdx/pXzmMrLSvXcF51o
	jA/slFE0ajs83A9E5JP6lRld+1jt7tkDDfHJ/bbmVplb5GWxyzNbiJbtVkLtUfUU
	P0YbmRCvmcTApu9i4BjpgxxbIhfISWl2jhke4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB4D62CA77;
	Wed, 13 Jul 2016 15:32:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 749A42CA76;
	Wed, 13 Jul 2016 15:32:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Benjamin Fritsch <beanie@benle.de>
Cc:	git@vger.kernel.org, Brendan Fosberry <brendan@codeship.com>
Subject: Re: Multiple Keys in ssh-agent, fail to clone
References: <CFA91608-1F29-4631-BABC-258404A62A3B@benle.de>
Date:	Wed, 13 Jul 2016 12:32:46 -0700
In-Reply-To: <CFA91608-1F29-4631-BABC-258404A62A3B@benle.de> (Benjamin
	Fritsch's message of "Wed, 13 Jul 2016 14:56:28 -0400")
Message-ID: <xmqqziplz63l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94C9EABE-4930-11E6-A672-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Benjamin Fritsch <beanie@benle.de> writes:

> I read the Changelog for 2.9 and couldn’t find any reference to changed key handling. Is there anything that I can add to the `git clone` command to get the old behavior?

I do not think this has much to do with the version of Git, unless
you are getting an updated SSH client together with your new version
of Git from whoever distributes it.

And it may not even be related to SSH version.  Did you change your
~/.ssh/config recently by any chance?  I personally do load many
keys (one per destination) in the agent and back when I didn't know
better, I didn't have IdentityFile line per each host, i.e. the last
lines in these two entries were missing in my ~/.ssh/config:

    Host foo.bar.com
      Protocol 2
      User gitolite
      IdentityFile ~/.ssh/foo-bar-com

    Host foo.baz.com
      Protocol 2
      User junio
      IdentityFile ~/.ssh/foo-baz-com

If you try to do "ssh -v -v foo.bar.com" with such a configuration,
you would observe that many keys are "offered" to the other side to
see if it is the one that it recognises, and you end up offering too
many of them before the right one.  An output from such a failing
session of "ssh -v" ends like this for me:

    $ ssh -v foo.bar.com
    ...
    debug1: Offering DSA public key: foo-baz-com
    debug1: Authentications that can continue: publickey
    debug1: Offering RSA public key: xxy-fsa-com
    debug1: Authentications that can continue: publickey
    debug1: Offering DSA public key: github
    debug1: Authentications that can continue: publickey
    debug1: ...
    debug1: Offering RSA public key: gitorious
    debug1: Authentications that can continue: publickey
    Received disconnect from 192.168.1.1: 2: Too many authentication failures for gitolite
    Disconnected from 192.168.1.1

If I do not have "IdentityFile ~/.ssh/foo-bar-com" line for the
"Host foo.bar.com" part, "ssh -v foo.bar.com" cannot know which
one of the keys it has available can be used to authenticate you
with foo.bar.com, so it ends up asking "do you know this key and
would you allow me to access you?" for each and every key.  Having
the line lets it use the appropriate key right at the beginning,
would not leak (they are "public" keys, so "leak" is not that a
serious problem, though) other public keys you have, and your
authentication is likely to succeed.
