From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at end of file
Date: Sat, 19 May 2007 13:39:59 -0700
Message-ID: <7vhcq8v97k.fsf@assigned-by-dhcp.cox.net>
References: <464EF7D2.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 22:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpVih-00064u-Gk
	for gcvg-git@gmane.org; Sat, 19 May 2007 22:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710AbXESUkB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 16:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760076AbXESUkB
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 16:40:01 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42953 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759710AbXESUkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 16:40:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519204000.XVSB22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 16:40:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 18fz1X00B1kojtg0000000; Sat, 19 May 2007 16:39:59 -0400
In-Reply-To: <464EF7D2.4030406@gmail.com> (Marco Costalba's message of "Sat,
	19 May 2007 15:12:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47774>

Marco Costalba <mcostalba@gmail.com> writes:

> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>   builtin-apply.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 0399743..f17f838 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1738,6 +1738,10 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
>   		newsize--;
>   	}
>
> +	if (new_whitespace == strip_whitespace)
> +		while (newsize > 1 && !strncmp(new + newsize - 2, "\n\n", 2))
> +			newsize--;
> +
>   	oldlines = old;
>   	newlines = new;
>   	leading = frag->leading;

I agree to what you are trying to do, but this patch is wrong.
You are stripping trailing newlines that were NOT introduced by
the patch, but happened to be present in the preimage (and in
the context).

Try it on this test vector:

cat >AAA <<\EOF
a
b
c
d


e
f
g
h
i


j
k


EOF
cat >P.diff <<\EOF
diff --git a/AAA b/AAA
index 59f6a9c..ffb28f5 100644
--- a/AAA
+++ b/AAA
@@ -1,4 +1,4 @@
-a
+A
 b
 c
 d
@@ -6,12 +6,11 @@ d
 
 e
 f
+
+
 g
 h
-i
-
 
-j
 k
 
 
EOF
