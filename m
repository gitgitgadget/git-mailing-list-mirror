From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] attribute regression fix for maint-1.8.1 and upward
Date: Tue, 26 Mar 2013 11:39:27 -0700
Message-ID: <1364323171-20299-1-git-send-email-gitster@pobox.com>
References: <20130323083927.GA25600@sigill.intra.peff.net>
Cc: pclouds@gmail.com, peff@peff.net, avila.jn@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 19:40:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYmw-0001y4-FO
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab3CZSje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:39:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339Ab3CZSjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:39:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DA6DA852;
	Tue, 26 Mar 2013 14:39:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iOfY
	IFcovut1v6KSVnu0hmiwTdA=; b=VjHU+H1iRcmyyjwxNkSluJXcT2u4E8eR+IIS
	/kNHiT+0lAjuffdDke3H+nkdX/ukm67iIPPQasuXLV/TT+OXiDgd8sGiQy2vIWPX
	ovHEfwDjCllFrzutaXDzWP6CdtbuOpp856T+FJpUPjOyyQs+RuF3SebAhoQtlm3R
	dZ+ISo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	npLppLu071+gJCXjRCrkqxrz26ClmatmCom414WolCex9922b03THxTxJYJEz0lw
	48akRyIcuKtdApvKWzwZ0NoMW4cbY4Gkcnd5G18MRGRplwkYf3O/Z67JimsUWVz1
	3N7etpPoBIK1VO9nnywEsWlNIsfLwRidbC4RuvZq2Ns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 323C2A851;
	Tue, 26 Mar 2013 14:39:33 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 902C1A850; Tue, 26 Mar 2013
 14:39:32 -0400 (EDT)
X-Mailer: git-send-email 1.8.2-350-g3df87a1
In-Reply-To: <20130323083927.GA25600@sigill.intra.peff.net>
X-Pobox-Relay-ID: 801F1D3E-9644-11E2-9972-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219177>

So here is an attempt to fix the unintended regression, on top of
9db9eecfe5c2 (attr: avoid calling find_basename() twice per path,
2013-01-16).  It consists of four patches.

The first patch is not essential to the fix, but I think it
clarifies what is going on in this codepath.

The second patch addresses the issue Jeff noticed; it appears as if
match_basename() takes counted strings, but one of the strings was
not a counted string at all.  Its length was given to the function
because the caller already had one, so that we do not have to do
strlen() ourselves.  And the other one was meant to be a counted
string, but the callee was not using it as such.  The patch makes
them both counted strings and treat them as such.

The third patch is the main fix.  As I said in the log message, I
didn't look at it very carefully, so extra sets of eyeballs are very
much appreciated.

The last one is a test stolen from Jeff to seal the series.  It
needs sign-off from Jeff.

Jeff King (1):
  make sure a pattern without trailing slash matches a directory

Junio C Hamano (3):
  attr.c::path_matches(): the basename is part of the pathname
  dir.c::match_basename(): pay attention to the length of string
    parameters
  attr.c::path_matches(): special case paths that end with a slash

 attr.c                          | 23 ++++++++++++-----------
 dir.c                           | 31 +++++++++++++++++++++++++++----
 t/t5002-archive-attr-pattern.sh |  6 ++++++
 3 files changed, 45 insertions(+), 15 deletions(-)

-- 
1.8.2-350-g3df87a1
