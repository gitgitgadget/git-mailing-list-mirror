From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Mon, 28 Jan 2013 21:33:25 -0800
Message-ID: <7vd2wotuxm.fsf@alter.siamese.dyndns.org>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 06:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U03pY-0003CU-KU
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 06:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3A2Fda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 00:33:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab3A2Fd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 00:33:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08AB590F5;
	Tue, 29 Jan 2013 00:33:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58WVfMoNUpxfL1/m/8iB6AjfPu8=; b=gsolYA
	XtVki5+pkdhs+cSdzsAVzlmpdgHhzrv9TJBqPZhuU9X/Ad2dimaDFFh8JMHExVvf
	23nLE1sceuMwSktGJxHsYXwyH5SmYiax4pQAZfm5M7CLaMSHi8HUi5ZJWd9TiD4g
	l6rNnMtSbB6ZjCHxwJ+eSb2H8WIG7A5zdxf0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tW5hcscVwKb300hLIeE3b7Ld++zsEi00
	Dp6MJGz+1g4/bovornpL86Fys3qvHE/M8c9rL1l/tluiUdeeYRW6QiES7qGUPvjt
	ToCp1Zc1TjpOYl8n98syZWrEcx8VRHI04H90zl/LQVLSMgMtcYgzxJLv231sDgEl
	Nfn7o9dyKS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F290690F4;
	Tue, 29 Jan 2013 00:33:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E18E90F3; Tue, 29 Jan 2013
 00:33:27 -0500 (EST)
In-Reply-To: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Tue, 29 Jan 2013 11:35:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 685FB118-69D5-11E2-B0BB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214904>

Duy Nguyen <pclouds@gmail.com> writes:

> :(literal) magic
> ================
>
> This magic is for people who want simple no-globbing pathspec (*). It
> can be used in combination with other magic such as case-insensitive
> matching. Incompatible with :(glob) magic below.
>
> Global option --noglob-pathspecs is added to add :(literal) to
> all. This is very similar to --literal-pathspecs. It just does not
> disable pathspec magic. :(glob) magic overrides this global option.
>
> (*) you can always disable wildcards by quoting them using backslash,
> but that's inconvenient

Have you considered if it may be helpful to have a :(literal) magic
(or any magic in general) that applies only to the first N
characters of the pathspec pattern?

When you are in subdirectory and do a pathspec limited operation,
e.g.

        cd Documentation && git ls-files "*.txt"

we internaly do an equivalent of this:

    (1) first find out the "prefix", e.g. "Documentation/" in this
        case;
    (2) prepend the prefix to user-supplied pathspecs, e.g. yielding
        "Documentation/*.txt" in this case; and
    (3) use the resulting pathspecs to match against full pathnames
        relative to the root of the working tree.

If the prefix had globbing character in it (e.g. we started in a
directory "D*cumentati*n" instead), we still should make sure that
that part matches literally, while allowing the globbing in
user-supplied part of the pathspec (e.g. "*.txt").  In the built in
code, you can work with the struct pathspec directly and mark the
entire prefix part with nowildcard_len field to match literally, but
if the above three-step logic needs to be implemented by a Porcelain
script like old days, they would need to quote glob specials in the
prefix part before appending user-supplied part to form the full
pathspec string.

I personally think we do not need to support something like this:

	prefix=$(git rev-parse --show-prefix)
	n=${#prefix}
        pathspec=":(literal-$n)$prefix$1"

but other aspiring Porcelain script writers may disagree and would
want to have it.  We can always solve it by giving them an easy and
uniform way to get the glob-quoted version of prefix to solve this
particular issue, i.e.

	prefixq=$(git rev-parse --show-prefix-glob-quoted)
        pathspec="$prefixq$1"

but magic that applies only to a substring may have other uses.

If you do not immediately think of any, let's not overengineer this.

Thanks.
