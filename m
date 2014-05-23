From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE costruct
Date: Fri, 23 May 2014 11:39:25 -0700
Message-ID: <xmqqegzkjq5e.fsf@gitster.dls.corp.google.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqmwe8jr44.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de, dak@gnu.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnuNb-0000rW-VD
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaEWSji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 14:39:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62950 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbaEWSjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 14:39:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 409301863C;
	Fri, 23 May 2014 14:39:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TLyNFm3YH1XPnHPcS3lvdMehYjs=; b=K3LUdo
	b23Z2YCcW3W6xnwA/QTk2vDyWuLLktXnMbR2iTU+S7XAc/yxSQbvM+WmGkEZYYwU
	z8TZtSPygkfV4VslK1K/VUMvJ57BOa3KdFMmN5Kgcynqfw+9iKyzEl7YVwI7W0xP
	OtSJmhlR2NOyJHkueNsUhHxKMJnnGNKD0B3lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z9ol7ZSGNVVncU2wzyZNnFwZffhgQxAd
	qXxrbbKkZnCsx69WyFR19tOb0db+jV/LJKJlSXnNd5cv8faUJWe2pYO3VMg3uijM
	edwJFn5fcCx4y3bcxtP8sr7Vsal+wburEAPie4CBi8uL5gPFibFXWop6PP0q2BQv
	OBrgnWDGZlI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 356AD1863B;
	Fri, 23 May 2014 14:39:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E2C018637;
	Fri, 23 May 2014 14:39:27 -0400 (EDT)
In-Reply-To: <xmqqmwe8jr44.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 23 May 2014 11:18:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 91C15C52-E2A9-11E3-AD97-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250010>

Junio C Hamano <gitster@pobox.com> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Found by check-non-portable-shell.pl
>
> Thanks.
>
> Makes me wonder why these two were missed, though.

Perhaps something like this?

I didn't check other rules, though, because I still have a feeling
that this "pretend to understand the shell syntax and point out
issues, without really parsing the script" is fundamentally an
error-prone approach and am hesitant to loosen the patterns too
much.

 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 45971f4..24d7555 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -21,7 +21,7 @@ while (<>) {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/test\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
-	/^\s*export\s+[^=]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
+	/(?:^|[^-a-zA-Z0-9_])export\s+[^=]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
 	# this resets our $. for each file
 	close ARGV if eof;
 }
