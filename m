From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Sun, 20 Jun 2010 17:03:56 -0700
Message-ID: <7vk4pttfo3.fsf@alter.siamese.dyndns.org>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006181140.16652.johan@herland.net>
 <7vzkyptwat.fsf@alter.siamese.dyndns.org>
 <201006210106.07758.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 21 02:04:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQUUy-0008W1-N1
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 02:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab0FUAEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 20:04:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab0FUAEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 20:04:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F281BD7CF;
	Sun, 20 Jun 2010 20:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=13RT2h2xKKSM79r96gjidwNkmRM=; b=PxWghb
	chul7c6Zq9yLaZfMUFC5KjIeo2Dpg8cioRrsnkDyCRflKxUQdQ8GWSNKTfd9JQCU
	Kw1265yWTOlzhMmeHEE8pAv+gkFwBwwkUPSbl3Fl4n/Wvv0+o2/YFZ6BieQ3EVf9
	k7/i4bq0h1RZ5MHKSxfjVOcMBbl9Oaowlb4bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W+94S5/jWoy4J0WR7rxtWmzLBhx7rqah
	TO+IpWAyJxPZKEkuHJlsO7f8bMuFmWUrWxAKjuFrlH3DOSp9H4F1Aqv0p6n/aNUX
	maUF2QqhSD84ABDt+708I0mxMDFtb0la/vbaALgaj+bwYDry8x2F7lqVtmm4FTrw
	nNDKXFLkASo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AFE2BD7CB;
	Sun, 20 Jun 2010 20:04:03 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 452B5BD7C9; Sun, 20 Jun
 2010 20:03:58 -0400 (EDT)
In-Reply-To: <201006210106.07758.johan@herland.net> (Johan Herland's message
 of "Mon\, 21 Jun 2010 01\:06\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8041852E-7CC8-11DF-BAA4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149408>

Johan Herland <johan@herland.net> writes:

>> For an "automated" heuristics based on "find common descendants" to make
>> sense, the branches you are merging have to share the common purpose, and
>> you need to limit the common descendants you find to the ones that are
>> compatible with the shared purpose.  The purpose of 'maintenance track'
>> may be to maintain the previous version without dragging newer and more
>> exciting things that happened in the later development.  In the above
>> picture, G (that has nothing but B and F) is the only commit that can be
>> safely assumed that two commits in the superproject space that bind B and
>> F respectively can use as the submodule as their merge result.  E and I
>> are contaminated with D and H whose purpose in the superproject space is
>> unknown without further hint.
>
> Yes, from a 'maint'-perspective, using G in the superproject probably makes 
> more sense than using E or I. From a different superproject perspective, 
> though, using E or I might make more sense.

Actually, what I was alluding to was that 'G' would be the _only_ commit
that may make sense (note that G may not necessarily make sense, but the
point is that we can say that others do _not_ make sense as alternatives)
if we know that the context of making the superproject merge is that it is
doing the 'maintenance track' merge.  Similarly, if we know that the merge
being done in the superproject is in the 'master' context, 'E' would be
the _only_ plausible candidate, similarly for 'I' in 'next' context.

It is further plausible to imagine that the .gitmodules file tracked in
the superproject's 'maint' branch can be used to express that 'maint'
branch of the submodule should be used.

If we revisit the Alice and Bob example with such an arrangement, if they
were working on their branches so that their results would be included in
the 'maint' track of the superproject, there won't be a merge conflict in
the .gitmodules file at the superproject level when their branch tips are
merged; we will know that the merged .gitmodules file will tell us that we
would want to follow 'maint' branch of the submodule.

Similarly if Alice were fixing a bug in 'maint' but Bob were advancing
features in 'master', then merging .gitmodules at the superproject level
will fast-forward at the path level (i.e. Alice didn't touch, but Bob
changed, so we take Bob's change), instructing us to follow 'master'
branch from the submodule automatically.
