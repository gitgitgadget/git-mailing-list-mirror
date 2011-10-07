From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/2] Be more careful when prunning
Date: Fri, 07 Oct 2011 16:00:07 -0700
Message-ID: <7v39f4tnk8.fsf@alter.siamese.dyndns.org>
References: <20111004103624.GA11863@sigill.intra.peff.net>
 <1317920187-17389-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Oct 08 01:00:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCJPG-0005E2-Ro
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 01:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759017Ab1JGXAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 19:00:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab1JGXAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 19:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B50C5EFD;
	Fri,  7 Oct 2011 19:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4V/TMdIbJRgA
	0TjeU7uveiqWiuU=; b=Grni1jJcVqUqbD0YvXjRk3+JSGnTr/hRVbxQPLRl8ouQ
	ghNzd8cqvLv8h3JiGKzW4+yXBA7VJ36Yaj55XFQPCzTVsO1nI6B4hIIAfnScUS1f
	Zmz8s9sw9FtlXfXHaVkwv5YBXYkAm81D5tCgjV8tRe+hcB+ZirHfyZvcQoFku4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jBVZ2z
	6SOp8yOun8TGRapm833YA73mmHxbeKmeN7b3zFYD+cG1XJxqQnaN4JKP68WlOOgW
	ht53EI0yuoybKO6NDjuNmhiPeEJfhNNmMul0duINCg12iWv6MDwYpkL5aCqvvbvr
	yrxN3u2WKmYiSyEAXzDij/1gmJ23BG1w8FGAM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 927925EFC;
	Fri,  7 Oct 2011 19:00:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EF835EFB; Fri,  7 Oct 2011
 19:00:08 -0400 (EDT)
In-Reply-To: <1317920187-17389-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 6 Oct 2011 18:56:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B5E10EC-F138-11E0-A2B3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183125>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Now comes the interesting part: when --tags is given, there is no
> refspec set up, fetch just sets up a global variable. What I'm
> thinking (and going to implement after dinner, unless people cry out
> against it) is this: just before calling prune_refs, add a refspec to
> the user-provided list with the refspec refs/tags/*:refs/tags/*
> similar to what fetch_one does if you gave it "tag v1.5.6". This woul=
d
> cause us to ignore the configured refspec and keep the branches. The
> lack of '+' is most certainly on purpose. Is there anything
> fundamentally wrong with that idea?

It sounds like that the approach should work and preserve the current
"fetch --tags" semantics, but with one small caveat (which is not a
downside).

As was discussed in a few separate threads last month, in the longer te=
rm
I think we should fix the semantics of "fetch --tags" to mean "in addit=
ion
to what you usually fetch with the configured refspecs, add that all
matching refs/tags/*:refs/tags/* to the refspec" to reduce confusion.
"Only fetch tags" may make sense if you have everything else, but by
itself it is somewhat a senseless thing to do.

The semantics has been kept this way only from fear of breaking backwar=
d
compatibility, but because nobody wants to only fetch tags without
branches, this forces people to say "git fetch && git fetch --tags".

We should re-evaluate the design and change it at a major version
boundary, I would think. And when that happens, we may need to rip out =
the
special case you discussed above.

Thanks.
