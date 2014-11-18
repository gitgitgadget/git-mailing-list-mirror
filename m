From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 13:11:51 -0800
Message-ID: <xmqq61ecusbs.fsf@gitster.dls.corp.google.com>
References: <20141118203204.GM6527@google.com>
	<Pine.LNX.4.44L0.1411181541590.2918-100000@iolanthe.rowland.org>
	<xmqqa93ousme.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:12:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqq47-0002SQ-O2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbaKRVLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:11:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932419AbaKRVLy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:11:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86AF51F892;
	Tue, 18 Nov 2014 16:11:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crMrBM8XsYawhPcCa4SpRKtMt3w=; b=xddYFz
	5KWGhu2ckoIQPAB+rPf+qoYXDZ7Rwjt+Wz2K6fUVTomL6OvhRMD6s0Bk9yHxvFa8
	b1lMviRwj++RbskjQ3Gz5gTz8zKpnZ9WvNu3D6fCVUX1dvt8A1Odbg6XivO3c7T3
	rN/XomNjsju/fzayvtQXKZOFfPaIhP8bPdh+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DeS8eime3leTa31kKPJC/+AoP4V01C4T
	2iGy3tEU2PFLWYIj/CsvgkJLu4KRWjWQ0XGLFwtyqwNNLsLhs/h0/Wb0ic4zSzE5
	/VMJ1aIpb2otS4z4QD37XkIi7DFbap9Jh6v4Bf3PIBR3sKg8wHQiLYUQIT1G41GL
	jnJ293wWD4E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DCF01F891;
	Tue, 18 Nov 2014 16:11:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB90F1F88F;
	Tue, 18 Nov 2014 16:11:54 -0500 (EST)
In-Reply-To: <xmqqa93ousme.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Nov 2014 13:05:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 861476BE-6F67-11E4-92A6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Alan Stern <stern@rowland.harvard.edu> writes:
>
>> On Tue, 18 Nov 2014, Jonathan Nieder wrote:
>>
>>> Alan Stern wrote:
>>> 
>>> > Tracking down regressions.  Bisection isn't perfect.  Suppose a
>>> > bisection run ends up saying that B is the first bad commit.  It's easy
>>> > enough to build B and test it, to verify that it really is bad.
>>> >
>>> > But to be sure that B introduced the fault, it would help to find the
>>> > latest commit that doesn't include B's changes -- that is, the latest
>>> > commit that B isn't reachable from (or the maximal elements in the set
>>> > of all such commits).
>>> 
>>> Isn't that B^ (or B^ and B^2, if B is a merge)?
>>
>> No.  Here's a simple example:
>>
>>             Y
>>            /
>>           /
>>          X--B
>>
>> In this diagram, X = B^.  But B isn't reachable from either X or Y, 
>> whereas it is reachable from one of X's children (namely Y).
> ...
>
> Why do you say B is reachable from Y?
>
> If you mean that B is a merge between X and Y, then that is already
> covered by what Jonathan wrote "(or B^ and B^2 if B is a merge)".
>
>     X----Y
>      \    \
>       .----B
> ...

No, that cannot be what you meant.  I was confused.  The above
picture does not make B reachable from Y (it is the other way
around: B reaches Y).  The topology where B isn't reachable from
either X or Y and is reachable from Y would be

	X---Y	i.e. B = Y^2, X = Y^1 = B^1 
         \ /  
          B

If B is broken, and X is not, then Y would be contaminated by the
breakage B introduces relative to X, unless Y is an evil merge and
fixed that breakage while merging.

In any case, even if Y is found to be broken, its parent B is
already broken, so that does not place the blame on Y, does it?

Still confused why you feel Y is any significant...
