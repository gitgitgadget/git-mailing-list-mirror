From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH v2] daemon.c: fix segfault on OS X
Date: Mon, 27 Apr 2009 15:59:49 +0200
Message-ID: <49F5BA55.3060606@googlemail.com>
References: <49F4BD9F.6070709@googlemail.com> <7vy6tmbzj3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Apr 27 16:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyRNN-0003Yq-Hj
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 16:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbZD0N74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 09:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZD0N7z
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 09:59:55 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:35120 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbZD0N7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 09:59:54 -0400
Received: by bwz7 with SMTP id 7so2307731bwz.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=SueJ67biMy/uwq26WtgzJc+MIsWm1Umpf7ckNg0bIl4=;
        b=gJsHaVh2IZ/g+Eod5V6LJEYFH2C+3dY1Q1j1jTx66IMF4BwC8r0Ke7YfHqIJ9+CyI8
         0EG9jlVr9CIgxVfgdxtY5Mr19kTiJvc56cm2alzXNKQVicutgpFBWcA5LExQf9c9/5Qd
         cjeQ8CpfxC55omJI2/ljCsNjZi1SrbmdVwmhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Zq47WJhHEI5Wer695FehYcyTiSky/5/KQavPHM+9wz3bg/oGHUQ5CAmvSiL9M5dWw3
         jD6Nz6hqAEqggDOoFAKmh88WbqXcivtwU5NuAInft8LQkHpoRtICSjr1CSQqZgZGt954
         E1aUl5NuOslDRUZYZSocgiCm0Px8al3qAQya8=
Received: by 10.103.11.5 with SMTP id o5mr3139056mui.75.1240840793094;
        Mon, 27 Apr 2009 06:59:53 -0700 (PDT)
Received: from golden.local (p5B01C290.dip.t-dialin.net [91.1.194.144])
        by mx.google.com with ESMTPS id j10sm8289191muh.45.2009.04.27.06.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 06:59:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <7vy6tmbzj3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117670>

On OS X (and maybe other unices), getaddrinfo(3) returns NULL
in the ai_canonname field if it's called with an IP address for
the hostname. We'll now use the IP address for the hostname if
ai_canonname was NULL, this also matches the behaviour on Linux.

steps to reproduce:
$ git daemon --export-all
$ git clone git://127.0.0.1/frotz
=> git daemon's fork (silently) segfaults.

Remove the pointless loop while at it. There is only one iteration
because of the break; on the last line and there are no continues.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---

Junio C Hamano wrote:
> But the part your patch touches is about supporting virtual hosting via
> pattern interpolation, and the daemon will still segfault even with your
> patch when somebody uses %CH expansion, because canon_hostname is left as
> NULL, won't it?  I suspect in such a case it might be safer to use a copy
> of the ip_address or something.

It doesn't segfault but it just assumes an empty hostname:

  $ git daemon --verbose --export-all --interpolated-path=%CH/%D
    [3251] Connection from 127.0.0.1:49423
    [3251] Extended attributes (16 bytes) exist <host=127.0.0.1>
    [3251] Request upload-pack for '/frotz'
    [3251] Interpolated dir '//frotz'

This upated patch uses a copy of ip_address. I did a quick test on my
Linux box and it looks like Linux' getaddrinfo(3) always returns the IP
address in ai_canonname instead of NULL when it is called with an IP
address hostname.

  $ git daemon --verbose --export-all --interpolated-path=%CH/%D
    [3871] Connection from 127.0.0.1:49427
    [3871] Extended attributes (16 bytes) exist <host=127.0.0.1>
    [3871] Request upload-pack for '/frotz'
    [3871] Interpolated dir '127.0.0.1//frotz'


Btw, if I connect to an IPv6 host with interpolated-path=%IP the IP
address gets converted to 0.0.0.0. Is this desired behaviour or yet
another bug?

(I hope thunderbird didn't f*ck up the formatting this time)


 daemon.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/daemon.c b/daemon.c
index 13401f1..daa4c8e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -444,27 +444,27 @@ static void parse_extra_args(char *extra_args, int buflen)
 	if (hostname) {
 #ifndef NO_IPV6
 		struct addrinfo hints;
-		struct addrinfo *ai, *ai0;
+		struct addrinfo *ai;
 		int gai;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
-		gai = getaddrinfo(hostname, 0, &hints, &ai0);
+		gai = getaddrinfo(hostname, 0, &hints, &ai);
 		if (!gai) {
-			for (ai = ai0; ai; ai = ai->ai_next) {
-				struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
-
-				inet_ntop(AF_INET, &sin_addr->sin_addr,
-					  addrbuf, sizeof(addrbuf));
-				free(canon_hostname);
-				canon_hostname = xstrdup(ai->ai_canonname);
-				free(ip_address);
-				ip_address = xstrdup(addrbuf);
-				break;
-			}
-			freeaddrinfo(ai0);
+			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
+
+			inet_ntop(AF_INET, &sin_addr->sin_addr,
+				  addrbuf, sizeof(addrbuf));
+			free(ip_address);
+			ip_address = xstrdup(addrbuf);
+
+			free(canon_hostname);
+			canon_hostname = xstrdup(ai->ai_canonname ?
+						 ai->ai_canonname : ip_address);
+
+			freeaddrinfo(ai);
 		}
 #else
 		struct hostent *hent;
-- 
1.6.3.rc3.1.g35108
