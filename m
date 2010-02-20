From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Sat, 20 Feb 2010 11:23:11 -0800
Message-ID: <7v8waniue8.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 22:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiuvM-00084P-4S
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 20:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902Ab0BTTX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 14:23:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0BTTX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 14:23:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 668339B9EE;
	Sat, 20 Feb 2010 14:23:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AnsjSMIJOt6xzmp5xrZ5DCTzQTM=; b=IWVw02yN/wevmwhiBRuSUut
	Ga0XDvlBhZ3fctuW+/8xCLd2l7NCmyi+k5PZEA+p5GKnnPnk8+/0eQvncP2nd7ts
	Q1zB06gZ4jcZigdVlNoh03nN9hgGj8whMalHCqQ+kTBMFzUmJ9LK7FNu74iDYzZ0
	3ZmpeGnqLi4EcYxJkuQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Oi1Ae8+uPx6RFwaTaiAQ3xjglj+owbsHpvTwAaqhnF4LZWsAL
	pjLD9TilJWewUG64wzJFkcRhWyEHYZZ2tlTJAzZiwdL1Bmm0egCUk1S0VCC1O/aN
	wf+eNUKpsNoAKaZyeu1FwUfl3SNtZfqUnWH8psMO81WrCxm8DKsDWKN/4I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E009B9EA;
	Sat, 20 Feb 2010 14:23:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6C099B9E5; Sat, 20 Feb
 2010 14:23:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 675D406A-1E55-11DF-857D-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140553>

Junio C Hamano <gitster@pobox.com> writes:

> Dmitry Potapov <dpotapov@gmail.com> writes:
>
>> ... I think it is possible
>> to avoid the overhead of being on the safe side in a few common cases.
>> Here is a patch. I have not had time to test it, but changes appear to
>> trivial.
>
> Yeah, these are obvious "paranoia not needed" cases.
>

Actually the "if it is smaller than 256k" part is not quite obvious.

>> @@ -2490,7 +2491,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
>>  	size_t size = xsize_t(st->st_size);
>>  
>>  	flag = write_object ? INDEX_MEM_WRITE_OBJECT : 0;
>> -	if (!S_ISREG(st->st_mode)) {
>> +	if (!S_ISREG(st->st_mode) || size < 262144) {
>>  		struct strbuf sbuf = STRBUF_INIT;
>>  		if (strbuf_read(&sbuf, fd, 4096) >= 0)
>>  			ret = index_mem(sha1, sbuf.buf, sbuf.len,

INDEX_MEM_PARANOID is never given to index_mem() in this codepath, so
trade-offs look like this:

 * In non-paranoia mode, your conjecture is that between

   - malloc, read, SHA-1, deflate, and then free; and
   - mmap, SHA-1, deflate and then munmap

   the former is faster for small files that can fit in core without
   thrashing.

 * In paranoia mode, your conjecture is that between

   - malloc, read, SHA-1, deflate, and then free; and
   - mmap, SHA-1, SHA-1 and deflate in chunks, and then munmap

   the former is faster for small files that can fit in core without
   thrashing.

The "mmap" strategy has larger cost in paranoia mode compared to its cost
in non-paranoia mode.  The "read" strategy on the other hand has the same
cost in both modes.  If this "read small files" is good for non-paranoia
mode, it is obvious that it is also good (better) for paranoia mode.

Which means that this hunk addresses an unrelated issue.  "paranoid
avoidance" falls naturally as a side effect of doing this, but that is not
the primary effect of this change.

There needs some benchmarking to justify it, I think.

So I'd split this hunk out when queuing.

Thanks.
