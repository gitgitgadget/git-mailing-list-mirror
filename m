From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/10] clone: delay cloning until after remote HEAD
 checking
Date: Mon, 23 Jan 2012 16:15:48 -0800
Message-ID: <7v62g26jm3.fsf@alter.siamese.dyndns.org>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 01:16:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpU3K-0003iL-5q
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 01:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab2AXAPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 19:15:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156Ab2AXAPw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 19:15:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07297625A;
	Mon, 23 Jan 2012 19:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7pSDzcxrjvwuLSRMRTU2+hxPpbo=; b=TpN89/
	/7r4bhbTRjD29/uqCijTpw2yqRO9svmgt20adcvHaPcdRyvYnsLov3E8/kLNrhwo
	r1h/hdhJd5Mj68yQO7j8cHBtrAIDOPxKdgcbhwSGjdZJKE7Uv563B44edG+zvp5f
	ZSl603mDjQDEzv9Via9wCZbzLng8X+Q1FiUXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CKs8l1ZTqH7qOjgnaTA0a2bMdHv2RUl2
	feDL4bdN7lP3OdPTNEvFR/Tw2iSMS8aKIJi2ZlMAYnjsQfLbO3OaLQ/k06N20qYz
	RIwZZ0ytfRn/10zTDwQ3+K2kcy6UE/Y5KHMIjkjrfYBDSinKDhQ9YKQ/kEcTDRIU
	wsnoDrcbudY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1CBC6259;
	Mon, 23 Jan 2012 19:15:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 805D56256; Mon, 23 Jan 2012
 19:15:50 -0500 (EST)
In-Reply-To: <1326189427-20800-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 10 Jan
 2012 16:57:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 924F1254-4620-11E1-81BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189025>

I wanted to merge this series to 'next' and further merge it early in the
next cycle to 'master', but with this my pushes (!!) seem to fail.

It breaks pushing to multiple URLs like this:

    $ cat .git/config
    [remote "origin"]
            url = https://code.google.com/p/git-htmldocs/
            url = github.com:gitster/git-htmldocs.git
            push = refs/heads/master:refs/heads/master
    $ git push

The second url that is supposed to use the git-over-ssh transport
mistakenly use https:// and fails with:

    error: Couldn't resolve host 'github.com:gitster' while accessing
    github.com:gitster/git-htmldocs.git/info/refs
    fatal: HTTP request failed
