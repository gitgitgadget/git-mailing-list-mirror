From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the definition of a valid Git symbolic reference?
Date: Mon, 14 Feb 2011 22:22:55 -0800
Message-ID: <7vsjvpq0jk.fsf@alter.siamese.dyndns.org>
References: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com>
 <F624322D-359A-48ED-A241-622042F77CDA@sb.org>
 <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>, libgit2@librelist.com
To: Emeric Fermas <emeric.fermas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 07:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpEJg-0004dM-VM
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 07:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab1BOGXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 01:23:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab1BOGXL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 01:23:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F3F847DA;
	Tue, 15 Feb 2011 01:24:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PC/dUirXFAOzpBlLBd5dv+1xpfg=; b=daKHAI
	pPdPigvE6hTN+sUbM+R0oVR3qjXsjdWI8oa97JX7myu4w28iZAemjOZUvjTp6fFR
	7xKQunmti0HldlpMULfsndGhI1FK97aA48/UPWEgjiJe7mJSHI55PLrIAomcKXrZ
	CQl8Ol7wliwMWF5jBAVvasWdc5GKAS1HDnYWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W4Pf8mK5otBvYSErSWygR4QAogPSt+DA
	tbTzzdVPQPLL+OsUrpFh6fVyjkt6nI08zLvCTbg/YqCRG7+Ldm6HefHsFmLPwdxO
	aCyNmgj5V+2t5bxe0jFKnwRoN5WlWw5xxpg6YVdSekBD1nlQJM9BhJwHkLNIR75Y
	0fNSOJ9iLQE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B21B847D8;
	Tue, 15 Feb 2011 01:24:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 075FC47D7; Tue, 15 Feb 2011
 01:24:02 -0500 (EST)
In-Reply-To: <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com>
 (Emeric Fermas's message of "Tue\, 15 Feb 2011 04\:49\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32BD7BA8-38CC-11E0-80F2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166812>

Emeric Fermas <emeric.fermas@gmail.com> writes:

> Once again, by reading at the code I can understand how those commands
> currently work. What I'm trying to achieve is to understand what
> should be their recommended usage.

There are only two valid kinds of symrefs right now:

 - .git/HEAD, pointing at somewhere under refs/heads/ hierarchy;

 - .git/refs/remotes/<some remote name>/HEAD, pointing at somewhere under
   refs/remotes/<the same remote name>/ hierarchy.

The code may be prepared to resolve recursive symrefs, symrefs other than
the above two kinds, symrefs that point at elsewhere, but all of them are
outside of the design scope of what the mechanism was intended to support.
What the code do to them (without crashing) is not the design, but simply
an undefined behaviour.

This won't change very much if we decide to reorganize the remote tracking
hierarchies in 1.8.0.  The former won't change at all, and the latter will
start pointing at refs/remotes/<the same remote name>/heads hierarchy
instead.

I vaguely recall tg abused the symref mechanism to point .git/HEAD at
funny locations; it may still be doing so, and if that is the case we
should extend the above list to cover that usage.
