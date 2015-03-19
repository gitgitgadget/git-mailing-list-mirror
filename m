From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] refs: introduce a "ref paranoia" flag
Date: Thu, 19 Mar 2015 14:31:39 -0700
Message-ID: <xmqqpp84hdxg.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072957.GB25191@peff.net>
	<xmqqbnjoiw4m.fsf@gitster.dls.corp.google.com>
	<20150319210019.GB7775@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:31:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYi2f-0000J3-HS
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbbCSVbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:31:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750852AbbCSVbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:31:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ABAD41D3E;
	Thu, 19 Mar 2015 17:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5DOqh3vtN1WRV9ojmwxjvMuihaA=; b=CZEhYZ
	z1xPn2UjjvNuP1CBqdzrZtNBDrh4itwBZLBM1lZ412zP+iu2uthul7P9J4Oq0TPM
	uV80D7UfdK6S2jV4j4IWN20S7BeXSJjbTUeEa8kt/G3dQPk1KTiXFqNBwdqm2XHP
	kCTsRQDMDyCZ5ppz6QsaPmEqqxJRX4lCdOpWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BF8vCP4GuwSTNM/CfQvFT5l2E2JlzfHx
	heWChs2ZoPnJy6Cm6sZQb9bgok9HWEs8l0oerERuusBYwUTlkQgPamgP+ix5CSr2
	iov4kLUwUOl7TV683bYrMioMRaRgCb4YxFtl7mVASIENajujcZ6pR498Yrb08lnZ
	iak9riawPyw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10F7341D3D;
	Thu, 19 Mar 2015 17:31:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8975341D35;
	Thu, 19 Mar 2015 17:31:40 -0400 (EDT)
In-Reply-To: <20150319210019.GB7775@peff.net> (Jeff King's message of "Thu, 19
	Mar 2015 17:00:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 54BC33E6-CE7F-11E4-8010-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265839>

Jeff King <peff@peff.net> writes:

>> > +	if (ref_paranoia < 0)
>> > +		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
>> > +	if (ref_paranoia)
>> > +		data.flags |= DO_FOR_EACH_INCLUDE_BROKEN;
>> 
>> I am not a big fan of proliferation of interfaces based on
>> environment variables, but hopefully this is isolated enough to
>> become an issue in the future.
>
> I'm not sure which part you don't like.
> 
> We do have to have this variable cross some process boundaries. Only
> "repack" knows whether to turn on paranoia, but "pack-objects" is the
> one that must act on it.
>
> Or is there something else I'm missing?

In general, I do not like the pattern of program A setting an
environment only because it wants to tell program B it spawns
something, because we cannot tell program B that the environment
should be dropped when it calls something else (e.g. user defined
hooks, merge drivers, textconvs, etc.) to prevent end user
invocation of Git commands from honoring it.  Setting GIT_DIR or
GIT_WORK_TREE and having to know when to drop them is not very
pleasant, for example.

I think the use of this pattern is OK in this codepath in which
repack calls pack-objects, and I think I can be persuaded to buy an
argument that there is no harm, or it may even be a good thing, to
run such an end-user program under paranoia mode, if pack-objects
wants to spawn one.
