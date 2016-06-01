From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify worktrees by basename
Date: Wed, 01 Jun 2016 11:44:14 -0700
Message-ID: <xmqqr3cgycjl.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-3-pclouds@gmail.com>
	<xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 20:44:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8B8N-0001nL-U9
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbcFASor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 14:44:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750740AbcFASoq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 14:44:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 247292124B;
	Wed,  1 Jun 2016 14:44:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zX2pqsSHn+Kk8CFCyYqc/tqQ/ws=; b=hWcMVV
	aQGis2v3eQIN+pgwaVVH5SUaUMQYbAOnuC1KRTfjvpZISyv1QhB9d7OatK98OiSs
	qPP9+uQ0VW5DBgOVVtKvrtAHbzxladqMNuqqKOcmCg169tv+RJvwIhkXcQlCPK9a
	8cah7kzuyUe4GitxFQoH2dDkeQa/b2XapQlvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k/jeIFByrd3W1gPHWRzVChYtutA153hT
	39oFRinFES3RWTHgN/f1+K+GFszNY5848XwVTfEdUToNa0b57q2u1KMs9k7DbHht
	IPZZcOq1lY0VNk5FUQ+Xl9wRY6/Ed0RRe9m1xZFneVLnf3mbfvWssis5bt5MeLoQ
	81wJIn/u4FE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ADDD2124A;
	Wed,  1 Jun 2016 14:44:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98A1F21248;
	Wed,  1 Jun 2016 14:44:16 -0400 (EDT)
In-Reply-To: <CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 1 Jun 2016 20:22:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7D6F384-2828-11E6-9149-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296148>

Duy Nguyen <pclouds@gmail.com> writes:

>> That is, wouldn't you rather see "worktree lock to/foo" work when
>> 'foo' is ambiguous but 'to/foo' is not?
>
> I don't know. I suppose if people have to make `basename $path` the
> same because of some weird build settings, e.g. abc/git and def/git,
> then this basename selection becomes useless.
>
> I had similar thought though, if you only have a worktree named "foo"
> then "fo" or even "f" should be unambiguous and can also identify a
> worktree, similar to short sha-1. But I discarded that idea because of
> the higher chances that typos can select a wrong worktree.

I do not think abbreviation of "foo" down to "fo" is sensible at
all.  I would instead suggest "path-component-wise tail match",
i.e. "to/foo" would match "path/to/foo", "path/TO/FOO" (on fold-case
filesystems), but not "pathto/foo".

> We would
> need to convert or match both '/' and '\' in "to/foo" case because of
> Windows, so it's not much easier than basename().

I never said "easier to implement".  But can this codepath get
backslashed paths in the first place?  I somehow thought that
normalization would happen a lot before the control reaches here.

You'll be calling into fspathcmp() anyway; shouldn't the function
know that '/' and '\' are equivalent on some platforms, or is it
legal to only call fspathcmp() on a single path component without
directory separator?
