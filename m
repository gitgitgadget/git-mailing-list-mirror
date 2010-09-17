From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2] git-rebase--interactive.sh: replace cut with ${v%% *}
Date: Fri, 17 Sep 2010 16:42:51 -0500
Message-ID: <0eafa42f1da5f66465a1eb9da170416363cf72e0.1284759770.git.chris_johnsen@pobox.com>
References: <7vsk182p2q.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 23:43:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwiiT-0008VO-IC
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 23:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0IQVn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 17:43:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab0IQVn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 17:43:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 710CDD6969;
	Fri, 17 Sep 2010 17:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=X9wL
	v/yKTvtwMbIDHqURmnchH54=; b=Ohq3nXzUR2uswwnh2d9DcoGI34TdiDrRrTVZ
	40UUMJ7R2JGGtPPHk3hlhTAhDU6CiRPG+dlXnc2Di7+OUz7DFNa+b2imLqodMeLn
	uhpTTA8CY4tUCk+IALm932DPMeotafOvbkJwYnK4gJUBDnTIG+4BCbmIKlZ/UcA+
	eYPOXos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	GifSNOhg2RRvdloBo/X6kx7CX53PjkpH1S1ouV1pbtAdIsaHR6zFWGR35gnyyykw
	c14JwpDlVtAK5QZlEkG37dwnQFxtw1+mJh8augrf28EcogrzmzkSBeHxSXHiNjhT
	wVxveLgdc4qEdhd9IWA07CCSyy7vbX35xOuva9yqC1c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF40D6967;
	Fri, 17 Sep 2010 17:43:21 -0400 (EDT)
Received: from Blinky.local.net (unknown [75.53.36.236]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 337C2D6963; Fri, 17
 Sep 2010 17:43:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc2
In-Reply-To: <7vsk182p2q.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 972A3E44-C2A4-11DF-A7D1-030CEE7EF46B-07245699!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156416>

Some versions of cut do not cope well with lines that do not end in
an LF. In this case, we can completely avoid cut by using the
${var%% *} parameter expansion (suggested by Brandon Casey).

I found this problem when t3404's "avoid unnecessary reset" failed
due to the "rebase -i" not avoiding updating the tested timestamp.

On a Mac OS X 10.4.11 system:

    % printf '%s' 'foo bar' | /usr/bin/cut -d ' ' -f 1
    cut: stdin: Illegal byte sequence

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

Brandon Casey wrote:
> Or we could write it like:
>
>    sha1=${rest%% *}
>
> Does the above work on your FreeBSD system?

Yes, as Junio points out, ${var%% *} is portable enough for Git.
After this change t3404 passes here without GNU cut available.

Junio C Hamano wrote:
> Agreed; the less use of 'cut' we see, the better ;-)

It seems like the other uses of cut in git-rebase--interactive.sh
would be more awkward if they were replaced with equivalent
processing done in-shell with parameter expansions. Eliminating them
should probably wait until after 1.7.3, if at all.
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index eb2dff5..a27952d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -626,7 +626,7 @@ skip_unnecessary_picks () {
 		case "$fd,$command" in
 		3,pick|3,p)
 			# pick a commit whose parent is current $ONTO -> skip
-			sha1=$(printf '%s' "$rest" | cut -d ' ' -f 1)
+			sha1=${rest%% *}
 			case "$(git rev-parse --verify --quiet "$sha1"^)" in
 			"$ONTO"*)
 				ONTO=$sha1
-- 
1.7.3.rc2
