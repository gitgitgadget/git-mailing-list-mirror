Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 17260 invoked by uid 107); 21 Feb 2010 22:31:22 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 17:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab0BUWbA (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 17:31:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0BUWa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 17:30:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50DFB9BF2E;
	Sun, 21 Feb 2010 17:30:58 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w7kunzqzqhvZYACleHuWDPY4j6A=; b=lf+kJC
	NjVxT6kCsCYxPoGuG+zHuTNOUg7bP+5akxBD2yrZ+esn4I+iAdcW2IJzOBNQcjg/
	LUYzNyo1V1NcXfrlyJm7wMjOCVvnJ1YeNss/O/Fj9gezdEPOLojv3ZBhkIuFdCcf
	01QpVPNRRKOGJftAjLu6jQtqkcWtysUTdmsV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Op4ORkwQ6ktWBgjMwCvbjIgjcAnr3VvC
	UHEFRrFoj3/X9HRG8lfXyAkQdK0FtrtcRY1Jb0CgYikeC1sJ13bss5uwohREtu84
	2Lcu//5JlXAhLhdY9z561ACEzELDMcStS2mnTEUp1RKvOXZQ9A9xhCtdQHUdDvXd
	eiQtfVD+uSs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AEE59BF2D;
	Sun, 21 Feb 2010 17:30:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C39E9BF2C; Sun, 21 Feb
 2010 17:30:53 -0500 (EST)
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Sun, 21 Feb 2010 14:30:51 -0800
In-Reply-To: <alpine.LFD.2.00.1002211522120.1946@xanadu.home> (Nicolas
 Pitre's message of "Sun\, 21 Feb 2010 16\:26\:51 -0500 \(EST\)")
Message-ID: <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: C6EEFB8E-1F38-11DF-90A6-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

>  	/* Then the data itself.. */
>  	stream.next_in = buf;
>  	stream.avail_in = len;
>  	do {
> +		unsigned char *in0 = stream.next_in;
>  		ret = deflate(&stream, Z_FINISH);
> +		git_SHA1_Update(&c, in0, stream.next_in - in0);

Actually, I have to take my earlier comment back.  This is not "paranoia".

I do not see anything that protects the memory area between in0 and
stream.next_in from getting modified while deflate() nor SHA1_Update() run
from the outside.  Unless you copy the data away to somewhere stable at
the beginning of each iteration of this loop and run deflate() and
SHA1_Update(), you cannot have "paranoia".

My comment about "trickier" is about determining the size of that buffer
used as "somewhere stable".
