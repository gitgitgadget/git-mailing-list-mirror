From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] refs.c: pass a list of names to skip to is_refname_available
Date: Thu, 02 Oct 2014 12:18:50 -0700
Message-ID: <xmqq61g2nuud.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com> <20141002014817.GS1175@google.com>
	<20141002020332.GB1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 21:19:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZlu0-00079N-H8
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 21:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbaJBTSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 15:18:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52234 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbaJBTSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 15:18:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC65D3FE85;
	Thu,  2 Oct 2014 15:18:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j8wwGOLPtYyRzm+LBn7keTA8t2M=; b=RBLHSk
	pkkmQ76CAimRy/1Oupy3bKEUy++FGNMUfG8mJkHY5JUrXZEilB13IJR5px+cVRa+
	ms/SZzoEC46O1hYln1JpIa21bjkZOrUrUTnjQocqJ7c9RSewkBJOVq1P5CexeSS0
	QdAZiz5SRKG01LpXSEfn/NZWkrOwdyVkFZneM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cd/C+umEtcLpNWp7b6sZ33NtmhOGgMDu
	3E0kSxsDF7ZbcwYRTHu9raT4ksPGpp73qfuSIdHB+4SyhqnLEIlSWup0flxvnuQU
	UOYcI4HSU9mCwhPh5gc/1FHMjKsCJTFH2JhZLGwJxOTLBuih8Y4M8QIMIyj2Hy4y
	cxJ1f4QONvg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A063D3FE84;
	Thu,  2 Oct 2014 15:18:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 27BB13FE7F;
	Thu,  2 Oct 2014 15:18:52 -0400 (EDT)
In-Reply-To: <20141002020332.GB1175@google.com> (Jonathan Nieder's message of
	"Wed, 1 Oct 2014 19:03:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F1CCE46E-4A68-11E4-BEEB-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257818>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/refs.c b/refs.c
> index f124c2b..6820c93 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -801,14 +801,16 @@ static int names_conflict(const char *refname1, const char *refname2)
>  
>  struct name_conflict_cb {
>  	const char *refname;
> -	const char *oldrefname;
>  	const char *conflicting_refname;
> +	struct string_list *skiplist;
>  };

As cbe73331 (refs: speed up is_refname_available, 2014-09-10)
touches the same area and is now in 'master', the logic around here
in this series needs to be reworked.

Thanks.
