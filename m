From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] reset: accept "git reset <removed file>"
Date: Tue, 19 Oct 2010 10:34:24 -0700
Message-ID: <7vk4le13z3.fsf@alter.siamese.dyndns.org>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <20101018211522.GA7655@burratino> <20101018224840.GA9729@burratino>
 <7viq0z2gxj.fsf@alter.siamese.dyndns.org> <20101019002349.GB9841@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 19:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8G5M-0007iG-Va
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 19:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab0JSReq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 13:34:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab0JSReq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 13:34:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05CE7DFACD;
	Tue, 19 Oct 2010 13:34:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YS6Y8UklWD6h7NwOOyw/uTKRFeE=; b=nJ8KDA
	2/s5UGkrKoLuAbJGe0ESuhsE8onAzsQtWOs/wlZ8lAPhx4q4Bk8zIetmDaVvsfq8
	SihtOt/qHDMr3zQ9samNe2nCSD3NLUG/6EOaKxYpIGhPWB67cVfV0yPm3B+y6TxF
	X+75wipYtaOjt4L5IB+qqV8PReTN0eAEJS+Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XSMrb4ZLF+76EXRButFI3ucW/6TPWiuN
	mOkZZ9+M96nbaW0iABHhYzWuHTGpacikMBstHvQHshGn3VoGQ5zcxd88afQ+/w1l
	nnF9nL7ajhZu6FyzGmBRgrbrlPwWn6BqDl8oX2nQXc87FhcW/AyFKKPTApPfGPAf
	QG3TB29pbOg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84EA3DFAC6;
	Tue, 19 Oct 2010 13:34:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26D1CDFAC0; Tue, 19 Oct
 2010 13:34:26 -0400 (EDT)
In-Reply-To: <20101019002349.GB9841@burratino> (Jonathan Nieder's message of
 "Mon\, 18 Oct 2010 19\:23\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2372A89E-DBA7-11DF-A51A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159342>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Makes me wonder
>>
>>  - if we can/want to have a logic like this inside verify_filename();
>
> Yes, I think so.  I was worried that this would be confusing for some
> command that looks to the worktree, like git grep without --cached,
> but I suspect that worry was unfounded.
>
> The one case I am worried about is "git rev-parse".  What is
> "git rev-parse <path>" supposed to be used for?
>
>>  - if we need a corresponding logic in either the previous else/if cascade
>>    that calls verify_non_filename(), or in verify_non_filename() itself.
>
> Yes.
>
> Is it safe to load the index so early?  I can imagine a person trying
> "git reset" to recover from a corrupted index; are we regressing in
> that respect and how would one check for it?

It is generally unsafe, I am afraid, and that is one of the reasons why
verify_filename() does not look in the index (the other one was "it is
merely a safety measure based on heuristics to help users, and no point
spending extra code nor cycles", iow, deliberate laziness ;-)), making the
proposal of this patch under discussion somewhat iffy.
