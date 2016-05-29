From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: Re: [RFC/PATCH] pull: set-upstream implementation
Date: Sun, 29 May 2016 22:00:50 +0200
Message-ID: <5639de7f-5a76-7038-ca13-867aaca3de64@grenoble-inp.org>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
 <xmqqvb22ypot.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	samuel.groot@grenoble-inp.org,
	Jordan De Gea <jordan.de-gea@grenoble-inp.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 29 22:01:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b76tS-0004DC-Fz
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 22:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbcE2UAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 16:00:55 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:35513 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbcE2UAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 16:00:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C9EAE247F;
	Sun, 29 May 2016 22:00:51 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VX5zcCVJC7St; Sun, 29 May 2016 22:00:51 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B67142473;
	Sun, 29 May 2016 22:00:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id AA8EA2077;
	Sun, 29 May 2016 22:00:51 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVR0wPtqJ9Vy; Sun, 29 May 2016 22:00:51 +0200 (CEST)
Received: from [192.168.1.28] (LFbn-1-8165-112.w90-112.abo.wanadoo.fr [90.112.74.112])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4C8752064;
	Sun, 29 May 2016 22:00:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqvb22ypot.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295844>



On 25/05/2016 20:09, Junio C Hamano wrote:
 > Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org> writes:
 >> Difficulties:
 >>     - I can't figure out what remote branch sould be tracked
 >>     in that case: `git pull -u origin :master`
 >
 > What does the command do without "-u"?

After some research, I think it creates a new branch if the ref doesn't 
exist. Otherwise it does nothing. So no branch should be tracked in that 
case.

 >> +-u::
 >> +--set-upstream::
 >> +    For each branch that is successfully pulled, add
 >> +    upstream (tracking) reference, used by argument-less
 >> +    linkgit:git-push[1] and other commands. For more information,
 >> +    see 'branch.<name>.merge' in linkgit:git-config[1].
 >
 > A crucial piece of information that is lacking in the above is where
 > <name> comes from.  The same issue exists in your proposed commit
 > log message.

You're right, documentation is unclear. I'll sort it out.

 > There a few design decisions you must have made that needs to be
 > either described fully or at least hinted here, too, such as (not
 > exhaustive and in random order):
 >
 >  * What should happen when the current branch already has these two
 >    configuration variables defined?  Should the user get a warning
 >    when this changes the setting from what was already there?

Neither `git pull --set-upstream` nor `git branch --set-upstream-to` 
warns the user in such case. So `git pull --set-upstream` should simply 
override the previous configuration the same way these commands do.


 >  * What should happen when the remote is specified as a Git URL, not
 >    as a remote nickname?  You want a nickname for the value to place
 >    in "branch.<name>.remote".
 >
 >     - Should Git find an existing remote that points at the URL and
 >       use it?  If so, and if the value we are about to place in
 >       "branch.<name>.merge" is outside its configured fetch refspec,
 >       should Git tweak the fetch refspec of the existing remote?
 >
 >     - Should Git create a new remote nickname for the URL?  If so,
 >       what should the fetch refspec be for the newly created remote?
 >       Should it fetch only the branch we fetched just now?

Still in comparison with `git push --set-upstream`, when using a Git URL 
as <repo>, "push" just sets "branch.<name>.remote" to the URL given in 
argument (even if there is a configured remote with this URL).
`git pull --set-upstream` should work the same way.

 >  * What should happen when more than one ref is given?
 >    branch_get_upstream() can return only one ref; should Git choose
 >    one of them at random?  Should Git warn and turn this into a
 >    no-op?

It depends whether refspecs given in arguments refers to the same branch 
or not. I discuss this point later in this email.

 >  * What should happen when the ref given to pull is not a branch
 >    (e.g. a tag)?  A tag, meant to be a stable anchoring point, is
 >    not something suitable to be set as branch.<name>.merge, even
 >    though it might be technically possible to configure it as such.
 >    Should Git warn and turn this into a no-op?

