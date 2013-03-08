From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup.c: Fix prefix_pathspec from looping pass end of
 string
Date: Thu, 07 Mar 2013 17:51:25 -0800
Message-ID: <7vk3pik6aq.fsf@alter.siamese.dyndns.org>
References: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com>
 <7vobeulw4d.fsf@alter.siamese.dyndns.org>
 <CADgNjakrBCD2jMNUz95E-7FkyKmNgcQeuz8grDWczb-hM6yHhg@mail.gmail.com>
 <7vvc92kbho.fsf@alter.siamese.dyndns.org>
 <CADgNja=8f+_ORb_WStRz2grr0pYmJ2gZTnCHbOGUb3ogPPd_LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 02:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDmTT-00011E-BY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 02:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759941Ab3CHBv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 20:51:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041Ab3CHBv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 20:51:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777D4BBD5;
	Thu,  7 Mar 2013 20:51:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RywCypVwuj8CIIEgCiCjcNofYO8=; b=F3tYLG
	+bPzu+2ji6sVuTwHMrkiuqfQ77njbbxwY7AnmjcYQL/15KfXczmBEP3RjGvsbXGS
	vNa2fGEdLwyte/ZUgIzkvjxxDZxQPch2o/djy5MpQkUEyFfHxBqTg8kE1oCJoZmM
	oQNaWc3x0RtK+mddr2FlsZQ3zEH1ZG8HRHOOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQeR+ad0ah2rTSCMC4bK9wRbyOSXa6C6
	vdWdjXQbO8ZfHDZ3cwaWhwfsz7NbkRD4uwyAeX51kEjrDHfZlwjXx7FLjeyXH1Qa
	aX8AFmlni/33oAXjIbpy+1s4PIeEzZ4EE8nkpKCL4UxNEOnm4EdIKvfshlWLQaOM
	Bb0Pr9T8/pE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C848BBD4;
	Thu,  7 Mar 2013 20:51:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC3FFBBD3; Thu,  7 Mar 2013
 20:51:26 -0500 (EST)
In-Reply-To: <CADgNja=8f+_ORb_WStRz2grr0pYmJ2gZTnCHbOGUb3ogPPd_LQ@mail.gmail.com> (Andrew
 Wong's message of "Thu, 7 Mar 2013 19:25:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B053A102-8792-11E2-AFDE-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217635>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On 3/7/13, Junio C Hamano <gitster@pobox.com> wrote:
>> This did not error out for me, though.
>>
>>     $ cd t && git ls-files ":(top"
>
> No error message at all? Hm, maybe in your case, the byte after the
> end of string happens to be '\0' and the loop ended by chance?
>
> git doesn't crash for me, but it generates this error:
>     $ git ls-files ":(top"
>     fatal: Invalid pathspec magic 'LS_COLORS=' in ':(top'

What I meant was that I do not get any error _after_ applying your
patch.

It is broken to behave as if "LS_COLORS=..." (which is totally
unrelated string that happens to be laid out next in the memory) is
a part of the pathspec magic specification your ":(top" started.
Your patch makes the code stop doing that.

But it is equally broken to behave as if there is nothing wrong in
the incomplete magic ":(top" that is not closed, isn't it?
