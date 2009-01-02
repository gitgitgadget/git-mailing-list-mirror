From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 22:59:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901022157260.27818@racer>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost>
 <20090102105856.GB14691@localhost> <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIs46-0007wu-NK
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773AbZABV7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758226AbZABV7E
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:59:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:54256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751813AbZABV7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:59:01 -0500
Received: (qmail invoked by alias); 02 Jan 2009 21:58:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 02 Jan 2009 22:58:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZodpN6Z3ZXWVfOW9wZ/rHd6RpWe5RQlFen0TDAn
	UdGwsI6+CTzYgZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104422>

Hi,

On Fri, 2 Jan 2009, Linus Torvalds wrote:

> So I was hoping for something else than a single "in this case patience 
> diff works really well". I was hoping to see what it does in real life. 

Funnily, I think the test case you sent me is a pretty good example.  Look 
at this hunk (without patience diff):

@@ -4205,25 +4205,25 @@ out:
  */
 static int nfs4_xdr_dec_setattr(struct rpc_rqst *rqstp, __be32 *p, struct nfs_se
 {
-        struct xdr_stream xdr;
-        struct compound_hdr hdr;
-        int status;
-
-        xdr_init_decode(&xdr, &rqstp->rq_rcv_buf, p);
-        status = decode_compound_hdr(&xdr, &hdr);
-        if (status)
-                goto out;
-        status = decode_putfh(&xdr);
-        if (status)
-                goto out;
-        status = decode_setattr(&xdr, res);
-        if (status)
-                goto out;
+       struct xdr_stream xdr;
+       struct compound_hdr hdr;
+       int status;
+
+       xdr_init_decode(&xdr, &rqstp->rq_rcv_buf, p);

... and then it goes on with the whole reindented function.  Compare this 
to the same hunk _with_ patience diff:

@@ -4205,25 +4205,25 @@ out:
  */
 static int nfs4_xdr_dec_setattr(struct rpc_rqst *rqstp, __be32 *p, struct nfs_se
 {
-        struct xdr_stream xdr;
-        struct compound_hdr hdr;
-        int status;
+       struct xdr_stream xdr;
+       struct compound_hdr hdr;
+       int status;

-        xdr_init_decode(&xdr, &rqstp->rq_rcv_buf, p);
-        status = decode_compound_hdr(&xdr, &hdr);
-        if (status)
-                goto out;
-        status = decode_putfh(&xdr);
-        if (status)
-                goto out;
-        status = decode_setattr(&xdr, res);
-        if (status)
-                goto out;
+       xdr_init_decode(&xdr, &rqstp->rq_rcv_buf, p);
+       status = decode_compound_hdr(&xdr, &hdr);

... and again the rest is reindented code.

The difference?  The common empty line.  I actually find it more readable 
to have the separation between the declarations and the code also in the 
diff.

This is just a very feeble example, but you get the idea from there.

Oh, you might object that the empty line is not unique.  But actually it 
is, because the patience diff recurses into ever smaller line ranges until 
it finally comes to such a small range that the empty line _is_ unique.

And in my analysis of the complexity, I stupidly left out that recursion 
part.  So: patience diff is _substantially_ more expensive than Myers'.

> But when I tried it on the kernel archive, I get a core dump.

I also got this trying on the git.git repository, with commit 
be3cfa85([PATCH] Diff-tree-helper take two.)  Funnily, I almost got there 
trying the same before sending the first revision, but I got impatient and 
stopped early.  Tsk, tsk.

Now I tried with my complete clone of git.git together with all of my 
topic branches, and it runs through without segmentation fault.  Patch 
follows.

Ciao,
Dscho
