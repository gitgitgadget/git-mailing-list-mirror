From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/8] Add concept of 'publish' branch
Date: Fri, 11 Apr 2014 12:48:39 -0700
Message-ID: <xmqqr453r6js.fsf@gitster.dls.corp.google.com>
References: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
	<1397239151-2391-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:48:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYhRS-0001yw-PO
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbaDKTso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:48:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbaDKTsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:48:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 729DD7AAEA;
	Fri, 11 Apr 2014 15:48:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FFwXtviXRvViFiWWkcrc1QXT5Oc=; b=wRM1Q/
	QatOaohiuD3t9l2lBJkck7YTUKWIQF06FCg/TJYWMaLKGZG1fVYFCiTWoWl7chGY
	gF0X2G2oTwMy8/GJme1xxLeBtPoCG/lkWkUkatw5kUPI8R6pGs0PzZTrJSiG5Mia
	ANR9rxisIWmKJE7ycCAIBjkuMNoofmDYymxAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CMOUbb4tvEIifBEsREDjdnBjxW1n4Yyf
	bS3JgBIac+xM9Q2eS84nrAZ0X0Ji0i2e6M75RKIV1szvjG+jB/UFDkCwEO6pMUM7
	cbOEyh6nMJZrTIKgyGAhDlcvXj2ha1htYbIXV0bo8QNbxtIKDcAi2mLaiLtngKTd
	f5anP2p6kKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F44F7AAE9;
	Fri, 11 Apr 2014 15:48:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA73A7AAE8;
	Fri, 11 Apr 2014 15:48:40 -0400 (EDT)
In-Reply-To: <1397239151-2391-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 11 Apr 2014 12:59:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 481F2C54-C1B2-11E3-BFC6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246138>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The publish branch is the branch the user wants to push to, akin to the
> upstream branch, which is the branch the user wants to use as a
> baseline. It overrides other configurations, such as push.default, and
> remote.<name>.push.
>
> The upstream branch is:
>
>   branch.$name.remote
>   branch.$name.merge

These two configuration variables are *NOT* the "upstream branch";
it is more like "the upstream branch of $name is _defined_ with
these two variables".

For example, with:

	[remote "foo"]
        	fetch = refs/heads/*:refs/remotes/foo/*
	[branch "bar"]
        	remote = foo
                merge = baz

The upstream branch of 'bar' is refs/remotes/foo/baz, and that is
determined by consulting these two variables, branch.bar.remote and
branch.bar.merge to learn that we look at refs/heads/baz from foo
and also refs/remotes/foo/baz is where we keep a copy of that.

> The publish branch is:
>
>   branch.$name.pushremote
>   branch.$name.push

Can you give a description for "the publish branch for $name" here
in a way similar to "the upstream" I gave an example above, so that
anybody reading this log message can answer questions like...

When the end users say master@{publish}, what conceptually are they
naming?  Can they use master@{publish} in a way similar to:

 $ git log master@{upstream}..master

that gives us what we did since we forked, because master@{upstream}
names the remote-tracking branch we locally have for the branch our
'master' integrates with?

Thanks.
