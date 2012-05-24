From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 11:17:53 -0700
Message-ID: <7v62blxx2m.fsf@alter.siamese.dyndns.org>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Colby Ranger <cranger@google.com>
X-From: git-owner@vger.kernel.org Thu May 24 20:18:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXcc0-0000Px-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933948Ab2EXSR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 14:17:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933458Ab2EXSR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 14:17:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C91938EE4;
	Thu, 24 May 2012 14:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WnBsgrte7RSyP7bcItNPK0UX0Bs=; b=ReX/yE
	6Tx53/gq4tiwdMyeEuRGidrlcw3DOJ5RxsGUEn/6t+yFLz/tw//YHxELnCef2CJW
	Ovk+PYLR+tKQ0oAOLg5pix2TNzMGF5WxcYDo0jwhFAvtFZMY3uB3oDYCUYaPkXtL
	ys2hMlVM8DLaDOJcjQBZx+qS9ofB6CfcMxVx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aDhNa5PvL5MpYQfm1pWbozCd574xE+xe
	bsStErZZG+w+vEWrW1tkgAXYM8YeQQERRM3TLX8gjVrip11x7kEEwnETmyFahnjh
	2cHuPWJ+bnHL94lxyzJloXpXmbfS5+ogFi8AOTF3uy0UqQeb3ZHjEZ2a6I0x/YBH
	bs3TXtE/fc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C099A8EE3;
	Thu, 24 May 2012 14:17:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8C008EDF; Thu, 24 May 2012
 14:17:54 -0400 (EDT)
In-Reply-To: <1337792767-18914-1-git-send-email-cranger@google.com> (Colby
 Ranger's message of "Wed, 23 May 2012 10:06:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C830238E-A5CC-11E1-8FF7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198401>

Colby Ranger <cranger@google.com> writes:

> Git over HTTPS has a high request startup latency, since the SSL
> negotiation can take up to a second. In order to reduce this latency,
> connections should be left open to the Git server across requests
> (or invocations of the git commandline).
>
> Reduce SSL startup latency by running a daemon job that keeps
> connections open to a Git server. The daemon job
> (git-remote-persistent-https--proxy) is started on the first request
> through the client binary (git-remote-persistent-https) and remains
> running for 24 hours after the last request, or until a new daemon
> binary is placed in the PATH. The client determines the daemon's
> HTTP address by communicating over a UNIX socket with the daemon.
>>From there, the rest of the Git protocol work is delegated to the
> "git-remote-http" binary, with the environment's http_proxy set to
> the daemon.
>
> Signed-off-by: Colby Ranger <cranger@google.com>

Clever.  Do you have some numbers?

If this persistent proxy weren't in the picture, the git client would
directly delegate its communication with the origin server to
git-remote-https, and git-remote-https would interact with the credential
API to handle authentication for "https://origin.server.xz/repo".

How does the persistent proxy sitting in between your git client and the
origin server and/or the real proxy you have at the perimeter of your
network interact with respect to authentication/authorization to access
the repository or the real proxy?  They will talk with the persistent
proxy, and the persistent proxy will talk with the git client via
git-remote-http, and I am assuming that this last git-remote-http will be
the one that uses the credential API.  Would it ask credential for
"https://origin.server.xz/repo"?  "http://origin.server.xz/repo"?  Or
would it be "persistent-https://origin.server.xz.repo"?

>  contrib/persistent-https/COPYING    |  202 +++++++++++++++++++++++++++++++++++

I do not mind carrying this in the contrib/ area (I am assuming that
distributing Apache licensed software that does not link with GPLv2 core
is OK).  It may be just me, but a file called COPYING that does not have
GPL text in it was a bit surprising.  I wonder if it is more customary to
call it either LICENSE (or perhaps LICENSE-2.0)?

>  contrib/persistent-https/README     |   62 +++++++++++
>  contrib/persistent-https/client.go  |  178 ++++++++++++++++++++++++++++++
>  contrib/persistent-https/main.go    |   82 ++++++++++++++
>  contrib/persistent-https/proxy.go   |  190 ++++++++++++++++++++++++++++++++
>  contrib/persistent-https/release.sh |   45 ++++++++
>  contrib/persistent-https/socket.go  |   97 +++++++++++++++++
>  contrib/persistent-https/tar.sh     |   40 +++++++
>  8 files changed, 896 insertions(+)

It might deserve its own contrib/persistent-https/Makefile in addition to
your internal "release" scripts, though.
