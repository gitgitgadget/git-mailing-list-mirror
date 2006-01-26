From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 26 Jan 2006 04:12:53 -0800
Message-ID: <7vhd7rfare.fsf@assigned-by-dhcp.cox.net>
References: <7vy814qx6o.fsf@assigned-by-dhcp.cox.net>
	<8aa486160601250634v294857e0j@mail.gmail.com>
	<7vvew7lv4s.fsf@assigned-by-dhcp.cox.net>
	<8aa486160601260104v745594d9m@mail.gmail.com>
	<7vk6cngwfh.fsf@assigned-by-dhcp.cox.net>
	<8aa486160601260156h6157ca34s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 13:13:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F260W-0002kD-KT
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 13:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWAZMM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 07:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAZMM4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 07:12:56 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26069 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751336AbWAZMMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 07:12:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126121258.WQOM25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 07:12:58 -0500
To: Santi Bejar <sbejar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15162>

Santi Bejar <sbejar@gmail.com> writes:

> 2006/1/26, Junio C Hamano <junkio@cox.net>:
>> No comment on your message yet, but please fix your MUA so that
>> your messages do not get rejected by the mailing list software.
>>
>> I suspect it is base64 CTE that causes it.
>>
>>         Content-Type: text/plain; charset=UTF-8
>>         Content-Transfer-Encoding: base64
>
> Sorry, about that. But I didn't get any notification.

You do not need to feel sorry.  It's just your voice is not
heard as widely as it should have been, and you did not know
about it.

The spam filter just drops things on the floor without bothering
to notify potential spammers.

I think this patch would address your two issues (applies on top
of "pu"), but I have not had time to test it seriously enough.

-- >8 --
[PATCH] combine-diff: better hunk splitting.

It considered an otherwise unchanged line that had line removals
in front of it an interesting line, which caused hunks to have
one extra the trailing context line.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 combine-diff.c |  142 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 116 insertions(+), 26 deletions(-)

0aa20bc0c276c3fcb7215ba9f591960178792261
diff --git a/combine-diff.c b/combine-diff.c
index 3b219a0..d94a93d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -323,52 +323,142 @@ static unsigned long line_all_diff(struc
 	return different;
 }
 
