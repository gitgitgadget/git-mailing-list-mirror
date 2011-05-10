From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] magic pathspec updates
Date: Tue, 10 May 2011 10:07:05 -0700
Message-ID: <7vvcxijxhi.fsf@alter.siamese.dyndns.org>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
 <BANLkTimLsNU0rLHRxxPmzFH_-1U5m3GoCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 19:07:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJqP3-0007Wn-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 19:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab1EJRHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 13:07:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab1EJRHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 13:07:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B65B466D;
	Tue, 10 May 2011 13:09:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ZBhBKsAFV8NjVlC28YBccK1rBuk=; b=A4ZXPM5fw+q/Asvf5CVj
	7PfV5initHxEtoyvGqS1l2sd3pwOorIAw55mp09J9i7Kpj/ElzfCOXpdd75TjCqC
	9sTgAOp2B9BvNpEgfC/z8TxcVBGCER48dddKEvqO7xV5TQbpKLK3qbgDsUFHW821
	o4jz4QJ18j5yY/EQUttSd4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hImw0ntQG2wfyZmf3R0c9BLA+xH66nWkejM6qdkYudfHrv
	5/RppUO4H8BazcKmiTHVChdkIqT8LDSAexASX4FHozO+omWeZwn71BsczLpYpBpv
	RKWXj9eMHpbsazBa0B/odlpfBxZnTT4Vu6CMabQXtC7ULBYl3xyK7m/fVZVHw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 48B1A466C;
	Tue, 10 May 2011 13:09:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A78B466B; Tue, 10 May 2011
 13:09:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C544D56-7B28-11E0-ADE7-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173341>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, May 10, 2011 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This is a series to update the magic pathspec topic, primarily the area
>> around the empty ':' pathspec.
>
> I think you missed git-commit and git-reset. "git commit --include :"
> may get past parse_and_validate_options() (ie. not dying) but later on
> in prepare_index(), there's no pathspec. I did not check very careful
> though.
>
>> Other than that, I think the current code is probably more or less safe to
>> dogfood with known rough edges.
>
> Agreed.

After re-reading the series one more time (including the ones that are
already in next), I think teaching get_pathspec() about a lone ":" was
probably a bad idea. The only reason we might want to say "there is no
pathspec whatsoever" is when a command wants to limit its operation to
the current subdirectory and it changes behaviour when run at the root
level with and without pathspec (e.g. history simplification).

Note that no such command exists in our vocabulary today, so you need
to imagine "git local-log" that acts like "git log" but by default
shows history simplified to explain only the subdirectory you are
currently in, or something.

Such an application can easily notice that argv[] has only a lone ":"
left and do the same thing it does when there is no pathspec, without
affecting other (existing) users of get_pathspec().

But the thing is, we do not have such an application like "local-log"
now, we know we can easily support such commands when needed without
teaching get_pathspec() about a lone ":", and we can be sure that
existing commands that know get_pathspec() will never give them an
empty pathspec if they feed a non-empty argv[] will not be broken by
not teaching get_pathspec() about a lone ":".

I am leaning toward ripping the lone ":" support from the code in
"next". I would also remove ":(icase)" from "next". It was only meant
to be a POC to show how far we could go only by futzing get_pathspec()
function, and was never meant to be a serious implementation of the
feature. It should be re-done after we do deeper conversion and use
the "struct pathspec" interface not "char **" interface.
