From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Sat, 11 May 2013 10:36:38 -0700
Message-ID: <7vr4hdxvtl.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
	<7vy5bm22f8.fsf@alter.siamese.dyndns.org>
	<518E0741.1060008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 11 19:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbDiy-0005dV-Bu
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 19:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3EKRgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 13:36:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777Ab3EKRgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 13:36:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47B521D2C8;
	Sat, 11 May 2013 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TFjd1/1IahTSXi3hXjWWKvgAbuI=; b=Uxvx+g
	8DsFzY4FLNgXe0mdUAx1zjjSKuuIEY5SQ8eQn7XKBqR7rhZPwNOhVYuTMGtKVZ1D
	4b26dz5yBMxWKQz/3dQjUoUIcAig/OC3K8HlFhv2U+5qLT7srmrD82Mkae3d58mf
	fh4J09e5RoZvS+/s/fmz0Ls8x7dkw7+TqmMxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZK21JMQzGL0+8jnq99hHQq/O8i1TnbD
	pcRzEB0yEkhotQ4AVLDzXxua6NaU6xPxmPkofN0YkKJjwfBrVg/Zt9wbtBnc+N6o
	RzIZWTmC7QfixgfGTBRqPmB5QpPH4l6R6e88Do3AKaFdFPzR9m+wfQc5ugYnw2qu
	5l7TpM3pQh4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA871D2C7;
	Sat, 11 May 2013 17:36:40 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B397C1D2C6;
	Sat, 11 May 2013 17:36:39 +0000 (UTC)
In-Reply-To: <518E0741.1060008@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Sat, 11 May 2013 10:54:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5653A88A-BA61-11E2-8B2A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223996>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>> +	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
>>> +	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
>>> +		return stream_blob_to_fd(1, sha1, NULL, 0);
>> 
>> It is surprising that the necessary change is only this, but I think
>> it is correct ;-).  We ignore textconv when the command line did not
>> mention --[no-]textconv, or the command line said --no-textconv
>> explicitly.
>> 
>> This (especially the first condition) may deserve an in-code comment
>> for anybody who wonders where this default behaviour is implemented.
>
> It's not as if we would document behavior by in-code comments in
> general, do we? The usual answer is "git log -S" or "git blame".

The comment and the future reader I had in mind was more like

	Default to --no-textconv, even though cmd_log_init_defaults()
        sets the bit, when the user did not explicitly ask for it.

sought by somebody who wonders _where_ in the code we ignore
ALLOW_TEXTCONV that is set in cmd_log_init_defaults().

That is not something you can find with "log -S" or "blame", is it?
