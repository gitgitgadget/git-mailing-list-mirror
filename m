From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/19] check_bindir: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 11:12:02 -0700
Message-ID: <xmqqsio4z5e5.fsf@gitster.dls.corp.google.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
	<1400593832-6510-2-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:12:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmoWN-0000S6-Em
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbaETSMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:12:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65000 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbaETSMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:12:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 172531896A;
	Tue, 20 May 2014 14:12:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rWjh5JmIWKHrTbe2KBOpq6sJ3XM=; b=aV07I+
	dcixWjQFl+FIu7R1lI/OG026VMoGBoTGWQbKiNSPDq9t52JvlZkw6bMl+2lkj4sP
	/+7EAlLrzyETl9cz/GJsc34ZrAw4wT7/51uybctxSoointpYWC50kxMq5YkQOW8m
	q8BJbsVvFN/sdR6DmF1OUDWdDHzrWHFfj6LxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2GPWibMjn9bDVzqt+ZYRbcO/ILznX2N
	8zH7X++L0smoxOBKJwT3ayitHOniYlJe2e2JXCDdY2alvNGTd0NTsJJIwtJaECuV
	1NiHgjyr+qL3PLhwuOMARqMqq1InfKLDGyI21nSlxs0/hNmBWHILJCn2HshjEUdN
	j9VPxF7NV4M=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E07318968;
	Tue, 20 May 2014 14:12:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EE6B418966;
	Tue, 20 May 2014 14:12:03 -0400 (EDT)
In-Reply-To: <1400593832-6510-2-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 20 May 2014 06:50:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3EF78AFC-E04A-11E3-8161-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249713>

Elia Pinto <gitter.spiros@gmail.com> writes:

> The interaction with unary operators and operator precedence
> for && and || are better known than -a and -o, and for that
> reason we prefer them. Replace all existing instances
> of -a and -o to save readers from the burden of thinking
> about such things.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---

Thanks.

As I already said, I think "better known" is much less of an issue
than that "-a/-o" is "more error prone", and that is the reason why
we may want to do this rewrite.

I do not know offhand how busy the tree would be when we can apply
these patches post-release without them getting rebased, but the
zero-th step before this series may want to be a patch like this.

 Documentation/CodingGuidelines | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ef67b53..7864c5b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -106,6 +106,19 @@ For shell scripts specifically (not exhaustive):
    interface translatable. See "Marking strings for translation" in
    po/README.
 
+ - We do not write our "test" command with "-a" and "-o" and use "&&"
+   or "||" to concatenate multiple "test" commands instead, because
+   the use of "-a/-o" is often error-prone.  E.g.
+
+     test -n "$x" -a "$a" = "$b"
+
+   is buggy and breaks when $x is "=", but
+
+     test -n "$x" && test "$a" = "$b"
+
+   does not have such a problem.
+
+
 For C programs:
 
  - We use tabs to indent, and interpret tabs as taking up to
