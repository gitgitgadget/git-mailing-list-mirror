From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Mon, 3 Apr 2006 12:33:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604031222360.30048@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
 <Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604022116060.3781@g5.osdl.org>
 <Pine.LNX.4.64.0604022124440.10401@alien.or.mcafeemobile.com>
 <7v4q1bglkp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 21:34:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQUoW-0003Nm-Q4
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 21:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWDCTeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 15:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWDCTeH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 15:34:07 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:60332 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751730AbWDCTeG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 15:34:06 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C85D3> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 3 Apr 2006 12:34:02 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q1bglkp.fsf@assigned-by-dhcp.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18347>

On Mon, 3 Apr 2006, Junio C Hamano wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
>
>> No problem. That's only an eye-issue though, since the diff is still a
>> valid diff according to its definition where D=A-B => B+D==A && A-D==B
>> From the day I released 0.18, xregression is continuosly running w/out
>> any issue. I'll check it out though ...
>
> There is another to report, when ctxlen == 0.
>
> Between the attached files "diff -u0 8f352aa dd40a03", the
> header for a hunk with only inserted lines misidentify the
> original location.
>
> For example, the first hunk says:
>
> 	@@ -0,0 +6 @@
>        +#include "diff.h"
>
> Which is inconsistent with what GNU diff says:
>
> 	@@ -5,0 +6 @@
>        +#include "diff.h"
>
> I've tried this patch but it is not right; the diff between the
> attached two files show a 47-line hunk that inserts at line 400,
> then the next 6-line hunk inserts at line 401 which is obviously
> bogus.
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index afaada1..3e7f999 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -244,7 +244,7 @@ int xdl_emit_hunk_hdr(long s1, long c1,
> 	memcpy(buf, "@@ -", 4);
> 	nb += 4;
>
> -	nb += xdl_num_out(buf + nb, c1 ? s1: 0);
> +	nb += xdl_num_out(buf + nb, c1 ? s1 : (s1-1));
>
> 	if (c1 != 1) {
> 		memcpy(buf + nb, ",", 1);

The fix is fine, but you should do the same even in the s2 case. The 
correct hunk should have been:

@@ -6,0 +6 @@

because the lines are actually inserted at the 6th position, but patch 
handle its own special 0 count case by adding 1 to the position, so I had 
to change even the xpatchi.c code. The 0-context diffs are pretty 
dangerous though, since in case of purely added hunks, patch has no way to 
verify the orig-file position by matching contexts.
Now I'll take a look at the pre-diff optimization issue ...



- Davide



--- xdiff/xpatchi.c
+++ xdiff/xpatchi.c
@@ -162,9 +162,9 @@
  	 * We start from zero, so decrement by one unless it's the special position
  	 * '0' inside the unified diff (new or deleted file).
  	 */
-	if (hki->s1 > 0)
+	if (hki->s1 > 0 && hki->c1 > 0)
  		hki->s1--;
-	if (hki->s2 > 0)
+	if (hki->s2 > 0 && hki->c2 > 0)
  		hki->s2--;

  	return 0;


--- xdiff/xutils.c
+++ xdiff/xutils.c
@@ -537,7 +537,7 @@
  	memcpy(buf, "@@ -", 4);
  	nb += 4;

-	nb += xdl_num_out(buf + nb, c1 ? s1: 0);
+	nb += xdl_num_out(buf + nb, c1 ? s1: s1 - 1);

  	memcpy(buf + nb, ",", 1);
  	nb += 1;
@@ -547,7 +547,7 @@
  	memcpy(buf + nb, " +", 2);
  	nb += 2;

-	nb += xdl_num_out(buf + nb, c2 ? s2: 0);
+	nb += xdl_num_out(buf + nb, c2 ? s2: s2 - 1);

  	memcpy(buf + nb, ",", 1);
  	nb += 1;
