From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/WIP PATCH 0/4] less ignorance of submodules for ignore=all
Date: Thu, 05 Dec 2013 21:51:31 +0100
Message-ID: <52A0E753.5090908@web.de>
References: <20131122215454.GA4952@sandbox-ub> <20131122220953.GI4212@google.com> <52910BC4.1030800@web.de> <20131124005256.GA3500@sandbox-ub> <52922962.3090407@web.de> <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com> <20131125174945.GA3847@sandbox-ub> <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com> <20131204221659.GA7326@sandbox-ub> <xmqq7gbkjlgx.fsf@gitster.dls.corp.google.com> <20131204231932.GG7326@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 21:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voftl-00050F-PE
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 21:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab3LEUvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 15:51:35 -0500
Received: from mout.web.de ([212.227.15.14]:52819 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab3LEUve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 15:51:34 -0500
Received: from [192.168.178.41] ([84.132.154.249]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LjJL9-1VJSwd3Kt5-00dYmL for <git@vger.kernel.org>;
 Thu, 05 Dec 2013 21:51:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131204231932.GG7326@sandbox-ub>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5EIhrvxX85eG2ADNz55BAl67KxRxDgT46zW6LfE8jwO7kAEjzJ7
 urrn4B2iuIUrBdfPV1M6ri++Q9V5bIHufM6Bexu3EGOvpE6vXKkR1RbN8mVKNokwMuoua8F
 Zzi4BTV/eyCPhCqTuPGw7k9sTssJ7A5gF2Xd8GAYryyK+R5u9KxOwuHlTV/6kdrvKFl8b8M
 1ScolnRN+XUF2ZgYI3ssw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238910>

Am 05.12.2013 00:19, schrieb Heiko Voigt:
> On Wed, Dec 04, 2013 at 02:32:46PM -0800, Junio C Hamano wrote:
> This series tries to achieve the following goals for the
> submodule.<name>.ignore=all configuration or the --ignore-submodules=all
> command line switch.

Thanks for the summary.

>  * Make git status never ignore submodule changes that got somehow in the
>    index. Currently when ignore=all is specified they are and thus
>    secretly committed. Basically always show exactly what will be
>    committed.

Yes, what's in the index should always be shown as such even when the
user chose to ignore the work tree differences of the submodule.

>  * Make add ignore submodules that have the ignore=all configuration when
>    not explicitly naming a certain submodule (i.e. using git add .).
>    That way ignore=all submodules are not added to the index by default.
>    That can be overridden by using the -f switch so it behaves the same
>    as with untracked files specified in one of the ignore files except
>    that submodules are actually tracked.

I think we should do this part in a different series, as everybody
seems to agree that this should be fixed that way and it has nothing
to do with what is ignored in submodule history.

>  * Let diff always show submodule changes between revisions or
>    between a revision and the index. Only worktree changes should be
>    ignored with ignore=all.
> 
>  * Generally speaking: Make everything that displays diffs in history,
>    diffs between revisions or between a revision and the index always
>    show submodules changes (only the commit ids) even if a submodule is
>    specified as ignore=all.

I'm not so sure about that. Some scripts really want to ignore the
history of submodules when comparing a rev to the index:

git-filter-branch.sh:			git diff-index -r --name-only --ignore-submodules $commit &&
git-pull.sh:    git diff-index --cached --name-status -r --ignore-submodules HEAD --
git-rebase--merge.sh:	if ! git diff-index --quiet --ignore-submodules HEAD --
git-sh-setup.sh:	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
git-stash.sh:	git diff-index --quiet --cached HEAD --ignore-submodules -- &&

I didn't check each site in detail, but I suspect each ignore option
was added on purpose to fix a problem. That means we still need "all"
(at least when diffing rev<->index). Unfortunately that area is not
covered well in our tests, I only got breakage from the filter-branch
tests when teaching "all" to only ignore work tree changes (see at the
end on how I did that).

So I'm currently in favor of adding a new "worktree"-value which will
only ignore the work tree changes of submodules, which seems just what
the floating submodule use case needs. But it looks like we need to
keep "all".

>  * If ignore=all for a submodule and a diff would usually involve the
>    worktree we will show the diff of the commit ids between the current
>    index and the requested revision.

I agree if we make that "ignore=worktree".

>> I do think that it is a good thing to make what "git add ." does and
>> what "git status ." reports consistent, and "git add ." that does
>> not add everything may be a good step in that direction

Yup, as written above I'd propose to start with that too.

>> (another
>> possible solution may be to admit that ignore=all was a mistake and
>> remove that special case altogether, so that "git status" will
>> always report a submodule that does not match what is in the HEAD
>> and/or index).

No, looking at the git-scripts that use it together with diff-index it
wasn't a mistake. But we might be missing a less drastic option ;-)

> I think it was too early to add ignore=all back then when the ignoring
> was implemented. We did not think through all implications. Since people
> have always been requesting the floating model and as it seems started
> using it I am not so sure whether there is not a valid use case. Maybe
> Sergey can shed some light on their actual use case and why they do not
> care about the precise revision most of the time.

You maybe right about not thinking things thoroughly through, but we
helped people that rightfully complained when the (then new) submodule
awareness broke their scripts.

> For example the case that all developers always want to work with some
> HEAD revision of all submodules and the build system then integrates
> their changes on a regular basis. When all went well it creates commits
> with the precise revisions. This way they have some stable points as
> fallback or for releases. Thats at least the use case I can think of but
> maybe there are others.

And that could be the "worktree" value.

Below is a hack that disables the diffing of rev and index, but not
that against the work tree. It breaks t4027-diff-submodule.sh,
t7003-filter-branch.sh and t7508-status.sh as expected:

---------------------->8--------------------
diff --git a/diff.c b/diff.c
index e34bf97..ed66a01 100644
--- a/diff.c
+++ b/diff.c
@@ -4813,7 +4813,7 @@ static int is_submodule_ignored(const char *path, struct d
        if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
                ignored = 1;
        options->flags = orig_flags;
-       return ignored;
+       return 0;
 }

 void diff_addremove(struct diff_options *options,
