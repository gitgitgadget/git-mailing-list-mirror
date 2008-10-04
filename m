From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git apply: git diff header lacks filename information for git
 diff --no-index patch
Date: Sat, 4 Oct 2008 09:54:36 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 18:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmAQ9-0001Xq-Kc
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 18:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbYJDQyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 12:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbYJDQyr
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 12:54:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44560 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbYJDQyq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Oct 2008 12:54:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94Gsa5W032607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Oct 2008 09:54:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94GsanZ023797;
	Sat, 4 Oct 2008 09:54:36 -0700
In-Reply-To: <20081004041714.GA12413@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.435 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97473>



On Sat, 4 Oct 2008, Jeff King wrote:
> On Thu, Oct 02, 2008 at 09:27:36PM +0300, Imre Deak wrote:
> > $ git apply patch
> > fatal: git diff header lacks filename information (line 4)
> > $ cat patch
> > diff --git a/dev/null b/a
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1f2a4f5ef3df7f7456d91c961da36fc58904f2f1
> > GIT binary patch

Ok, this patch is broken in so many ways..

> Hmm. The problem is that "git apply" doesn't accept that "a/dev/null"
> and "b/a" are the same, so it rejects them as a name. I guess on a text
> patch, we would just pull that information from the "---" and "+++"
> lines, so we don't care that it's not on the diff commandline.

Exactly. In order to avoid all the ambiguities, we want the filename to 
match on the 'diff -' line to even be able to guess, and if it doesn't, we 
should pick it up from the "rename from" lines (for a git diff), or from 
the '--- a/filename'/'+++ b/filename' otherwise (if it's not a rename, or 
not a git diff).

And being a binary diff, and a creation event, all of this fails.

To make things worse, git has also screwed up the "/dev/null" and 
prepended the prefix to it, making it even harder to see any patterns to 
the names. Gaah.

> However, a _non_ --no-index patch doesn't produce the same output. It
> will actually produce the line:
> 
>   diff --git a/a b/a
> 
> even if it is a creation patch. So I'm not sure which piece of code is
> at fault.

It's some of both. I think --no-index is broken, that "a/dev/null" is 
total crap regardless of anything else. There's no way that thing is 
correct, and even if you were not to want "a/a", it should have been just 
plain "/dev/null". 

But for a native git patch, we shouldn't even use the (at least slightly 
more correct) "/dev/null", since native git application doesn't actually 
do the "is_dev_null()" for native patches, and just wants the filename to 
be the same.

So I think "git apply" is correct, and "git diff --no-index" is broken.

That said, I think git-apply being "correct" is not a great excuse, and we 
should do the "be liberal in what you accept, conservative in what you 
generate", and think about how to make git-apply be more willing to handle 
this case too. 

Quite frankly, I should have doen the explicit headers as

	"new file " <mode> SP <name>

instead of

	"new file mode " <mode>

(and same for "deleted file", obviously) and the patch would have been 
more readable _and_ we'd have avoided this issue. But when I did all that, 
I didn't even think of binary diffs (they weren't an issue originally). 

Dang.

Anyway, for now I'd suggest a patch like this. Hmm? The "diff --git" 
format assumes that the names are the same, so make it so.

			Linus

---
 diff.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 9053d4d..0910b4e 100644
--- a/diff.c
+++ b/diff.c
@@ -1479,7 +1479,7 @@ static void builtin_diff(const char *name_a,
 {
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
-	char *a_one, *b_two;
+	char *a_one, *b_two, *h_name;
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
@@ -1497,7 +1497,8 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	fprintf(o->file, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	h_name = DIFF_FILE_VALID(one) ? a_one : b_two;
+	fprintf(o->file, "%sdiff --git %s %s%s\n", set, h_name, h_name, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
 		fprintf(o->file, "%snew file mode %06o%s\n", set, two->mode, reset);
