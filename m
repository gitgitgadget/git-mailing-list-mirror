From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] branch: skip commit checks when deleting symref
 branches
Date: Thu, 18 Oct 2012 14:34:23 -0700
Message-ID: <7vpq4flb1c.fsf@alter.siamese.dyndns.org>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com>
 <507D315E.8040101@lsrfire.ath.cx> <7vr4oytn4q.fsf@alter.siamese.dyndns.org>
 <507FEF0B.1060309@lsrfire.ath.cx> <507FF0EF.3070702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Miklos Vajna <vmiklos@suse.cz>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:34:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOxji-0003AN-L1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 23:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab2JRVe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 17:34:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799Ab2JRVe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 17:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9CA08766;
	Thu, 18 Oct 2012 17:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W6Y1vgm+2YwP
	r/n+rUhsED9J/vc=; b=gfleS2C/JXI9TG+rZEA32ZUBNhASBPRThHZXxUCXNOvP
	qd9n7TeqsDqcwh7wmywEaSUESMmZZKf4kfZ7OmTctVOPLJz/W3o7vh+Ey1Jg/hi4
	hXhRthf//RC2AXJikDl3c0THX7tvO98NBrGkJ8ec/TRizOHkr1KDEGnxUe5XkU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ob7kth
	bLJi1UuOWmhS98EUizFfyPSXhmv1zR9FvWFpkFvFoV+UOq51GsVSuGJbuSVNHkg5
	6jYzbYTFdjRxrtmCQBe8Ps/tA0cxunZK2H0qWry/E0TDz0TEnxuC7UBAQbQBoEjC
	oMpJrF04h494klgYH2VBc5rlnEqpp9S57dbdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B158765;
	Thu, 18 Oct 2012 17:34:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C3988764; Thu, 18 Oct 2012
 17:34:25 -0400 (EDT)
In-Reply-To: <507FF0EF.3070702@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu, 18 Oct 2012 14:07:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 968D035C-196B-11E2-BDF9-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208021>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Before a branch is deleted, we check that it points to a valid
> commit.  With -d we also check that the commit is a merged; this
> check is not done with -D.
>
> The reason for that is that commits pointed to by branches should
> never go missing; if they do then something broke and it's better
> to stop instead of adding to the mess.  And a non-merged commit
> may contain changes that are worth preserving, so we require the
> stronger option -D instead of -d to get rid of them.
>
> If a branch consists of a symref, these concerns don't apply.
> Deleting such a branch can't make a commit become unreferenced,
> so we don't need to check if it is merged, or even if it is
> actually a valid commit.  Skip them in that case.  This allows
> us to delete dangling symref branches.

Purist in me tells me that we should be using "symbolic-ref -d" to
correct from such a misconfiguration, but ignoring that, the above
logic makes perfect sense to me, especially together with the next
change to tell what branch the symref was pointing at, which can be
used by the user when the user removes such a symbolic ref by
mistake.

Thanks.  Will queue all five.
