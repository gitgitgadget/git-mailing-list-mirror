From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Sun, 02 Sep 2012 13:43:43 -0700
Message-ID: <7vpq64f935.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
 <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
 <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
 <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
 <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2P-00008J-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab2IBUou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900Ab2IBUot (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07A33833C;
	Sun,  2 Sep 2012 16:44:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=fjCLQKBNGwp+84h+N4KCzGVMQ+c=; b=xAl7UFZMg+CyVwPmZf03
	pZ1Wv+L/aoIdBqeas1T3m0DSyUQCKUxtfrZivUhVzkiN+6JPKLKFAFyfh1BaO8pT
	iDsKKGvUY+cHT2s+LnlNWsVu8alKzw/LoJ32IChLv3XrnkTWfzIfkv77FBlXYRzC
	TTxPWxK8vDtNWpOIu/zTNfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dO3XB6c6XpstPf5zP4EWHZGchiRJS63LQyn1xkQgeO1uzK
	fC57Syppu77u2TGbJcvASCvHCYa0n2vmNFY6pmbHxyauUX6lFDcJV/P3NdiRAWOf
	UmKlbtuCcRdFV3wmdRUsCldE8WF/eTZuJiqxmvyWWS+SoTA9Lpi1hHPjyHR4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA16D833B;
	Sun,  2 Sep 2012 16:44:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37D638339; Sun,  2 Sep 2012
 16:44:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 091B6824-F53F-11E1-80F5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204671>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> > > Should we leave tv_usec untouched then? That was we round up on
>> > > the next (and subsequent?) round(s). Or just set to ENOTSUP in
>> > > setitimer if ovalue is !NULL?
>> >
>> > I was alluding to the latter.
>> 
>> OK, will do that then.

Thanks.

>> Unless I screwed up the operator precedence?

I think you did, but not in the version we see below.

> int git_setitimer(int which, const struct itimerval *value,
> 				struct itimerval *ovalue)
> {
> 	int ret = 0;
>
> 	if (!value ) {

Style: space before ')'?

> 		errno = EFAULT;
> 		return -1;

EFAULT is good ;-)

The emulation in mingw.c 6072fc3 (Windows: Implement setitimer() and
sigaction()., 2007-11-13) may want to be tightened in a similar way.

> 	}
>
> 	if ( value->it_value.tv_sec < 0

Style: space after ')'?

> 	    || value->it_value.tv_usec > 1000000
> 	    || value->it_value.tv_usec < 0) {
> 		errno = EINVAL;
> 		return -1;
> 	}
>
> 	if ((ovalue) && (git_getitimer(which, ovalue) == -1))
> 		return -1; /* errno set in git_getitimer() */

As nobody passes non-NULL ovalue to setitimer(), I think we should
instead get rid of git_getitmier() implemenation, and change this to

	if (ovalue) {
        	errno = ENOTSUP;
                return -1;
	}

which is how I understood what "the latter" in the paragraph I
quoted from you above meant.

> 	switch (which) {
> 	case ITIMER_REAL:
> 		 /* If tv_usec is > 0, round up to next full sec */
> 		alarm(value->it_value.tv_sec + (value->it_value.tv_usec > 0));

OK.

> 		ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> 		break;
> 	case ITIMER_VIRTUAL:
> 		case ITIMER_PROF:
> 		errno = ENOTSUP;
> 		ret = -1;
> 		break;
> 	default:
> 		errno = EINVAL;
> 		ret = -1;
> 		break;
> 	}
>
> 	return ret;
> }

Other than that, looks good.

Thanks.
