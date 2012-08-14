From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement ACL module architecture and sample MySQL ACL
 module
Date: Tue, 14 Aug 2012 10:06:37 -0700
Message-ID: <7vsjbp768y.fsf@alter.siamese.dyndns.org>
References: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
 <7v1uj98nbj.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtYz3OX1C6HS7ivhJKBOSg=Ex3rKEdTYSbcDfFT1Jh4hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Novotny <minovotn@redhat.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:06:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1KZs-0002Eu-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 19:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697Ab2HNRGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 13:06:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809Ab2HNRGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 13:06:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6E160B0;
	Tue, 14 Aug 2012 13:06:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u66RWNf/APwZCXeUZE8AqHvaH2U=; b=KVNUXe
	KoK97GBC64sqOOg5qjxFKobdvR8qDog9Vo2lO7BXyoIwKs66qcRkLBc/AvT33CTo
	Z74NPo2t+N1DlMW1ISf0iYfNuG2ll/qX62d+Ql0cOGOygptIBiMU3Jek9c4JUnM+
	s0+wPWWABJf0bMkSKO06CpOf55QOxzYdUDMKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E3PhCxeD4jalB8ad/XsP2Kl2VxEnaZda
	2apKf0gMU0CCMuyqcBtMCPqUYrgzr7iac3Gru0JnlMNDkv6oHe579IVL7JbWtym4
	7dsDyh4TCyR4OWzMfHlNrfPkQD3LJ/a+pxMFhDxAVtsJyZtL2DmUUHFxnEsAuEw0
	/QwLfrHFz0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C84360AF;
	Tue, 14 Aug 2012 13:06:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAB2260AE; Tue, 14 Aug 2012
 13:06:38 -0400 (EDT)
In-Reply-To: <CAJo=hJtYz3OX1C6HS7ivhJKBOSg=Ex3rKEdTYSbcDfFT1Jh4hw@mail.gmail.com> (Shawn
 Pearce's message of "Tue, 14 Aug 2012 09:27:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 695E8854-E632-11E1-B69D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203414>

Shawn Pearce <spearce@spearce.org> writes:

> Parsing the request line of git-daemon is easy. But we could make it
> easier. An alternative arrangement would be to add a new command line
> flag to git daemon like --command-filter that names an executable
> git-daemon will invoke after parsing the request line. It can pass
> along the client IP address, command request, repository name, and
> resolved repository path, and tie stdin/stdout to the client. This
> binary can decide to exec the proper git binary for the named command,
> or just exit to disconnect the client and refuse service. This makes
> it simple for a tool like gitolite to plug into the git-daemon
> authorization path, without needing to be the network daemon itself,
> worry about number of active connection slots, etc.

I think that is a good direction to go in, except that I am unsure
what kind of conversation do you want to allow between the "command
filter" helper and the client by exposing standard input and output
stream to to the helper.  If the client side has a matching "pre
negotiate command" helper support, then presumably the helpers can
discuss what Git protocol proper does not care about before deciding
to allow the connection go through, but until that happens, opening
the stdio streams up to the helper sounds like an accident waiting
to happen to me (e.g. "fetch-pack" connects, the server side helper
reads the first pkt-line from the client, says "OK, you may proceed"
to the daemon, then the daemon spawns the "upload-pack", which will
obviously see a corrupt request stream from "fetch-pack").
