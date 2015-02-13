From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not their referent
Date: Fri, 13 Feb 2015 13:53:08 -0800
Message-ID: <xmqq3869mqbf.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
	<54DE259C.4030001@alum.mit.edu>
	<xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>
	<xmqqk2zloeg1.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYRi3KYcvNQbkhP0uLFgpJzD+h=P+smOLQy2Msv0C_1kw@mail.gmail.com>
	<xmqqa90hocc5.fsf@gitster.dls.corp.google.com>
	<54DE5A72.6030106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart?= =?utf-8?Q?=C3=ADn?= Nieto 
	<cmn@elego.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMOAq-0007xo-IY
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbbBMVxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:53:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752758AbbBMVxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:53:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50B36341D2;
	Fri, 13 Feb 2015 16:53:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ORunMOsW/J20nvhrPZcA8O9Ias=; b=XSL7+t
	iefKPSC8XGathnGGv4wgYGxIs8+TPZezlUrxHkuxTtz/01j2xWRqrawI22/ajeRN
	jwKbsRWzJdUgwdg+ahxXNaTUoUxMefo4BlX57okFlTTi445t807CFtkptw7xt1fv
	RuX5iTNRmTM4XDGbLy2DeFjXVj8l47N+g3lvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJitqVOX45M0aX22Zf/FAuLGWZqukBLe
	23RGtAZ8ykO1umJJR2L+IMpMIy24KNWwja5/z8XauqGIyTFtNEZxfVO7Z5U9xCcS
	ea6Nxn+I+T1nx7P4DC2y4N/lzoKCNvlB7aCyxN3CrolwQsVWglpAthTqyaSKdY+U
	octK1L4SUU0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46323341D1;
	Fri, 13 Feb 2015 16:53:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8301341CF;
	Fri, 13 Feb 2015 16:53:09 -0500 (EST)
In-Reply-To: <54DE5A72.6030106@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 13 Feb 2015 21:11:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B31C2EF2-B3CA-11E4-AEA7-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263839>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Now back to the real world. Currently, if R is changed *through* a
> symbolic reference S, then the reflogs for both R and S are updated, but
> not the reflogs for any other symbolic references that might point at R.
> If R is changed directly, then no symref's reflogs are affected, except
> for the special case that HEAD's reflog is changed if it points directly
> at R. This limitation is a hack to avoid having to walk symrefs
> backwards to find any symrefs that might be pointing at R.

Yup.

> It might actually not be extremely expensive to follow symrefs
> backwards. Symbolic references cannot be packed, so we would only have
> to scan the loose references; we could ignore packed refs. But it would
> still be a lot more expensive than just updating one file. I don't know
> that it's worth it, given that symbolic references are used so sparingly.

I personally do not think it is worth it.  I further think that it
would be perfectly OK to do one of the following:

    - We only maintain reflogs for $GIT_DIR/HEAD; no other symrefs
      get their own reflog, and we only check $GIT_DIR/HEAD when
      updating refs/heads/* and no other refs for direct reference
      (i.e. HEAD -> refs/something/else -> refs/heads/master symref
      chain is ignored).

    - In addition to the above, we also maintain reflogs for
      $GIT_DIR/refs/remotes/*/HEAD but support only when they
      directly point into a remote tracking branch in the same
      hierarchy.  $GIT_DIR/refs/remotes/foo/HEAD that points at
      $GIT_DIR/refs/remotes/bar/master is ignored and will get an
      undefined behaviour.

> I think that the rule about locks as expressed above can be carried over
> the the real world:
>
>     We should hold the locks on exactly those references (symbolic
>     or regular) whose reflogs we plan to change. We should acquire all
>     of the locks before making any changes.

Sure.
