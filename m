From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH 0/4] git http tests with apache 2.4
Date: Fri, 14 Jun 2013 10:32:57 -0700
Message-ID: <7v61xgpph2.fsf@alter.siamese.dyndns.org>
References: <20130609080722.GA31699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 19:33:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnXs2-0002VQ-7q
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 19:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab3FNRdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 13:33:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab3FNRdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 13:33:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F1627786;
	Fri, 14 Jun 2013 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9XAoue+nzcjGRn8lFTxFYYWkIvY=; b=AqbHTm
	+ayVmd0+OvntcdFpzPnMCNVOHFHJSKh7bg5aKy0WiciO+f1jAw4Z6xrmGnl7rk5w
	yBckflpQo9og/5870stmA0vR/+gEFslvkWDIFjfhaYErGzFkJAyO7CWguajImBV1
	rBobxawl00Dd4JjjdZ5FTJgSnweWqRwrM02AE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=naY8+T0q/4T3b2LTI9dm+O+3DiF4qTGk
	Qp/4QBMq6u13dbXvgU9+XnYIyT3M64YjPInB6nkhEUgVw74UtLMH2Z7amVq/eYf+
	tSV2YWfmIqnYvTY4ntUtbcEh/TWhJOUMoYuWXNEQkjl5kQ+bxlG3KsoORCF2QSAY
	XPc1FTQOCG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EAC427785;
	Fri, 14 Jun 2013 17:32:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C99A27784;
	Fri, 14 Jun 2013 17:32:58 +0000 (UTC)
In-Reply-To: <20130609080722.GA31699@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 9 Jun 2013 04:07:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 748CDBD8-D518-11E2-94ED-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227903>

Jeff King <peff@peff.net> writes:

> Apache 2.4 recently shipped in Debian unstable, and I noticed that all
> of the git httpd tests stopped working. It turns out that some
> configuration directives have changed between 2.2 and 2.4, and the httpd
> server would not start at all.
>
> With this series, the tests run again (for me, at least). The
> "<IfVersion>" checks hopefully mean that there are no regressions for
> people running 2.2 and lower.
>
> However, the final patch is very unsatisfactory. We have to pick an MPM
> module to mention in the config, but we don't have any idea what's
> available. I suspect what I have provided will work on most Unix-ish
> systems. Under Windows, there is a totally different MPM. But I am not
> sure that our http tests run at all on Windows, as we seem to check in
> lib-httpd.sh for a Unix-ish apache module path.

Thanks.  I think the final one, while it may be unsatisfactory, is a
reasonable (or "least bad") compromise, at least for now.  I do not
think of a better way, without adding "if you want customization,
write a snippet to be included in the configuration used during the
test", which feels way overkill.
>
> As far as I know, Apache does not have a "try to load this module and
> fallback" directive. We could perhaps look in the module directory and
> try to do something clever in the shell before starting Apache. Advice
> from Apache gurus is welcome.
>
>   [1/4]: t/lib-httpd/apache.conf: do not use LockFile in apache >= 2.4
>   [2/4]: t/lib-httpd/apache.conf: load extra auth modules in apache 2.4
>   [3/4]: t/lib-httpd/apache.conf: load compat access module in apache 2.4
>   [4/4]: t/lib-httpd/apache.conf: configure an MPM module for apache 2.4
>
> -Peff
