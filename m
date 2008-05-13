From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH v2] revision.c: really honor --first-parent
Date: Tue, 13 May 2008 22:15:22 +0200
Message-ID: <20080513201522.GA11485@cuci.nl>
References: <1210547651-32510-1-git-send-email-hjemli@gmail.com> <1210605156-22926-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:17:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw0vw-00019F-Es
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 22:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbYEMUP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761002AbYEMUP0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 16:15:26 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47624 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762166AbYEMUPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 16:15:23 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 632A15461; Tue, 13 May 2008 22:15:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1210605156-22926-1-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82040>

Lars Hjemli wrote:
>In add_parents_to_list, if any parent of a revision had already been
>SEEN, the current code would continue with the next parent, skipping
>the test for --first-parent. This patch inverts the test for SEEN so
>that the test for --first-parent is always performed.

Let's put it this way:
- If there would have been only one path to any particular point in the
  tree, then the --first-parent flag makes no differences, because the
  tree wouldn't contain any merges to begin with.
- If a tree contains *any* merges (i.e. a commit with multiple parents),
  then there are always multiple paths to some common ancestor, and
  therefore depending on which path you travel up first, you sometimes get
  clashes with the SEEN flag (unpredictable by definition).
- It would seem logical and sufficient to avoid this unpredictability by
  utilising the --first-parent flag to present and walk a tree of commits
  AS IF there were no merges.
- My original patch did just that, it simplified the code to make sure
  that all other parents beside the first parent are ignored when
  walking the tree.
- Your code now doesn't simplify the (IMO) convoluted walk, and still
  marks things as seen, even though in the first-parent case, these
  commits are not really seen at all.  It implies that your code
  generates differing output, depending on the merges present.
- The question now is, do we want the output of --first-parent to be
  immutable with respect to merges being present (but hidden from sight
  during a --first-parent run), or do we want the output of
  --first-parent to actually change depending on variations in parents
  other than the first parent?

I'd say it's better to keep the code simpler, and to make sure the
output does *not* depend on any parents other than the first (as
implemented in my original patch).

>This is a slightly different approach which I think is less ugly.

Your patch is smaller, and therefore (perhaps) less ugly; the resulting
code and logic of my original patch is simpler (IMHO), and therefore
cleaner (but it all depends on (the lack of) consensus over the points above).
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.

"If I had to live my life again, I'd make the same mistakes, only sooner."
