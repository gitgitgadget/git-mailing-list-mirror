From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach read-tree the -n|--dry-run option
Date: Wed, 11 May 2011 15:47:52 -0700
Message-ID: <7v8vucg8h3.fsf@alter.siamese.dyndns.org>
References: <4DC47242.6060205@web.de>
 <7vhb97xx5g.fsf@alter.siamese.dyndns.org>
 <7vfwoqwby5.fsf@alter.siamese.dyndns.org> <4DC67CF4.80901@web.de>
 <4DC70200.1080201@web.de> <7vwri0ric1.fsf@alter.siamese.dyndns.org>
 <4DCB04A1.3010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 12 00:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKICO-0007uj-Ab
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 00:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588Ab1EKWsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 18:48:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566Ab1EKWsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 18:48:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74F15476C;
	Wed, 11 May 2011 18:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PKVn0+eTdxOYvgEigi+EPY1igDY=; b=Bc2eaX
	vP/iq4EcUNHCGqgelkRBdazhBNJV3beDaDRUu2ldQFXxlwAix4hMPRPeC2rsw6SN
	uQQV/J77OCChvrZiTGZxbsY1uHybhdUZk/jjsYish1qzurrmvqXMjMnro4jwSS9w
	dIU0EBVj0U1gyH2431cslXkHFB8nZWg8JnFJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FoNmYjV0AivYBOvsVplPsjh1qeExoC3t
	1yzpTJkMJDeI/ckKFueWBiqkTRnRKjSePKfcyyeW6j4wg1cIWPCBbg2sy1NWIgeq
	2rfZhutARDSqC1D0CP4FAi+dhd4tvMK5+I/GJ+P6Ldtv5uC8pcNE5oMuDoxg5hrw
	N/amEqfzcHY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 449D74769;
	Wed, 11 May 2011 18:50:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36CF44766; Wed, 11 May 2011
 18:49:58 -0400 (EDT)
In-Reply-To: <4DCB04A1.3010202@web.de> (Jens Lehmann's message of "Wed, 11
 May 2011 23:50:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 017E8E4A-7C21-11E0-8CD2-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173432>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Using this option tells read-tree to not update the index. That makes it
> possible to check if updating the index would be successful without
> changing it.

Thanks for verifying the 3-way case as well.

> As using --dry-run is expected to have no side effects, this option makes
> no sense together with "-u".

I wondered if there be cases where "read-tree -m <1 to 3 trees>" will
succeed but the same command with "-u" can fail. If there were such cases,
we would need more than this patch does.

An obvious case is when you cannot write to your working tree, perhaps due
to ENOSPC or incorrect permission settings in the working tree, but I am
not worried about that. I am only worried about situations related to
version control (i.e. you may lose local changes).

I _think_ the only difference "-u" makes is that check_updates() makes
calls to checkout_entry(), and the only errors checkout_entry() would
catch are filesystem related ones. Even though there is one conditional
that says "if the cached stat does not match, you cannot checkout unless
you set .force to the checkout state", but unpack_trees() does set that
flag, so we should be safe.

Thanks.
