From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] xread: poll on non blocking fds
Date: Mon, 14 Dec 2015 15:11:32 -0800
Message-ID: <xmqqmvtchbh7.fsf@gitster.mtv.corp.google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-3-git-send-email-sbeller@google.com>
	<CAPig+cQoranAhJKSZm6jP-hYutkoXkf6461sY1v5NseQVTNL_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cHM-0000kr-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbbLNXLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:11:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753634AbbLNXLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:11:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E7CD348CF;
	Mon, 14 Dec 2015 18:11:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KZ69CnM2RS7lQCibMfzIl9DeTnY=; b=tI9HP4
	4TZ+4KsB1VZneoks7svKPDZj12GymNKJyClT2ZpPtRZdAvyJlkmgg63Bun+pcbN9
	7a6tzu4Ezglk5/LlOb4yNlJavEtTDddJivP+WXFLJ7yo1h6at6dzSr2PhU66iEtz
	YEvmw+fa4BYSdihnJ1FUtb6396goODAZPBRH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uMT+tMJIM2JxT3tihqn7LDtgrGs+VlgF
	Rx2iTEqBK1nUfzSDeyMnXrma99Fg89/rBahocGBZAfXWVSq8MYYfOtG21oBlrzat
	rSIgBKuxV1cOSMcmwMolRXcXZvITTNp7YEsvxY3xKVH/KRVBKfp0dvVUGxYi+TWX
	zTFkkc6sM1c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 259FF348CE;
	Mon, 14 Dec 2015 18:11:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8398D348CD;
	Mon, 14 Dec 2015 18:11:33 -0500 (EST)
In-Reply-To: <CAPig+cQoranAhJKSZm6jP-hYutkoXkf6461sY1v5NseQVTNL_g@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 14 Dec 2015 17:58:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 04683FD0-A2B8-11E5-A9B6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282448>

Eric Sunshine <ericsunshine@gmail.com> writes:

> This comment tells us what the code itself already says, but not why
> the value is being ignored. The reader still has to consult the commit
> message to learn that detail, which makes the value of the comment
> questionable.

Let's do this for now, then.

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Mon, 14 Dec 2015 11:37:12 -0800
Subject: [PATCH] xread: poll on non blocking fds

The man page of read(2) says:

  EAGAIN The file descriptor fd refers to a file other than a socket
	 and has been marked nonblocking (O_NONBLOCK), and the read
	 would block.

  EAGAIN or EWOULDBLOCK
	 The file descriptor fd refers to a socket and has been marked
	 nonblocking (O_NONBLOCK), and the read would block.  POSIX.1-2001
	 allows either error to be returned for this case, and does not
	 require these constants to have the same value, so a portable
	 application should check for both possibilities.

If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
As the intent of xread is to read as much as possible either until the
fd is EOF or an actual error occurs, we can ease the feeder of the fd
by not spinning the whole time, but rather wait for it politely by not
busy waiting.

We should not care if the call to poll failed, as we're in an infinite
loop and can only get out with the correct read().

Signed-off-by: Stefan Beller <sbeller@google.com>
Acked-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrapper.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 6fcaa4d..1770efa 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -236,8 +236,24 @@ ssize_t xread(int fd, void *buf, size_t len)
 	    len = MAX_IO_SIZE;
 	while (1) {
 		nr = read(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
-			continue;
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN || errno == EWOULDBLOCK) {
+				struct pollfd pfd;
+				pfd.events = POLLIN;
+				pfd.fd = fd;
+				/*
+				 * it is OK if this poll() failed; we
+				 * want to leave this infinite loop
+				 * only when read() returns with
+				 * success, or an expected failure,
+				 * which would be checked by the next
+				 * call to read(2).
+				 */
+				poll(&pfd, 1, -1);
+			}
+		}
 		return nr;
 	}
 }
-- 
2.7.0-rc0-109-gb762328
