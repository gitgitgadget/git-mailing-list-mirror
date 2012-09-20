From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Wed, 19 Sep 2012 21:14:57 -0700
Message-ID: <1348114499-22811-1-git-send-email-gitster@pobox.com>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 06:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEYAy-00088p-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 06:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab2ITEPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 00:15:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab2ITEPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 00:15:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E158515;
	Thu, 20 Sep 2012 00:15:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hVC+
	wDOx525O45xaFfpKYukwM1g=; b=l/yoMyT5xTQBmOrxJrczXVyKpQxESAAZ3T2/
	8NbGiA/g6b3rXJRq9DMQOoeCWsRWtoJip5xsMFnjAx5Hdl6Gg9Xavl8AsCLIRtbS
	aZnzLThEuqhRKPatp4vN0U/iP5MkKp854YiXjzz3hl4dYFurYePoTOZq3YSD0PlI
	uEE9AxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	xmLYAPlZZYHiIhURLmprq+ZOLmgXnBx2NRfeyyOIBTDhx3cegyLrRoMM+bsZ5QmO
	RGYZNhFkOsAd75+qn+k14c8zBW9+c6RLICtTTvEgZB692OJ9zJCAmNUR/Icm+VDe
	gRrHWsi9H71OBj9nRbbMABwN1aH2Zu4ldu9TZv3UlTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82C738514;
	Thu, 20 Sep 2012 00:15:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB98B850C; Thu, 20 Sep 2012
 00:15:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.389.g3dff30b
In-Reply-To: <1348109753-32388-1-git-send-email-spearce@spearce.org>
X-Pobox-Relay-ID: BED19984-02D9-11E2-9DEC-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206033>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> From: "Shawn O. Pearce" <spearce@spearce.org>
>
> If the user doesn't want to use the dumb HTTP protocol, she may
> set GIT_CURL_FALLBACK=0 in the environment before invoking a Git
> protocol operation. This is mostly useful when testing against
> servers that are known to not support the dumb protocol. If the
> smart service detection fails the client should not continue with
> dumb behavior, but instead provide accurate HTTP failure data.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  remote-curl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

I can see how this feature may be useful, but I have to say the
external interface triply sucks.

 - If it is primarily for debugging smart HTTP, a solution with an
   environment variable without more permanent configuration
   variable would be sufficient, but then the environment variable
   is better named GIT_SMART_HTTP_DEBUG, or something no?

 - If it is useful outside the context of debugging, perhaps a per
   remote configuration variable remote.$name.$variable (or
   http.$prefix_of_server_url.$variable) might be necessary?

 - I do not see this as "fallback (to) curl"; you still talk your
   smart protocol over curl library.  "fallback to dumb http" is
   more understandable.  

In any case, I think CURL_FALLBACK was named with CURL in its name
primarily because the environment applies only to remote-curl, but
that means we cannot have any fallback logic other than the current
"smart does not work, fall back on dumb" in the future.

Here is a bit of rewrite.  [1/2] is yours but with a bit more
sensible name. [2/2] is entirely optional.


Junio C Hamano (1):
  remote-curl: make dumb-http fallback configurable per URL

Shawn O. Pearce (1):
  Disable dumb HTTP fallback with GIT_DUMB_HTTP_FALLBACK=false

 remote-curl.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

-- 
1.7.12.1.389.g3dff30b
