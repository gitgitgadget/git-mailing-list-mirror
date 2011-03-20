From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH -1/3] gitweb: Always call parse_date with timezone
 parameter
Date: Sat, 19 Mar 2011 17:27:50 -0700
Message-ID: <7v39miws8p.fsf@alter.siamese.dyndns.org>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost>
 <201103192318.45925.jnareb@gmail.com>
 <AANLkTimV7vvD0PTMejydiyW_CeUH0cuQ-2+PnRqjzob5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 01:28:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q16V8-0007N7-MJ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 01:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab1CTA2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 20:28:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab1CTA2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 20:28:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9652F4144;
	Sat, 19 Mar 2011 20:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=daf66pS/aUWHf4N7gvIvD80RMG8=; b=Mfk8LL
	hMoqh852qBfZE7qfYRk1ejJXXSeDef0EibvSqkyqR1ehZPI4wde950h11xS/luSs
	C6NX+NawvFUv44bk2nCaGEDdXq2fGCz5ybMhHzHm1XKyS0unJtYVUc2kGTHu4b/d
	YI9+oi891YMqX7vSrLBx2PlvhVU2OqE94qvbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmpL5ccO5AvX2ITinatK4H7eO5CpjIWu
	Sa61tHWEZIivuyZ33tfOIeFae6SKngCPv41bZ5jjVdizFL+eRqSzz8LaqVcIEwiO
	slK5BbEAZWVOQKfoil8CbnVUGgw7QxP71etv8AbjEW0G0SRtX3hOvv8B6mwoB57q
	iqJ86Dguc64=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63D684143;
	Sat, 19 Mar 2011 20:29:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 025664141; Sat, 19 Mar 2011
 20:29:27 -0400 (EDT)
In-Reply-To: <AANLkTimV7vvD0PTMejydiyW_CeUH0cuQ-2+PnRqjzob5@mail.gmail.com>
 (Kevin Cernekee's message of "Sat, 19 Mar 2011 15:56:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2012F8D0-5289-11E0-B103-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169478>

Kevin Cernekee <cernekee@gmail.com> writes:

> On Sat, Mar 19, 2011 at 3:18 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> ...
> Should be 'author_tz'
>
> Looking at the master branch, I don't see %ad actually getting used
> anywhere?  Maybe it is safe to delete the line entirely, since
> git_print_authorship() calls parse_date() itself.

Thanks for being careful, I agree "while at it, remove an unnecessary
call" would be better.

>> @@ -7064,7 +7064,7 @@ sub git_feed {
> ...
> Should be 'committer_tz'
>
> I would agree that it isn't such a good thing for
> $latest_date{'rfc2822_local'} to be set to GMT in this case.

I would say it isn't good in _any_ case.

If the localtime conversion logic _were_ very expensive, and if the
function that fills 'rfc2822_local' _were_ written to allow callers that
do not need local time by passing undef to its tz parameter to avoid the
computation cost, it may make sense to allow 'rfc2822_local' to be undef,
but neither is true.  This callsite was simply buggy.

> Am I correct in interpreting "PATCH -1/3" as: "apply this before
> Kevin's set of 3 patches?"

I had the same reaction; judging from the contents, I now realize that is
what was meant by "minus one", but originally I read that hyphen as "I
don't know how many iterations we had so instead of writing v$N I am just
striking it out" ;-)
