From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add xmallocz()
Date: Tue, 26 Jan 2010 12:47:02 -0800
Message-ID: <7v1vhczj95.fsf@alter.siamese.dyndns.org>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1264530255-4682-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <19295.21148.182245.516321@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZsJp-0001cb-VD
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 21:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0AZUrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554Ab0AZUrS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 15:47:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0AZUrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 15:47:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1592994145;
	Tue, 26 Jan 2010 15:47:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8oF9cr1jIdG+pbhUW+cJ9XR5fBY=; b=aTrXFA
	RN7OGmcKWtuMnMNGQHvvQt7C6JdJw83XfdmmnRU7+ZgFudgdd0H8QPLSjKqxf8Un
	/X29eCabEsxI5kLG9hGvUmd/+iMEarx0kbS171ah7y3PspyvNy9KhUNO9BxT9IfJ
	OcFMh/BEXPkjtjZagzzmEjMWuOIqpiMbBasP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D9Eu3JQKSmAaReHaseLyqpYZQJxNA/sW
	iiOnNlxfOjMisSeczTtEjs6sdQCjUda/33e63lXPw2qhG98zMczo1413zigkbrYE
	pgb6YvYgkm63kz5cvkV9Rh6nzh1TSAthUpy27vQlK1Ekln6hWwQKjuHqCGPK/6lu
	XTx7NbYjsZ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8BA094143;
	Tue, 26 Jan 2010 15:47:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DA499413B; Tue, 26 Jan
 2010 15:47:04 -0500 (EST)
In-Reply-To: <19295.21148.182245.516321@blake.zopyra.com> (Bill Lear's
 message of "Tue\, 26 Jan 2010 14\:37\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F87E3D86-0ABB-11DF-A2FF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138074>

Bill Lear <rael@zopyra.com> writes:

> On Tuesday, January 26, 2010 at 20:24:12 (+0200) Ilari Liusvaara writes:
>>Add routine for allocating NUL-terminated memory block without risking
>>integer overflow in addition of +1 for NUL byte.
>>...
>> void *xmemdupz(const void *data, size_t len)
>> {
>>-	char *p = xmalloc(len + 1);
>>+	char *p = xmallocz(len);
>> 	memcpy(p, data, len);
>> 	p[len] = '\0';
>> 	return p;
>
> Do you need the statement
>
>  	p[len] = '\0';
>
> any longer in the above?  If not, could you just do this:
>
> void *xmemdupz(const void *data, size_t len)
> {
> 	return memcpy(xmallocz(len), data, len);
> }

I think the intention to name it xmallocz() was "This is to allocate
buffer to hold 'len' bytes worth of stuff, and between the caller and this
function the buffer is arranged to be NUL terminated".  Even though none
of the existing callers of xmalloc() expected the function to do the NUL
termination (hence they do NUL termination themselves), I _think_ Ilari
made the function to do this because its name now ends with "z" that hints
the callers such a NUL-termination might happen inside the function.

I'd rather see the function lose the NUL termination; if that makes the
behaviour inconsistent with its name, perhaps it is better to rename the
function; perhaps xmalloc1() to denote that it overallocates by one?
