From: Yuri <yuri@rawbw.com>
Subject: Re: git quietly fails on https:// URL, https errors are never reported
 to user
Date: Fri, 17 Jan 2014 01:40:54 -0800
Message-ID: <52D8FAA6.1010601@rawbw.com>
References: <52D7D017.107@rawbw.com> <20140116180310.GA27180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 10:41:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W45vG-0001dj-9N
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbaAQJlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 04:41:01 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:52854 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbaAQJk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:40:59 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0H9eskd043291;
	Fri, 17 Jan 2014 01:40:54 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140116180310.GA27180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240580>

On 01/16/2014 10:03, Jeff King wrote:
> We used to print "Reading from helper 'git-remote-https' failed" in this
> instance. But in the majority of cases, remote-https has printed a
> useful message already to stderr, and the extra line just confused
> people. The downside, as you noticed, is that when the helper dies
> without printing an error, the user is left with no message.

I would like to suggest to return this printout, see patch below. This 
would be a revert of this commit:
commit 266f1fdfa99f5d29ca7ce455966e7960c00a82e4
Author: Jeff King <peff@peff.net>
Date:   Fri Jun 21 03:05:39 2013 -0400

I think that in a rare case of error this extra-printout wouldn't hurt. 
I also made this message more user friendly, without mentioning the term 
"helper".

Yuri

diff --git a/transport-helper.c b/transport-helper.c
index 2010674..5ea2831 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -58,7 +58,7 @@ static int recvline_fh(FILE *helper, struct strbuf 
*buffer, const char *name)
         if (strbuf_getline(buffer, helper, '\n') == EOF) {
                 if (debug)
                         fprintf(stderr, "Debug: Remote helper quit.\n");
-               exit(128);
+               die("Failure in '%s' protocol reader", name);
         }

         if (debug)
