From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Fri, 05 Aug 2011 22:22:12 -0700
Message-ID: <7vr54z15dn.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <7v4o1y81sv.fsf@alter.siamese.dyndns.org>
 <CABPp-BE=9r+upGUD45J7fPshqQE97UMZzaA+cu_WJ1A2p_Bigg@mail.gmail.com>
 <7vpqkl3sok.fsf@alter.siamese.dyndns.org>
 <CABPp-BFx38gLQDn0sccp74Z=RtEVzaxWiVqopxkWwXTSGuYxxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 07:22:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpZL8-00076N-Lh
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 07:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059Ab1HFFWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 01:22:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab1HFFWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 01:22:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BFB25F30;
	Sat,  6 Aug 2011 01:22:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Uba/OTeYIFAhb6hdT7kd/gAwiI=; b=MrPPxx
	XA7ju54RGb+u8bXzGBeuYRxyh3nueyNU1yq1e4faqc1hVXD9drsXkTqE6LAMIS20
	RMbef7xH5uCOqXIQ5ciRmjmXQQK63Dw/+3kDut8M0ejSowq9CtCymv1yXyqA8BgO
	Wc3UZkleG4GMWVOo/tOs/uqCp/Zf1lWKY7IzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=phRq9nM1fXSr0Cdq5mFwceg4v5Vut9Jz
	xrHXe6T8BYYOxASAiOrQDeAsNU+dmC3+hipH9aAM5OobYIpBAys/A9+em08Y2Rwz
	Tnk4RIHG4ILa5HVGsNZEZff9jOJvfQgOtzMjLaFIScV2EpRKpZ3EWB6Ffa27KMGh
	gF+o689e81g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F9D35F2F;
	Sat,  6 Aug 2011 01:22:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12AEE5F2B; Sat,  6 Aug 2011
 01:22:13 -0400 (EDT)
In-Reply-To: <CABPp-BFx38gLQDn0sccp74Z=RtEVzaxWiVqopxkWwXTSGuYxxw@mail.gmail.com> (Elijah
 Newren's message of "Thu, 4 Aug 2011 13:16:35 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B1EF4D0-BFEC-11E0-B376-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178828>

Elijah Newren <newren@gmail.com> writes:

> On Thu, Aug 4, 2011 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> ... It
>>> would be nice to make use of the original index we had before
>>> unpacking, but that is overwritten at the end of unpack_trees.
>>
>> I somehow thought that we can give separate src and dst index
>> to the unpack_tree() machinery these days. Aren't you using it?
>
> Ah, yes, it appears to be possible.

But why do you care about the original index (i.e. the starting state of
our side) in the first place? If your algorithm depends on the original
index, wouldn't that mean you would screw up the same merge if the user
merged branches in the opposite direction?

I think the fact you have a path "two" at stage 0, combined with the two
diffs you ran for rename detection between the common ancestor and two
branches, should be enough to decide if one branch added the path or moved
it from elsewhere (in which case the common ancestor would not have that
path), or it kept the path at the original place (with or without content
change), no?
