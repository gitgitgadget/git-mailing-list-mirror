From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: Allow blank *trailing* context lines to match
 beyond EOF
Date: Wed, 07 Apr 2010 22:32:04 -0700
Message-ID: <7vd3ya8q7f.fsf@alter.siamese.dyndns.org>
References: <4BBD5827.7030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 07:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzkLi-0007Gi-KW
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 07:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab0DHFcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 01:32:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab0DHFcN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 01:32:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F41CA94DE;
	Thu,  8 Apr 2010 01:32:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kYzPRXDmaLmG
	eddPqal4Q0JtMW0=; b=r2/oi87QAVQEaDb0xj7N6Waz9VPxLpYe6CGzGoqlffg3
	Ic+h5X2c53YHc5vspW/NR9vFszXAv6Q8EIup+My6A7TBzLM0LH22mkUYjsHLATGR
	so4S6kyPPhiEg+Skes3nLTKD2AF9ZuyeMJC1SFItJ9n7m+yb8FMnsBLgKZOX2gU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XTU7Rq
	qGash3NFq7NPKBkcyQK2KKpSkrrKQgjsunC8Lrwv9NlBmdkvohcFu32s+xxVfuuJ
	U+MzdYakEOORNwzC3K3PjJXeEzRyBO3uD8cW20Xhzc0aaW7dfzy04VdpL3bawWTM
	B0fcLo6GRgwSZjzXIT+/nKjY9XA0mOJzoi2Wg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7141A94DD;
	Thu,  8 Apr 2010 01:32:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44104A94DC; Thu,  8 Apr
 2010 01:32:07 -0400 (EDT)
In-Reply-To: <4BBD5827.7030003@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Thu\, 08 Apr 2010 06\:14\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13E939DA-42D0-11DF-A56E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144317>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> This patch should fix the problem observed by Junio, but note that
> there will be one or more blank lines left at the end of the
> file.
>
> I am not sure whether that should be fixed. In this particular
> case, the blank lines are part of the context but not part of
> the file being patched, so it could be argued that the blank
> lines should not be added back.
>
> But there are already other circumstances in which
> "--whitespace=3Dfix" does not guarantee that the file does
> not end with blank lines, for instance if we have:
>
>  a
>  b
>  (blank line)
>  (blank line)
>  (blank line)
>  (blank line)
>  c
>  d
>
> and then delete the "c" and "d" lines:
>
>  a
>  b
>  (blank line)
>  (blank line)
>  (blank line)
>  (blank line)

Even though I think these are both worth fixing, I do not think it shou=
ld
happen as part of this patch.  Because the code that needs to "fix" the
"extra blank bug" this patch introduces will need to deal with exactly =
the
same horizon effect as your "deleting c and d at the end will not have =
the
blank immediately after b in the context" example, I expect we will fix
the fallout from this patch when we fix that "delete c and d at the end=
"
example.
