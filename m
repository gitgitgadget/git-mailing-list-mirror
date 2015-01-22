From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] apply --whitespace=fix buffer corruption fix
Date: Thu, 22 Jan 2015 14:58:21 -0800
Message-ID: <1421967505-16879-1-git-send-email-gitster@pobox.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 23:58:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQhz-0007l5-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbbAVW6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:58:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751930AbbAVW6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:58:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D99B33134D;
	Thu, 22 Jan 2015 17:58:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9Uo1
	LBC+Fy1xXoqkINJxLXK7wgA=; b=CAz4fWWE4IkuiqMJaHMM5rI/QMiBjEb29e+b
	14oTzoJLqUKPANDHtbHuDi4NeQV9F0kN3M3Zia0mNmCJ8sDjBs0SDGhmKwlN6i30
	eKXSvY9BIh2vkEH9Yf6CUGpFpCniouychVU2lPrYYyoTC5c/peEC4wvb1nsjbiE/
	ODOnw18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cPPmxX
	l9kru8fNFnLoyVfnNGFQZ2JvoOPTl03EAyfPcovARfE/IuCbvq1XnCjz4o7sO6nM
	f4PVjdA8LIgYr2dtoYbnOdQejHzCXvGwq+gVTZe9sHXcg3n5z4we+hhxRYhQnVfR
	fnADBruCdPkMg8+uBKM1ibU+LWlaKv4CzZQKg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0A8C3134C;
	Thu, 22 Jan 2015 17:58:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 636983133D;
	Thu, 22 Jan 2015 17:58:26 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc1-150-gaf32ea2
In-Reply-To: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 2C866E44-A28A-11E4-B7CD-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262881>

"git apply --whitespace=fix" used to be able to assume that fixing
errors will always reduce the size by e.g. stripping whitespaces at
the end of lines or collapsing runs of spaces into tabs at the
beginning of lines.  An update to accomodate fixes that lengthens
the result by e.g. expanding leading tabs into spaces were made long
time ago but the logic miscounted the necessary space after such
whitespace fixes, leading to either under-allocation or over-usage
of already allocated space.

The second patch in this series is to illustrate this with a runtime
sanity-check to protect us from future breakage (this is a reroll of
a "how about this" weatherbaloon patch $gmane/262579, with Kyle's
test script).

The third patch corrects the under-counting and makes the new test
pass.

The fourth patch makes us report the fact that we corrected
whitespace errors in the common-context part.  When asked to correct
whitespace errors, and given a patch that has whitespace errors in
the common context (i.e. the lines prefixed with " ") either in the
patch itself or the corresponding part in the file we are patching,
we have been correcting the whitespace errors "while at it" since
around c1beba5b (git-apply --whitespace=fix: fix whitespace fuzz
introduced by previous run, 2008-01-30), but we were not reporting
that we saw a need to fix them.

This is not about the "buffer corruption fix", which is the primary
focus of this series, but it is here because it is related to
whitespace fix.


Junio C Hamano (4):
  typofix
  apply: make update_pre_post_images() sanity check the given postlen
  apply: count the size of postimage correctly
  apply: detect and mark whitespace errors in context lines when fixing

 builtin/apply.c               |  34 ++++++++++--
 t/t4138-apply-ws-expansion.sh | 121 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100755 t/t4138-apply-ws-expansion.sh

-- 
2.3.0-rc1-116-g84c5016
