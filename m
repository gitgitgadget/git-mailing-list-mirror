From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 14:38:59 -0700
Message-ID: <xmqqtwjyfb0s.fsf@gitster.mtv.corp.google.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
	<xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka=EJ-L+Zaqh0kWUdjmyUva3fEcbwJn18uxshe3R5ABBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:39:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiU16-0007RK-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbcCVVjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:39:04 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751378AbcCVVjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:39:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFF8C4FCE3;
	Tue, 22 Mar 2016 17:39:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gKfXN6k2SnzO1PzMjcUyUxhTcqk=; b=aDuklX
	kiVWVenU989tlu6LJmU6x0ysk67EMeGBt/pwH6pcOZacPZ4RfktAfYy62l1zOkAS
	s2RP6HrsWJsMqzDXWRly7pipfT2cdL5YHJSTrKXkmZ8Cp/pVZ+QN8h91j7xu4yYA
	cvRjAEFP3V1kypevNXpCGWleqzhyf/y7G4Vps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BjNPVj/v7iXwh4N0chpASGpYI7O8R47/
	10cdZSP7NF7hG4Pwear5yeEunQ5jNaz+dK+MM3C2p7BEnmtnky5GRz4K6OcjVkgU
	lMAbQb56rtntIZSuXGDE5WV6pgMM+RgRBQ8ow7PO+o4pzn9aI0gAasILT7DS4Xn7
	iaUqia25+ao=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD40C4FCE2;
	Tue, 22 Mar 2016 17:39:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5969C4FCC3;
	Tue, 22 Mar 2016 17:39:00 -0400 (EDT)
In-Reply-To: <CAGZ79ka=EJ-L+Zaqh0kWUdjmyUva3fEcbwJn18uxshe3R5ABBQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Mar 2016 14:16:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D4F8B68-F076-11E5-AFF5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289569>

Stefan Beller <sbeller@google.com> writes:

>> I do not think that buys us much.  You have already shown how to
>> implement "filter first and then pathspec match" if a caller
>> wants to (which turned out to be a regression in this case, but
>> that is besides the point).
>
> And by including this filtering into the pathspec machine we can pass
> a flag DONT_BREAK_ON_NO_FILTER_RESULTS_WHEN_HAVING_OTHER_MATCHES
> (name for illustration purpose only ;) which is how I understand this
> regression?

But you do not even need that if you fix the regression with
something like this, no?  Do we need to add complexity to pathspec
machinery only to make it easier to misuse it and then add another
DONT_BREAK_... band-aid to fix a bug that can come from such a
misuse?

 builtin/submodule--helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed764c9..740b57a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -37,10 +37,11 @@ static int module_list_compute(int argc, const char **argv,
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!S_ISGITLINK(ce->ce_mode) ||
-		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
+		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
 				    0, ps_matched, 1))
 			continue;
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
 		list->entries[list->nr++] = ce;
