From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Thu, 16 Aug 2012 09:26:33 -0700
Message-ID: <7vwr0y247a.fsf@alter.siamese.dyndns.org>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org>
 <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
 <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com>
 <7v8vdjfddk.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtwS=fdjTCVsEQHdVn9p+_2k-wJ_W_zLtZkWGO+M4suNQ@mail.gmail.com>
 <7vmx1v2y01.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtgq7j67RU28ziQN4xUX7S5-YcaiApmcpMSYdamV-0SgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T22uB-0002EF-E5
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab2HPQ0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:26:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab2HPQ0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 12:26:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D48F783B5;
	Thu, 16 Aug 2012 12:26:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/Ixecp8fJ13adDgblYppPuf9RQ=; b=pOJ+xR
	S53ID0vHXrS5kYER6QCMrQzhIij1T/9PCQCUwKTrbEclabReUEcXWwadOOjQgEzg
	O3+MkwrdBaV5ibbacSV4Jvk2vhmNx7P+zVQkfDot2wMcPIP4ia/qYTcAIyVUaR1+
	ZBXwJHvkYTp7E3BE5zxj66tv6UOexqR1q6OvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVHR/rE4rT5tVu5zZgXYSGezETeOFyab
	rRgYiJE8X8r1GAjFPYFK35VLoIg4pleDXifJvW+UbeX0g04QHh4Q4TxMJwQ3PDdD
	W6Qci1BIlFVEpPbM9WBmRGAcR4+n4i89GKAQxQyRgOvp4DI9sEnriHlRovJckw26
	4UinWQetzVo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1DCE83B4;
	Thu, 16 Aug 2012 12:26:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5450783B3; Thu, 16 Aug 2012
 12:26:35 -0400 (EDT)
In-Reply-To: <CAJo=hJtgq7j67RU28ziQN4xUX7S5-YcaiApmcpMSYdamV-0SgQ@mail.gmail.com> (Shawn
 Pearce's message of "Thu, 16 Aug 2012 08:54:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 259B4F06-E7BF-11E1-8176-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> On Wed, Aug 15, 2012 at 10:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> An obvious way to record the "delta chain" is to simply keep the
>> name_hash of each object in the pack, which would need 2 bytes per
>> object in the pack, that would bloat pack_idx_entry size from 32
>> bytes to 34 bytes per entry.  That way, after your bitmap discovers
>> an object that cannot reuse existing deltas, you can throw it, other
>> such objects with the same name-hash, and then objects that you know
>> will be available to the recipient (you mark the last category of
>> objects as "preferred base"), into the delta_list so that they are
>> close together in the delta window.
>
> Yes, this is one thought I had. Inside of JGit I think the name hash
> is 32 bits, not 16 bits. Storing the name hash into the *.idx file
> means we need to codify what the name hash algorithm is for a given
> *.idx file version, and compatible implementations of Git must use the
> same hash function. Thus far the name hash has been an in-memory
> transient concept that doesn't need to be persisted across runs of the
> packer. Storing it means we have to do that.

Let's not go there.  We cannot resurrect the name hash out of *.pack
stream, which means index-pack cannot recreate it after receiving
objects over the network.  We would need to instead teach index-pack
to observe the delta chains, and come up with some "delta chain
identifier" (unique name to identify what you called "delta cluster"
in your response) on its own, and give it to each object when it
writes the *.idx file out.
