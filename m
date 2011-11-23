From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/3] revert: introduce --abort to cancel a failed
 cherry-pick
Date: Tue, 22 Nov 2011 16:43:55 -0800
Message-ID: <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 01:45:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT0xu-00083D-Po
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 01:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821Ab1KWAn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 19:43:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932785Ab1KWAn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 19:43:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18CC165B7;
	Tue, 22 Nov 2011 19:43:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ch+2K22fwLTuAAQEkXRPtq0/Hs0=; b=ulA3EO
	y16y8Zz/JExXWizE6z85DtdJxkwy2zWv7+ODxQ3mKpNK9FUCElEaxWGnW/Iun45E
	ev9ReSmqklxx3re8n/xXQETOP4u76pxbQiu2b/qYs0G9zCujdbxQk1Cmcu3+bNG6
	t4oZHFw0X1Gm+6KGU3dwKWePOJ+5VyUYBdhpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TsYwm48a8Zs6+pA5sRCeA51MisOIElAQ
	+VvgC0R2Ra873C3P7qWnAUzriqgOFJamN3OaaeIQkTaCv75GmNDAyDdTgwl04R7Z
	D/TLL0n4FFvr1QEbl3xhxO2pDrB/4vc6sCCVvlzsWyHeVHlEeHIM3Q/jDA+FEpYF
	+yUP3P1aK5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0CC65B6;
	Tue, 22 Nov 2011 19:43:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B0B165B5; Tue, 22 Nov 2011
 19:43:56 -0500 (EST)
In-Reply-To: <20111122112001.GF7399@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Tue, 22 Nov 2011 05:20:02 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39ACA358-156C-11E1-8237-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185815>

Jonathan Nieder <jrnieder@gmail.com> writes:

> After running some ill-advised command like "git cherry-pick
> HEAD..linux-next", the bewildered novice may want to return to more
> familiar territory.  Introduce a "git cherry-pick --abort" command
> that rolls back the entire cherry-pick sequence and places the
> repository back on solid ground.
>
> Just like "git merge --abort", this internally uses "git reset
> --merge", so local changes not involved in the conflict resolution are
> preserved.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> ...
> @@ -168,6 +265,7 @@ test_expect_success '--continue continues after conflicts are resolved' '
>  	OBJID
>  	:100644 100644 OBJID OBJID M	unrelated
>  	OBJID
> +	:000000 100644 OBJID OBJID A	bar
>  	:000000 100644 OBJID OBJID A	foo
>  	:000000 100644 OBJID OBJID A	unrelated
>  	EOF

What is this hunk about?  Don't you also need another one to the test
after that one?  When merged with rr/revert-cherry-pick series, t3510 seems
to misbehave around this area.
