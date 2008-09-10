From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit 140b378d07229e breaks gitk highlighting
Date: Wed, 10 Sep 2008 12:22:35 -0700
Message-ID: <7vtzcnx0uc.fsf@gitster.siamese.dyndns.org>
References: <30e4a070809090531i6c6dd2c8r189e70927b5444c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	=?utf-8?Q?Karl_Hasselstr?= =?utf-8?Q?=C3=B6m?= <kha@treskal.com>,
	"Paul Mackerras" <paulus@samba.org>
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 21:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdVIB-0004Wg-Au
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 21:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYIJTWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 15:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbYIJTWq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 15:22:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYIJTWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 15:22:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 335385DD2F;
	Wed, 10 Sep 2008 15:22:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2F3FF5DD29; Wed, 10 Sep 2008 15:22:38 -0400 (EDT)
In-Reply-To: <30e4a070809090531i6c6dd2c8r189e70927b5444c9@mail.gmail.com>
 (Mark Levedahl's message of "Tue, 9 Sep 2008 08:31:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7577102-7F6D-11DD-88FC-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95548>

"Mark Levedahl" <mlevedahl@gmail.com> writes:

> gitk since the above commit ("Teach git diff-tree --stdin to diff
> trees") fails to reliably highlight commits matching a given path
> specification. For an example of the problem,
>
>    $gitk ec3a4ba519c001
>
>    and select commit "touching paths" with "t" in the entry bar
>
> The 4'th commit down (t9124: clean up chdir usage) is NOT highlighted,
> though it clearly touches t. Reverting commit 140b378 restores the
> correct behavior. This gets into parts of the code I don't understand,
> so I decline to try to offer a patch.

Feeding the following to "git diff-tree -r -s --stdin -- t" misbehaves
with that change.  The second line is skipped.

7c4d0219cf9ab6a7738a09ad7fec72d5e9f2ac67
a786091b4a487bc08bbff4864717cf5d8383e983
4a09bc966449ca0a7e9a5bb70f91b47debdd7c4e

This should fix it.

I think we should have a stronger warning against misusing lookup_object()
without knowing what it does.  It is marked "Internal only" in the header,
but it does not explain why.  The interface is there to help the lazy
object lookup (e.g. you parse a commit and learn about a parent it has.
You do not want to read the parent commit at that point, so you create a
placeholder commit object and point at it from the child.  You would want
to make sure that you populate the same placeholder object with the data
you read from the parent commit when it gets the turn of the parent commit
to be parsed).

diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 1138c2d..a9e32c9 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -71,8 +71,7 @@ static int diff_tree_stdin(char *line)
 	line[len-1] = 0;
 	if (get_sha1_hex(line, sha1))
 		return -1;
-	obj = lookup_object(sha1);
-	obj = obj ? obj : parse_object(sha1);
+	obj = parse_object(sha1);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