-static int make_hunks(struct sline *sline, unsigned long cnt,
-		       int num_parent, int dense)
+static unsigned long adjust_hunk_tail(struct sline *sline,
+				      unsigned long all_mask,
+				      unsigned long hunk_begin,
+				      unsigned long i)
+{
+	/* i points at the first uninteresting line.
+	 * If the last line of the hunk was interesting
+	 * only because it has some deletion, then
+	 * it is not all that interesting for the
+	 * purpose of giving trailing context lines.
+	 */
+	if ((hunk_begin + 1 <= i) &&
+	    ((sline[i-1].flag & all_mask) == all_mask))
+		i--;
+	return i;
+}
+
+static unsigned long next_interesting(struct sline *sline,
+				      unsigned long mark,
+				      unsigned long i,
+				      unsigned long cnt,
+				      int uninteresting)
+{
+	while (i < cnt)
+		if (uninteresting ?
+		    !(sline[i].flag & mark) :
+		    (sline[i].flag & mark))
+			return i;
+		else
+			i++;
+	return cnt;
+}
+
+static int give_context(struct sline *sline, unsigned long cnt, int num_parent)
 {
 	unsigned long all_mask = (1UL<<num_parent) - 1;
 	unsigned long mark = (1UL<<num_parent);
 	unsigned long i;
 	int has_interesting = 0;
 
-	i = 0;
+	i = next_interesting(sline, mark, 0, cnt, 0);
+	if (cnt <= i)
+		return 0;
+
 	while (i < cnt) {
-		if (interesting(&sline[i], all_mask)) {
-			unsigned long j = (context < i) ? i - context : 0;
-			while (j <= i)
+		unsigned long j = (context < i) ? (i - context) : 0;
+		unsigned long k;
+		while (j < i)
+			sline[j++].flag |= mark;
+
+	again:
+		j = next_interesting(sline, mark, i, cnt, 1);
+		if (cnt <= j)
+			break; /* the rest are all interesting */
+
+		/* lookahead context lines */
+		k = next_interesting(sline, mark, j, cnt, 0);
+		j = adjust_hunk_tail(sline, all_mask, i, j);
+
+		if (k < j + context) {
+			/* k is interesting and [j,k) are not, but
+			 * paint them interesting because the gap is small.
+			 */
+			while (j < k)
 				sline[j++].flag |= mark;
-			while (++i < cnt) {
-				if (!interesting(&sline[i], all_mask))
-					break;
-				sline[i].flag |= mark;
-			}
-			j = (i + context < cnt) ? i + context : cnt;
-			while (i < j)
-				sline[i++].flag |= mark;
-			has_interesting = 1;
-			continue;
+			i = k;
+			goto again;
 		}
-		i++;
+
+		/* j is the first uninteresting line and there is
+		 * no overlap beyond it within context lines.
+		 */
+		i = k;
+		k = (j + context < cnt) ? j + context : cnt;
+		while (j < k)
+			sline[j++].flag |= mark;
+	}
+	return 1;
+}
+
+static int make_hunks(struct sline *sline, unsigned long cnt,
+		       int num_parent, int dense)
+{
+	unsigned long all_mask = (1UL<<num_parent) - 1;
+	unsigned long mark = (1UL<<num_parent);
+	unsigned long i;
+	int has_interesting = 0;
+
+	for (i = 0; i < cnt; i++) {
+		if (interesting(&sline[i], all_mask))
+			sline[i].flag |= mark;
+		else
+			sline[i].flag &= ~mark;
 	}
 	if (!dense)
-		return has_interesting;
+		return give_context(sline, cnt, num_parent);
 
 	/* Look at each hunk, and if we have changes from only one
 	 * parent, or the changes are the same from all but one
 	 * parent, mark that uninteresting.
 	 */
-	has_interesting = 0;
 	i = 0;
 	while (i < cnt) {
-		int j, hunk_end, same, diff;
+		unsigned long j, hunk_begin, hunk_end;
+		int same, diff;
 		unsigned long same_diff, all_diff;
 		while (i < cnt && !(sline[i].flag & mark))
 			i++;
 		if (cnt <= i)
 			break; /* No more interesting hunks */
-		for (hunk_end = i + 1; hunk_end < cnt; hunk_end++)
-			if (!(sline[hunk_end].flag & mark))
-				break;
+		hunk_begin = i;
+		for (j = i + 1; j < cnt; j++) {
+			if (!(sline[j].flag & mark)) {
+				/* Look beyond the end to see if there
+				 * is an interesting line after this
+				 * hunk within context span.
+				 */
+				unsigned long la; /* lookahead */
+				int contin = 0;
+				la = adjust_hunk_tail(sline, all_mask,
+						     hunk_begin, j);
+				la = (la + context < cnt) ?
+					(la + context) : cnt;
+				while (j <= --la) {
+					if (sline[la].flag & mark) {
+						contin = 1;
+						break;
+					}
+				}
+				if (!contin)
+					break;
+				j = la;
+			}
+		}
+		hunk_end = j;
+
 		/* [i..hunk_end) are interesting.  Now does it have
 		 * the same change with all but one parent?
 		 */
@@ -387,13 +477,13 @@ static int make_hunks(struct sline *slin
 		}
 		if ((num_parent - 1 <= same) || (diff == 1)) {
 			/* This hunk is not that interesting after all */
-			for (j = i; j < hunk_end; j++)
+			for (j = hunk_begin; j < hunk_end; j++)
 				sline[j].flag &= ~mark;
 		}
-		else
-			has_interesting = 1;
 		i = hunk_end;
 	}
+
+	has_interesting = give_context(sline, cnt, num_parent);
 	return has_interesting;
 }
 
-- 
1.1.4.g2cff
