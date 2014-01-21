From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Tue, 21 Jan 2014 13:04:24 -0800
Message-ID: <xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 21 22:04:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5iUu-0002i6-05
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 22:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaAUVEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 16:04:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaAUVEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 16:04:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A9664692;
	Tue, 21 Jan 2014 16:04:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/m6Y2D3j8N7toQ5JFuL2Kb3fa/4=; b=ex4cnP
	F/fEx/trxSpFzDF67SvogwRSOCnzRfEEPWFPV0S9Zwb4/jeJfvxC9zX5F6/1GaEN
	J5N5FQ1buFcVtGoFDdr2oly2Ldb967eI9eGw9Ajg7PNifjbTTclyEqmG690jHleK
	t9At20CMkRnO9PSC7P/9ESOCqA26jv32HcHTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJxmlpTAng2EH+dNzriFR2i87gkeNrbE
	K0k6hrEdDoy0Ci2ZfGMpMxuEtJ7FfyUpCl+6jf1LQxAiS3r1x2WpPDltLCrp1ZDf
	Dv4dUxI8sRUL9cRLMUuTLfpiXbf0ZoIwjmSHIE0cIpK2Fx2joMXZRUmrEZ1FxBqI
	c0nZB1kqc0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF9C64690;
	Tue, 21 Jan 2014 16:04:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A7A36468C;
	Tue, 21 Jan 2014 16:04:28 -0500 (EST)
In-Reply-To: <52DD857C.6060005@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 20 Jan 2014 20:22:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D8309AC-82DF-11E3-830B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240774>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> If the git version number consists of less than three period
> separated numbers, then the windows resource file compilation
> issues a syntax error:
>
>   $ touch git.rc
>   $ make V=1 git.res
>   GIT_VERSION = 1.9.rc0
>   windres -O coff \
>             -DMAJOR=1 -DMINOR=9 -DPATCH=rc0 \
>             -DGIT_VERSION="\\\"1.9.rc0\\\"" git.rc -o git.res
>   C:\msysgit\msysgit\mingw\bin\windres.exe: git.rc:2: syntax error
>   make: *** [git.res] Error 1
>   $
>
> [Note that -DPATCH=rc0]

Thanks for a report.  I've been wondering how many distros and
packagers would have an issue like this when we go to 2-digit
release naming.  Of course we knew everybody can grok 3-or-4 ;-)

> In order to fix the syntax error, we replace any rcX with zero and
> include some additional 'zero' padding to the version number list.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> This patch is marked RFC because, as I was just about to send this
> email, I realized it wouldn't always work:

Yeah, and I suspect that with the use of $(wordlist 1,3,...) it is
not even working for maintenance releases.  Does it differenciate
between 1.8.5.1 and 1.8.5.2, for example?.  Or does "windres" always
assume that a package version is always 3-dewey-decimal (not 2, not
4)?
