From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Mon, 14 Jan 2013 15:36:21 -0800
Message-ID: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 00:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TutaC-0002Vp-1j
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 00:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181Ab3ANXg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 18:36:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066Ab3ANXg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 18:36:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF23EBEAF;
	Mon, 14 Jan 2013 18:36:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	IPxWTaCLBaRnPr+gSIloMMOsXc=; b=ZFc7l3xV9lAD6GdRnkzLFLLVI4jzn1oxE
	J0YbbG9Wre5MgTJwFTF2tOiKKxI6S/IanNvxDTvF2feYpd4rC636gcczQulYogUX
	+qagAvtUxbENe6CYfE++pDRdGkZiZAgWR4eLoHcCpm7eMUhq8at7Tu/8E0r9jns9
	pgsfHtHr2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=ByHSH8mTk7LZjSYrGgFYH8gYS2Zc437pgHcO1qR6rnaC9jTYrPTeW4sC
	E4n64mOYmWmSIHOzn1gso6PdlAcWqG321DT4cAk0n8L7f1CW85eXFoyuEYqy0F0B
	FLgA6wuJ9wCmUhqXGmm4S2MSQ9r0z3Cqc8ogAkdzluiBM7DDRhk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3540BEAE;
	Mon, 14 Jan 2013 18:36:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BC49BEAD; Mon, 14 Jan 2013
 18:36:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34CEDD20-5EA3-11E2-A70C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213542>

It appears that memcmp() uses the usual "one word at a time"
comparison and triggers valgrind in a callback of bsearch() used in
the refname search.  I can easily trigger problems in any script
with test_commit (e.g. "sh t0101-at-syntax.sh --valgrind -i -v")
without this suppression.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/valgrind/default.supp | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 0a6724f..032332f 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -49,3 +49,11 @@
 	Memcheck:Addr4
 	fun:copy_ref
 }
+
+{
+	ignore-memcmp-reading-too-much-in-bsearch-callback
+	Memcheck:Addr4
+	fun:ref_entry_cmp_sslice
+	fun:bsearch
+	fun:search_ref_dir
+}
