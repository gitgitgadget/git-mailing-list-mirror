From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] branch: introduce --list argument
Date: Thu, 25 Aug 2011 12:52:41 -0700
Message-ID: <7vmxexjmk6.fsf@alter.siamese.dyndns.org>
References: <4E5607E0.1050300@drmicha.warpmail.net>
 <32d0954697da9ac96cc11af0d8cc1390d93fd037.1314259226.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 21:52:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwfyu-0003kV-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 21:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab1HYTwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 15:52:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab1HYTwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 15:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2826F4C60;
	Thu, 25 Aug 2011 15:52:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CuQHFg01XEXoJF/rFhJjWHcbCsA=; b=FGL1di
	1ZFHFJ+Wf6MQRs4E8S3dB9EHznX814iPDpYnRTvhdD+qZrDE4jghgvlgYdX7FbO4
	MHZdgMMCiTKsq1BL1ScSACmDKifVkVWU5Ddv1TJZZVjCC67qkwQvDuoY8yt42fLr
	xsY0/ZIyXO9kGuntdFsoCYqNtzddhKlB7E1dY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PDHaiKy3qabj+I/pTrMZgX/9kdhDG5Z9
	nkd6eZQhAaL1U8nCNX8JpqnPgbQzw6DChO08YpSA8+JaDL8gqPRoCGHNx6H2DEWb
	yFz5ctNMWzSdoPejSGFImpcU0x/MIrAHGsOV9W9SxewNw+pS60CMGiWDMEY+6rYD
	1MMa9XUohI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2F24C5F;
	Thu, 25 Aug 2011 15:52:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53EB84C5E; Thu, 25 Aug 2011
 15:52:43 -0400 (EDT)
In-Reply-To: <32d0954697da9ac96cc11af0d8cc1390d93fd037.1314259226.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 25 Aug 2011 10:30:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC09DF7C-CF53-11E0-AF83-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180106>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> @@ -695,12 +696,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
>  			     0);
> -	if (!!delete + !!rename + !!force_create > 1)
> +	if (!!delete + !!rename + !!force_create + !!list > 1)
>  		usage_with_options(builtin_branch_usage, options);
>  
> +	if (argc == 0 || (verbose && argc == 1))
> +		list = 1;
> +

I am afraid this is not quite right.

What happens if one of delete/rename/force-create can take a single
argument, or more importantly, if we someday gain another option that can
take zero or one argument and is incompatible with other operating mode?

For example, what happens to this command line with your "git branch":

	$ git branch -v -m boo

The first test passes (no explicit --list), and then you violate the "only
one of these operating mode can be set" assertion you made yourself by
flipping list on, no?

It is a good practice to always run the defaulting tweak *before* checking
options that are mutually incompatible, to catch your own mistake in the
tweaking code.

On top of my previous "multiple patterns allowed" tweak, a replacement
patch to this file may look like this.  I suspect there should be a better
way to represent the mode in a single variable and enforce that there is
only one chosen, but that is left for another day.

 builtin/branch.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0fa62bd..4243e7c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -629,7 +629,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force_create = 0;
+	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
@@ -668,6 +668,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
+		OPT_BOOLEAN(0, "list", &list, "list branch names"),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
@@ -710,12 +711,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-	if (!!delete + !!rename + !!force_create > 1)
+
+	if (!delete && !rename && !force_create &&
+	    (argc == 0 || (verbose && argc)))
+		list = 1;
+
+	if (!!delete + !!rename + !!force_create + !!list > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0 || (verbose && argc))
+	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev,
 				      with_commit, argv);
 	else if (rename && (argc == 1))
