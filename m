From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: introduce %(upstream:track[short])
Date: Wed, 13 Nov 2013 11:42:12 -0800
Message-ID: <xmqqk3gcdr6z.fsf@gitster.dls.corp.google.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
	<1384335406-16332-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 20:42:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VggKV-00034H-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 20:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab3KMTmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 14:42:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756303Ab3KMTmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 14:42:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4DF552CEB;
	Wed, 13 Nov 2013 14:42:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2FY4L/fxMb0KGpeMeXIGY2jzy4Y=; b=uneVGH
	3O4cLqPhZVu/hr760PLwLEVijSboEDsWXlmEhugm2Jd3Lp8T7e/mIodX/dMO0Kzp
	XD+v7V37WEz7ZPubzdxfHDM/alpA+mD57LUesNfwFdkfZXqjNUJ5lbQ31DeYHXIp
	i5vWBcUT6AYp5VhxEvNv88LtmIAsfxiyJ0gdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GpDH77ggdk77E81/3lhBGhWgm8B2mfa+
	ufPShO3QOS1Vaws0NVscch7A7NwTRaPjt5Fp/4C80cvTOTWuHlZ0wZF7be02/30I
	QNX4sIjyHrYOx+YP7pLmzyTkOeCqUpaU+s38KewWME+sjAo2sMYBGlEXaKMkx7KE
	EXgldInr0/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A502A52CEA;
	Wed, 13 Nov 2013 14:42:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE99452CE8;
	Wed, 13 Nov 2013 14:42:15 -0500 (EST)
In-Reply-To: <1384335406-16332-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 13 Nov 2013 15:06:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B31C6C88-4C9B-11E3-91EC-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237798>

You need to squash 78465bb, which has been queued on the previous
round, in to this step.  There also is a similar issue introduced by
the updated 3/3:

builtin/for-each-ref.c: In function 'populate_value':
builtin/for-each-ref.c:701:13: error: 'refname' may be used uninitialized in this function [-Werror=uninitialized]


    700                         if (!strcmp(formatp, "short"))
    701                                 refname = shorten_unambiguous_ref(refname,
    702                                                       warn_ambiguous_refs);

Thanks.

-- >8 --
Date: Thu, 31 Oct 2013 14:17:36 -0700
Subject: [PATCH] fixup! for-each-ref: introduce %(upstream:track[short])

The condition !prefixcmp(name, "upstream") must be true for the
variable "branch" to be reused, so the variable should be always set
when it gets used, but GCC does not seem to realize this fact.
---
 builtin/for-each-ref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index ed81407..67168a1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -641,7 +641,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
-		struct branch *branch;
+		struct branch *branch = NULL;
 
 		if (*name == '*') {
 			deref = 1;
@@ -719,6 +719,7 @@ static void populate_value(struct refinfo *ref)
 			} else if (!strcmp(formatp, "trackshort") &&
 				!prefixcmp(name, "upstream")) {
 
+				assert(branch != NULL);
 				stat_tracking_info(branch, &num_ours, &num_theirs);
 				if (!num_ours && !num_theirs)
 					v->s = "=";
-- 
1.8.5-rc1-322-g9c05f5a
