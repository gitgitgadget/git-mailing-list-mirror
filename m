From: Junio C Hamano <gitster@pobox.com>
Subject: Re: With errno fix: [PATCH] Do not log unless all connect() attempts
 fail
Date: Wed, 13 Jul 2011 13:58:38 -0700
Message-ID: <7vtyap6gox.fsf@alter.siamese.dyndns.org>
References: <7276ACEE-EF52-49DF-83EA-642DE504B3EA@apple.com>
 <CABPQNSYWKVngfoj4AqTCbWixENSmgnbdDBGBt+EpWnBgbqpofg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Zarzycki <zarzycki@apple.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 13 22:58:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6W5-0002iF-Tr
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 22:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab1GMU6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 16:58:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab1GMU6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 16:58:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42D206794;
	Wed, 13 Jul 2011 16:58:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=23jmE1nkl9Yi8CX9iWVPYsc2T54=; b=thP4Cw
	hO+zikrDMS9devop0O9bupWM4gcSyr2MVqfWgsnUBhJRLvUfB4jV1FvVQ5Z+np/V
	6sT+BT/8Nl+b2uzkrteOdaKxSca8aeRY1wDnB90bagc1urL+hBU4VOiMtF9Ez/xr
	hn8YVzoqY4B5pDQ1tPG2nEDhia+vV6dfjNzEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1efIoODJORv3VGsqNToMI84qA7oq8n0
	wIbRhuzKdguC3PK2TbjkGB/fNMRna5JufLf/SSLiVvsF8MD6KgBxxL6MSKZrPynx
	SC/B94Q3lhyonaAh+1oaU7wDCU72hHCX3JFI3Emg/KbBohx4QklumkB+xi5O0XcH
	XYaupu+JFts=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C0AC6793;
	Wed, 13 Jul 2011 16:58:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 791906790; Wed, 13 Jul 2011
 16:58:40 -0400 (EDT)
In-Reply-To: <CABPQNSYWKVngfoj4AqTCbWixENSmgnbdDBGBt+EpWnBgbqpofg@mail.gmail.com> (Erik
 Faye-Lund's message of "Wed, 13 Jul 2011 20:47:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2EBAC9E-AD92-11E0-8E81-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177080>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Uhm, this will still fail to report errors for the very last entry,
> no? When socket returns -1 in the last iteration (and errno gets
> saved), there's no code that reports it...

I guess the fix should look something like this.

By the way, is anybody interested in fixing the other side of the ifdef
that is compiled on IPv4-only installations? 

 connect.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 8eb9f44..844107e 100644
--- a/connect.c
+++ b/connect.c
@@ -193,7 +193,7 @@ static const char *ai_name(const struct addrinfo *ai)
 static int git_tcp_connect_sock(char *host, int flags)
 {
 	struct strbuf error_message = STRBUF_INIT;
-	int sockfd = -1, saved_errno = 0;
+	int sockfd = -1;
 	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
@@ -220,15 +220,12 @@ static int git_tcp_connect_sock(char *host, int flags)
 	for (ai0 = ai; ai; ai = ai->ai_next) {
 		sockfd = socket(ai->ai_family,
 				ai->ai_socktype, ai->ai_protocol);
-		if (sockfd < 0) {
-			saved_errno = errno;
-			continue;
-		}
-		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
-			saved_errno = errno;
+		if ((sockfd < 0) ||
+		    (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0)) {
 			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
-				host, cnt, ai_name(ai), strerror(saved_errno));
-			close(sockfd);
+				    host, cnt, ai_name(ai), strerror(errno));
+			if (0 <= sockfd)
+				close(sockfd);
 			sockfd = -1;
 			continue;
 		}
