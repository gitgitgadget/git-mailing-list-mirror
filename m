From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header dependencies
Date: Mon, 25 Aug 2014 14:03:26 -0700
Message-ID: <xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
References: <20140822042716.GE27992@peff.net>
	<20140822043303.GB18192@peff.net> <20140825194641.GS20185@google.com>
	<20140825200042.GJ30953@peff.net> <20140825204516.GT20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM1QX-0003p6-P2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 23:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbaHYVDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 17:03:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50217 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbaHYVDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 17:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2E9235BC7;
	Mon, 25 Aug 2014 17:03:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YfCINZ6xtvsjxHNaeqi4qS3hYqw=; b=Oax2uJ
	RqZ0kXexZO7duiLTIQCV0zkWNYS5czhG6GZx9Vr9+MJm1DhdHCNB9UEYRgE6sgIS
	YJoZ3F97lOIdmhHZMtrifRwOzh830TrmHiOd3cAVypbTv0gaf2tUpKjSlIq1q6mq
	bBnpLW0s9cfCzBJAAEutTDDMFzd4Ghp/5/RiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pJ+Wjw03YVh2VBt9cy6pgDVxn4gpsrrh
	0WM8SteB+V3W5HaRFserrNZ5l4uul4/ai1QsnS5w2DE05xy+0yFLb6O/46g0Z9d6
	6FujQMqObuK6IJneElFdV1gfsl6J5bamS0sVmSSxvpO7GRt/9xfvvx1CEWgQA+67
	1MjWhhtwQAI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 986AF35BC6;
	Mon, 25 Aug 2014 17:03:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D556935BB8;
	Mon, 25 Aug 2014 17:03:28 -0400 (EDT)
In-Reply-To: <20140825204516.GT20185@google.com> (Jonathan Nieder's message of
	"Mon, 25 Aug 2014 13:45:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 435064F0-2C9B-11E4-8981-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255867>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> It is unfortunately easy for our static header list to grow
>> stale, as none of the regular developers make use of it.
>> Instead of trying to keep it up to date, let's invoke "find"
>> to generate the list dynamically.
>
> Yep, I like this.
>
> It does mean that people who run "make pot" have to be a little more
> vigilant about not keeping around extra .h files by mistake.  But I
> trust them.
>
> [...]
>> +LIB_H = $(shell $(FIND) . \
>> +	-name .git -prune -o \
>> +	-name t -prune -o \
>> +	-name Documentation -prune -o \
>> +	-name '*.h' -print)
>
> Tiny nit: I might use
>
> 	$(shell $(FIND) * \
> 		-name . -o
> 		-name '.*' -prune -o \
> 		-name t -prune -o \
> 		-name Documentation -prune -o \
> 		-name '*.h' -print)
>
> or
>
> 	$(shell $(FIND) * \
> 		-name '.?*' -prune -o \
> 		-name t -prune -o \
> 		-name Documentation -prune -o \
> 		-name '*.h' -print)
>
> to avoid spending time looking in other dot-directories like .svn,
> .hg, or .snapshot.

Wouldn't it be sufficient to start digging not from "*" but from
"??*"?  That is, something like

	find ??* \( -name Documentation -o -name .\?\* \) -prune -o -name \*.h

;-)

> With or without such a change,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
