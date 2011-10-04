From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] log --children
Date: Tue, 04 Oct 2011 22:51:49 +0200
Message-ID: <4E8B71E5.7030303@drmicha.warpmail.net>
References: <4E8B68AC.7020009@drmicha.warpmail.net> <1317761100-33922-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:52:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBByB-0008Ks-QQ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696Ab1JDUwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:52:02 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59086 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933506Ab1JDUwB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 16:52:01 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4F65723964;
	Tue,  4 Oct 2011 16:52:00 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 04 Oct 2011 16:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=pIrc2zfS8opJU/841A9Sec
	GTgf0=; b=qXbE9t+uBDyqLz9XPGRqFGDFwdAnYHfHUGVQV9PkIHwY8yoGXyMWVY
	NupeXD6bLYKeb28x5LvbfEmdLVfTVelZazflvnFsdQ7/YSpf6eNVd+WQt1MTuh4b
	nF4ueP7Wlnj9AkD1VPbKeftBTempUYUTFpLXdbaEHTHLrTRk1doCA=
X-Sasl-enc: KF+pHT7wzGuoRrVcatqv+IQG46l6qCefR6U0te5k+wAy 1317761519
Received: from localhost.localdomain (p5485928F.dip0.t-ipconnect.de [84.133.146.143])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 53096AA0569;
	Tue,  4 Oct 2011 16:51:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <1317761100-33922-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182803>

Jay Soffian venit, vidit, dixit 04.10.2011 22:45:
> Teach git-log to support --children, which was added by f35f5603f4
> to the revision machinery, and by 72276a3ecb to rev-list, but
> was never added to git-log.
> 
> Also add tests for 'log --children' and 'log --parents'.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> On Tue, Oct 4, 2011 at 4:12 PM, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> That means that "log --children --parents" will print out the parents'
>> sha1s, then the children's. Is that a good default format, or should we
>> somehow deal with the case when both are specified?
> 
> They are mutually exclusive:
> 
> $ git log --parents --children
> fatal: cannot combine --parents and --children
> 
>> And I guess we would like to test this...
> 
> Good idea. :-)
> 

Thanks ;)

Looks good to me.

Michael

> j.
> 
>  log-tree.c                  |   12 ++++++++++++
>  t/t4013-diff-various.sh     |    2 ++
>  t/t4013/diff.log_--children |   34 ++++++++++++++++++++++++++++++++++
>  t/t4013/diff.log_--parents  |   34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+), 0 deletions(-)
>  create mode 100644 t/t4013/diff.log_--children
>  create mode 100644 t/t4013/diff.log_--parents
> 
> diff --git a/log-tree.c b/log-tree.c
> index 24c295ea1d..e7694a3a4c 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -165,6 +165,14 @@ static void show_parents(struct commit *commit, int abbrev)
>  	}
>  }
>  
> +static void show_children(struct rev_info *opt, struct commit *commit, int abbrev)
> +{
> +	struct commit_list *p = lookup_decoration(&opt->children, &commit->object);
> +	for ( ; p; p = p->next) {
> +		printf(" %s", find_unique_abbrev(p->item->object.sha1, abbrev));
> +	}
> +}
> +
>  void show_decorations(struct rev_info *opt, struct commit *commit)
>  {
>  	const char *prefix;
> @@ -414,6 +422,8 @@ void show_log(struct rev_info *opt)
>  		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
>  		if (opt->print_parents)
>  			show_parents(commit, abbrev_commit);
> +		if (opt->children.name)
> +			show_children(opt, commit, abbrev_commit);
>  		show_decorations(opt, commit);
>  		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
>  			putchar('\n');
> @@ -473,6 +483,8 @@ void show_log(struct rev_info *opt)
>  		      stdout);
>  		if (opt->print_parents)
>  			show_parents(commit, abbrev_commit);
> +		if (opt->children.name)
> +			show_children(opt, commit, abbrev_commit);
>  		if (parent)
>  			printf(" (from %s)",
>  			       find_unique_abbrev(parent->object.sha1,
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 93a6f20871..a488325e2c 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -231,6 +231,8 @@ log -GF -p master
>  log -GF -p --pickaxe-all master
>  log --decorate --all
>  log --decorate=full --all
> +log --parents
> +log --children
>  
>  rev-list --parents HEAD
>  rev-list --children HEAD
> diff --git a/t/t4013/diff.log_--children b/t/t4013/diff.log_--children
> new file mode 100644
> index 0000000000..bb8ed432cf
> --- /dev/null
> +++ b/t/t4013/diff.log_--children
> @@ -0,0 +1,34 @@
> +$ git log --children
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
> +Merge: 9a6d494 c7a2ab9
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:04:00 2006 +0000
> +
> +    Merge branch 'side'
> +
> +commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a 59d314ad6f356dd08601a4cd5e530381da3e3c64
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:03:00 2006 +0000
> +
> +    Side
> +
> +commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 59d314ad6f356dd08601a4cd5e530381da3e3c64
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:02:00 2006 +0000
> +
> +    Third
> +
> +commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:01:00 2006 +0000
> +
> +    Second
> +    
> +    This is the second commit.
> +
> +commit 444ac553ac7612cc88969031b02b3767fb8a353a 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:00:00 2006 +0000
> +
> +    Initial
> +$
> diff --git a/t/t4013/diff.log_--parents b/t/t4013/diff.log_--parents
> new file mode 100644
> index 0000000000..bc4d44ff1f
> --- /dev/null
> +++ b/t/t4013/diff.log_--parents
> @@ -0,0 +1,34 @@
> +$ git log --parents
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
> +Merge: 9a6d494 c7a2ab9
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:04:00 2006 +0000
> +
> +    Merge branch 'side'
> +
> +commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a 444ac553ac7612cc88969031b02b3767fb8a353a
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:03:00 2006 +0000
> +
> +    Side
> +
> +commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:02:00 2006 +0000
> +
> +    Third
> +
> +commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 444ac553ac7612cc88969031b02b3767fb8a353a
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:01:00 2006 +0000
> +
> +    Second
> +    
> +    This is the second commit.
> +
> +commit 444ac553ac7612cc88969031b02b3767fb8a353a
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:00:00 2006 +0000
> +
> +    Initial
> +$
