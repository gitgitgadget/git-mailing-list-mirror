From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] War on blank-at-eof
Date: Fri,  4 Sep 2009 03:55:09 -0700
Message-ID: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:55:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWSC-0003iL-4J
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbZIDKzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbZIDKzY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962AbZIDKzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 397B543D23
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=gu+J0uEW+qoMnEB1aE7kJmU+mp0
	=; b=pFHOO/c5sdleBClpWmNeTe/C7+AhptTFkD9TcfGI3CU7XuAy1sSOpBkhEz+
	IyuFy5gj28Zyaou7EGmUm8jhV2aHT3sBtbEpQRzFlc2eZdwBPffYlLKhVRu2sxe3
	9MnP2zsW47NWoQxJexxiRj2V+zGn7qzdklXJa4EGAfI3jelc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=l/T9Q6ZuviFdApqkAFB4p+pCI5srt
	SztMRF5wdZSmBB96Hn0xd97zRZ5JkEm9nx9apT9iFn4pQwvgynY5kE1YcWIZAN4K
	atzgsujUF8rJMXiVXWPZuK53zQSKSh7D4HsvyYgjptMmr4YyiezY+a6whQ5IHGXd
	VzV8My2qKSXbe4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31A1743D22
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78A6843D21 for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:20 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
X-Pobox-Relay-ID: 728A4F4E-9941-11DE-8BFF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127711>

We had quite inconsistent handing of patches that add new blank lines at
the end of file, and this miniseries is about fixing it.

Patch 1 is a fix to an ancient bug introduced by v1.5.5-rc0~156^2~11.

Patch 2 fixes a bug that is even older---I suspect it dates back to the
very first change that introduced the feature, but I did not bother to
dig.

Patch 4 (Patch 3 is a preliminary refactoring used by it) is about the
discrepancy between "--whitespace=fix" and "--whitespace=warn".  The
blank-at-eof error was silently fixed but never diagnosed, which has
been one of the long-standing itch of mine to fix.

Patch 5 corrects the definition of blank-at-eof.  If a patch adds an
non-empty line that consists solely of whitespaces at the end of file, we
should diagnose and strip it just line a new empty line.  After all, both
are blank lines.

Patch 6 is a simple code reduction I noticed while preparing this series;
it can be a standalone patch, but it is obvious enough to be here.

Patches 7 and 8 address "git diff --check", which had roughly the same
logic as the --whitespace=fix.  It shared the same problems the earlier
parts of the series fixed for "git apply".

Patch 9 is about "diff --color" to paint blank-at-eof as error, which we
did not do so far because it was too cumbersome.  This has been another
one of the long-standing itch of mine to fix.

The series applies to v1.6.0.6-87-g82d97da; merging the result to 'master'
needs some conflict resolution.

 1 apply --whitespace=fix: fix handling of blank lines at the eof
 2 apply --whitespace=fix: detect new blank lines at eof correctly
 3 apply.c: split check_whitespace() into two
 4 apply --whitespace=warn/error: diagnose blank at EOF
 5 apply --whitespace: warn blank but not necessarily empty lines at EOF
 6 diff.c: the builtin_diff() deals with only two-file comparison
 7 diff --whitespace=warn/error: obey blank-at-eof
 8 diff --whitespace=warn/error: fix blank-at-eof check
 9 diff --color: color blank-at-eof

 Documentation/config.txt   |    2 +
 builtin-apply.c            |   61 +++++++++++++++-------
 cache.h                    |    3 +-
 diff.c                     |  119 +++++++++++++++++++++++++++++---------------
 t/t4015-diff-whitespace.sh |   11 +++-
 t/t4019-diff-wserror.sh    |   11 ++++-
 t/t4124-apply-ws-rule.sh   |   80 +++++++++++++++++++++++++++++
 ws.c                       |    6 ++
 8 files changed, 230 insertions(+), 63 deletions(-)
