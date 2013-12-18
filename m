From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 10:00:35 -0800
Message-ID: <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
References: <20131218171446.GA19657@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 19:01:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtLQY-0003Qn-HF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 19:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab3LRSAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 13:00:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301Ab3LRSAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 13:00:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A10559FD0;
	Wed, 18 Dec 2013 13:00:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e3PFnrR8ncYu/udZwF6cMLNCqhE=; b=owviBB
	4t7YxqP/icIOoxaal3NKvktFoifX8AzTu8FHm8Mw+1Jq6d64iPK7x0ptRkEROb/R
	2bp2uHzYrd2izzZL6u6sP0LBTGYcWe+pawmvAmg2MhTTLPdd2HX0JPtpczZpyAyx
	CCEzgtBaSlKg7Zr9X76hM3fWLPwKGR+nQE4UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=emiiuRyOT1/ri9YzCWFOy2PWcxg9FOSJ
	eucMtm3iCVc0ymfaP6RVUSQ5ynEkA0cB7j/1Z99BG6VjX71tROgmcA5EVpn0h28C
	kS6p3WzoKkgVoUYOHK7PrfUIrkVaYH96JfqJiZ0RDxIWtKA9esJKxzcHt4lq548J
	4cU+nlYSZ9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 741A659FCF;
	Wed, 18 Dec 2013 13:00:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BCAB59FCD;
	Wed, 18 Dec 2013 13:00:37 -0500 (EST)
In-Reply-To: <20131218171446.GA19657@kitenet.net> (Joey Hess's message of
	"Wed, 18 Dec 2013 13:14:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CA31428-680E-11E3-BF1C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239464>

Joey Hess <joey@kitenet.net> writes:

> In sha1_file.c, when git is built on linux, it will use 
> getrlimit(RLIMIT_NOFILE). I've been deploying git binaries to some
> unusual systems, like embedded NAS devices, and it seems some with older
> kernels like 2.6.33 fail with "fatal: cannot get RLIMIT_NOFILE: Bad address".
>
> I could work around this by building git without RLIMIT_NOFILE defined,
> but perhaps it would make sense to improve the code to fall back
> to one of the other methods for getting the limit, and/or return the
> hardcoded 1 as a fallback. This would make git binaries more robust
> against old/broken/misconfigured kernels.

Hmph, perhaps you are right.  Like this?

 sha1_file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index daacc0c..a3a0014 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -809,8 +809,12 @@ static unsigned int get_max_fd_limit(void)
 #ifdef RLIMIT_NOFILE
 	struct rlimit lim;
 
-	if (getrlimit(RLIMIT_NOFILE, &lim))
-		die_errno("cannot get RLIMIT_NOFILE");
+	if (getrlimit(RLIMIT_NOFILE, &lim)) {
+		static int warn_only_once;
+		if (!warn_only_once++)
+			warning("cannot get RLIMIT_NOFILE: %s", strerror(errno));
+		return 1; /* see the caller ;-) */
+	}
 
 	return lim.rlim_cur;
 #elif defined(_SC_OPEN_MAX)
