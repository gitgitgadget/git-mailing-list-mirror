From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RESEND PATCH] git-checkout: fix argument parsing to detect
 ambiguous arguments.
Date: Wed, 23 Jul 2008 12:10:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231158390.2830@eeepc-johanness>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org> <20080723012751.GI11831@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 12:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbIf-0007lj-VH
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbYGWKJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbYGWKJL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:09:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:57000 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753259AbYGWKJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:09:09 -0400
Received: (qmail invoked by alias); 23 Jul 2008 10:09:07 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp004) with SMTP; 23 Jul 2008 12:09:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VYMZUPqqVLAlnQHKZo5CPO7gCfmjNvpTxSbIXIV
	563uPOebVAcSBC
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080723012751.GI11831@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89619>

Hi,

On Wed, 23 Jul 2008, Pierre Habouzit wrote:

> Note that it also fix a bug, git checkout -- <path> would be badly

s/fix/fixes/

> understood as git checkout <branch> if <path> is ambiguous with a branch.
> 
> Testcases included.
> 
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>

Instead of the "Testcases included", I would have expected something like

	When calling "git checkout <name>" and <name> is both a path and a 
	branch, Git would silently assume that you meant the branch.  
	Worse, "git checkout -- <name>" would behave the same.

probably even as first paragraph.

>   This is a resend with proper patches that made me realize that my

s/patches/tests/

> previous patch had silly mistakes and wasn't testing thigns properly.
> 
>  builtin-checkout.c            |   23 +++++++++++++++++------
>  t/t2010-checkout-ambiguous.sh |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 6 deletions(-)
>  create mode 100755 t/t2010-checkout-ambiguous.sh
> 
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index fbd5105..97321e6 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -438,12 +438,17 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  
>  	opts.track = git_branch_track;
>  
> -	argc = parse_options(argc, argv, options, checkout_usage, 0);
> -	if (argc) {
> +	argc = parse_options(argc, argv, options, checkout_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (argc && strcmp(argv[0], "--")) {
> +		int may_be_ambiguous = argc == 1 || strcmp(argv[1], "--");
> +
>  		arg = argv[0];
> -		if (get_sha1(arg, rev))
> -			;
> -		else if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
> +		if (get_sha1(arg, rev)) {
> +			if (may_be_ambiguous)
> +				verify_filename(NULL, arg);

Still you allow "git checkout <path> --" to succeed, right?  It should 
not.

IMHO you need "must_be_branch" and "must_not_be_path" instead of 
"may_be_ambiguous".

I.e. something like

		int must_be_branch = argc > 1 && !strcmp(argv[1], "--");
		int must_not_be_path = argc > 1 && strcmp(argv[1], "--");

		arg = argv[0];
		if (get_sha1(arg, rev)) {
			if (must_be_branch)
				die ("Not a branch: '%s'", arg);
		}
		else {
			if (must_not_be_path)
				verify_non_filename(NULL, arg);
			if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
				[...]

And maybe you want to add a test for "git checkout <path> --" to fail, 
too.

Ciao,
Dscho
