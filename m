From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] unpack_entry: do not die when we fail to apply a delta
Date: Fri, 14 Jun 2013 14:59:00 -0700
Message-ID: <7vk3lwmk0r.fsf@alter.siamese.dyndns.org>
References: <20130614214943.GA29138@sigill.intra.peff.net>
	<20130614215334.GB3821@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:59:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unc1V-0004IN-Li
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab3FNV7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:59:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab3FNV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:59:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B74E42708B;
	Fri, 14 Jun 2013 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vPyNS0ArzoaOIUVO4yRZCb3LpXw=; b=fzXTou
	EwckuAL5xkQ93H0jHkMomK/L4Piw4j2oV7hjZDQbbCETEWEATQaeEBkVvBWez3dc
	id3jDkJbs1CN0iKjBVp5G0BPk/bnOHWhsa8Od+lXhac2ev3j5Eo/aMqBSaBukLcJ
	bN9XLlWa8Yt6ajf8cWE3PkqgD/VmzOmmjhH58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PjvSai4f3N9li3uP5cZvAQE4XIKVk6r/
	ySLpYQPh40FE1QTdjGwJBnbIR9gn2F352h/V4q98foCJQ0Ks8j8g4jFujFdgr3DS
	sMIPe4MWUKSaGXe7SIamvg7Co4zKTlUIRZM4WpjpYiheZsn90rW6p4Kk2LzjNZ1g
	kJ+8VkjOO3M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEBBB2708A;
	Fri, 14 Jun 2013 21:59:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A4E027088;
	Fri, 14 Jun 2013 21:59:02 +0000 (UTC)
In-Reply-To: <20130614215334.GB3821@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Jun 2013 17:53:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F8EC736-D53D-11E2-8970-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227926>

Jeff King <peff@peff.net> writes:

>  test_expect_success \
> +    'corruption of delta base reference pointing to wrong object' \
> +    'create_new_pack --delta-base-offset &&
> +     git prune-packed &&
> +     printf "\220\033" | do_corrupt_object $blob_3 2 &&

Interesting.  You cheated in a different way with a hardcoded
offset, instead of hardcoded knowledge of where the object name
is stored in binary in the .idx file ;-)

> +     git cat-file blob $blob_1 >/dev/null &&
> +     git cat-file blob $blob_2 >/dev/null &&
> +     test_must_fail git cat-file blob $blob_3 >/dev/null'
> +
> +test_expect_success \
> +    '... but having a loose copy allows for full recovery' \
> +    'mv ${pack}.idx tmp &&
> +     git hash-object -t blob -w file_3 &&
> +     mv tmp ${pack}.idx &&
> +     git cat-file blob $blob_1 > /dev/null &&
> +     git cat-file blob $blob_2 > /dev/null &&
> +     git cat-file blob $blob_3 > /dev/null'
> +
> +test_expect_success \
> +    '... and then a repack "clears" the corruption' \
> +    'do_repack --delta-base-offset --no-reuse-delta &&
> +     git prune-packed &&
> +     git verify-pack ${pack}.pack &&
> +     git cat-file blob $blob_1 > /dev/null &&
> +     git cat-file blob $blob_2 > /dev/null &&
> +     git cat-file blob $blob_3 > /dev/null'

Nice.  Will replace the one I queued yesterday with these two patches.

> +test_expect_success \
>      'corrupting header to have too small output buffer fails unpack' \
>      'create_new_pack &&
>       git prune-packed &&
