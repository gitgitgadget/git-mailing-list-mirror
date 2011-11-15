From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] Allow resolve_ref() caller to decide whether to
 receive static buffer
Date: Mon, 14 Nov 2011 23:09:57 -0800
Message-ID: <7v39dpyi7u.fsf@alter.siamese.dyndns.org>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 08:10:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQD9t-0002NB-8J
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 08:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab1KOHKD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 02:10:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924Ab1KOHKA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 02:10:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D04982363;
	Tue, 15 Nov 2011 02:09:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zh9hc0oDbRiS
	72ZgoqdsNmMxqoQ=; b=hGzRNjDt5CfIXCUdkO+p9VTveinZxEebP+qrvkUFAvi0
	VaiG1Cytk0FiJflKX5SVseoCSWr1UYpZqya+tFHqOinyn6s6cjaqssgzVwo7Hw8y
	HPhrOTzOpx5x5gZvtHzfqkYsnxZwFI1Z06BMMN7rUW01pH9LCnDTiDtCGDIhkJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GNN6hn
	LTdofUJK6t2By8M69SRK8UVZYCV9/7+O1/KrXPAHzqMStUi4+96Ul5i/dcUIInLE
	yE5VvN+DgRZU3zlajjy79z92AAZyCPnR0SQIGgwECnh0gr+tp3OAgZ2gqXrXD6Q6
	vG5QDIVZaJVWO3pVQAfM65Ut6s95aBDx7cFto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A082362;
	Tue, 15 Nov 2011 02:09:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46F782361; Tue, 15 Nov 2011
 02:09:59 -0500 (EST)
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 15 Nov
 2011 13:07:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4690978-0F58-11E1-865D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185436>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> resolve_ref() is taught to return a xstrdup'd buffer if alloc is true=
=2E
> All callers are updated to receive static buffer as before though.

Thanks for working on this. I have a slight fear that this may collide
with some topics in flight, but that is something we can worry about af=
ter
1.7.8 release is done.

I like the direction of the entire series, and agree with the reasoning
behind the choices of callsites to be converted in later part of the
series (they are clearly documented).

After this series, all the callsites use either 0 or 1 and never a
computed value for the extra argument. I think it would make it a lot
safer and easier for other people who later want to touch the codepath
that has resolve_ref(..., 0) calls in it, if we instead did this in the
following way:

 (1) Rename resolve_ref() to resolve_ref_unsafe() everywhere to make it
     stand out in the code, without changing anything else. This is the
     moral equivalent of a half or your [01/10].

 (2) Introduce resolve_ref() that returns a copy. This is equivalent to
     the other half of your [01/10].

 (3) Convert the ones that should use resolve_ref() to do so. This is
     equivalent to the remainder of your series.

 (4) Convert callsites of resolve_ref_unsafe() that xstrdup()'s the
     returned value back to use resolve_ref() as needed.

 (5) And finally document in in-code comments at each tricky callsites =
of
     resolve_ref_unsafe() why the use of the unsafe variant is OK in th=
at
     context. This can be done as part of step 1. We obviously do not h=
ave
     to document trivial ones (e.g. a variable in a narrow sub-function
     scope receives the return value of resolve_ref_unsafe(), and the
     value is immediately used without giving it a longer lifetime).

The above is primarily a naming issue, but names are important. It forc=
es
developers to _think_ before using something named _unsafe_, and helps
them to be on the lookout when they insert new code between an existing
call to the unsafe one and use of its result.

There are other "unsafe" functions like git_path() whose callsites can =
be
updated with the same strategy, and we probably should do that.
