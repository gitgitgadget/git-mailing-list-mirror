From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/7] web--browse: better support for chromium
Date: Fri, 03 Dec 2010 13:57:49 -0800
Message-ID: <7vipzamsde.fsf@alter.siamese.dyndns.org>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:58:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POddr-0001TR-0E
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab0LCV6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:58:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab0LCV6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:58:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB31B3C35;
	Fri,  3 Dec 2010 16:58:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cy2P29nJ2tsCN83toEiLxNwnmLE=; b=v8OkJ/
	w+1TuNaBQRpotxOYCxOx9bB/WT31pE2vVlA98/drxvr19LuFVFyDNl74bYQATv3k
	n87Ghh+2nwy/fwm7by2zzP5Tm15f4Q9J+E6HzpPzioMxE2Oh/nB8U58pzv/iqDvy
	1vjWBC0mJO34C5T0JW/v4IvZMy2ZQCi5HSU9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q1KM2wFDQ/puWeFXUMSvkL0xlmyXYtFJ
	8PYF7DgKhOY2isuWz3iekFz6LGlF1b3G4rjzTwc3aRo9s5r2ksiF3jGgWPV8ddwz
	pKs2uyHNm/kml3Yvz8RtDM5sdacbf+k2A2W56TrIsaTim+yFTcW3NTev4xXBjGLK
	DqXMrRA+KQA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A7423C31;
	Fri,  3 Dec 2010 16:58:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DCFC83C2D; Fri,  3 Dec 2010
 16:58:10 -0500 (EST)
In-Reply-To: <1291394861-11989-6-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Fri\,  3 Dec 2010 17\:47\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EA71DA0-FF28-11DF-BD08-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162864>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

>  init_browser_path() {
>  	browser_path=$(git config "browser.$1.path")
> +	if test -z "$browser_path" -a "$1" = chromium ; then
> +		type chromium-browser > /dev/null 2>&1 && browser_path=chromium-browser
> +	fi
>  	test -z "$browser_path" && browser_path="$1"

We tolerate

	test && test && effect

and even encourage when the construct is short enough, over

	if test && test
        then
        	effect
	fi

But because you are writing an "if" block anyway, I think the above should
be like this:

	if test -z "$browser_path" &&
           test "$1" = chromium &&
           type chromium-browser >/dev/null 2>&1
	then
        	browser_path=chromium-browser
	fi
	browser_path=${browser_path:-"$1"}

Yours is:

	if test && test
        then
        	test && effect
	fi

which is less than readable, no?
