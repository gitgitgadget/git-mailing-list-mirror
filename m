From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Fri, 03 Jun 2011 09:11:19 -0700
Message-ID: <7vaadyc2u0.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <20110601220518.GA32681@sigill.intra.peff.net>
 <7vipspfazy.fsf@alter.siamese.dyndns.org>
 <20110601224754.GA16820@sigill.intra.peff.net>
 <20110603050901.GA883@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSWyH-0002pd-Pw
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 18:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab1FCQLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 12:11:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab1FCQLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 12:11:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D1B856AD;
	Fri,  3 Jun 2011 12:13:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ei0YqSsoaNLt+i4ZiEgqWBfCLAQ=; b=UNE5r8
	MZAXNfMoZYFgcSLcLyvWikHYDreON5AhaIuNByo150kpuiv5Wrnw0VcTVLKnmqPu
	t7hhYga0UYz8Lgrxa3vuD7NFi0AhqCQB5Yli+OIbhZIgEKeaEn+vz7y+oE+dMOHs
	T7Rd4xlMS9TMdey4lK2I2tZtNngM5tN+Nvww0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZfjB+JPWYFdOb5ewqyWtWNAWy9duPYpX
	lc5Gojr2CHNhBbnn/xc7uOQBCH3YTNNBruW5Y1+RBk95C2I9Yko+byt1cMboSVR0
	EO7yOG6RE5aCjL23L/3YBGs6S45ROyJMitrFhVfgcw9roiggAkQ1/5TQCHRV9HTP
	N+KhUMTP6yA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9146656AC;
	Fri,  3 Jun 2011 12:13:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7794056AB; Fri,  3 Jun 2011
 12:13:29 -0400 (EDT)
In-Reply-To: <20110603050901.GA883@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Jun 2011 01:09:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DD66CC4-8DFC-11E0-91B7-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175013>

Thanks. Looks sane in a somewhat weird way; the series is internally
consistent, and that is why I said "sane".

An alternative would be not to checkout anything when HEAD points at an
object that does not exist, or point the HEAD at the default "master"
branch just like in the case when we cannot guess uniquely. That way, we
do not have to worry about having to fetch the orphaned detached HEAD,
which is an unlikely thing the publisher wanted to feed to its recipients
in the first place. I tend to prefer the former (i.e. resulting in no
paths in the working tree, possibly with a big warning message "the
repository does not suggest which branch to track---are you sure you
wanted to clone from there?").

Seriously.

We treat the symbolic-ref on the publishing end not as the "current"
branch at all. It is used as the "suggested primary branch to track".  So
allowing to fetch from a repository with detached HEAD is already a weird
setup. I am hoping that we are not setting up origin/HEAD to point at
anything in this case, as the remote is telling us that there is no
suggested primary branch for the clients to track by having a detached
HEAD to begin with.

Even if you are fetching your own (or your pal's) repository with a
working tree to transfer a work-in-progress, any work on detached HEAD
that is orphaned is too transitory, and it goes against my taste to let
people fetch from it.

But people are free to have bad taste ;-).
