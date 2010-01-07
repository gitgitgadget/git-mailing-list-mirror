From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Be more user-friendly when refusing to do something because of conflict.
Date: Thu, 07 Jan 2010 16:34:21 +0100
Message-ID: <vpqiqbeornm.fsf@bauges.imag.fr>
References: <vpqhbqz6lcr.fsf@bauges.imag.fr>
	<1262809074-27137-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vskajq716.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 16:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSuNs-0002AP-FO
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 16:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab0AGPen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 10:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602Ab0AGPen
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 10:34:43 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49142 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403Ab0AGPem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 10:34:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o07FYIHc009265
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jan 2010 16:34:18 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NSuNR-0005m9-TR; Thu, 07 Jan 2010 16:34:21 +0100
In-Reply-To: <7vskajq716.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 06 Jan 2010 13\:04\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Jan 2010 16:34:19 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o07FYIHc009265
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1263483259.3353@9yR1qIhwNJdfqcKyxObAVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136348>

Thanks for your detailed feedback.

Junio C Hamano <gitster@pobox.com> writes:

> "The new output looks like this, which is much better..." is missing
> here.

Added.

> One advice, "use add/rm as appropriate to mark resolution" goes only as
> far as making the index in order, without recording it in a commit.  The
> other, "commit -a", will make a commit, I suspect that "commit -a" needs
> to be matched with "commit" if the user chooses to take the first advice
> of resolving paths incrementally.  IOW
>
>     use 'git add/rm <file>' as appropriate to mark resolution and make a
>     commit, or use 'commit -a', before running me again.
>
> might be more appropriate.

Applied.

The same sentence has a slightly different meaning for commit and
merge. For commit "make a commit" means "redo what you tried to do",
and for merge, it means "make a commit before you redo what you tried
to do".

>> +static void refresh_cache_or_die(int refresh_flags)
>> +{
>> +	/*
>> +	 * refresh_flags contains REFRESH_QUIET, so the only errors
>> +	 * are for unmerged entries.
>> +	*/
>
> Mixed indentation.

fixed.

>> +	if(refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN)) {
>
> SP after "if".

fixed (together with the useless brace which you had missed ;-) ).

> What should we see upon "commit --dry-run" and what does the code after
> the patch produce?

Good remark. Just tried, it works without option, with -a, -o, -i.
They all give the usual status output, except -o which complains:

$ git commit --dry-run -o foo.txt
fatal: cannot do a partial commit during a merge.

(as before)

> Are we sure refresh_flags always lack REFRESH_UNMERGED that allows
> unmerged entries and produces the unmerged error messages when
> needed?

Argument from intimidation:
If they hadn't, we would have noticed the output (foo.txt: needs
merge) before the patch.

Rational argument:
prepare_index starts with this:

	if (is_status)
		refresh_flags |= REFRESH_UNMERGED;

and each call to refresh_cache_or_die is within prepare_index, with
these flags, untouched.

>> -	if (file_exists(git_path("MERGE_HEAD"))) [...]
>> -	if (read_cache_unmerged()) [...]
>> +	if (read_cache_unmerged()) {
>> +		die_resolve_conflict("merge");
>> +	}
>> +	if (file_exists(git_path("MERGE_HEAD"))) {
>> +		if (advice_resolve_conflict)
>> +			die("You have not concluded your merge (MERGE_HEAD exists).\n"
>> +			    "Please, commit your changes before you can merge.");
>> +		else
>> +			die("You have not concluded your merge (MERGE_HEAD exists).");
>> +	}
>
> It is not a very big deal, but why are these checked in different order
> after the patch?
[...]
> Note that the user might have already run "add -u" to mark everything
> resolved, in which case MERGE_HEAD will still exist even though the index
> is free of ummerged entries.

That's precisely the reason. You hardly have conflicts without a
MERGE_HEAD, but it's sensible to have a MERGE_HEAD without unmerged
entries in the index, which means you're one step closer to the
commit.

I've added a comment (not a commit message) to make it clear.

> Nice.  Maybe we want to handle other cases like:
>
> 	$ git rebase master
>         ... conflicted

(if it's conflicted, it's OK, same user-friendly message. If you
already git add-ed your conflicts, git pull will run normally :-( ).

>         ... called away for a 30-minutes meeting
>         ... forgot the user was in the middle of the rebase
>         $ git pull
>
> and the "pull" refused to run because the earlier "rebase" hasn't been
> concluded (I suspect an earlier "am" failure would be the same issue).

Yes, but I think that's a separate topic (and I'm getting short in
time budget). This will also apply to many commands (pull,
merge, ...), including shell and C. It would probably be good to have
a C function like can_I_start_merge() exposed as a plumbing command to
be used by git-pull.sh.

And I'm wondering whether the ability to run pull in the middle of a
rebase is a bug or a feature. Never did that, but I can imagine
someone doing a 'rebase -i' with an 'edit' command to let rebase stop,
do a merge, and then 'rebase --continue', to insert a merge commit in
the middle of a patch serie.

Patch follows. Fyi the difference with v3 are:

diff --git a/advice.c b/advice.c
index ec2bd82..3309521 100644
--- a/advice.c
+++ b/advice.c
@@ -33,9 +33,13 @@ int git_default_advice_config(const char *var, const char *value)
 void NORETURN die_resolve_conflict(const char *me)
 {
        if (advice_resolve_conflict)
+               /*
+                * Message used both when 'git commit' fails and when
+                * other commands doing a merge do.
+                */
                die("'%s' is not possible because you have unmerged files.\n"
-                   "Please, fix them up in the work tree, and then use 'git add/rm <file>'\n"
-                   "as appropriate to mark resolution, or use 'git commit -a'.", me);
+                   "Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
+                   "appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
        else
                die("'%s' is not possible because you have unmerged files.", me);
 }
diff --git a/builtin-commit.c b/builtin-commit.c
index a4977ac..b3b37c2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -240,8 +240,8 @@ static void refresh_cache_or_die(int refresh_flags)
        /*
         * refresh_flags contains REFRESH_QUIET, so the only errors
         * are for unmerged entries.
-       */
-       if(refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN)) {
+        */
+       if (refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN)) {
                die_resolve_conflict("commit");
        }
 }
diff --git a/builtin-merge.c b/builtin-merge.c
index abe6c03..79a35c3 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -851,6 +851,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
                die_resolve_conflict("merge");
        }
        if (file_exists(git_path("MERGE_HEAD"))) {
+               /*
+                * There is no unmerged entry, don't advise 'git
+                * add/rm <file>', just 'git commit'.
+                */
                if (advice_resolve_conflict)
                        die("You have not concluded your merge (MERGE_HEAD exists).\n"
                            "Please, commit your changes before you can merge.");

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
