From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attempt connects in parallel for IPv6-capable builds
Date: Thu, 28 Jan 2016 19:04:34 -0800
Message-ID: <xmqqtwlxjdbx.fsf@gitster.mtv.corp.google.com>
References: <20160128115720.GA1827@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 04:04:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOzMY-0002lT-AM
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 04:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbcA2DEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 22:04:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751912AbcA2DEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 22:04:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8AAD53FF72;
	Thu, 28 Jan 2016 22:04:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YGVX32dRTx0wZwRZl5FJgnneCKE=; b=akgKMp
	IghfHzNgoupKbCui3tZU1zdw965lG0w+1kncUquV8+fqwVeKzXfcwn/P6qmknL4d
	l6EFmclkpERKMXsAmrptkTCXFZS9ZO6cMyPJdv5PdwP/xZ9wdQUFhKXwR7ryADxN
	yuvg5hWgQ1/F6xwypahFKGOtolVjpxlDL5Bzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSZ9yk39xm0zdSlQb0o/IshQbXg16X4W
	jb2UT+RPdyM82DZSu6As8sRzGpHZk9BMRgtNMJNeRrVHVcOd84lg8wlKEkIhTRSX
	BMSeicgVdag9JkSPumIPwf7WdROgAiHwz7oZYeoFhokMn5aanXYNaCYx/hFMvQa6
	1NR30Kzy3UY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 822B93FF71;
	Thu, 28 Jan 2016 22:04:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F23FC3FF6F;
	Thu, 28 Jan 2016 22:04:35 -0500 (EST)
In-Reply-To: <20160128115720.GA1827@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 28 Jan 2016 11:57:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0724ADE4-C635-11E5-A84F-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285054>

Eric Wong <normalperson@yhbt.net> writes:

> getaddrinfo() may return multiple addresses, not all of which
> are equally performant.  In some cases, a user behind a non-IPv6
> capable network may get an IPv6 address which stalls connect().

I'd assume that you are not solving a hypothetical problem, but you
may (at least sometimes) have to reach outside world from such a
network environment.  I further assume that git_tcp_connect() is not
the only activity you do from such a network, and other network
activities are similarly affected.

How do you work around the same issue for connections that do not go
through git_tcp_connect()?  The same issue would affect Git traffic
going over git-remote-curl, and also your usual Web browser traffic,
no?

What I am getting at is if it is saner to solve the issue like how
curl(1) solves it with its -4/-6 command line options, e.g. by
adding a pair of configuration variables "net.ipv[46] = true/false".
