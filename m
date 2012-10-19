From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix potential hang in https handshake (v2).
Date: Thu, 18 Oct 2012 17:37:45 -0700
Message-ID: <7v4nlrl2jq.fsf@alter.siamese.dyndns.org>
References: <5080906b.xT6aRtW1ELoWhZZw%szager@google.com>
 <7v8vb3l2q5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sop@google.com
To: szager@google.com
X-From: git-owner@vger.kernel.org Fri Oct 19 02:38:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP0bA-00044t-8f
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 02:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab2JSAht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 20:37:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816Ab2JSAhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 20:37:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F340A9D55;
	Thu, 18 Oct 2012 20:37:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zs9/3N6e3kLCgxjTN+CFWB4hM5A=; b=ehohuS
	v8k8hYQ+PiL7bwD8MNv8ZXzBpXqha5uH8Sij8QQg2p3bmmRAQRZgNYt9V5eLmidc
	XwUECeJ/+uZX43jNFYaxLy4d+MPCbZ454V9GfnuRJrm1EtGrJC3BY3oNXva6pbZU
	iJi7MYM8CF4mj39Q75POwqA6I5PquqWUG0w+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZe7HY+v4xFsMnxocfaBZfMukBdgFVDP
	1T2UDH3Iva0NOFDqCoq/bZUfnDz/syjAiozzcNjwT+K5G0tdj4HfM4gG/TcEcuk7
	SH3trwX+roM9RK3QN6LMlvmzNMa8GnSBiKiFHLrFaAe6aKK5YGJIjttH03Qyzse9
	+QFGojETFPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFD0E9D52;
	Thu, 18 Oct 2012 20:37:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D3E29D4F; Thu, 18 Oct 2012
 20:37:46 -0400 (EDT)
In-Reply-To: <7v8vb3l2q5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 18 Oct 2012 17:33:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 342D853C-1985-11E2-92F4-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208034>

Junio C Hamano <gitster@pobox.com> writes:

> We end up calling select() without any bit set in fds, so it would
> become micro-sleep of select_timeout in such a case, but as far as I
> can see, the existing code either
>
>  * does not select() and keeps polling step_active_slots() without
>    delay, when curl_timeout gives a 0 return value; or
>
>  * sets 50ms timeout or whatever negative value derived from
>    curl_timeout when the returned value is not 0 nor -1.
>
> Is the symptom that select(), when given a negative timeout and no
> fd to wake it, sleeps forever (or "loooong time, taking that negative
> value as if it is a large unsigned long") or something?

Addendum.

What I am trying to get at are (1) three line description I can put
in the release notes for this fix when it is merged to the
maintenance track, and (2) a feel of how often this happens and how
bad the damage is.

The latter helps us judge if this "do the normal thing, but if in a
rare case where we do not find any fds, patch it up to proceed" is a
better approach over your original.

Thanks.
