From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] match_basename: use strncmp instead of strcmp
Date: Fri, 08 Mar 2013 23:50:04 -0800
Message-ID: <7v4nglf1w3.fsf@alter.siamese.dyndns.org>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362802190-7331-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 08:50:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEEYN-0003rP-SP
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 08:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab3CIHuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Mar 2013 02:50:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab3CIHuI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Mar 2013 02:50:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B6D79149;
	Sat,  9 Mar 2013 02:50:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YuyXgey7Gzl5
	CFzn6Yl01zCCR8g=; b=cDFd823owWL0MXs1rylzjIzxcIJIMfVsvWb+E9hRmEIb
	Bw7F410xZ7IX+oQA37ru59I4CC5nYuvnScN/HxLmle8tpCf64S7csk5du1nKVfw7
	gFbDe5zE7JbiE+SBqRCtNMADpXqP/O0SoGIyULUuWoPDL2uSbfEElI7WUlcDaU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eT0Xux
	qLMUPQbUUvrBFYkWkNQV0Y4+pwZn7DcJf8+DKYdcVMUDtbnT3EMjdLy9zlKVmD4v
	TZJJMmRjH7vrLYIiAWc7gigvtPgqI2/yy/2SjZuBXRLqyN7LAOMACsTDI0QjB+9G
	EBSrsgs7475caL4NiItYhHi5RjnYrzs9lGfSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8047E9148;
	Sat,  9 Mar 2013 02:50:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2BA39146; Sat,  9 Mar 2013
 02:50:05 -0500 (EST)
In-Reply-To: <1362802190-7331-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 9 Mar
 2013 11:09:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5325A1A-888D-11E2-966F-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217704>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> strncmp provides length information, compared to strcmp, which could
> be taken advantage by the implementation. Even better, we could check
> if the lengths are equal before calling strncmp, eliminating a bit of
> strncmp calls.

I think I am a bit slower than my usual self tonight, but I am
utterly confused by the above.

strncmp() compares _only_ up to the first n bytes, so when you are
using it for equality, it is not "we could check length", but is "we
MUST check they match to the length of the shorter string", if you
want to obtain not just faster but correct result.

Am I mistaken?

Even if you are using strcmp() that yields ordering not just
equality, it can return a correct result as soon as it hits the
first bytes that are different; I doubt using strncmp() contributes
to the performance very much.  Comparing lengths before doing
byte-for-byte comparison could help because you can reject two
strings with different lengths without looking at them.

At the same time, I wonder if we can take advantage of the fact that
these call sites only care about equality and not ordering.
