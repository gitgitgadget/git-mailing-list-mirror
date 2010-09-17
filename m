From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH] git-rebase--interactive.sh: LF terminate line sent to cut
Date: Fri, 17 Sep 2010 09:17:43 -0500
Message-ID: <60d13fc6a7d5b1b08f35f91b2d90eb7c13922390.1284733059.git.chris_johnsen@pobox.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 16:20:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwbnZ-0001z0-4L
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 16:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0IQOT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 10:19:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab0IQOT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 10:19:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF1CCD6257;
	Fri, 17 Sep 2010 10:19:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=qtElxMebGyefRWz/eH+PJzmKtFI
	=; b=N3R+rS5vLinUwvfYQy0+DhAMS9k7I7UKWZz9SVk+Yszo9JCzZoKTxnBJPee
	LdeSUR3Xg2chZ4X+oZnVMUMfTjKOivJtQGbyBWz+8ZPV/SEFBixPwIDGu/PJLrwW
	+O1OSRTWanJ7qgDj9ei85XVZWb075n7NMSF0BdYq0pPGAnbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=duD9Pbslnyht4KArhEFYT
	9679rQma9njss06XB+SSTkRy+OsczGa6pnBXTWowJQewUy52BRJaZXIUBaef24ve
	NjNWoUZvTFVhgph9hMJ2e839yIJo3lCB/TAAN2+1rpuuccfPnzPjA5u2ro1FglNx
	mASh1GTfqAzmsuGGYGGhew=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89CC9D624E;
	Fri, 17 Sep 2010 10:19:50 -0400 (EDT)
Received: from Blinky.local.net (unknown [75.53.36.236]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81AA7D624D; Fri, 17
 Sep 2010 10:19:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc2
X-Pobox-Relay-ID: A2091D32-C266-11DF-960E-030CEE7EF46B-07245699!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156385>

Some versions of cut do not cope well with lines that do not end in
an LF. Add '\n' to the printf format string to ensure that the
generated output ends in a LF.

I found this problem when t3404's "avoid unnecessary reset" failed
due to the "rebase -i" not avoiding updating the tested timestamp.

On a Mac OS X 10.4.11 system:

    % printf '%s' 'foo bar' | /usr/bin/cut -d ' ' -f 1
    cut: stdin: Illegal byte sequence
    % printf '%s\n' 'foo bar' | /usr/bin/cut -d ' ' -f 1
    foo

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---
It looks like the cut on my system is derived from FreeBSD. It is
probably an old version though (possibly too old to care about).

The cut from GNU coreutils does not to have this problem, so using
it serves as a workaround.
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index eb2dff5..834460a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -626,7 +626,7 @@ skip_unnecessary_picks () {
 		case "$fd,$command" in
 		3,pick|3,p)
 			# pick a commit whose parent is current $ONTO -> skip
-			sha1=$(printf '%s' "$rest" | cut -d ' ' -f 1)
+			sha1=$(printf '%s\n' "$rest" | cut -d ' ' -f 1)
 			case "$(git rev-parse --verify --quiet "$sha1"^)" in
 			"$ONTO"*)
 				ONTO=$sha1
-- 
1.7.3.rc2
