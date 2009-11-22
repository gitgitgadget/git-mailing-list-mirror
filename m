From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule.c: Squelch a "use before assignment" warning
Date: Sat, 21 Nov 2009 19:32:42 -0800
Message-ID: <7vhbsnkzdx.fsf@alter.siamese.dyndns.org>
References: <1258680785-42235-1-git-send-email-davvid@gmail.com>
 <7v8we17ha9.fsf@alter.siamese.dyndns.org>
 <c5plt6-5me.ln1@burns.bruehl.pontohonk.de>
 <7vws1jl0xp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 22 04:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC3CV-0002CD-5e
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 04:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbZKVDco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 22:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbZKVDco
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 22:32:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZKVDcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 22:32:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31BC0A0533;
	Sat, 21 Nov 2009 22:32:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EOEHPQGiae+L2PLc+2+pQfOvlgY=; b=QWqIHk
	rA9/42OpADyWsWkECUdpj9C273LiJgb1TqoVqhUVDLDtmIlllFc8CCsA6efZvU++
	mg4BuFtgRVG0Oeuq+o7XCbyy0iLiinHSA6NSlkpO6Xz65NiQOAi8EKcNlHHdVdXR
	BFUOjdloxEZsX6G2yWP/9/BH5UqIMO/3bZzA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2zf9+sBsqSkyJE800lp4jBvi/UCcL3Y
	Yrm5zvAB+jAGImz3LdBJdMNjS52vfWZ8tx2p6nK6XRNC3vkrLslBoO837NOWKd8j
	0OIE/Ar/v8DARb0XpI0GScLFVEtU/lqYHz0n0aCwhH2GVfuB3VwTLre53bHRHfSo
	i/jyR5E0mew=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12477A0532;
	Sat, 21 Nov 2009 22:32:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 06FA1A0530; Sat, 21 Nov 2009
 22:32:43 -0500 (EST)
In-Reply-To: <7vws1jl0xp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 21 Nov 2009 18\:59\:14 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B3E8F58A-D717-11DE-A4E0-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133422>

Junio C Hamano <gitster@pobox.com> writes:

> Christoph Bartoschek <bartoschek@gmx.de> writes:
>
>> Why is the compiler not complaining about the fake initalization? For 
>> initialization a value is used that is not initialized.
>
> That is a fairly well established idiom to tell gcc "you may mistakenly
> think it isn't, but this is used".

Sorry, but I was called away from the keyboard in mid sentence.  It should
have read "...this is used after getting assigned, so do not worry".

But I need to clarify a few things about this issue.

As the maintainer, I do not like a fake initialisation myself very much.
It is a declaration that "left" is always assigned before getting used by
the person who wrote _that particular version_, but later updates to the
code might introduce a codepath to incorrectly use "left" before getting
assinged to, and the fake initialisation will prevent the compiler from
catching it.

When the variable in question is a pointer, assigning NULL instead of
"left = left" will at least give us a predictable and more reproducible
breakage when later updates break the code.  I wouldn't have minded if
David's patch were to update both the existing fake initialisation and the
new one to assign NULL.  At least dereferencing such a pointer will give
us a segfault reliably.  But unfortunately there is no such "magic" values
for variables of other types (e.g. int) to help us catch uninitialized use
of variables at runtime.

By the way, if a static analyser is meant to be useful for real-world
programs, as opposed to merely an academic exercise, it should know this
convention; like it or not, it is used fairly widely.  That is, it should
check "left" is assigned before used in the rest of the function without
this "gcc hack" initializer, and if the only questionable use of "left" is
the RHS of this fake initialisation, should refrain from warning.
