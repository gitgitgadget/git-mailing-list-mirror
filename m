From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Sat, 8 Sep 2012 19:57:33 +0200
Message-ID: <k2g0up$28h$1@ger.gmane.org>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de> <1347124173-14460-2-git-send-email-jengelh@inai.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 19:58:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAPIF-0008O2-OB
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 19:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab2IHR57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 13:57:59 -0400
Received: from plane.gmane.org ([80.91.229.3]:58793 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119Ab2IHR56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 13:57:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TAPI6-0008F2-VN
	for git@vger.kernel.org; Sat, 08 Sep 2012 19:57:58 +0200
Received: from dsdf-4db5dae6.pool.mediaways.net ([77.181.218.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2012 19:57:58 +0200
Received: from jojo by dsdf-4db5dae6.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2012 19:57:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db5dae6.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205022>

Jan Engelhardt wrote:
> This reverts f9c87be6b42dd0f8b31a4bb8c6a44326879fdd1a, in a sense,
> because that commit broke logging of "Connection from ..." when
> git-daemon is run under xinetd.
> 
> This patch here computes the text representation of the peer and then
> copies that to environment variables such that the code in execute()
> and subfunctions can stay as-is.
> 
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
> daemon.c |   55
> +++++++++++++++++++++++++++++++++++++++++++++++++++---- 1 file
> changed, 51 insertions(+), 4 deletions(-) 
> 
> diff --git a/daemon.c b/daemon.c
> index 4602b46..eaf08c2 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1,3 +1,4 @@
> +#include <stdbool.h>
> #include "cache.h"
> #include "pkt-line.h"
> #include "exec_cmd.h"
> @@ -1164,6 +1165,54 @@ static int serve(struct string_list
>  *listen_addr, int listen_port, return service_loop(&socklist);
> }
> 
> +static void inetd_mode_prepare(void)
> +{
> + struct sockaddr_storage ss;
> + struct sockaddr *addr = (void *)&ss;
> + socklen_t slen = sizeof(ss);
> + char addrbuf[256], portbuf[6] = "";
> +
> + if (!freopen("/dev/null", "w", stderr))
> + die_errno("failed to redirect stderr to /dev/null");
> +
> + /*
> + * Windows is said to not be able to handle this, so we will simply
> + * ignore failure here. (It only affects a log message anyway.)
> + */
> + if (getpeername(0, addr, &slen) < 0)
> + return;
> +
> + if (addr->sa_family == AF_INET) {
> + const struct sockaddr_in *sin_addr = (void *)addr;
> +
> + if (inet_ntop(addr->sa_family, &sin_addr->sin_addr,
> +       addrbuf, sizeof(addrbuf)) == NULL)
> + return;
> + snprintf(portbuf, sizeof(portbuf), "%hu",
> + ntohs(sin_addr->sin_port));
> +#ifndef NO_IPV6
> + } else if (addr->sa_family == AF_INET6) {
> + const struct sockaddr_in6 *sin6_addr = (void *)addr;
> +
> + addrbuf[0] = '[';
> + addrbuf[1] = '\0';
> + if (inet_ntop(AF_INET6, &sin6_addr->sin6_addr, addrbuf + 1,
> +       sizeof(addrbuf) - 2) == NULL)
> + return;
> + strcat(addrbuf, "]");
> +
> + snprintf(portbuf, sizeof(portbuf), "%hu",
> + ntohs(sin6_addr->sin6_port));
> +#endif
> + } else {
> + snprintf(addrbuf, sizeof(addrbuf), "<AF %d>",
> + addr->sa_family);
> + }
> + if (setenv("REMOTE_ADDR", addrbuf, true) < 0)
> + return;
> + setenv("REMOTE_PORT", portbuf, true);

setenv() is not a function available on all plattfomrs.

Bye, Jojo