`pull --set-upstream` should only set "branch.<name>.merge" to remote 
branches. So yes a check must be done with eventually a no-op.

 >> +    refspecs = parse_fetch_refspec(nr_refspec, refspecs_name);
 >> +
 >> +    for (i = 0; i < nr_refspec; i++) {
 >> +        if (refspecs[i].src != NULL && strlen(refspecs[i].src) > 0) {
 >
 > More importantly, what would you see here in .src when your command
 > line were:
 >
 >     $ git pull -u <REMOTE> "refs/heads/*:refs/remotes/foo/*"
 >
 > Hint: check .pattern to make sure it is false.  Skip them at the top
 > of the loop body, perhaps.

This case wasn't handled at all, thanks for the hint.

 >> +            remote_branch = refspecs[i].src;
 >> +        } else {
 >> +            warning(N_("not yet implemented"));
 >
 > What do you plan to implement here?

Now that I understand `git pull -u origin :master`, there's nothing to 
implement here, except maybe a warning?

 >> +            local_branch = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
 >> +            skip_prefix(local_branch, "refs/heads/", &local_branch);
 >
 > What happens here if your user did this?
 >
 >     $ git checkout HEAD^0 && git pull -u <REMOTE> ...
 >
 > You do not have "local_branch" here.  Check the condition, warn and
 > turn it into no-op (I do not think "pull -u" is important enough to
 > fail the entire command).

"pull -u" should indeed only work for branches, I'll put a check on this.
But I'm not really sure what procedure I should use to fully resolve 
refs. In git code, sometimes "dwim_ref" is used, sometimes it's 
"resolve_ref_unsafe" and haven't found any documentation on this.

 >> +        }
 >> +
 >> +        strbuf_init(&remote_name, strlen(repo) + 
strlen(remote_branch) + 1);
 >> +        strbuf_addf(&remote_name, "%s/%s", repo, remote_branch);
 >
 > What happens here if your user did this?
 >
 >     $ git pull -u git://git.kernel.org/r/e/p/o master
 >
 > Specifically, what is "repo" at this point?
 >
 >> +        create_branch(local_branch, local_branch, remote_name.buf, 
0, 0, 0, opt_verbosity < 0, BRANCH_TRACK_OVERRIDE);
 >
 > I thought you were only setting up configurations for existing
 > branch.  Why do you call create_branch() on the existing
 > local_branch, which is supposed to be the current one?

We took the example of `git branch --set-upstream-to=<remote>/<branch>` 
for this one. Perhaps using directly install_branch_config() is more 
relevant here.
It allows to set a non-configured remote (I mean in the .git/config) as 
the remote for the branch (with the full URL), fixing the example you 
gave me and working like `git push -u git://git.kernel.org/r/e/p/o master`.


 > What does it mean for this loop to execute more than once, flipping
 > the configuration for the current branch number of times?  The last
 > one wins?  Does it even make sense from the end-user's point of
 > view?

The loop is here to handle when the user uses multiple 
'remote_branch:local_branch' notation.
(e.g. `git pull -u <remote> master:master other:other`)

For now, the last one wins. But I agree, it doesn't really make sense.
The simplest solution from the technical point of view would be to no-op 
when multiple refs are passed in arguments.
However `git pull -u <remote> master:master other:other` seems legit.

So another solution would be to warn and no-op if the same branch config 
is modified twice.

 >> +    rm -rf parent &&
 >> +    git init parent &&
 >> +    cd parent &&
 >> +    (
 >> +        echo content >file &&
 >> +        git add file &&
 >> +        git commit -m one &&
 >> +        git checkout -b other &&
 >> +        echo content >file2 &&
 >> +        git add file2 &&
 >> +        git commit -m two &&
 >> +        git checkout -b master2 &&
 >> +        git checkout master
 >> +    ) &&
 >> +    cd ..
 >
 > The tests typically do
 >
 >     ... some stuff ... &&
 >         (
 >         cd elsewhere &&
 >                 ... more stuff ...
 >     ) &&
 >         ... yet more stuff ...
 >
 > to make sure that even after any of "... more stuff ..." fails, the
 > caller of this sequence will find it in an expected and stable
 > place.  As written in your patch, if any of the "... more stuff ..."
 > fails, the caller will be in "parent" directory, not in the original
 > directory, because your "cd .." will not be exectued.
 >
 > I wonder if you are completely missing the point of using a subshell
 > here?

You quoted the same issue later and indeed I didn't use it correctly.

 >> +check_config() {
 >> +    (echo $2; echo $3) >expect.$1
 >
 >     test_write_lines "$2" "$3" >"expect.$1"
 >
 > Unless you want your variable reference is split at $IFS, quote
 > your variables.
 >

 >> +    (git config branch.$1.remote
 >> +     git config branch.$1.merge) >actual.$1
 >> +    test_cmp expect.$1 actual.$1
 >
 > It is not _wrong_ per-se, but I do not think ".$1" suffix is adding
 > any value.  I'd drop it if I were doing this patch.

I took these functions from "t/t5523-push-upstream.sh" and I didn't 
closely look at it. I'll clean it up.

 >> +'
 >> +
 >> +test_expect_success TTY 'quiet pull' '
 >> +    ensure_fresh_upstream &&
 >> +
 >> +    test_terminal git pull -u --quiet upstream master 2>&1 | tee 
output &&
 >> +    test_cmp /dev/null output
 >> +'
 >
 > There is no test that makes sure that the new feature does not kick
 > in when it should not.  E.g. pulling from somewhere that is not a
 > configured remote.  For example,
 >

Yes you're right. I'll reshape tests and create new ones to cover more 
use cases.

Thanks for the time you spent for this huge and very useful feedback.
