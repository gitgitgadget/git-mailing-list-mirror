From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't optimize code in debug build
Date: Sun, 13 Feb 2011 11:28:24 -0800
Message-ID: <7vbp2fybs7.fsf@alter.siamese.dyndns.org>
References: <AANLkTinw7DJ3hP7ACcScHTYy-Dvizq-OxefP6e0dEBbR@mail.gmail.com>
 <201102131036.51311.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 13 20:28:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pohcg-00057E-4E
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 20:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab1BMT2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 14:28:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab1BMT2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 14:28:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AFB34972;
	Sun, 13 Feb 2011 14:29:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CTqL5N/10KxMUcj+Vt9Aa8HTpMc=; b=IHy7jj
	o/tVBNrAYEF9j+FBrk0aU86LmKYSU7cm03T2DdqV8EWSE+GbF08Zxw+wYlrwks88
	wCXej9VD12pMVJLRD0YQEjBMwMvNQ7AMPNuEg9RZseFNdr9ycedWapmSstTLkX4T
	VTNcZMD1BoEamHnHS0WvvMSkrtApSCsiSPrdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOUF7BRU4Ke2OP8CoxEW87979UC+xNEi
	OlrUEm6USAh5T9Lq9xHoUyXz11lBxezOxgXhkbYvVT9WWc2ChW6bnzC4d/ddCiSM
	1oytwo/QCU1V8psYPbOqXn/RwKfQS10YGbxCrBDCquqXPGDhCnGfE4VCrnx90c6p
	05StI2IsKo8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 360B14971;
	Sun, 13 Feb 2011 14:29:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1629B496E; Sun, 13 Feb 2011
 14:29:28 -0500 (EST)
In-Reply-To: <201102131036.51311.j6t@kdbg.org> (Johannes Sixt's message of
 "Sun\, 13 Feb 2011 10\:36\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95B415D0-37A7-11E0-8698-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166676>

Johannes Sixt <j6t@kdbg.org> writes:

>> @@ -262,7 +262,10 @@ endif
>>
>>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>>
>> -CFLAGS = -g -O2 -Wall
>> +CFLAGS = -g -Wall
>> +ifndef DEBUG
>> +CFLAGS += -O2
>> +endif
>>  LDFLAGS =
>>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>>  ALL_LDFLAGS = $(LDFLAGS)
>
> Instead of this, you can just write
>
>  CFLAGS = -g -Wall
>
> in your config.mak. Is anything wrong with that?

You then need to feed -O2 from the command line when you are not doing a
debugging build.  On the other hand, with the current Makefile, you need
to feed "-g -O0" from the command line when you are doing a debugging
build if you and your debugger get confused when seeing an optimized
binary.  So neither is a very good solution.

But having to feed DEBUG=Yes when running a debug build is not a good
solution either.  A single toggle is simply too coarse-grained; the next
temptation after applying this patch would be to add

	ifdef DEBUG
        CFLAGS += -DDEBUG
        endif

and from there everything goes downhill.  That is the last thing we would
want to see happen.

So I would say the current Makefile is just fine as is.
