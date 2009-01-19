From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs
 twice
Date: Mon, 19 Jan 2009 13:33:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de> <7vprijra52.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 13:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOtLF-0004JN-Kf
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 13:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758981AbZASMde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 07:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758822AbZASMdd
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 07:33:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:46276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754552AbZASMdc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 07:33:32 -0500
Received: (qmail invoked by alias); 19 Jan 2009 12:33:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 19 Jan 2009 13:33:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SQjEcQaGSTvgpbVGJcDp5LS+xZKyhg+A5Henr/n
	PCH6c0D60rEGjG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106351>

Hi,

On Mon, 19 Jan 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Well, I would rather be in favor of something like this.
> >
> > -- >8 --
> > Subject: interpret_nth_last_branch(): avoid traversing the reflog twice
> >
> > You can have quite a many reflog entries, but you typically won't recall
> > which branch you were on after switching branches for more than several
> > times.
> >
> > Instead of reading the reflog twice, this reads the branch switching event
> > and keeps the latest 16 (which is an arbitrary limitation that should be
> > plenty) such entry, to switch back to the branch we were recently on.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  sha1_name.c              |   48 +++++++++++++++++++++------------------------
> >  t/t2012-checkout-last.sh |   44 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 66 insertions(+), 26 deletions(-)
> >
> > diff --git a/sha1_name.c b/sha1_name.c
> > index 9e1538e..d6622f2 100644
> > --- a/sha1_name.c
> > +++ b/sha1_name.c
> > @@ -750,19 +746,19 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
> >  	nth = strtol(name+3, &num_end, 10);
> >  	if (num_end != brace)
> >  		return -1;
> > ...
> > -	if (cb.nth < nth)
> > -		return 0;
> > ...
> > +	if (cb.cnt < nth)
> > +		return -1;
> 
> This should (obviously) be "return 0".

This, together with a removal of the hard-coded limit of 16 could be 
squashed with this patch:

-- snipsnap --
diff --git a/sha1_name.c b/sha1_name.c
index 2c5461e..9e5f444 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -691,11 +691,9 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	return retval;
 }
 
-#define MAX_PREVIOUS_BRANCH 16
-
 struct grab_nth_branch_switch_cbdata {
-	long cnt;
-	struct strbuf buf[MAX_PREVIOUS_BRANCH];
+	long cnt, alloc;
+	struct strbuf *buf;
 };
 
 static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
@@ -720,7 +718,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	if (target[len] == '\n' && !strncmp(match, target, len))
 		return 0;
 
-	nth = cb->cnt++ % MAX_PREVIOUS_BRANCH;
+	nth = cb->cnt++ % cb->alloc;
 	strbuf_reset(&cb->buf[nth]);
 	strbuf_add(&cb->buf[nth], match, len);
 	return 0;
@@ -753,19 +751,22 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 	nth = strtol(name+3, &num_end, 10);
 	if (num_end != brace)
 		return -1;
-	if (nth <= 0 || MAX_PREVIOUS_BRANCH < nth)
+	if (nth <= 0)
 		return -1;
-	for (i = 0; i < MAX_PREVIOUS_BRANCH; i++)
+	cb.alloc = nth;
+	cb.buf = xmalloc(nth * sizeof(struct strbuf));
+	for (i = 0; i < nth; i++)
 		strbuf_init(&cb.buf[i], 20);
 	cb.cnt = 0;
 	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
 	if (cb.cnt < nth)
-		return -1;
-	i = (cb.cnt + MAX_PREVIOUS_BRANCH - nth) % MAX_PREVIOUS_BRANCH;
+		return 0;
+	i = cb.cnt % nth;
 	strbuf_reset(buf);
 	strbuf_add(buf, cb.buf[i].buf, cb.buf[i].len);
-	for (i = 0; i < MAX_PREVIOUS_BRANCH; i++)
+	for (i = 0; i < nth; i++)
 		strbuf_release(&cb.buf[i]);
+	free(cb.buf);
 
 	return brace-name+1;
 }
-- 
1.6.1.347.g7b62749
