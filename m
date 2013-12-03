From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improvements to git-archive tests and add_submodule_odb()
Date: Tue, 03 Dec 2013 09:54:03 -0800
Message-ID: <xmqq61r5q0qs.fsf@gitster.dls.corp.google.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
	<8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
	<CAPig+cTUjvfWLC5vX0=BwtSDb613E9jMoyVXWp=de_Tyb5Ei7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Townsend <nick.townsend@mac.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 18:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnuAq-0005fa-ND
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 18:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab3LCRyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 12:54:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303Ab3LCRyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 12:54:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 828D653DFA;
	Tue,  3 Dec 2013 12:54:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n5z9r4IhyqAsOEbncBz8FOGDKac=; b=UyIVpP
	I3hsSyHftte3T7y4yCLkjPg2XF5XvANYs+y+lP+DkUE4Z4t1/iUqrVF2nnwE2BR0
	baJeE5KusNsjGh/CEnE30jut/qgUnPXoq3FRT/QwxyKmG15+z3GF118zOAYKX5jd
	Naq4B0dTgWC/aMW51klqPUa85ssHOKylD9Geg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TUTXBKEVaMeJWVNFL7y+MxtQKcwdQvGe
	9bjNvO/zARymddDLUyx3BBeXjkVL11aA0An1Vkz2s8u+iJu7EBs4+uMPvSkvgSI/
	Lc+vgwqcziqeL/ejvv5vy/9lpf0tpoCR/5d9hRcybtKeYWy//HZYjn32IYFtT/AM
	3AfEsxIZZTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FDE853DF3;
	Tue,  3 Dec 2013 12:54:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7655E53DF2;
	Tue,  3 Dec 2013 12:54:10 -0500 (EST)
In-Reply-To: <CAPig+cTUjvfWLC5vX0=BwtSDb613E9jMoyVXWp=de_Tyb5Ei7w@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 3 Dec 2013 04:26:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9C3CDB4-5C43-11E3-98C8-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238704>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +test_expect_success 'archive subtree from subdir' '
>> +       cd a &&
>> +       git archive --format=tar HEAD >../asubtree.tar &&
>> +       cd .. &&
>> +       make_dir extract &&
>> +       "$TAR" xf asubtree.tar -C extract &&
>> +       check_dir extract af b b/bf b/c b/c/cf
>> +'
>
> If git-archive fails, the subsequent 'cd ..' will not be invoked,
> hence all tests following this one will fail since the current
> directory has not been restored. If you place the 'cd a' in a
> subshell, then the current directory remains unchanged for commands
> outside the subshell (and you can drop the 'cd ..'):
>
>     (
>     cd a &&
>     git archive ...
>     ) &&
>     make_dir ...
>     ...

Thanks, and please indent the commands run in the subshell for
better readability.
