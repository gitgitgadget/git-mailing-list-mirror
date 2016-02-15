From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] bisect: read bisect paths with strbuf_getline()
Date: Sun, 14 Feb 2016 21:05:10 -0800
Message-ID: <xmqqtwlar2bd.fsf@gitster.mtv.corp.google.com>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB03.3020000@moritzneeb.de>
	<xmqqlh74unja.fsf@gitster.mtv.corp.google.com>
	<56C0EB3F.90202@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVBLb-0003gI-TG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 06:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbcBOFFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 00:05:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750824AbcBOFFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 00:05:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E84034496B;
	Mon, 15 Feb 2016 00:05:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8h22gZH04KcVoj1UROV+UBi3tHg=; b=wK7oFf
	q59SSPmozya4jj5s7kIwA0/A0B1cQEOvDSNvo0+wZSq9j4eBULMCLlo7GjIzMAP+
	NRnwzlbanqg3e4ridrfayZ4qdGXq6fBIvjypczTFOeA2p8OmkvpUl5Vkrdjmo4st
	AQr/q5fQiABYfbyC+giI+iZ/0OYc5vnf54rh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XQw70/nMzAeqfx1CMCmCMAOnZMACXHFC
	H1ove69YfDJD+NomZpG7FwICKQXXFMv6wz5AfNnwhNGgKKNrKfEBzJkvQgxQ3hRH
	7X7wWsY4+fbFwLQyfNw1TqGrMYjatYGv8ta7eIKYxu+d8nZE5L7E1jyA7PMcUCo7
	1MmojtxvVP8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E01364496A;
	Mon, 15 Feb 2016 00:05:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6407444964;
	Mon, 15 Feb 2016 00:05:11 -0500 (EST)
In-Reply-To: <56C0EB3F.90202@moritzneeb.de> (Moritz Neeb's message of "Sun, 14
	Feb 2016 22:01:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0CF33EA-D3A1-11E5-B8F6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286172>

Moritz Neeb <lists@moritzneeb.de> writes:

>> You would also want to think about the necessity of strbuf_trim()
>> here.  Now strbuf_getline() would trim the trailing CR, would we
>> still need to call strbuf_trim() here?  The code will break if you
>> just remove the call, but on the other hand, you will realize that
>> the trimming done by calling it is excessive and unnecessary, once
>> you inspect the code and learn who writes the file being read here
>> and how.
>
> I am not sure what you mean by excessive: How much can I assume that
> the input is like expected? The files we are talking about are supposed
> to be read and written by git only. But could be modified in theory with
> an editor, right? Then things could break, right? This question maybe holds
> true for the other patches as well, I still have to look into them.

These are all good questions you as a Git contributor to be asking
yourself, and I really like the fact that you are thinking aloud
here.

As to bisect pathspec, while I do not think it is sensible to change
it in the middle of bisection, I do not think it would cause the
bisect command to produce an incorrect result if you did so.  You
would be changing the definition of what is the "middle point" of
the history on the fly by changing the pathspec, hence you may end
up making the bisection suboptimal, but it shouldn't affect the
correctness of the bisection.

So I tend to agree with you that it is a good idea to be prepared to
parse what the end user may have futzed with the editor, as long as
the user did not break the syntax of the quoted string.

Your answer to the question quoted at the top of this message could
be a summary of the above reasoning, with a conclusion: "we would
want to tolerate trailing (or leading) whitespaces the user might
add with his editor; even though we use strbuf_getline() to remove
the CR at the end of line, we still need to strbuf_trim() the line
we read".

	Side note: of course, you can instead say "while it is
	technically possible, we have never advertised this file to
	be editable by user, or encouraged them to do so" and
	tighten the parsing to assume only what we write out,
	erroring out when we see any attempt to edit it.

Either way, the most important thing is to record the reasoning
behind the design choice you made clearly in the proposed commit log
message.

Thanks.
