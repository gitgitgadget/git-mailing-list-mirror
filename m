From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v5] pull: allow dirty tree when rebase.autostash enabled
Date: Wed, 22 Jul 2015 21:07:24 +0200
Message-ID: <20150722190724.GA11291@ikke.info>
References: <1434538880-15608-1-git-send-email-me@ikke.info>
 <1436046158-19426-1-git-send-email-me@ikke.info>
 <xmqqd205yq98.fsf@gitster.dls.corp.google.com>
 <20150707035956.GA6105@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: gitster@ikke.info
X-From: git-owner@vger.kernel.org Wed Jul 22 21:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzMY-0003IA-U3
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbbGVTH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 15:07:26 -0400
Received: from ikke.info ([178.21.113.177]:51841 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbbGVTH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:07:26 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 8F37D4400AE; Wed, 22 Jul 2015 21:07:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150707035956.GA6105@yoshi.chippynet.com>
User-Agent: Mutt/1.5.23+89 (0255b37be491) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274455>

On Tue, Jul 07, 2015 at 11:59:56AM +0800, Paul Tan wrote:
> On Mon, Jul 06, 2015 at 01:39:47PM -0700, Junio C Hamano wrote:
> > Kevin Daudt <me@ikke.info> writes:
> > 
> > > rebase learned to stash changes when it encounters a dirty work tree, but
> > > git pull --rebase does not.
> > >
> > > Only verify if the working tree is dirty when rebase.autostash is not
> > > enabled.
> > >
> > > Signed-off-by: Kevin Daudt <me@ikke.info>
> > > Helped-by: Paul Tan <pyokagan@gmail.com>
> > > ---
> > 
> > I applied it, tried to run today's integration cycle, and then ended
> > up ejecting it from my tree for now, as this seemed to break 5520
> > when merged to 'pu' X-<.
> > 
> > Well, that is partly expected, as Paul's builtin/pull.c does not
> > know about it (yet).
> 
> Yeah, sorry about that.
> 
> Here's a modified patch for the C code.
> 
> Regards,
> Paul
> 
> --- >8 ---
> From: Kevin Daudt <me@ikke.info>
> Date: Sat, 4 Jul 2015 23:42:38 +0200
> 
> rebase learned to stash changes when it encounters a dirty work tree,
> but git pull --rebase does not.
> 
> Only verify if the working tree is dirty when rebase.autostash is not
> enabled.
> 
> Signed-off-by: Kevin Daudt <me@ikke.info>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/pull.c  |  6 +++++-
>  t/t5520-pull.sh | 11 +++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 722a83c..b7bc1ff 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -823,10 +823,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		hashclr(orig_head);
>  
>  	if (opt_rebase) {
> +		int autostash = 0;
> +
>  		if (is_null_sha1(orig_head) && !is_cache_unborn())
>  			die(_("Updating an unborn branch with changes added to the index."));
>  
> -		die_on_unclean_work_tree(prefix);
> +		git_config_get_bool("rebase.autostash", &autostash);
> +		if (!autostash)
> +			die_on_unclean_work_tree(prefix);
>  
>  		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
>  			hashclr(rebase_fork_point);
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index f4a7193..a0013ee 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -245,6 +245,17 @@ test_expect_success '--rebase fails with multiple branches' '
>  	test modified = "$(git show HEAD:file)"
>  '
>  
> +test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
> +	test_config rebase.autostash true &&
> +	git reset --hard before-rebase &&
> +	echo dirty >new_file &&
> +	git add new_file &&
> +	git pull --rebase . copy &&
> +	test_cmp_rev HEAD^ copy &&
> +	test "$(cat new_file)" = dirty &&
> +	test "$(cat file)" = "modified again"
> +'
> +
>  test_expect_success 'pull.rebase' '
>  	git reset --hard before-rebase &&
>  	test_config pull.rebase true &&
> -- 
> 2.5.0.rc1.21.gbd65f2d.dirty
> 

Any news about this? Is it still waiting for something?
