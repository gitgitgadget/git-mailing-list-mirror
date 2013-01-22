From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Tue, 22 Jan 2013 14:51:59 -0800
Message-ID: <7v1udcn84w.fsf@alter.siamese.dyndns.org>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com>
 <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:52:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txmhe-0005qx-88
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 23:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab3AVWwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 17:52:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab3AVWwC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 17:52:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A096BA16;
	Tue, 22 Jan 2013 17:52:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6BDWf8ZSEBc3tSflFINbCPshNM=; b=BbSz79
	WX3VJEmesjo5/QrKxbfvEAOVg6WSHBVZcWPAODumWemi0ntfY2beCX0FbZ9PlB60
	yuux/vPD5VV+xyQJneDfRa/3MWNH2NEM3kFX7tyBHxBCZNkp6prTtYOKo2oxZv+v
	ZtzM5AN0NZbMA09EkxGmpHSI9ix4eYgw5sKcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gxFVZEVHGmPN3iJgaZXUSikXjdowGRWB
	nXtWNPcRovJpWcYV5vUh0MFZ4NQybXK4Dyaz1SCSxmNrddzB7fCX+fRgUBhMUOVa
	VoZ0WZ1rAqiAjs6uRpJmLtk5ChFTJe7cmUgvL5qIXoHr7kACWujkTpNTOrr96BI9
	0UtxJ98SEwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26E23BA15;
	Tue, 22 Jan 2013 17:52:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96152BA14; Tue, 22 Jan 2013
 17:52:01 -0500 (EST)
In-Reply-To: <7vr4lcnbn5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Jan 2013 13:36:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 559E1D74-64E6-11E2-A32D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214260>

Junio C Hamano <gitster@pobox.com> writes:

> We obviously do not want to set FNM_PATHNAME when we are not
> substituting fnmatch() with wildmatch(), but I wonder if it may make
> sense to unconditionally use WM_PATHNAME semantics when we build the
> system with USE_WILDMATCH and calling wildmatch() in this codepath.
> Users can always use "*/**/*" in place of "*" in their patterns
> where they want to ignore directory boundaries.

Another possibility, which _might_ make more practical sense, is to
update dowild() so that any pattern that has (^|/)**(/|$) in it
implicitly turns the WM_PATHNAME flag on.  There is no reason for
the user to feed it a double-asterisk unless it is an attempt to
defeat some directory boundaries, so we already know that the user
expects WM_PATHNAME behaviour at that point.  Otherwise, the user
would have simply said '*' instead, wouldn't he?

I said "_might_" because it sounds a bit too magical to my taste.
I dunno.
