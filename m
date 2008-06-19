From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --cc bug
Date: Wed, 18 Jun 2008 23:54:49 -0700
Message-ID: <7vhcbpx6bq.fsf@gitster.siamese.dyndns.org>
References: <48510CFA.3060101@viscovery.net> <48565311.9070407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 08:56:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9E46-0000w1-2v
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 08:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYFSGzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 02:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbYFSGzJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 02:55:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYFSGzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 02:55:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF00E184D5;
	Thu, 19 Jun 2008 02:55:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 39972184D3; Thu, 19 Jun 2008 02:55:00 -0400 (EDT)
In-Reply-To: <48565311.9070407@viscovery.net> (Johannes Sixt's message of
 "Mon, 16 Jun 2008 13:48:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5E7CDF2-3DCC-11DD-8AF7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85450>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Sixt schrieb:
>> @@@ -635,31 -865,171 +641,169 @@@ void CValuesView::EraseVa...
>>  -LRESULT CValuesView::OnOptionsChanged(WPARAM, LPARAM)
>>  -{
>>  -	if (GetDocument()->ShowPointerValues()) {
>>  -		// invalidate values in the display
>>  -		CPoint pt(m_x, m_y);	// will be erased
>>  -		InvalidateValues();
>>  -		FindFmtStrings();
>>  -		Update(pt.x, pt.y);
>>  -	}
>>  -	return 0;
>>  -}
>>  -
>>   void CValuesView::OnUpdate(CView* pSender, LPARAM lHint, ...
>>   {
>>   	switch (lHint) {
>> ++<<<<<<< HEAD:SomUI/ValuesWnd.cpp
>> ++=======
>> + 	case UPDATE_MONITORFRAME:
>> + 		{
>> (hunk truncated for exposition)
>> 
>> Notice that there are no context lines at the beginning of the second
>> hunk. I would not have expected this, and I think it's a bug in git diff.

Interesting.  There indeed is a bug, but it is not a bug that "-LRESULT"
is not preceded by three more context lines.  The bug is that these
deletion are shown when "void CValuesView::" line is shown.

The diff combining logic discards hunks that take the result solely from
a single parent.  So in the above example (and your smaller example in the
tarball), the initial segment that begins with "-LRESULT" is not
interesting at all and should never be shown.

The computation first finds "interesting" parts (done by make_hunks()),
and then the first interesting line it finds actually is "++<<<<<<".

Then it gives a bit of context going back from that line (done by
give_context()).  It goes back by the default 3 lines and stops at the
line "void CValuesView::".  Then the output routine start emitting from
that line.

The problem is that the internal data structure hooks the deleted lines in
front of the surviving line that follows it.  That means that showing the
sline[] that holds "void CValuesView::" will show the unwanted "-LRESULT"
deletion part as part of it.

You can view this in action by running "git diff -U2" in your tarball
repository.  By reducing the context to 2, the leading edge context now
begins at the opening brace after "void CValuesView::" line, which does
not have deletion lines in front of it, so you will see what you expect.

This patch would fix it for the sample repository, but I am not sure if it
has unintended side effects.

 combine-diff.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 588c58b..9f80a1c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -84,6 +84,7 @@ struct sline {
 	/* bit 0 up to (N-1) are on if the parent has this line (i.e.
 	 * we did not change it).
 	 * bit N is used for "interesting" lines, including context.
+	 * bit (N+1) is used for "do not show deletion before this".
 	 */
 	unsigned long flag;
 	unsigned long *p_lno;
@@ -308,6 +309,7 @@ static int give_context(struct sline *sline, unsigned long cnt, int num_parent)
 {
 	unsigned long all_mask = (1UL<<num_parent) - 1;
 	unsigned long mark = (1UL<<num_parent);
+	unsigned long no_pre_delete = (2UL<<num_parent);
 	unsigned long i;
 
 	/* Two groups of interesting lines may have a short gap of
@@ -329,7 +331,7 @@ static int give_context(struct sline *sline, unsigned long cnt, int num_parent)
 
 		/* Paint a few lines before the first interesting line. */
 		while (j < i)
-			sline[j++].flag |= mark;
+			sline[j++].flag |= mark | no_pre_delete;
 
 	again:
 		/* we know up to i is to be included.  where does the
@@ -502,6 +504,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 		       int use_color)
 {
 	unsigned long mark = (1UL<<num_parent);
+	unsigned long no_pre_delete = (2UL<<num_parent);
 	int i;
 	unsigned long lno = 0;
 	const char *c_frag = diff_get_color(use_color, DIFF_FRAGINFO);
@@ -581,7 +584,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 			int j;
 			unsigned long p_mask;
 			sl = &sline[lno++];
-			ll = sl->lost_head;
+			ll = (sl->flag & no_pre_delete) ? NULL : sl->lost_head;
 			while (ll) {
 				fputs(c_old, stdout);
 				for (j = 0; j < num_parent; j++) {
