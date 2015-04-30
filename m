From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Thu, 30 Apr 2015 10:59:06 -0700
Message-ID: <xmqq4mnx1or9.fsf@gitster.dls.corp.google.com>
References: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqd22l1pkl.fsf@gitster.dls.corp.google.com>
	<20150430174440.GC21800@peff.net>
	<xmqq8ud91ozm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 19:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnskB-0008JZ-9N
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 19:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbD3R7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 13:59:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750866AbbD3R7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 13:59:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 599854D6A9;
	Thu, 30 Apr 2015 13:59:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nURIuAN2HLXZxHKBEcKlENCnXmk=; b=LpkFhh
	WE2rIiWajQMXohjzK16tEeCPZfBR8hvC3e27erdKWUxOUlE5W39MLKrvkPcqw6ba
	ntHP3elvQpmCG4x+DKF6Y/rs1XQUP/7sUf6CYx1ZZtIGr1YJPaJiqKMHXPY+TKh3
	EauCvF8XkK4v9NJ8RR0GpUE+AHZufDPAz0kCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bgdvxuqr2KgsBzx9f5APOQ3mMPRW6if2
	aNX27uAi+8Wee+7Pxn/btVYx8RMSSKtXiqpHuhDIf8a6/JkIGaZoXp8OKVXSGFFm
	qUDiYXPK3u7stNQYeSvo07BQwIopeYKn6yU4DMqtl9ma+5EV4+4tLRS5SZS+fKE/
	JDHzYLELcq8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 532E44D6A8;
	Thu, 30 Apr 2015 13:59:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C42C14D6A3;
	Thu, 30 Apr 2015 13:59:07 -0400 (EDT)
In-Reply-To: <xmqq8ud91ozm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 30 Apr 2015 10:54:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98DA19B8-EF62-11E4-9449-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268083>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ISTR that you compile with "-std=c89". typeof was added in c99, I think
>> (and was a GNU extension before that). I wonder if that is fooling the
>> gcc version-check.
>
> Yeah, I think that is very likely.

Yes.  One workaround is to explicitly say that we accept the GNU
extension in the source, perhaps.

 git-compat-util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f1f8f23..7fad5aa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -62,8 +62,8 @@
 # if GIT_GNUC_PREREQ(3, 1)
  /* &arr[0] degrades to a pointer: a different type from an array */
 # define BARF_UNLESS_AN_ARRAY(arr)						\
-	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
-							typeof(&(arr)[0])))
+	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(arr), \
+							   __typeof__(&(arr)[0])))
 # else
 #  define BARF_UNLESS_AN_ARRAY(arr) 0
 # endif
