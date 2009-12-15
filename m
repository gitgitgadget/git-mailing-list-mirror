From: Junio C Hamano <gitster@pobox.com>
Subject: Re: the 100 mb push
Date: Tue, 15 Dec 2009 12:00:41 -0800
Message-ID: <7vzl5kypli.fsf@alter.siamese.dyndns.org>
References: <20091215192338.GA16654@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 21:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKdZq-0003uB-Jo
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 21:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbZLOUAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 15:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbZLOUAw
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 15:00:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbZLOUAv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 15:00:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A40D5A7FB4;
	Tue, 15 Dec 2009 15:00:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aSI4N6aJqYjokKIqrZbv1o2B18I=; b=MiKsXt
	DrUWMWVCYQs77uGX3q7xI2aKaMuwvv0qHosURflJIFRxfnaeq+0ZLBc85LpfxraV
	9FsKoWbiWGkBUmlCdKv1Grdstt5w8Uus/VI2W9naXHFTdZHgC7aaNhNjJCtXPiOl
	u+j/retnFdwL3jxMzpp5gL+5bucLcRmvxx3yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mvKmfjiZtGseLZRmZn0ce+ZOAgYmPUDt
	LQGJnj54Sl4gB1Vko6Xosx6OFoU+evbhTpFOZmJeol8qF0bpmSGGxF4EplHR/nx1
	27D44UsLE4dFD0To2AJqU1ucjdnIY59aNnSb9Ww3lo5IIJly2r+TWDdLaQKVScgT
	CI3P06tqmW0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8318AA7FB3;
	Tue, 15 Dec 2009 15:00:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 66C69A7FB0; Tue, 15 Dec 2009
 15:00:43 -0500 (EST)
In-Reply-To: <20091215192338.GA16654@gnu.kitenet.net> (Joey Hess's message of
 "Tue\, 15 Dec 2009 14\:23\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88B9EC70-E9B4-11DE-A1A9-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135296>

Joey Hess <joey@kitenet.net> writes:

> So, my question is, assuming this is not a straight up bug in git, would
> it make sense to avoid this gotcha in some way?

The "push" support was originally written for people who push into their
own repositories for publishing (i.e. almost always fast-forwarding) and
lacked the elaborate common ancestor discovery negotiation the "fetch"
side had.

Suppose you have a rewound or forked history, like this:


(their side)

                *---Y pu
               / 
          *---X
         /
    *---*---Z master


(your side)

          *---X---*---A pu
         /
    *---*---Z---*---B master

  - You were in sync when the 'pu' was at X with them; somebody pushed a
    few commits on top of it (forked case); or

  - You were in sync when the 'pu' was at Y with them (you pushed it their
    last time yourself), but you rebuilt 'pu' since then (rewound case).

If you run "git push there master +pu", it learns that the tips of
'master' and 'pu' are at Z and Y respectively at their end.  Because the
protocol did not negotiate the common ancestor, it would try to send:

    rev-list A B ^Z ^Y

but using only the information available at your end locally.

Because you either never have heard of (in a forked case) or no longer
know (in a rewound case) what 'Y' is, in order to update 'pu', you end up
sending commits 'Z..A', duplicating 'Z..X' part, because "^Y" cannot
participate in the ancestory computation.  Commits 'Z..B' will be sent to
update 'master'.

And this aspect of "git push" protocol hasn't changed much since it was
written.

In contrast, the protocol used for "fetch" tries to discover 'X' in such a
case by a little exchange, like this:

 downloader: Your tip is at 'Y'?  I've never heard of it.  Please
             tell me about its parents.

 uploader:   It is this "Y^", and its parent is 'X', and ...

 downloader: Ok, I know what 'X' is. I heard enough to proceed. Thank you.
