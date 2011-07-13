From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Wed, 13 Jul 2011 14:12:55 -0700
Message-ID: <7vpqld6g14.fsf@alter.siamese.dyndns.org>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
 <20110713072350.GA18614@sigill.intra.peff.net>
 <7vaach7wfh.fsf@alter.siamese.dyndns.org>
 <20110713205844.GA15435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:13:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6jw-0001r0-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 23:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab1GMVM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 17:12:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab1GMVM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 17:12:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C199F698C;
	Wed, 13 Jul 2011 17:12:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PDaaGyBsRwVxjIQKh00hutJ95nM=; b=pgKEsj
	iOBK3PRFzJ0zOxYpo8FEPKQGkxwmoxiu1HcnqJY6gwdC0QSJ3ud5t8KFbjw/yB9C
	Jsk00rA09v4F0kmATGSYOHzCM0lE6Q474A3jCtPI8Qiypfjzpr8PtLO9LQ/JuTWl
	dinW4a3cNjvIMVe5yOjNgs6MkJ0GAYpdk0YeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tr6VjwZ6eE17U8UHOy4WbmSR2dZMdhDM
	e6mD8jJTOrxvAsLC8dwKTnHq4+EFld+O6VSkj88UCMSsP7OUEOks74vXXjsFHFTp
	GsNFqjaNVqykJFM/KDArz/Mj6lBXdv1ziMXam8fmL/O4ahwa+yGv3VxS+4y80rU4
	34X+1ycO5bw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8BC6698B;
	Wed, 13 Jul 2011 17:12:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0546D698A; Wed, 13 Jul 2011
 17:12:56 -0400 (EDT)
In-Reply-To: <20110713205844.GA15435@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Jul 2011 16:58:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1789C44-AD94-11E0-ADC8-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177083>

Jeff King <peff@peff.net> writes:

> Or are you suggesting dropping generations entirely, and just using
> marked-up commit timestamps (or even a flag saying "this timestamp is
> bogus, don't use it for cutoffs")?

Not suggesting, but that was exactly what I was wondering.  For example,
still_interesting() in revision.c says "compare timestamp and return SLOP,
not 'we are done'", and presumably that code could notice that "ah, this
commit is marked as being on a stretch that timestamp based cut-off is
unusable--keep digging". The "tag --contains" and "name-rev" would also
have similar logic (I haven't looked at them for a while though).

> But there's a big question of deciding which timestamps are bogus.

I agree that the ones that you need to dig through may not be the ones
with bogus timestamps, but either an ancestor or a descendant (I haven't
thought it through) of a commit with bogus timestamp. That is why I said
"a commit on a stretch that timestamp based cut-off is unusable".

> But I think I still like generation numbers because:
>
>   1. They're simple, complete, and unambiguous.

No question nor dispute about it.

> The only slowness for the generation slowness is the
> extra I/O on writing out the cache. But it's not very much,...

Ok.
