From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: absurdly slow git-diff
Date: Fri, 7 Nov 2008 15:48:34 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com>
References: <20081107200126.GA20284@toroid.org> <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org> <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com> <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:49:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyb5L-0006yb-DQ
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbYKGXsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbYKGXsh
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:48:37 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:32806 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYKGXsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 18:48:36 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2B7C59> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Fri, 7 Nov 2008 18:48:34 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100365>

On Fri, 7 Nov 2008, Linus Torvalds wrote:

> 
> 
> On Fri, 7 Nov 2008, Davide Libenzi wrote:
> > 
> > With +/- 100 lines (200 lines window):
> > 
> > davide@alien:~$ time ./xdiff_test --diff 1 2 > /dev/null 
> > 
> > real    0m1.534s
> > user    0m1.466s
> > sys     0m0.040s
> 
> I assume the patch is something like the appended?
> 
> 		Linus
> 
> ---
>  xdiff/xprepare.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index e87ab57..4bebd76 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -318,7 +318,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
>  	 * Note that we always call this function with dis[i] > 1, so the
>  	 * current line (i) is already a multimatch line.
>  	 */
> -	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
> +	for (r = 1, rdis0 = 0, rpdis0 = 1; r < 100 && (i - r) >= s; r++) {
>  		if (!dis[i - r])
>  			rdis0++;
>  		else if (dis[i - r] == 2)
> @@ -334,7 +334,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
>  	 */
>  	if (rdis0 == 0)
>  		return 0;
> -	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
> +	for (r = 1, rdis1 = 0, rpdis1 = 1; r < 100 && (i + r) <= e; r++) {
>  		if (!dis[i + r])
>  			rdis1++;
>  		else if (dis[i + r] == 2)
> 

Yeah, similar. Mine is below. There's one less branch in the for loops.



- Davide


diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index deba25a..3ebd87c 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -23,10 +23,9 @@
 #include "xinclude.h"
 
 
-
 #define XDL_KPDIS_RUN 4
 #define XDL_MAX_EQLIMIT 1024
-
+#define XDL_SIMSCAN_WINDOWN 100
 
 
 typedef struct s_xdlclass {
@@ -246,6 +245,18 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	long r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
+	 * Limits the window the is examined during the similar-lines
+	 * scan. The loops below stops when dis[i - r] == 1 (line that
+	 * has no match), but there are corner cases where the loop
+	 * proceed all the way to the extremities by causing huge
+	 * performance penalties in case of big files.
+	 */
+	if (i - s > XDL_SIMSCAN_WINDOWN)
+		s = i - XDL_SIMSCAN_WINDOWN;
+	if (e - i > XDL_SIMSCAN_WINDOWN)
+		e = i + XDL_SIMSCAN_WINDOWN;
+
+	/*
 	 * Scans the lines before 'i' to find a run of lines that either
 	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
 	 * Note that we always call this function with dis[i] > 1, so the
