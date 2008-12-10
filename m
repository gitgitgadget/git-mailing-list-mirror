From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Annotating patches inside diff
Date: Wed, 10 Dec 2008 10:40:42 -0800
Message-ID: <7vfxkv27rp.fsf@gitster.siamese.dyndns.org>
References: <200812101445.48034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:42:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAU1E-0004C6-4S
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 19:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbYLJSku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 13:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbYLJSku
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 13:40:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbYLJSks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 13:40:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B863851B1;
	Wed, 10 Dec 2008 13:40:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 216E8851AD; Wed,
 10 Dec 2008 13:40:43 -0500 (EST)
In-Reply-To: <200812101445.48034.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 10 Dec 2008 14:45:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F470A78-C6EA-11DD-A5D7-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102699>

Jakub Narebski <jnareb@gmail.com> writes:

> I remember that long time ago on git mailing list there was discussed 
> extending git-apply and friends (including git-am), to be able to 
> ignore lines in patches with selected special prefix, different from 
> '@' for chunks headers, ' ' for context, '+'/'-' for added/deleted 
> lines.  IIRC it was chose '|' for this purpose.

That's a blast from the past.

> This way you could annotate patch
>
> @@ -4667,7 +4667,6 @@ HTML
> ...
>
> Was it accepted or dropped, or is this feature present but not 
> documented?

The code is simple, but I do not think it is a good idea to do so:

 * If it is about describing the state (what it does, how it does it and
   why), you should be writing that as in-code comments;

 * If it is about describing the change (what it used to do and how, and
   what it does after your change and how, and why you changed it that
   way), i.e. "we used to do X but now we do Y for such and such reasons"
   (your example is a good one, except in real life you would want to
   state "why" as well), you should be writing that in the commit log
   message; and

 * If describing the change in the commit log message feels insufficient,
   it probably is a sign that the patch is too big and covers too many
   topics.

In other words, I think the problem the old patch attempted to solve was
this:

   When you do too many things in a patch touching many places of the
   code, and want to explain and justify all of them, your commit log
   message becomes a list of "we used to do X but 7th hunk changes it to Y
   because of Z" entries for different X, Y and Z.  When this list gets
   too big, it is easier to read through the patch if such explanation are
   done close to where the changes described are.

For your reference, this was the dropped patch.

From: Junio C Hamano <junkio@cox.net>
Date: Fri, 8 Dec 2006 21:03:52 -0800
Subject: [PATCH] mailinfo: hack to accept in-line annotations in patches.

Long before git-apply, when I wanted to talk about rationale of
individual changes, I used to add annotation between hunks
(delimited @@ -n,m, +l,k @@) as unindented plain text and rely
on GNU patch to discard them as garbage.  Because git-apply is
much less forgiving than GNU patch, this is not possible.

This patch teaches mailinfo that lines that begin with a '|' would
never appear in the patch text and can be discarded safely.
Which means that we can generate a patch as usual using format-patch,
and add annotations inline, prefixed with '|'.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-mailinfo.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index c95e477..2608260 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -720,8 +720,10 @@ static int handle_commit_msg(char *line)
 
 static int handle_patch(char *line)
 {
-	fputs(line, patchfile);
-	patch_lines++;
+	if (line[0] != '|') {
+		fputs(line, patchfile);
+		patch_lines++;
+	}
 	return 0;
 }
 
