From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at end of file
Date: Sat, 19 May 2007 16:03:38 -0700
Message-ID: <7vsl9stnzp.fsf@assigned-by-dhcp.cox.net>
References: <464EF7D2.4030406@gmail.com>
	<7vhcq8v97k.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705191458o3fa1d1a0ndd916d1efafdd2a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 01:03:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpXxj-00045l-8P
	for gcvg-git@gmane.org; Sun, 20 May 2007 01:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758596AbXESXDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 19:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758611AbXESXDk
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 19:03:40 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38033 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758596AbXESXDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 19:03:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519230339.PMIP13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 19:03:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1B3e1X00F1kojtg0000000; Sat, 19 May 2007 19:03:38 -0400
In-Reply-To: <e5bfff550705191458o3fa1d1a0ndd916d1efafdd2a7@mail.gmail.com>
	(Marco Costalba's message of "Sat, 19 May 2007 23:58:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47779>

"Marco Costalba" <mcostalba@gmail.com> writes:

> What about this?
>
> builtin-apply.c |   13 +++++++++----
> 1 files changed, 9 insertions(+), 4 deletions(-)

You count the trailing blank lines in new and old, and if new
one has more you strip them out, which _sounds_ sane.

But it is unclear to me how you are limiting the processing to
the very end of the file.  The "new" and "old" essentially is a
patch fragment that is separated into two, and the part you
modified with your patch does not know if the hunk applies at
the end of the patch yet.

That is, given this patch:

diff --git a/builtin-apply.c b/builtin-apply.c
index 9e82757..113c71f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1746,10 +1746,15 @@ static int apply_one_fragment(struct buffer_desc *des..
                newsize--;
        }

-       if (new_whitespace == strip_whitespace)
-               while (newsize > 1 && !strncmp(new + newsize - 2, "\n\n", 2))
-                       newsize--;
-
+       if (new_whitespace == strip_whitespace) {
+               int cnt1 =  1, cnt2 = 1;
+               while (newsize -  cnt1 > 1 && new[newsize - cnt1] == '\n')
+                       cnt1++;
+               while (oldsize -  cnt2 > 1 && new[newsize - cnt2] == '\n')
+                       cnt2++;
+               if (cnt1 > cnt2 && cnt1 > 2)
+                       newsize -= cnt1 - cnt2;
+       }
        oldlines = old;
        newlines = new;
        leading = frag->leading;

"new" has these lines

                newsize--;
        }

        if (new_whitespace == strip_whitespace) {
                int cnt1 =  1, cnt2 = 1;
                while (newsize -  cnt1 > 1 && new[newsize - cnt1] == '\n')
                        cnt1++;
                while (oldsize -  cnt2 > 1 && new[newsize - cnt2] == '\n')
                        cnt2++;
                if (cnt1 > cnt2 && cnt1 > 2)
                        newsize -= cnt1 - cnt2;
        }
        oldlines = old;
        newlines = new;
        leading = frag->leading;

while "old" has this:

                newsize--;
        }

        if (new_whitespace == strip_whitespace)
                while (newsize > 1 && !strncmp(new + newsize - 2, "\n\n", 2))
                        newsize--;

        oldlines = old;
        newlines = new;
        leading = frag->leading;

and these may or may not be at the end of the file, so
inspecting what blank lines they have at the end is not
sufficient.  If "new" does not introduce new blank lines at its
end, then you can be sure that you are not adding trailing blank
lines, but even if "new" does introduce a new blank line at the
end, you do not know if that is adding it to the end of the
file, or in the middle.

You do not know where the hunk is applied until you do the loop
that follows the part your patch we are discussing.
