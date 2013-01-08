From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 08 Jan 2013 00:19:51 -0800
Message-ID: <7vobh0f5nc.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <7vd2xggm8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 09:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsUR1-0006Uo-CH
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 09:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab3AHIVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 03:21:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab3AHITy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 03:19:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5FA67FCD;
	Tue,  8 Jan 2013 03:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IPXb4C3z6nluBag079Szwl7ikWM=; b=YJ9+HN
	Uijg975VCw5OPFRvsljpJdip4ixM4w+IwlUqEmwY84E7e7TH/bm5H6IeWJcfnbou
	nnklf+963tBwRqWmlRu3BKIa0egIdH8L3p35GX0riEKGvFBz9RrpUQh5vkqsI3n9
	LoVLgEaTSX82UOxkWcITE2mor8VF5F5YsUKGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GEbG3wYbnET1BvRXnfr3xFpRpzVeEPPQ
	yGBc76Rjt9/xuAU0vAGa1jplp9B/dsPPdgVWJr4yIrl17ojTyyUtug/R+3IEjf16
	dALaa185rz8XALpPs6MSfAbtVQB4jhepyOo8zHht7T3ZLs5KX8fX42F8tlax4bnj
	rGirEQLTE88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8462B7FC9;
	Tue,  8 Jan 2013 03:19:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE0197FB9; Tue,  8 Jan 2013
 03:19:52 -0500 (EST)
In-Reply-To: <7vd2xggm8a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Jan 2013 23:36:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D7F066C-596C-11E2-AE06-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212950>

Junio C Hamano <gitster@pobox.com> writes:

> I think we need a protocol update to fix this; instead of sending
> "Now I want your tips and N commits behind it, please update my
> shallow bottom accordingly", which creates the above by giving you Z
> and 3 generations back and updates your cut-off point to W, the
> receiving end should be able to ask "I have a shallow history that
> cuts off at these commits. I want to get the history leading up to
> your tips, and also deepen the history further back from my current
> cut-off points by N commits", so that you would instead end up with
> something like this:
>
>  (you)
>      o---o---o---A---B---C---D---E---F---...---W---X---Y---Z
>
> That is, truly "deepen my history by 3".  We could call that "git
> fetch --deepen=3" or something.

I take that back.  If you start from

>  (upstream)
>   ---o---o---o---A---B
>
>  (you)
>                  A---B

and you are interested in peeking the history a bit deeper, you
should be able to ask "I have a shallow history that cuts off at
these commits. I want my history deepened by N commits.  I do not
care where your current tips are, by the way." with

    git fetch --deepen=3 

and end up with

>  (you)
>      o---o---o---A---B

without getting the new history leading to the updated tip at the
upstream.  If you want the new history leading to the updated tip,
you can just say:

    git fetch

without any --depth nor --deepen option to end up with:

>  (you)
>                  A---B---C---D---E---F---...---W---X---Y---Z

instead.
