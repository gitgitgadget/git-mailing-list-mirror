From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Tue, 22 Jan 2013 13:36:14 -0800
Message-ID: <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 22:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxlWJ-00023X-PK
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 22:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab3AVVgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2013 16:36:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab3AVVgR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2013 16:36:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 072B2B7C2;
	Tue, 22 Jan 2013 16:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DR5UydY7fugS
	Kode6lMMOg7OlgU=; b=Q9hwOh6HE+K7Idht9ZBlSJVrzlz9kHA8lKhLFX01qM4Z
	Tp3KGZhDXll+LMsRSwotYrcltsIDoM0WxXAg4z8I6ajZGE8bExB4t839qt0rSD9W
	l1eCaXMdviE6VPz/dSRI3wCdfOxxWksKQ6gMQKEjMQvIjdqxvNC0C2Ah2MDXwvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cNMOUI
	PdVUUAW1NvNTLdFjoeOtx++6nPMdPrM4YmXwfStZzhBTJJIYE3+zv6oW8ijRR0LH
	h7pPptfk34ZTjLFfpiDMmmleHr3S+wyjhPX2nwAwGY4VR733KhubUxlMero66Rzo
	hH+ceQethvitw3UR2/IBvEuogAV5t9RkQlPBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFCA3B7C1;
	Tue, 22 Jan 2013 16:36:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51969B7BF; Tue, 22 Jan 2013
 16:36:16 -0500 (EST)
In-Reply-To: <1357008251-10014-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 1 Jan
 2013 09:44:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C06B5686-64DB-11E2-B515-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214253>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> "**" is adjusted to only be effective when surrounded by slashes, in
> 40bbee0 (wildmatch: adjust "**" behavior - 2012-10-15). Except that
> the commit did it wrong:
>
> 1. when it checks for "the preceding slash unless ** is at the
>    beginning", it compares to wrong pointer. It should have compared
>    to the beginning of the pattern, not the text.

So should

	git ls-files '**/Makefile'

list the Makefile at the top-level of the repository (I think it
should)?

But that does not seem to be working.

I think the callpath goes like this:

 match_pathspec()
  -> match_one()
    -> fnmatch_icase()
      -> fnmatch()
       -> wildmatch()

and the problem is that the fnmatch_icase() call made by match_one()
always passes 0 as the value for flags.  Without WM_PATHNAME,
however, the underlying dowild() does not honor the "**/" magic.

We obviously do not want to set FNM_PATHNAME when we are not
substituting fnmatch() with wildmatch(), but I wonder if it may make
sense to unconditionally use WM_PATHNAME semantics when we build the
system with USE_WILDMATCH and calling wildmatch() in this codepath.
Users can always use "*/**/*" in place of "*" in their patterns
where they want to ignore directory boundaries.
