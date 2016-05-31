From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/lib-git-daemon: ksh portability workaround
Date: Tue, 31 May 2016 16:04:00 -0700
Message-ID: <xmqq60tt3k4f.fsf@gitster.mtv.corp.google.com>
References: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 01:04:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7shm-0006Bc-1J
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbcEaXEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:04:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbcEaXEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:04:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A87F420206;
	Tue, 31 May 2016 19:04:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zngQ8WVG/enZ3WUrkYTEnMg9Q7Y=; b=xI7Lrz
	SgiPwL3OTqk6U/ExCjZ0R6mfzLI324Pd0xHJM56/0qgOJePTo77eGteGz/qjYJrc
	zqJoa1Pmw5/NXlrjGj73bM77d5hhQP5cLaHlJ8Kux4dkZZ9kmTwwx8/5onalmGFN
	n8J/3pN41SihtXH/i7lsYIkQomo3hrLtO6gSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZLSsUgndlesDGilwfJ1NUiKVkS4MIC7
	wVDt7vQqTTRS/lBMqS/C55GiUQkZ6a+xyjjQNmib6iYdyKKL6/noar4NpgkN13M+
	LZs9p9HuPUDLfWCgga9h+wclhYJdjiuF3/GtAVqnR1PvH6r9ebc0FOfo500PAZ+x
	IpILskabQDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A009120205;
	Tue, 31 May 2016 19:04:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F75B20203;
	Tue, 31 May 2016 19:04:02 -0400 (EDT)
In-Reply-To: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 May 2016 15:47:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7262CA0-2783-11E6-BB30-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296031>

The "git daemon" test checks with what status the daemon exits when
we terminate it, and we expect that we can observe death by SIGTERM.

We forgot that ksh adds 256, unlike 128 that are used by other POSIX
shells, to the signal number that caused the process to die when
coming up with the exit status.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 340534c..623b3ae 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -83,7 +83,8 @@ stop_git_daemon() {
 	wait "$GIT_DAEMON_PID" >&3 2>&4
 	ret=$?
 	# expect exit with status 143 = 128+15 for signal TERM=15
-	if test $ret -ne 143
+	# or 271 = 256+15 on ksh
+	if test $ret -ne 143 && test $ret -ne 271
 	then
 		error "git daemon exited with status: $ret"
 	fi
