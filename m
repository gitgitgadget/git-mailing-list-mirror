From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] unpack-trees: allow pruning with pathspec
Date: Tue, 30 Aug 2011 10:32:17 -0700
Message-ID: <7v7h5u3ivy.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-3-git-send-email-gitster@pobox.com>
 <CACsJy8CBJEimG5am8+aWTGP7kzuZ79WfZ3KQKh7pyjKTx-mR9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:32:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySAk-0003g4-BE
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab1H3RcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 13:32:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755822Ab1H3RcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:32:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BC1943AD;
	Tue, 30 Aug 2011 13:32:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=roCP8+kpOzIEG6rNYgXK3OMhj2U=; b=SpfMmG
	GkAKpL9GfY8JSgtl/7f8K0bJnO9u1kRsL04mE8zpcjhPkZlgPYkBznlsQ5Sqc3Oi
	GMqQSo32ukfwPEIn1P20/jxnCr0Ld/lxut36MbE00j0ks0zJDGQqjJhRcktU6ccH
	BCzcEXVS648EaU3NbyP6oGOr8IsTA5iPJanWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lr38UbTd7u4putAuttlkYM7JI8egFfaT
	jltDT3z5mlRJrYIUQoy4DJMhGtxNwiQ56kvgryBNGEuiC4JSiWvLjfpin/4KRYGD
	5lY2BowGA9EPBUT/bB7qrbsnFgOmE1pSsc6w9F2YX1j9pB6yrq1vPTVbYvelekvX
	0Y5Se8v4dhk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71ED243AC;
	Tue, 30 Aug 2011 13:32:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04E2B43AA; Tue, 30 Aug 2011
 13:32:18 -0400 (EDT)
In-Reply-To: <CACsJy8CBJEimG5am8+aWTGP7kzuZ79WfZ3KQKh7pyjKTx-mR9A@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 30 Aug 2011 20:03:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02D0D884-D32E-11E0-AF8B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180422>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Aug 30, 2011 at 4:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> and this codepath probably should not be enabled while running a merge
>
> But do you think if it works with merge (ie. a partial merge)?

I highly doubt it.

The primary reason why I doubt it would work is actually the same as the
very reason why a merge would work with unpack_trees() machinery. It walks
all the entries in the trees involved, picking matching entries that would
go in the result, while also picking the corresponding entry from the index,
and compute their merge and depositing the result in the final index. If
you "optimize" it by not walking some parts of trees, you don't just omit
merging damages made to these parts by other trees, but you also omit
recording the contributions by the current HEAD and the index. You would
need to compensate for that by doing something that copies the contents
of the index for paths outside the area covered by pathspec.

And whole point of this series is not doing that. We don't want to say
"because they are outside pathspec, we pretend that these paths in index
do not have corresponding entries in the trees we are merging into" and
end up producing creation filepairs for them.

But I honestly am not interested giving it unnecessary deep thought at
this point in the cycle. I haven't found a need for a low-level partial
merge machinery implementation to support any higher level workflows in
git, and the path-level 3-way merge machinery already exists in the form
of ll_merge().
