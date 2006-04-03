From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Mon, 3 Apr 2006 16:29:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604031625330.30048@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 01:29:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQYU5-0007gs-Jh
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 01:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWDCX3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 19:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWDCX3T
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 19:29:19 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:65452 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964943AbWDCX3S
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 19:29:18 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C865B> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 3 Apr 2006 16:29:16 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18361>

On Sun, 2 Apr 2006, Junio C Hamano wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
>
>> On Sun, 2 Apr 2006, Junio C Hamano wrote:
>>
>>> $ git diff-tree -p 52e8a6^2 52d8a6 -- git-fetch.sh
>>>
>>> shows a change that trivially is redundant, like this:
>>>
>>>    diff --git a/git-fetch.sh b/git-fetch.sh
>>>    index b4325d9..de4f011 100755
>>>    --- a/git-fetch.sh
>>>    +++ b/git-fetch.sh
>>>    @@ -320,7 +320,7 @@ fetch_main () {
>>> ..
>>> Notice the first '-' and '+' lines of second hunk are identical?
>>>
>>> There is another interesting thing.  This is running diff
>>> between 52e8a6^2 and 52d8a6 blobs, but if I change them slightly
>>> so that the first hunk is not different, then this anomaly
>>> disappears.
>>
>> Could you send me the two files that creates the above diff?
>
> I should have tried your pristine xdiff code myself before
> bothering you, but I haven't (sorry).
>
> The problem is from the "stripped down" version we use in git,
> so you may or may not see the problem in your version.  Attached
> are the files.

This is the change I made to libxdiff. Xregression already made a few 
thousands on iterations w/out problems.



- Davide



--- xdiff/xdiffi.c
+++ xdiff/xdiffi.c
@@ -349,12 +349,7 @@
  	kvdf += xe->xdf2.nreff + 1;
  	kvdb += xe->xdf2.nreff + 1;

-	/*
-	 * Classical integer square root approximation using shifts.
-	 */
-	xenv.mxcost = 1;
-	for (; ndiags; ndiags >>= 2)
-		xenv.mxcost <<= 1;
+	xenv.mxcost = xdl_bogosqrt(ndiags);
  	if (xenv.mxcost < XDL_MAX_COST_MIN)
  		xenv.mxcost = XDL_MAX_COST_MIN;
  	xenv.snake_cnt = XDL_SNAKE_CNT;


--- xdiff/xprepare.c
+++ xdiff/xprepare.c
@@ -25,6 +25,7 @@


  #define XDL_KPDIS_RUN 4
+#define XDL_MAX_EQLIMIT 1024



@@ -305,26 +306,48 @@


  static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
-	long r, rdis, rpdis;
+	long r, rdis0, rpdis0, rdis1, rpdis1;

-	for (r = 1, rdis = 0, rpdis = 1; (i - r) >= s; r++) {
+	/*
+	 * Scans the lines before 'i' to find a run of lines that either
+	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
+	 * Note that we always call this function with dis[i] > 1, so the
+	 * current line (i) is already a multimatch line.
+	 */
+	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
  		if (!dis[i - r])
-			rdis++;
+			rdis0++;
  		else if (dis[i - r] == 2)
-			rpdis++;
+			rpdis0++;
  		else
  			break;
  	}
-	for (r = 1; (i + r) <= e; r++) {
+	/*
+	 * If the run before the line 'i' found only multimatch lines, we
+	 * return 0 and hence we don't make the current line (i) discarded.
+	 * We want to discard multimatch lines only when they appear in the
+	 * middle of runs with nomatch lines (dis[j] == 0).
+	 */
+	if (rdis0 == 0)
+		return 0;
+	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
  		if (!dis[i + r])
-			rdis++;
+			rdis1++;
  		else if (dis[i + r] == 2)
-			rpdis++;
+			rpdis1++;
  		else
  			break;
  	}
+	/*
+	 * If the run after the line 'i' found only multimatch lines, we
+	 * return 0 and hence we don't make the current line (i) discarded.
+	 */
+	if (rdis1 == 0)
+		return 0;
+	rdis1 += rdis0;
+	rpdis1 += rpdis0;

-	return rpdis * XDL_KPDIS_RUN < (rpdis + rdis);
+	return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
  }


@@ -334,34 +357,40 @@
   * might be potentially discarded if they happear in a run of discardable.
   */
  static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, rhi, nreff;
+	long i, nm, rhi, nreff, mlim;
  	unsigned long hav;
  	xrecord_t **recs;
  	xrecord_t *rec;
  	char *dis, *dis1, *dis2;

-	if (!(dis = (char *) xdl_malloc((xdf1->nrec + xdf2->nrec + 2) * sizeof(char)))) {
+	if (!(dis = (char *) xdl_malloc(xdf1->nrec + xdf2->nrec + 2))) {

  		return -1;
  	}
-	memset(dis, 0, (xdf1->nrec + xdf2->nrec + 2) * sizeof(char));
+	memset(dis, 0, xdf1->nrec + xdf2->nrec + 2);
  	dis1 = dis;
  	dis2 = dis1 + xdf1->nrec + 1;

+	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
+		mlim = XDL_MAX_EQLIMIT;
  	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
  		hav = (*recs)->ha;
  		rhi = (long) XDL_HASHLONG(hav, xdf2->hbits);
-		for (rec = xdf2->rhash[rhi]; rec; rec = rec->next)
-			if (rec->ha == hav && ++dis1[i] == 2)
+		for (nm = 0, rec = xdf2->rhash[rhi]; rec; rec = rec->next)
+			if (rec->ha == hav && ++nm == mlim)
  				break;
+		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
  	}

+	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
+		mlim = XDL_MAX_EQLIMIT;
  	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
  		hav = (*recs)->ha;
  		rhi = (long) XDL_HASHLONG(hav, xdf1->hbits);
-		for (rec = xdf1->rhash[rhi]; rec; rec = rec->next)
-			if (rec->ha == hav && ++dis2[i] == 2)
+		for (nm = 0, rec = xdf1->rhash[rhi]; rec; rec = rec->next)
+			if (rec->ha == hav && ++nm == mlim)
  				break;
+		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
  	}

  	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];


--- xdiff/xutils.c
+++ xdiff/xutils.c
@@ -29,6 +29,19 @@



+long xdl_bogosqrt(long n) {
+	long i;
+
+	/*
+	 * Classical integer square root approximation using shifts.
+	 */
+	for (i = 1; n > 0; n >>= 2)
+		i <<= 1;
+
+	return i;
+}
+
+
  int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
  		     xdemitcb_t *ecb) {
  	int i = 2;


--- xdiff/xutils.h
+++ xdiff/xutils.h
@@ -25,6 +25,7 @@



+long xdl_bogosqrt(long n);
  int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
  		     xdemitcb_t *ecb);
  int xdl_mmfile_outf(void *priv, mmbuffer_t *mb, int nbuf);
