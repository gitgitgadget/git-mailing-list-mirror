From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "retry request without query when info/refs?query
 fails"
Date: Wed, 19 Sep 2012 23:29:34 -0700
Message-ID: <7vlig5cilt.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
 <1348120680-24788-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 08:29:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEaGi-0004Ok-3U
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 08:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab2ITG3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 02:29:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833Ab2ITG3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 02:29:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E179B9D4B;
	Thu, 20 Sep 2012 02:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Si01q0qcirgdy6KxkJIImH7vVG4=; b=V+tHIk
	uakRIW+7fX0uT/8/BumiwRZxCP0/MofuYrcGEnJQqaF7odATWDwQVvN3WFL7RrMq
	EjToAw/JrgdrHlU5bRvIvkbc3MsRMHj4eNjVhrbG7qar936NuinjTOmIUOPj6UKw
	tm++dwHyzxENkI38QVaMxVMaV/XqclcOLKsZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eYttC91661tsMGnNKH6/+wLJfpyYw2Ac
	J0TgCxDnH+kinSFFQ+eBFxKFcjdRP2T614PbjCnTLuk8h8mF4I5dyljznPleWZIw
	iGbn3Cz6SChth5jQ/B/UO+JtsXSTiVo44V7S2nMb7givwMSY1QOgAhZ9gbziSCr+
	VE2Gqf29j80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9875E9D4A;
	Thu, 20 Sep 2012 02:29:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E61709D48; Thu, 20 Sep 2012
 02:29:35 -0400 (EDT)
In-Reply-To: <1348120680-24788-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Wed, 19 Sep 2012 22:58:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C09D2C4-02EC-11E2-8A49-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206037>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This reverts commit 703e6e76a14825e5b0c960d525f34e607154b4f7.
>
> Retrying without the query parameter was added as a workaround
> for a single broken HTTP server at git.debian.org[1]. The server
> was misconfigured to route every request with a query parameter
> into gitweb.cgi. Admins fixed the server's configuration within
> 16 hours of the bug report to the Git mailing list, but we still
> patched Git with this fallback and have been paying for it since.

As the consequence of the above, the only two things we know about
the servers in the wild are (1) a misconfiguration that requires
this retry was once made, so it is not very unlikely others did the
same misconfiguration, and (2) those unknown number of servers have
been happily serving the current clients because the workaround
patch have been hiding the misconfiguration ever since.

But as long as the failure diagnosis from updated clients that
revert this workaround is sufficient to allow such misconfigured
servers, I think it is OK.  We might see a large number of small
people having to run around and fix the configuration as a fallout,
though.

> Most Git hosting services configure the smart HTTP protocol and the
> retry logic confuses users when there is a transient HTTP error as
> Git dropped the real error from the smart HTTP request. Removing the
> retry makes root causes easier to identify.

Does that hold true also for dumb only small people installations?
They are the ones that need more help than the large installations
staffed sufficiently and run smart http gateway.
