From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What should "git submodule summary" give before an initial commit?
Date: Thu, 04 Mar 2010 01:36:58 +0100
Message-ID: <4B8F00AA.5050007@web.de>
References: <4B8E5450.3040702@gmail.com> <7vhboxqje8.fsf@alter.siamese.dyndns.org> <20100303200239.GA28904@coredump.intra.peff.net> <7vhboxno38.fsf@alter.siamese.dyndns.org> <20100303204257.GA5501@coredump.intra.peff.net> <7v3a0hktga.fsf@alter.siamese.dyndns.org> <7vzl2phz8e.fsf@alter.siamese.dyndns.org> <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ping Yin <pkufranky@gmail.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 01:37:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmz42-0000CF-Dc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 01:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab0CDAhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 19:37:07 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:59609 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab0CDAhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 19:37:04 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 42E7214AD180A;
	Thu,  4 Mar 2010 01:37:02 +0100 (CET)
Received: from [80.128.122.244] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nmz3m-0005Ws-00; Thu, 04 Mar 2010 01:37:02 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18czPHZT33ojhlAy56vUQu/a9dV5kZCtrMIIAJg
	EIAohNxAf9HeVH69UteABB7VDx5ggys9MGbaglSYMeGvzPlJJ+
	kwVapn5ZmlkulscWRIvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141494>

Am 03.03.2010 22:58, schrieb Junio C Hamano:
> "git status" collects the changes for both the index (since HEAD) and the
> working tree files (since the index), summarizes and shows them.  When it
> is run before the first commit is made, it uses a logic different from the
> one used in the normal case to gather the information on the index, as we
> don't have HEAD yet, i.e. instead of "diff-index HEAD", we would run
> "diff-index emtpy-tree".
> 
> How should status.submodulesummary integrate into this framework?
> 
> Currently, it blindly runs "git submodule summary", and it gives an extra
> error message about HEAD not being a commit, and people (me included)
> misguidedly have spent time on squelching the message.
> 
> But I think that was _all wrong_.  I do not think "git submodule summary"
> should fail even when you haven't made your first commit.
> 
> If you are before the first commit, we say everything you have in the
> index is a change you are adding with your next commit (which will be your
> initial one).  If you added a submodule commit to the index, shouldn't
> "git submodule summary" say "you'll be committing the addition of this
> subproject"?  IOW, shouldn't we be comparing an empty tree to find added
> submodules, like this, when we haven't made the first commit?
> 
>  git-submodule.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5869c00..0397f9d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -556,10 +556,10 @@ cmd_summary() {
>  	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
>  	then
>  		head=$rev
> -		shift
> +		test $# = 0 || shift
>  	elif test -z "$1" -o "$1" = "HEAD"
>  	then
> -		return
> +		head=4b825dc642cb6eb9a060e54bf8d69288fbee4904
>  	else
>  		head="HEAD"
>  	fi

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

Your patch fixes "git submodule summary" in a freshly created repo for me.


But to make "git status" with status.submodulesummary work as expected,
i need something like the following patch on top of current pu (because
"git submodule summary --cached HEAD" returns no changes in a freshly
created repo):

diff --git a/wt-status.c b/wt-status.c
index 5807fc3..6769c2e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -459,11 +459,21 @@ static void wt_status_print_changed(struct wt_status *s)
 	wt_status_print_trailer(s);
 }

-static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted)
+static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted, int initial)
 {
 	struct child_process sm_summary;
 	char summary_limit[64];
 	char index[PATH_MAX];
+	const char *ref = NULL;
+	if (!uncommitted) {
+		if (s->amend)
+			ref = "HEAD^";
+		else
+			if (initial)
+				ref = "4b825dc642cb6eb9a060e54bf8d69288fbee4904";
+			else
+				ref = "HEAD";
+	}
 	const char *env[] = { index, NULL };
 	const char *argv[] = {
 		"submodule",
@@ -472,7 +482,7 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 		"--for-status",
 		"--summary-limit",
 		summary_limit,
-		uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD"),
+		ref,
 		NULL
 	};

@@ -581,8 +591,8 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_unmerged(s);
 	wt_status_print_changed(s);
 	if (s->submodule_summary) {
-		wt_status_print_submodule_summary(s, 0);  /* staged */
-		wt_status_print_submodule_summary(s, 1);  /* unstaged */
+		wt_status_print_submodule_summary(s, 0, s->is_initial);  /* staged */
+		wt_status_print_submodule_summary(s, 1, 0);  /* unstaged */
 	}
 	if (s->show_untracked_files)
 		wt_status_print_untracked(s);
