From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fmt-merge-message problem..
Date: Wed, 12 Jul 2006 22:21:05 -0700
Message-ID: <7vhd1mw05a.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607122133250.5623@g5.osdl.org>
	<7vlkqyw0om.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 13 07:21:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0tdR-0008Ff-S7
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 07:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWGMFVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 01:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWGMFVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 01:21:09 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40871 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751303AbWGMFVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 01:21:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713052107.WTKD554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 01:21:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vlkqyw0om.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 12 Jul 2006 22:09:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23814>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> which makes no sense AT ALL. It's doesn't even parse. "Merge commit <repo> 
>> of <branch>"? Whaa? That's just insane.
>>
>> Also, the " * HEAD" is just ugly. It was better before.
>
> Yes, this is a simple mistranslation from Perl to C.  A patch
> will follow shortly.

-- >8 --
[PATCH] fmt-merge-msg fix

The new C version mistranslated the original Perl version in the
case to pull from the HEAD.  This made it to say nonsense like
this:

	Merge commit ...url... of HEAD

        * HEAD:
        ...

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-fmt-merge-msg.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 6527482..fe0ef44 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -76,6 +76,7 @@ static int handle_line(char *line)
 	unsigned char *sha1;
 	char *src, *origin;
 	struct src_data *src_data;
+	int pulling_head = 0;
 
 	if (len < 43 || line[40] != '\t')
 		return 1;
@@ -101,8 +102,11 @@ static int handle_line(char *line)
 	if (src) {
 		*src = 0;
 		src += 4;
-	} else
-		src = "HEAD";
+		pulling_head = 0;
+	} else {
+		src = line;
+		pulling_head = 1;
+	}
 
 	i = find_in_list(&srcs, src);
 	if (i < 0) {
@@ -112,7 +116,10 @@ static int handle_line(char *line)
 	}
 	src_data = srcs.payload[i];
 
-	if (!strncmp(line, "branch ", 7)) {
+	if (pulling_head) {
+		origin = strdup(src);
+		src_data->head_status |= 1;
+	} else if (!strncmp(line, "branch ", 7)) {
 		origin = strdup(line + 7);
 		append_to_list(&src_data->branch, origin, NULL);
 		src_data->head_status |= 2;
@@ -124,9 +131,6 @@ static int handle_line(char *line)
 		origin = strdup(line + 14);
 		append_to_list(&src_data->r_branch, origin, NULL);
 		src_data->head_status |= 2;
-	} else if (!strcmp(line, "HEAD")) {
-		origin = strdup(src);
-		src_data->head_status |= 1;
 	} else {
 		origin = strdup(src);
 		append_to_list(&src_data->generic, strdup(line), NULL);
