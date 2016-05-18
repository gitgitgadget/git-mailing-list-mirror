From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 08:39:06 -0700
Message-ID: <xmqqa8jntlyd.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
	<20160517031353.23707-5-sbeller@google.com>
	<xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ-xf167LiO+zY+B8BTYd-9h7u=dgpL=4tsEJDPgwq8CA@mail.gmail.com>
	<xmqqposkv3c9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 17:39:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33ZR-00076a-5f
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcERPjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:39:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753465AbcERPjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:39:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 542681C6E6;
	Wed, 18 May 2016 11:39:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OY0O3KT67yt8fl/nWUQwhWvSnjM=; b=m+sBxN
	0E3Adpj5kt/krpA7q0aAZrBBt1hss7DckU8UKxAM/vDBNhLkhf/1KFxNzWBU3LRu
	fA2zvV492lN8vagDNmTOgS+wV3Nm2XUBIAdxnKdbgSPdiID8+F2gI495LpsiCPgN
	MkYni04kcGPmQ7T6PFkrR8y+MQ6+nF4GcuyMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rp05EVQUu23rIrakHLY9ll16/2ST74aL
	DnnZ7ujyjQoV+vt5fKzRKp4o+UNiuM8WTcvL1t842SEd0f8uviZSIW/4I5KiqDrL
	ynENGCi/Jn4XcAuwCytHFcUYk7RqFMONFWQ1FzCimFCLmKuxzGpcRaHqjEXgtnU7
	6BCOFCtKXvE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C4131C6E5;
	Wed, 18 May 2016 11:39:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B70C41C6E4;
	Wed, 18 May 2016 11:39:08 -0400 (EDT)
In-Reply-To: <xmqqposkv3c9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 17 May 2016 13:25:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A93F8E16-1D0E-11E6-A163-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294966>

Junio C Hamano <gitster@pobox.com> writes:

> The mention of the possibility is purely as a hint useful for a
> possible enhancement in the far future.  If we ever want to support
> something like this:
>
> 	":(attr-expression (VAR1=VAL1 | VAR1=VAL2) & VAR2)"
>
> you can remember that you can put VAR1 and VAR2 in attr_check to
> grab values for VAR1 and VAR2 (even though VAR1 is mentioned twice
> in the expression), and use them in the evaluation you will perform.
>
>> So for the matching we would need to get the order right, i.e.
>>
>>     const char *inspect_name = git_attr_name(item.attr_match[i].attr);
>>     for (j=0; j <  p.attr_check.check_nr; j++) {
>>         const char *cur_name = git_attr_name(p.attr_check.check[j].attr);
>>         if (!strcmp(inspect_name, cur_name))
>>             break;
>
> You do not strcmp() when you have attributes.  They are interned so
> that you can compare their addresses.  That makes it somewhat
> cheaper.
>
> Once you start "expression over random attributes", you'd need to
> map attr => value somehow.  The format attr_check structure gives
> you, i.e. a list of <attr, value>, is aimed at compactness than
> random hashmap-like access.  If the caller wants a hashmap-like
> access for performance purposes, the caller does that itself.

To expand this a bit, I actually do not think hashmap-like access is
necessary even in such an application.

An implementation of the evaluator, at least a production-quality
one, for the attr expression example shown above is unlikely to keep
the expression in a single string "(VAR1=VAL1 | VAR1=VAL2) & VAR2".
Instead it would use a parse tree with nodes that represent
operators (e.g. OR, AND, "=", etc.)  and terms (e.g. attribute
reference VAR1, VAR2, and constatnts "VAL1", "VAL2") as its internal
representation.

And a node in such a parse tree that refers to an attribute VAR1
would unlikely to keep a "const char *" that is "VAR1".  The node
would have a field that stores an index into the attr_check.check[]
array when the textual expression is "compiled" into a parse tree
and the set of attributes the expression uses (hence it needs to
ask the attributes API about, to prepare attr_check array) is
identified.

When "evaluating" the parse-tree, a node that refers to an attribute
has an index into attr_check.check[] array, so there is no need for
a loop like the one shown above at all.

When "showing" the expression (for debugging purposes), it would
grab the "index into the attr_check.check[] array" from the node,
and the element in that array is an <attr, value> pair, so it can
use git_attr_name() to obtain the attribute name.
