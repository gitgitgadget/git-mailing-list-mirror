From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] attr.c: always pass check[] to collect_some_attrs()
Date: Thu, 09 Jun 2016 11:15:02 -0700
Message-ID: <xmqq37omi5zt.fsf@gitster.mtv.corp.google.com>
References: <20160608225818.726-1-gitster@pobox.com>
	<20160608225818.726-6-gitster@pobox.com>
	<CAGZ79kbWygHWVhcn9du8P15i2okvFgvt2VPdamHCf2Bvm-n0fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 20:15:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB4UP-0000CQ-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 20:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbcFISPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 14:15:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932790AbcFISPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 14:15:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4546F21053;
	Thu,  9 Jun 2016 14:15:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ujlZn0AtpNgK6UEESqFuhMuBdk0=; b=Hnk4mf
	GQWVYdW+zGmz0Sxp97150gG/3GQEH0wJKIaNtroSv8FSNHocKZDz/GuwTpDQG17X
	Ezn0oyT0ti5ahkkG7L54+6B9cPjPO+HrQJdDU+EPVptbIA+mSDW2F+T05JVMoiVV
	vVqg4MEAXWGmKCB5eLiEHslnZLUk7rpMwyCTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VgboGEF+tZ/hklqOjvMpOCI2UuEVxQpQ
	CablY7WNpN00p/sw6IPWM8Do63nr/F0cFPiQLnLIJ2Fs96x64t12aJAD5nEfD82i
	/mtwg5qakiyIkDM9gfkXwDaugdgyhaFqbbbjcOylpKNHHBM0vf19Qbjbq+QOAgNE
	UhJhmB01D0w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CB7E21052;
	Thu,  9 Jun 2016 14:15:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9ED121050;
	Thu,  9 Jun 2016 14:15:04 -0400 (EDT)
In-Reply-To: <CAGZ79kbWygHWVhcn9du8P15i2okvFgvt2VPdamHCf2Bvm-n0fg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 8 Jun 2016 17:25:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 16EA0872-2E6E-11E6-9B56-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296911>

Stefan Beller <sbeller@google.com> writes:

>>  static void collect_some_attrs(const char *path, int pathlen,
>> -                              struct git_attr_check *check)
>> +                              struct git_attr_check *check, int collect_all)
>
> I think it may be better to have a collect_all_attrs instead of a flag here,
> as more than half the executed code differs (the parts conditioned on
> collect_all are rather large in the function)

It is understandable if it appears to anybody who does not know the
future that way ;-)

The plan is to remove that "if (!collect_all)" optimization block.
Once the attr_stack and check_all_attr becomes per git_attr_check
instance, there is no reason to keep record of all attribute
definitions read from the .gitattribute files.  The entries that are
known not to matter (i.e. not listed in git_attr_check) can be
discarded when they are read before it hits attr_stack.

The "optimization" in that block is to optimize one special case: an
attribute may be defined in the git_attr_hash[] dictionary, and the
ones that appeared in various .gitattribute files are marked with a
bit (an attribute may be in that dictionary only because the caller
who asks about the attribute filled it in check->check[] array, and
may not appear in the .gitattribute files prepare_attr_stack()
read).  If the check->check[] wants to know about an attribute that
does not appear in any of the .gitattribute files, we can answer
"that attribute is not set to anything" without actually executing
any matches with path patterns.

The "an attr_stack that is per git_attr_check only has to contain
what matters and can discard irrelevant records" is a natural
extension of the current optimization.  Instead of the current "when
0 rules refer to attribute, do not do any of the 47 path matches
defined in the attribute system, but even if one rule refers to it,
do all 47 path matches to check", we would do "among 47 path
patterns, only attempt to match patterns that affect the attributes
that we are checking (which could be 0 rules).
