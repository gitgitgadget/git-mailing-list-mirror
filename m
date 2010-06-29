From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use
 of  it.
Date: Mon, 28 Jun 2010 22:43:25 -0700
Message-ID: <7v4ogmcs1u.fsf@alter.siamese.dyndns.org>
References: <c4c9797a4cbea89f1f0fb0501e6a03912b598b17.1277595284.git.tfransosi@gmail.com>
 <de7ad1688930aa47515736885b7d8438118e7aa1.1277595923.git.tfransosi@gmail.com>
 <7vbpawifwa.fsf@alter.siamese.dyndns.org>
 <AANLkTim14fh1RRSoYFK5uIqi8OrkB2zHahInDpO80gws@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 07:43:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTTbj-00085p-Qd
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 07:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab0F2Fnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 01:43:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab0F2Fni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 01:43:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7D54BFAEB;
	Tue, 29 Jun 2010 01:43:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=r00Pp2pj0tuY+gdGF2WdaiKMGeM=; b=CFWo8jtqtEAdvqrzm6UHD8E
	QW4Zw+hvchJH0uObBgi3JeB94sYuGcj0prYSL2fqEjTKhXsjt0Y4m0nhN2iG5Xs7
	setOc3UiAzslyQ2ZT47oIZ+umaa/02o+bNjlon82SyQ8PIXOSgeBMKpS5+F7vfyo
	ohq6SAU3vaZ5IUfTNIl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ek9SZZ3KcTgZa6rysqaKVRufxVQPc7kOiaToF3QZV/63KlDFH
	SAVLwIQflS6HlAim5RYfczAsndFTJZ5Zpr3KKc5RxwYNBCfmF9IkN01VS9Qh65Et
	0JuXeYkF5Dh73uRwMfb2c+343i21+w1knjjoYwnVZlINbDcK0nMWlW3zFY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9839BBFAEA;
	Tue, 29 Jun 2010 01:43:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98CE9BFAE5; Tue, 29 Jun
 2010 01:43:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 40B2C68C-8341-11DF-AE26-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149885>

Alex Riesen <raa.lkml@gmail.com> writes:

>> But I wonder if this is worth it (not this "more complete", but your
>> patch). We convert 16 or so instances of initialization for "no strdup"
>> list, but there are about the same number of "strdup" instances still
>> spelled out:
>>
>>    $ git grep -e 'struct string_list [^ ]* = {.*'
>>    $ git grep -e 'struct string_list [^ ]* = {.*1'
>>
>> Wouldn't it be more sensible to use this instead?
>>
>>    #define STRING_LIST_INIT(pleasedup) { NULL, 0, 0, (pleasedup) }
>
> This begs for using strdup(string-to-dup) in the macro argument, which
> will not compile with ancient compilers which don't allow code in an
> initializer.

Err, one of us must be confused.

I was suggesting to rewrite things like these, found in builtin/remote.c
(add and rm):

	struct string_list track = { NULL, 0, 0, 0 };
	struct string_list branches = { NULL, 0, 0, 1 };

like so:

	#define STRING_LIST_INIT(pleasedup) { NULL, 0, 0, (pleasedup) }
	struct string_list track = STRING_LIST_INIT(0);
        struct string_list branches = STRING_LIST_INIT(1);

I don't see strdup in macro argument anywhere.

The original patch in this thread proposed to do this instead:

	#define STRING_LIST_INIT { NULL, 0, 0, 0 }
	struct string_list track = STRING_LIST_INIT;
        struct string_list branches = { NULL, 0, 0, 1 };

converting about half of initializers to the macro, and leaving the other
half spelled out.
