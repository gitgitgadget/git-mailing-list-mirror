From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Convert struct name_entry to use struct object_id.
Date: Tue, 19 Apr 2016 17:17:20 -0700
Message-ID: <xmqqk2jtxhf3.fsf@gitster.mtv.corp.google.com>
References: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
	<1460934641-435791-5-git-send-email-sandals@crustytoothpaste.net>
	<xmqqshyhxkw1.fsf@gitster.mtv.corp.google.com>
	<20160419231617.GA572694@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 02:17:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asfpg-0004L5-3v
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 02:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbcDTARY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 20:17:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752132AbcDTARX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 20:17:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D2A114EA8;
	Tue, 19 Apr 2016 20:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nxlrfZi59Sr8me3RCk5lMRlAmp0=; b=gJByYR
	FbkWRwLaNfPHUyNXTV3M5GUdYWmNKOGlCwlNt2Gyr+B6vqaJPlLkASwLQl0/ssW9
	r6iEBh3JfUL4rJWqqGHifDvrm67gah2DO0yj4IT/fPCZqSjRLqVvGLHBdUsYa+NV
	f/tydEBlRmfiSwXnMCzIjUv7RZcz2/WJsxETQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jL4Z5sqg4lIjwiSnBMW2ivr7KrNSpbMP
	PHE6K/Dt4p23jagepLJxs+/lSJBGUz+8qyDYLgwtIMiLS0btc0SORVpHpFAKEggD
	Mn+/htiLGtqKibnW3H+ksgxXlssJjqg0pJT6qkVzvXo3rn7PeA7XixuSdT4XxG+T
	8WsjEckrHoI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15AA014EA7;
	Tue, 19 Apr 2016 20:17:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8470614EA5;
	Tue, 19 Apr 2016 20:17:21 -0400 (EDT)
In-Reply-To: <20160419231617.GA572694@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 19 Apr 2016 23:16:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40040BD0-068D-11E6-864D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291972>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Apr 19, 2016 at 04:02:22PM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > @@ -314,7 +314,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
>> >  	}
>> >  
>> >  	if (same_entry(entry+0, entry+1)) {
>> > -		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
>> > +		if (entry[2].oid->hash && !S_ISDIR(entry[2].mode)) {
>> 
>> Thanks for a warning in the cover letter.
>> 
>> "if (entry[2].oid && !S_ISDIR(entry[2].mode)" would be a faithful
>> conversion, wouldn't it?
>
> Yes, I think that would be a better conversion.  I'll reroll after
> waiting for further comments.

Thanks.  A simple general rule to follow is that anything that
assumed entry.sha1 is non-NULL should become entry.oid->hash, while
anyting that checked if entry.sha1 is NULL or not should become a
check on entry.oid, I think.  Even though offsetof(oid.hash) might
happen to be zero, compiler writers are crazy and "optimize" the
above entry[2].oid->hash saying "you are dereerencing into the hash
field without first checking if oid pointer is NULL, so we'd assume
that you know oid is not NULL here--which makes this always true so
we won't even do any check and only check entry[2].mode"..
