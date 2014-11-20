From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Thu, 20 Nov 2014 09:23:21 -0800
Message-ID: <xmqqegsx4whi.fsf@gitster.dls.corp.google.com>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
	<20141119191502.GC9908@peff.net>
	<xmqqbno2rhlz.fsf@gitster.dls.corp.google.com>
	<546DB778.2000000@drmicha.warpmail.net>
	<20141120155621.GA30273@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 18:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrVSX-0006Rh-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 18:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbaKTRXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 12:23:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757356AbaKTRXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 12:23:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A27D1E2C0;
	Thu, 20 Nov 2014 12:23:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kajt4TuSeegIFpuMwNsmNn3kWI4=; b=oiUgbG
	CKTIl0kK4zJ350qUOlyVpXvC1dseJahSiFmRHurkbqoee1mRsoJx0lSrnByoc9kA
	akQfdhl5lY1lY5o3Iu1XJGgDPBhzYhAk3TBGQH5zsStbL8JdJZOo77UVwu5BE9UO
	2q/SN+z5Sp6qzi7LUwFiTP2dloXfbv+k3xt9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=baez6+oMtCj6XUnABz4IM6lzTCE8SijG
	8G2U3JTDwFQJiqfiOlEYGDnpkQ+KrwgkrmSMhCz+xE3+DMVCDYdpIlfr0XpI2DVC
	kQabVMjC2dtx4LT2iTClKXl1c9NSWHWXodQ9Fx2JI6aaaODVPqYRESBNA9kPwQ53
	6LmUDqQCI1I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EF3A1E2BF;
	Thu, 20 Nov 2014 12:23:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2B941E2AC;
	Thu, 20 Nov 2014 12:23:23 -0500 (EST)
In-Reply-To: <20141120155621.GA30273@peff.net> (Jeff King's message of "Thu,
	20 Nov 2014 10:56:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE74065C-70D9-11E4-BDAF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 20, 2014 at 10:42:16AM +0100, Michael J Gruber wrote:
>
>> >> Perhaps we could do a hybrid: add the files that were not ignored, but
>> >> then still exit non-zero. Careful scripts need to check the exit status
>> >> of "git add" anyway, and sloppy humans with over-broad wildcards
>> >> typically do not care about the exit status.
>> > 
>> > ;-)
>> > 
>> 
>> You can simply say "Michael" in your last subclause above :)
>> 
>> I'm wondering whether that behaviour change (without --ignore-errors) is
>> OK - I don't mind, but hey, I usually don't.
>
> I can't think of a case that it really hurts, but then I have not
> thought too hard on it. If you want to play with it, I think the patch
> is as simple as:
>
> diff --git a/builtin/add.c b/builtin/add.c
> index ae6d3e2..1074e32 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -284,7 +284,7 @@ static int add_files(struct dir_struct *dir, int flags)
>  		for (i = 0; i < dir->ignored_nr; i++)
>  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
>  		fprintf(stderr, _("Use -f if you really want to add them.\n"));
> -		die(_("no files added"));
> +		exit_status = 1;
>  	}
>  
>  	for (i = 0; i < dir->nr; i++)
>
> It needs a tweak to t3700.35, which expects the "fatal:" line on stderr.
> But other than that, it passes all tests. So it must be good, right? :)

;-)

It indeed is a behaviour change, but I do not expect it would be too
heavy a change to require us a transition period or major version
bump.  But because that is just my expectation, which is not what
real world users would expect, so I'd prefer to cook such a change
for at least a cycle and a half in 'next'.
