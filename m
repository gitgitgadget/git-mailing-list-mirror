From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/19] "git apply --3way"
Date: Tue, 10 Jul 2012 00:03:53 -0700
Message-ID: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUUg-0007tv-0f
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab2GJHER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2GJHEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0706B7DC3
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=aJnN8fMvazGBzkeFdEsPHaRREsk
	=; b=YanddRgXDSAd8+ygeHQ4XEgu/p0R9aoO3JTZw0nYFZDDyujw4DA5seCRanq
	q4hlnabGu6UirMgANuDn2fLBPrTu2RD2ZH91LHsnDFpW73Zt4aCMtZavE11u9Ext
	QbI6F06KxIUiUj6LjpHGNE+wt+IC57EE0M1dv4gOc7JfJVyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=TzLZKPNLHtW1z6WZCI2LNOD3YDEbg
	ec0BKhAgJQZBdpzQKuyK4BNu2dkZXSUBL2jhjXGUiUT1ETFpgv2/fPlT6AZkWyJ4
	7k3ePtmVb45XXiiVjtjyMOdmXgP4T1XJ/03rQk+NHQUWKxV5YRcqkN9i30T3lqIS
	4iInDyibO2JExI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E943E7DC2
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A0FD7DBF for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
X-Pobox-Relay-ID: 75189A86-CA5D-11E1-A4A9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201238>

With finishing touches (mostly updates to in-code comments and log
messages). Previous ones were:

    http://thread.gmane.org/gmane.comp.version-control.git/197538
    http://thread.gmane.org/gmane.comp.version-control.git/197637
    http://thread.gmane.org/gmane.comp.version-control.git/199936

Teach "git apply" a similar "-3"way merge fallback option with this
series, and you can now apply your patches without having to reduce
context.  As it will leave the conflicted halves in the index and
let you manually resolve conflicts in the working tree, "--3way"
implies "--index", and cannot be used with "--cached" or "--reject".

I've been using this in my regular workflow, which involves a fair
amount of "git diff >P.diff" later followed by "git apply P.diff"
when flipping patches in topics around, and things seem to work OK.

Junio C Hamano (19):
  apply: fix an incomplete comment in check_patch()
  apply: a bit more comments on PATH_TO_BE_DELETED
  apply: clear_image() clears things a bit more
  apply: refactor read_file_or_gitlink()
  apply: factor out checkout_target() helper function
  apply: split load_preimage() helper function out
  apply: refactor "previous patch" logic
  apply: further split load_preimage()
  apply: move check_to_create_blob() closer to its sole caller
  apply: move "already exists" logic to check_to_create()
  apply: accept -3/--3way command line option
  apply: fall back on three-way merge
  apply: plug the three-way merge logic in
  apply: move verify_index_match() higher
  apply: --3way with add/add conflict
  apply: register conflicted stages to the index
  apply: allow rerere() to work on --3way results
  apply: document --3way option
  apply: tests for the --3way option

 Documentation/git-apply.txt |  11 +-
 builtin/apply.c             | 557 ++++++++++++++++++++++++++++++++++----------
 t/t4108-apply-threeway.sh   | 157 +++++++++++++
 t/t4117-apply-reject.sh     |   8 +
 4 files changed, 615 insertions(+), 118 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

-- 
1.7.11.1.294.g68a9409
