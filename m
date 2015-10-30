From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] test: accept death by SIGPIPE as a valid failure mode
Date: Fri, 30 Oct 2015 14:22:14 -0700
Message-ID: <xmqqr3kcjbll.fsf_-_@gitster.mtv.corp.google.com>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
	<CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
	<CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com>
	<xmqq8u6qluh2.fsf@gitster.mtv.corp.google.com>
	<xmqqvb9ojcmf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fredrik Medley <fredrik.medley@gmail.com>, peff@peff.net,
	patrick.reynolds@github.com,
	Lars Schneider <larsxschneider@gmail.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsH7v-0007IG-1O
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 22:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbbJ3VWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 17:22:18 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760658AbbJ3VWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 17:22:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EBC028C57;
	Fri, 30 Oct 2015 17:22:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fd1Q4BungP2SFwBJEu7Vu3wb65E=; b=fIGYud
	gjmyG86VYmdBOLnlWoeuLWAdF/9CmspNN3PkcD7vJYp1Z6YKmMBdcTulHOEc7HQV
	6/xBMwVuFotiFNJOs9dKfb8oXJUErQ9CBGAxvL6YK48RR2pn9B4b/7cc73XFOX4d
	a+ggU0r9GGGTuImWOQBXHYNMr8kbdvPeBIzzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DlvWjuFsqxwy36MgAkOLSlRGMqArjRfP
	XzZ6BDkkw5+4NAPERbBDemuRgHwcES8hHmDg/bfJIkaBhrHl9qoSdBgaR0UctioB
	ogMefQnTtLeYIwTBxz5kTJirf7a6bYubRKtk/6nxfhXd9M9znrCqjcPftk+/Epvq
	zSRdC/21Tic=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 864FC28C56;
	Fri, 30 Oct 2015 17:22:16 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0D6FD28C55;
	Fri, 30 Oct 2015 17:22:15 -0400 (EDT)
In-Reply-To: <xmqqvb9ojcmf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 30 Oct 2015 14:00:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B34E4DE-7F4C-11E5-BED2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280543>

On a local host, the object/history transport code often talks over
pipe with the other side.  The other side may notice some (expected)
failure, send the error message either to our process or to the
standard error and hung up.  In such codepaths, if timing were not
unfortunate, our side would receive the report of (expected) failure
from the other side over the pipe and die().  Otherwise, our side
may still be trying to talk to it and would die with a SIGPIPE.

This was observed as an intermittent breakage in t5516 by a few
people.

In the real-life scenario, either mode of death exits with a
non-zero status, and the user would learn that the command failed.
The test_must_fail helper should also know that dying with SIGPIPE
is one of the valid failure modes when we are expecting the tested
operation to notice problem and fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a real commit log message.  As the goal is to
   treat death-by-sigpipe just like a call to die(), this version
   silently lets the test pass instead of giving a message to the
   standard error stream.

 t/test-lib-functions.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8f8858a..4f40ffe 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -556,6 +556,9 @@ test_must_fail () {
 	if test $exit_code = 0; then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
+	elif test $exit_code -eq 141; then
+		# died with sigpipe
+		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192; then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
-- 
2.6.2-456-gc12a6fe
