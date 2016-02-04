From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 04 Feb 2016 11:43:58 -0800
Message-ID: <xmqqtwlogt1d.fsf@gitster.mtv.corp.google.com>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
	<20160204121437.GF29880@serenity.lan>
	<alpine.DEB.2.20.1602041334450.2964@virtualbox>
	<20160204130111.GG29880@serenity.lan>
	<alpine.DEB.2.20.1602041411520.2964@virtualbox>
	<20160204140609.GH29880@serenity.lan>
	<alpine.DEB.2.20.1602041619430.2964@virtualbox>
	<20160204155316.GI29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:44:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPp4-0001E4-3t
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934191AbcBDToF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:44:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932372AbcBDToB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:44:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D2C2414E0;
	Thu,  4 Feb 2016 14:44:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2SGg0zulRrXJARSgia+w16Ind3M=; b=bYNDjA0J5tUi45W2yEPj
	upYPADxPW4yaSYGpCCmcineGS3ArpftCaSeMh9NMcUUHrlnVTFaBvla4rw80DnB1
	BfZgObBfMMYAbnxsOB9dsPOKzLA1Yk1MNWXklFSgzmcVI7cpgbBhZLnWzsk3R2Pw
	um0pMg9vBr1nl9d7ivYjnr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GBdMQPRAhgj8gK3zmZgOimdlU48ubo6ziw1GFIvgVZNH8E
	RGbeaC2jV5unlAUhZIZyDQi/yNOxu8THbiDR3rSyoXWddPHi5davhtOcLrPGe8Yc
	JuJ1Zgp/fXymcQ+d8UBMkVkR72HK8kva8lDnoLBAa1j9nM25PYyhdr0wIHTb4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5C3B414DD;
	Thu,  4 Feb 2016 14:44:00 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E688C414D8;
	Thu,  4 Feb 2016 14:43:59 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2EB76F8-CB77-11E5-B014-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285485>

Junio C Hamano <gitster@pobox.com> writes:

> One thing I was wondering about the $(( ... )) syntax while reading
> this thread was about the SP around the expression, i.e.
>
> 	var=$(( $term1 * $term2 + $term3 ))
>
> vs
>
> 	var=$(($term1 * $term2 + $term3))
>
> I personally do not have strong preference between the two, but I
> have a vague impression that we preferred the former because
> somebody in the past gave us a good explanation why we should.
>
> "git grep" however seems to tell us that we are not clearly decided
> between the two, so I probably am misremembering it and there is no
> preference either way.

One thing that is somewhat related is that we would want to avoid
writing things like this by mistake:

	var=$((cmd1 && cmd2) | cmd3)

which is not meant to be an arithmetic expansion, but is a command
substitution that happens to have a subshell at the head of the
pipeline.  I think bash gets this right, but some shells (e.g. dash)
tries to parse this as an arithmetic expansion upon seeing "$((" and
fails to parse it, waiting forever until it sees the matching "))".
So we write it like this to make it safer:

	var=$( (cmd1 && cmd2) | cmd3 )

Perhaps having a SP after $(( of a real arithmetic expression, i.e.

	var=$(( ... anything ... ))

makes it easier to tell these two apart?  I dunno.
