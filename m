From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] Tying loose ends on grep-pcre
Date: Wed, 10 Oct 2012 00:55:07 -0700
Message-ID: <1349855714-17008-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 09:55:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLr8e-0000Ov-4y
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab2JJHzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:55:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab2JJHzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:55:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC9DD6F8F
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=F8/Ksx3Cgx9D6SdJYiuBQ2g2kKg
	=; b=nCze6okPMkTJFxoFcVkWsmORbeBBt/S4fpg8gRivDTq4Ui8b2WltozXOBZD
	JiE4WoLE/K6KVUsZOXuELjO2kUMLko6aMXbrGYDUOS5agcqzYyn49rpBT0YWp27y
	cTBJwSbS45jdU4FwiQqNel053IjoqjDUHrs4LnNyntZ9/B2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Zd+O8V3OFFCuPzZ4+PBhQdvzNRrb7
	m9xRsl5hHnERm90evcWHzFZjrx5ps0nJiuodbgxORfQWE+tDZN3D6mZ93KbRtZ4Z
	B7+piRlBv7NV3eAII98/fCrGXK+OhqTvpuMn3W0PHHmCIfIck0THArhbE3i5dDb8
	sIesYzFQbBG4R4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C62F86F8D
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00B4A6F8C for
 <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc1.76.g5a375e6
X-Pobox-Relay-ID: D49BDA0A-12AF-11E2-B86C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207372>

It took longer than expected, but here is a reroll of the previous
series to bring more recent "git grep" enhancements to the "--grep"
option of commands in "git log" family.

The early part of the series (1-3) refactors the code that reads
configuration items related to "grep" and the code that mixes the
result with the command line options to prepare grep_opt, which so
far lived in builtin/grep.c, and moves them to the grep.[ch] at the
top-level.

The middle part (4-6) reuses the code to set-up grep_opt refactored
by the earlier part of the series on revs->grep_filter that is used
in "git log --grep=..." processing.  It incidentally fixes a small
bug where "git log -F -E --grep='<ere>'" did not look for matches to
the pattern in extended regular expression, and adds --basic-regexp
and --perl-regexp command line options to "git log" family for
completeness.

The last one teaches "git log" family to honor the "grep.*"
configuration variables, e.g. "grep.patterntype", so that you can
say "git -c grep.patterntype=perl log --grep='(?:pcre)'".

Obviously, it is too late for this cycle and will not graduate to
'master' before the 1.8.0 final.


Junio C Hamano (7):
  builtin/grep.c: make configuration callback more reusable
  grep: move the configuration parsing logic to grep.[ch]
  grep: move pattern-type bits support to top-level grep.[ch]
  revisions: initialize revs->grep_filter using grep_init()
  log --grep: use the same helper to set -E/-F options as "git grep"
  log --grep: accept --basic-regexp and --perl-regexp
  log: honor grep.* configuration

 Documentation/rev-list-options.txt |  10 +++
 builtin/grep.c                     | 133 ++--------------------------
 builtin/log.c                      |   8 +-
 grep.c                             | 177 +++++++++++++++++++++++++++++++++++++
 grep.h                             |   6 ++
 revision.c                         |  14 ++-
 t/t4202-log.sh                     |   6 ++
 7 files changed, 225 insertions(+), 129 deletions(-)

-- 
1.8.0.rc1.76.g5a375e6
