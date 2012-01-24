From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/10] clone: delay cloning until after remote HEAD
 checking
Date: Mon, 23 Jan 2012 16:34:14 -0800
Message-ID: <7vzkde546x.fsf@alter.siamese.dyndns.org>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-7-git-send-email-pclouds@gmail.com>
 <7v62g26jm3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 01:34:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpUL8-00034B-CN
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 01:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab2AXAeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 19:34:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab2AXAeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 19:34:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF666686;
	Mon, 23 Jan 2012 19:34:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5aaJSYhGKqMjBiu+/QK7Td6Rfpw=; b=CdilNj
	Dj655uG83yCkRhcNZXqcSEglTv7w/gZwEzWH8MmEmkI2ivDMogVoIF2YEiVXrkMy
	PMW9ABb7sHh9PUNChxOCiceJHfoYIWj30+hYdv3BtDI3esee/v6eHr/Nh5hq9GjR
	VT2d69zZ6+eoG/LC1rsf30PEa+SpIauWrxLLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CSdV2LNVKaKluIzoPtJsIhCo+7Eh8EW0
	O4RD1ErDaZoghHfLBZ24P0cb124MsCmjvdZ/IZxWk+pj0nlOAx8XPbm1O0G7pEn6
	sTH/c9ScettfikVai0TXBalCK7yQptDl947q6IsufXEt8HZWDC1o5tDOz7sYROBO
	7yLzGlyu1cg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5FC86685;
	Mon, 23 Jan 2012 19:34:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24D0F6684; Mon, 23 Jan 2012
 19:34:16 -0500 (EST)
In-Reply-To: <7v62g26jm3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jan 2012 16:15:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 254FD1AE-4623-11E1-AF92-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189027>

Junio C Hamano <gitster@pobox.com> writes:

> It breaks pushing to multiple URLs like this:
>
>     $ cat .git/config
>     [remote "origin"]
>             url = https://code.google.com/p/git-htmldocs/
>             url = github.com:gitster/git-htmldocs.git
>             push = refs/heads/master:refs/heads/master
>     $ git push
>
> The second url that is supposed to use the git-over-ssh transport
> mistakenly use https:// and fails with:
>
>     error: Couldn't resolve host 'github.com:gitster' while accessing
>     github.com:gitster/git-htmldocs.git/info/refs
>     fatal: HTTP request failed

And here is an obvious band-aid to work it around.
