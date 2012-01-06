From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Work around sed portability issue in
 t8006-blame-textconv
Date: Fri, 06 Jan 2012 14:53:33 -0800
Message-ID: <7vehvcigsy.fsf@alter.siamese.dyndns.org>
References: <1325339068-6063-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vd3b0vc6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjIfN-0006vc-BR
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 23:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124Ab2AFWxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 17:53:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758833Ab2AFWxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 17:53:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50F906361;
	Fri,  6 Jan 2012 17:53:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AO+R0yZT/OvNtHZWCl8q2PW2GgU=; b=wc9dDe
	ZaAoML/LJMXM5sqaF13RD9eKcw9teetWgkxhPgGPNTsIRmdxUcZIQO3e/QJVpyI1
	frSUC+iHCVMr+FEkBY5PTQqh+X1k/CkhpgWw4PrbWEABuOzQ2+GnK7QjiN6vsHwF
	rjOhCOw3u3nzgaev1Bb5TpSaEQwh2D8CmqxVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cKQ0yfvtqzvREzQqiCd7SLi8DqM7XYqs
	LNI0mf+RBfs+5jJWnkj/n8i8O/XzHgrVoWZXmqxEQ2sC3O5N/u5g8ltc3ZYpsIma
	J02HmkSQCwzQjs2CSDvlO6zsWufpDpEP88G6ifBEkeiDvgO2rWZ0irOQ65x6EWqJ
	qufsclYc2iY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4688F6360;
	Fri,  6 Jan 2012 17:53:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF3E9635F; Fri,  6 Jan 2012
 17:53:34 -0500 (EST)
In-Reply-To: <7vd3b0vc6h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 03 Jan 2012 11:05:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43648558-38B9-11E1-945E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188055>

Junio C Hamano <gitster@pobox.com> writes:

> Ben Walton <bwalton@artsci.utoronto.ca> writes:
>
>> In test 'blame --textconv with local changes' of t8006-blame-textconv,
>> using /usr/xpg4/bin/sed on Solaris as set by SANE_TOOL_PATH, an
>> additional newline was added to the output from the 'helper' script
>> driven by git attributes.
>>
>> This was noted by sed with a message such as:
>> sed: Missing newline at end of file zero.bin.
>>
>> In turn, this was triggering a fatal error from git blame:
>> fatal: unable to read files to diff
>
> Interesting. A file with incomplete line technically is not a text file
> and sed is supposed to work on text files, so it is allowed to be picky.
>
>> Use perl -p -e instead of sed -e to work around this portability issue
>> as it will not insert the newline.
>
> I am not sure if additional newline is the problem, or the exit status
> from sed is, from your description. Your first paragraph says you will get
> output from sed but with an extra newline, and then later you said blame
> noticed an error in its attempt to read the contents. I am suspecting that
> it checked the exit status from the textconv subprocess and noticed the
> error and that is the cause of the issue, but could you clarify?  IOW, I
> am suspecting that replacing "as it will not insert the newline" with "as
> it does not error out on an incomplete line" is necessary in this
> sentence.

Ping?
