From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Fri, 29 Feb 2008 11:26:29 -0800
Message-ID: <7vfxvbd0nu.fsf@gitster.siamese.dyndns.org>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
 <7v7igqyii9.fsf@gitster.siamese.dyndns.org>
 <18373.58839.636432.448970@cargo.ozlabs.ibm.com>
 <7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
 <18374.39253.408961.634788@cargo.ozlabs.ibm.com>
 <7vprugdxpj.fsf@gitster.siamese.dyndns.org>
 <18375.58359.687664.855599@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 20:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVAt6-0004qb-RL
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 20:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbYB2T0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 14:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932917AbYB2T0o
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 14:26:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678AbYB2T0n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 14:26:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 15F8C22F5;
	Fri, 29 Feb 2008 14:26:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E283322F4; Fri, 29 Feb 2008 14:26:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75552>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> Doesn't
>> 
>> 	git rev-parse --revs-only --no-flags "$@" | grep '^[0-9a-f]'
>> 
>> give you what you want?
>
> Well, it does, except for --merge, which is perhaps a special case.
>
> (Actually, what would git rev-parse --revs-only --no-flags output that
> isn't a SHA1 ID?  Why do you have the grep command there?)

Try it on user inputs like "master..next", "next...master".  You
wanted to grab only the positive ones, no?

> That's essentially what I do.  I think I'll just have to do special
> cases for --merge and --left-right.

Are you sure?  I can imagine that --merge may be problematic,
because it implicitly is about MERGE_HEAD...HEAD, but rev-parse
may not know about it.  I think --left-right and symmetric
should be fine.

	$ set x --left-right master...next; shift
	$ git rev-parse --revs-only --no-flags "$@" |
          git name-rev --stdin
        88113cfea67557067f1363b210b803637d186632 (next)
        97b97c58e609a1cd23b3c2514f41cdb0405870ee (master)
        ^97b97c58e609a1cd23b3c2514f41cdb0405870ee (master)

In the above case, master is a strict ancestor of next, but the
third line that is negative (and my grep would exclude) is
generally the merge-base between the left and right positives.
The two positives are what you wanted to exclude from the second
round, aren't they?

And in order to handle them sanely without worrying about
revision machinery and rev-parse going out-of-sync, I would
almost suggest doing something like the attached patch and say:

	$ git rev-list --no-walk "$@"

The user options can contain --left-right and --boundary, so the
output from this could begin with ">", "<" and "-".  If you
discard the ones that are prefixed with "-" (i.e. the user had
the --boundary option in "$@"), grab the ones that are not
prefixed (i.e. the user did not have the --left-right option in
"$@"), and the ones prefixed with ">" and "<" (i.e. the user did
have --left-right, and you would strip the prefix from such a
line), you would find all positive ones the user specified, I
think.

-- >8 --
revision --no-walk: do not refuse to show the list with negatives

Scripts may want to find out what revs the user gave from the
command line.

	git rev-list --no-walk --boundary "$@"

would be a natural way to find out what revs (with flags) they
are, but --no-walk refused to work if there are negative ones.
Lift that restriction.
 
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 revision.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 0eb6faa..c0931eb 100644
--- a/revision.c
+++ b/revision.c
@@ -129,8 +129,6 @@ void mark_parents_uninteresting(struct commit *commit)
 
 static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
 {
-	if (revs->no_walk && (obj->flags & UNINTERESTING))
-		die("object ranges do not make sense when not walking revisions");
 	if (revs->reflog_info && obj->type == OBJ_COMMIT &&
 			add_reflog_for_walk(revs->reflog_info,
 				(struct commit *)obj, name))

