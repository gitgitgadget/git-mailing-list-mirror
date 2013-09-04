From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Wed, 04 Sep 2013 11:23:37 -0700
Message-ID: <xmqqsixkmonq.fsf@gitster.dls.corp.google.com>
References: <cover.1378142795.git.brad.king@kitware.com>
	<cover.1378307529.git.brad.king@kitware.com>
	<ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 20:23:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHHk2-000063-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 20:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445Ab3IDSXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 14:23:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749Ab3IDSXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 14:23:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC9A3FC28;
	Wed,  4 Sep 2013 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WI2ZD1Bd+m01GzLd5KP2q6drgak=; b=PzZv48
	W09SjyH5t0w1q3pGZY0lwYLuRMKLaRkqFGCS82qOseu5rtBKHLeJK5ZWk6LH2yNo
	bKeczpkSqnvT5SXIASCgao3I3ACLnaNuQiXXe8AJmx+jF4QWDxApA2JPKGq4yTQh
	pBQIiSQwgVPYgZ/zhAuHXSVrU31iwqku4ijvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d4uFO8vtxEE6Sp80btbjN6VFlYhNYLbf
	dtPix/jniyleEK9w3ug8jnZMHp6gm/fUlI6OIV5qdzwn5E9TL5iQHlGVz2A8svMF
	lrwVs2cz8KoxCJbendCwz9bxgBVJQJKk5xljQ5/xuwabsEbB88er+lZOSqWZ1k+B
	FLDkOt0pBgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B18E33FC26;
	Wed,  4 Sep 2013 18:23:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCC173FC22;
	Wed,  4 Sep 2013 18:23:39 +0000 (UTC)
In-Reply-To: <ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>
	(Brad King's message of "Wed, 4 Sep 2013 11:22:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F284684-158F-11E3-B87B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233854>

Brad King <brad.king@kitware.com> writes:

> +With `--stdin`, update-ref reads instructions from standard input and
> +performs all modifications together.  Empty lines are ignored.
> +Each non-empty line is parsed as whitespace-separated arguments.

"whitespace-separated" implies that we may allow fields separated
with not a single SP, but with double SPs or even HTs between them.
I personally do not think we should be so loose; it is not like we
are allowing the user to type these from the terminal, so limiting
"separated by a single SP" may be perfectly adequate, and make it
less error prone (e.g. there will not be a confusion "Is 'A SP SP B'
A followed by B, or A followed by an empty string followed by B?").

> +Quote arguments containing whitespace as if in C source code.

Probably "as if they were strings in C source code".

> +Specify updates with lines of the form:
> +
> +	[--no-deref] [--] <ref> <newvalue> [<oldvalue>]
> +
> +Lines of any other format or a repeated <ref> produce an error.
> +Specify a zero <newvalue> to delete a ref and/or a zero <oldvalue>
> +to make sure that a ref not exist.  Use either 40 "0" or the
> +empty string (written as "") to specify a zero value.  Use `-z`
> +to specify input with no whitespace, quoting, or escaping, and
> +terminate each argument by NUL and each line by LF NUL.

This is a somewhat interesting choice of the record terminator. Do
we have a precedent to use LF NUL elsewhere?  If this is the first
such case where we need to express variable number of NUL-separated
fields in a record, I think I am fine with LF NUL (but I am sure
other people would give us a better convention if we ask them
politely ;-)), but I just want to make sure we do it the same way as
other codepaths, if exist, that have to handle this kind of thing.
