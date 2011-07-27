From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] revert: Introduce --continue to continue the
 operation
Date: Wed, 27 Jul 2011 15:52:20 -0700
Message-ID: <7vk4b3mj4r.fsf@alter.siamese.dyndns.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-19-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 00:52:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmCxo-0000dF-2h
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 00:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab1G0WwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 18:52:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755405Ab1G0WwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 18:52:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AF5746BB;
	Wed, 27 Jul 2011 18:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=KUHHUIqnkkhiQnRfvED14isCt/k=; b=gdR3769iExe0gst/21JU
	8kkhQG8OEXr8EPy3SshOYaZ59E8izYRIanBGe/xi9AZPsHeX0sNOH/U8+DT6YMKS
	8fHJ+Tf1P2B/uozTCzqDbDv8Vramnz6dXqoHHyEe0ReN10+a36pMPpgJCTKIsuha
	zCenJr6G/JTqh2xvUwIlVSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GFPChQARGyE+oHIAQFvukFVR6KQN+SVuLviI2LFZSI7Mwn
	aGGcuM/ve2VK7v/d2uKTz06NszgEeuWOEJcYW81jarZLYqEQIGVvvLbTTSRYmCjt
	mhjP50vQs85xZYZ0BYabosLgM4Q5srClqiCaLVAr49st2j8NP9Kbf02uLKwsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D1046BA;
	Wed, 27 Jul 2011 18:52:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2589D46B9; Wed, 27 Jul 2011
 18:52:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16BE05CE-B8A3-11E0-A44E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178002>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> @@ -109,14 +108,40 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
>  	va_end(ap);
>  }
>  
> +static void verify_opt_mutually_compatible(const char *me, ...)
> +{
> +       const char *opt1, *opt2;
> +       va_list ap;
> +       int set;
> +
> +       va_start(ap, me);
> +       while ((opt1 = va_arg(ap, const char *))) {

(style)
Many lines indented with SP thoughout the patch.

> +	       set = va_arg(ap, int);
> +	       if (set)
> +		       break;
> +       }
> +       if (!opt1)
