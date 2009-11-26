From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 02/11] strbuf: add non-variadic function
 strbuf_vaddf()
Date: Wed, 25 Nov 2009 16:59:24 -0800
Message-ID: <7vskc2ksnn.fsf@alter.siamese.dyndns.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDShz-00065k-TS
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759552AbZKZA7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759462AbZKZA7c
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:59:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759283AbZKZA7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:59:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D63DA1A8A;
	Wed, 25 Nov 2009 19:59:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G+QLpiRsND/CPJepQIs7DHn3eAM=; b=Y03HHl
	d43qIp/OZMtiw1iNtQcAJn9K7w2FJXrRpf66cqv/O4ewtiMEHqMitBC2TgurCTXb
	plkv/0dxr79sZS5JWvnVjayInY7kdyeE1hZemNpSv18t77A+CfyceQIAaYPzYcnJ
	9TMdvDEKnKJacWob45ZmlKoIkRzWOhrRFycgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fc3jDgEJG3Cu4BTN2jaAAwNnGQA27dW4
	g7Eea5zuxyqCm1nkANZAu2D1xeSy/tbJZ0dSaEibYFfElQeAibTxZ+XNSgCB/8Xx
	eebbfv4Q4tjYEM1GyhK8y5XojBq5LJY9oTn4CTan2moD8mnyAzXc8BeryjCSotyL
	n+sHgMSzH3U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E33D7A1A89;
	Wed, 25 Nov 2009 19:59:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28864A1A88; Wed, 25 Nov 2009
 19:59:25 -0500 (EST)
In-Reply-To: <1259196260-3064-3-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Thu\, 26 Nov 2009 00\:44\:11 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F56D564C-DA26-11DE-ADD9-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133746>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> +void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
>  {
>  	int len;
>  
>  	if (!strbuf_avail(sb))
>  		strbuf_grow(sb, 64);
>  	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
>  	if (len < 0)
>  		die("your vsnprintf is broken");
>  	if (len > strbuf_avail(sb)) {
>  		strbuf_grow(sb, len);
>  		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
>  		if (len > strbuf_avail(sb)) {
>  			die("this should not happen, your snprintf is broken");
>  		}

Hmm, I would have expected to see va_copy() somewhere in the patch text.
Is it safe to reuse ap like this in two separate invocations of
vsnprintf()?
