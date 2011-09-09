From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] date.c: Support iso8601 timezone formats
Date: Fri, 09 Sep 2011 09:35:28 -0700
Message-ID: <7vhb4lvflb.fsf@alter.siamese.dyndns.org>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
 <1315563033-9476-1-git-send-email-lihaitao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Haitao Li <lihaitao@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:35:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R243J-0006SV-2q
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152Ab1IIQfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:35:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754956Ab1IIQff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:35:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD35B4D49;
	Fri,  9 Sep 2011 12:35:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUcS6agukpffvzifM78cKGY2hxg=; b=DQ22rh
	nAmujnzdJOJDfRf5pylxPaHz8GiOJ3UIrIv3OGggyGuB0shD8nyYZ2IQtVN61Tw0
	6l2WWDOqg7jJf/FluhxAQXa6C8WF2hLSm2hKdsNcm+O7vgE1pbq6Dv/sCKknLhMD
	TNX/ndzOs7Lq49QnirLSHKcVFOMK1+zW1RSaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UCKX1FertHd4+rL4f0vICE1XAk+QRBLS
	UzDKXX+5/OwXfXMOcEk5j4lgz09SJy92YGQ5tQUdJY/P2QHWjMIpgar1T+QlQYAm
	lhFQEaP6WkGA6QrNZth8DYhALDiPjcL4y82fYZbzMDH1FmV7zB9jjQPKdlZ2DtNk
	7Z3FbslsxuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C450D4D48;
	Fri,  9 Sep 2011 12:35:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 419844D46; Fri,  9 Sep 2011
 12:35:31 -0400 (EDT)
In-Reply-To: <1315563033-9476-1-git-send-email-lihaitao@gmail.com> (Haitao
 Li's message of "Fri, 9 Sep 2011 18:10:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBC49D5A-DB01-11E0-B0F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181093>

Haitao Li <lihaitao@gmail.com> writes:

> Timezone designators including additional separator (`:`) are ignored.
> Actually zone designators in below formats are all valid according to
> ISO8601:2004, section 4.3.2:
>     [+-]hh, [+-]hhmm, [+-]hh:mm

Thanks for a re-roll.

> This patch teaches git recognizing zone designators with hours and
> minutes separated by colon, or minutes are empty.

The last sentence above makes it sound as if you are accepting

	"2011-09-17 12:34:56 +09:"

but I suspect that is not what you intend to allow.  Perhaps "we allowed
hh and hhmm and this teaches Git to recognize hh:mm format as well"?

> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index f87abb5..5235b7a 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -40,6 +40,11 @@ check_parse 2008-02 bad
>  check_parse 2008-02-14 bad
>  check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
>  check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
> +check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
> +check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
>  check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5

The above are from Peff, no?  We should credit him for tests in the
proposed log message.

Because the three formats 8601 specifies are "hh", "hhmm", or "hh:mm"
after +/-, among the above new tests, it appears to me that zone
designators "-5" and "-:30" should yield "bad", instead of being accepted.
The same for "+09:" I mentioned above, which is not in the new test.
