From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] gitweb: fix #patchNN anchors when path_info is
 enabled
Date: Fri, 18 Mar 2011 09:57:09 -0700
Message-ID: <7v7hbwxt7e.fsf@alter.siamese.dyndns.org>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
 <201103181359.46600.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 17:57:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0czP-0001nB-9B
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 17:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab1CRQ5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 12:57:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab1CRQ5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 12:57:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEA16417A;
	Fri, 18 Mar 2011 12:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TPdnY9Z4HSVc1/pq4HesMuxlBHU=; b=OtK6oW
	hQWCGqxGlJfx7P00jelNtRjjTQ4Hv5tGOZKLbOmK84fpPsS7nzSlxJ8QSbPJItQz
	w4mMLLeEJ/25EizPw2gFubtJAlx4VcV/6vy/R0uSuxXGTiwz3bXUSBnBzNm7cMhw
	L9gGQfm7jDKKqkkzP3QW//6vOqqEw99IJVQD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rPqbjYv/GYkiVTs4qVxznW/dup1aZSW7
	DO31aienk7kedctkGTrcMuyOgZBCSAmcxuhyF4k1ZXDJl1YlQkClVSp2Bc+p+s9w
	hIWfvd/YgMn6Ls1uVQtUeptQ19yTiRu27+NnJ0G5rpGRhLymmjlER8WoKVACWIx2
	BIVe5gSVExo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A655E4177;
	Fri, 18 Mar 2011 12:58:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75F084170; Fri, 18 Mar 2011
 12:58:46 -0400 (EDT)
In-Reply-To: <201103181359.46600.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 18 Mar 2011 13:59:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF89AB3A-5180-11E0-A691-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169338>

Jakub Narebski <jnareb@gmail.com> writes:

> I like v2 version, and had only small corrections.  For you to not have
> to resend this patch once again, I have added those corrections and sent
> them as a patch myself.
>
> Changes from original v2 version from Kevin Cernekee:
>
> * Fix (re-add) accidentally lost in v2 '"<td class=\"link\">"' in first
>   chunk using href(-anchor => ...)
> * Reword commit message (hopefully make it better, and not only longer)

Thanks.

> * Move code that sets implicit -replay when -anchor is the only parameter
>   lower, and change order of subexpression, for better possible future
>   extendability, if there would be other cases when we would want to 
>   automatically turn on -replay.

I think you meant this part:

	# implicit -replay
	$params{-replay} = 1 if (keys %params == 1 && $params{-anchor});

But I don't think it is that much of an improvement as long as it uses the
statement modifier syntax ("A if B") for a thing like this.

I will not bother rewriting the commit I made out of this patch myself,
but the next person who wants to add the auto-replay for his option will
first have to rewrite the above into:

	if (key %params == 1 && $params{-anchor}) {
		$params{-replay} = 1;
	}

before turning it into:

	if ((key %params == 1 && $params{-anchor}) ||
	    ("here comes my new condition")) {
		$params{-replay} = 1;
	}

anyway. If your rewrite were to a plain-vanilla "if () { ... }", it would
have been a real improvement.

Besides, I find it a bad taste to use statement modifier syntax unless the
modifying condition ("if B" part) is much more likely to hold true than
false.

If you limit your use of statement modifiers for conditions that almost
always hold true, it will become much easier to scan the code for the
first time, because you can skim through and almost ignore the condition
part to follow the logic for the normal case. But turning 'replay' on in a
specific narrow case (and later in a specific set of narrow cases) is a
complete opposite of normal codeflow.

Anyway, thanks for the clean-up.  Applied.
