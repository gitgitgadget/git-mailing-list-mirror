From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Fri, 28 Feb 2014 10:04:32 -0800
Message-ID: <xmqqy50vun9r.fsf@gitster.dls.corp.google.com>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
	<1393491610-19476-2-git-send-email-cmn@elego.de>
	<xmqqob1sxq8v.fsf@gitster.dls.corp.google.com>
	<1393590104.5277.19.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Feb 28 19:04:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRnc-0001fE-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 19:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbaB1SEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 13:04:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbaB1SEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 13:04:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B8B6E86B;
	Fri, 28 Feb 2014 13:04:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lSqIQkMPrLlB
	an5UWRbxEBn9CEI=; b=Mfa97m23Oi9xJXUYWQuYVH9C9j/6ae7g9IQK0zp1D7Lv
	M2EPVuAQGIOdvhCRh7ltbmrOYBjUGkFqgBTPW9nw0PFAM/4qfaMDDs841Kx7lvqC
	csRs1VvhxsCvizL1GEkDeuu+0RV/9gsbGhk8IMy4sMcTpuiUltKmHsVR1p5ZPMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ppmaXT
	FbfYzRw4JS+rdOGrGh+JDzqS/0y9vgCpS+fCZKpfA5LNYb5VWV8g/ipOfC2CrR5N
	u4f5G9B8cWdWmUBNKciFHJGNRfbzMccpgEIWLm9nsJ4S6ZuGTX5fUr1TdnGAGTSP
	CvDbbKU0CWt4S44eQboArBwIygcgaLyUjXr48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA2D26E86A;
	Fri, 28 Feb 2014 13:04:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C3886E866;
	Fri, 28 Feb 2014 13:04:35 -0500 (EST)
In-Reply-To: <1393590104.5277.19.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Fri, 28 Feb 2014 13:21:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C801104E-A0A2-11E3-B5C9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242999>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> ... However, we now
> have 'origin/master' and 'origin/pr/5' both of which match the
> 'refs/remotes/origin/*' pattern. The current behaviour is to stop at =
the
> first match, which would mark it as stale as there is no
> 'refs/heads/pr/5' branch in the remote.

OK, but with a later pattern, we can find out that it came from pull/5
that was advertised by the remote.  If we had origin/pr/1 when the
remote no longer has pull/1, then we can say that is stale.

Makes sense.  Thanks for an explanation.

I wonder how well --prune would work on a repository in pre 1.5
layout, where all branches were copied to local refs/heads/
hierarchy except for 'master' (which is renamed to 'origin').  Does
it have a similar issue?  Do we end up pruning refs/heads/origin
away because we do not see it on the remote end, or we somehow
already deal with it and not have to worry about it?
