From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suprising error message from "git clone"
Date: Mon, 20 Aug 2007 13:40:56 -0700
Message-ID: <7vr6lyrlbb.fsf@gitster.siamese.dyndns.org>
References: <vpqwsvqmfhw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:42:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INE4n-0002vp-L2
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377AbXHTUlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXHTUlE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:41:04 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXHTUlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:41:01 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C8376125128;
	Mon, 20 Aug 2007 16:41:19 -0400 (EDT)
In-Reply-To: <vpqwsvqmfhw.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	20 Aug 2007 16:45:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56254>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I got a suprising error message:
>
> $ cd /tmp/
> $ git clone ~/some/repository
> Initialized empty Git repository in /tmp/repository/.git/
> Warning: -l asked but cannot hardlink to /home/moy/some/repository/.git

Yup, we already discussed when we switched to defaulting to -l,
but nobody cared enough to get around to patch the warning.

Untested but something like this should suffice...

By the way, could you possibly drop Mail-Followup-To: please?

 git-clone.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index e4a9ac4..18003ab 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -99,6 +99,7 @@ origin_override=
 use_separate_remote=t
 depth=
 no_progress=
+local_explicitly_asked_for=
 test -t 1 || no_progress=--no-progress
 while
 	case "$#,$1" in
@@ -109,6 +110,7 @@ while
 	*,--na|*,--nak|*,--nake|*,--naked|\
 	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local)
+	  local_explicitly_asked_for=yes
 	  use_local_hardlink=yes ;;
 	*,--no-h|*,--no-ha|*,--no-har|*,--no-hard|*,--no-hardl|\
 	*,--no-hardli|*,--no-hardlin|*,--no-hardlink|*,--no-hardlinks)
@@ -281,7 +283,8 @@ yes)
 			then
 				rm -f "$GIT_DIR/objects/sample"
 				l=l
-			else
+			elif test -n "$local_explicitly_asked_for"
+			then
 				echo >&2 "Warning: -l asked but cannot hardlink to $repo"
 			fi
 		fi &&
