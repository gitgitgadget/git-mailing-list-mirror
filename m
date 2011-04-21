From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] revisions: allow --glob and friends in
 parse_options-enabled commands
Date: Thu, 21 Apr 2011 05:48:24 -0500
Message-ID: <20110421104823.GC16260@elie>
References: <20110421102241.GA16185@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 12:48:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCrR3-0002s2-Ob
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 12:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab1DUKs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 06:48:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33866 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab1DUKs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 06:48:28 -0400
Received: by iyb14 with SMTP id 14so1292215iyb.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2q5zySBLmpLsPXMIrTjo7+ow3CKTndodRvJP/ml0FMo=;
        b=UMBN6tIU2B2thIBkz8aV8O+rpVoddoBkSzImIH+cK3XzAqySxwMYgeSFLQNyYBAm2d
         3rH/CaCm/Bf27jvgO16JqOIQttmJAm1Cfjh6NH9fsZdOvd/ub6nxnCKyNIUyvMorgH7g
         OhoEuP40C3XfYJMxZJ3iqCeRNcIsDovMrOfbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AHF2xO3VQH7nKhfz1JCmqZkpwiEbVIEnuouWYJff7VGi/ciWkQRUTXNuuH+4q3Og9U
         w6JUmeEzvVbBFtk67a2kBCeCwJoNgiW2vU5CUii1uM17EtiiHT/DfniBc8EUhAVhUJ4L
         Gi/EQkJJYB+21lz0YhfgSyZlEf6Ao8CRnQ04E=
Received: by 10.42.240.10 with SMTP id ky10mr2829691icb.45.1303382907903;
        Thu, 21 Apr 2011 03:48:27 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id jv9sm657622icb.1.2011.04.21.03.48.26
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 03:48:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110421102241.GA16185@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171901>

As v1.6.0-rc2~42 (2008-07-31) explains, even pseudo-options like --not
and --glob that need to be parsed in order with revisions should be
marked handled by handle_revision_opt to avoid an error when
parse_revision_opt callers like "git shortlog" encounter them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.  I hope despite the mess it was not too
unpleasant.

 revision.c               |   14 ++++++++++++-
 t/t6018-rev-list-glob.sh |   50 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index c9b1e32..2389764 100644
--- a/revision.c
+++ b/revision.c
@@ -1178,7 +1178,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
-	    !strcmp(arg, "--bisect"))
+	    !strcmp(arg, "--bisect") || !prefixcmp(arg, "--glob=") ||
+	    !prefixcmp(arg, "--branches=") || !prefixcmp(arg, "--tags=") ||
+	    !prefixcmp(arg, "--remotes="))
 	{
 		unkv[(*unkc)++] = arg;
 		return 1;
@@ -1534,6 +1536,16 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	const char *optarg;
 	int argcount;
 
+	/*
+	 * NOTE!
+	 *
+	 * Commands like "git shortlog" will not accept the options below
+	 * unless parse_revision_opt queues them (as opposed to erroring
+	 * out).
+	 *
+	 * When implementing your new pseudo-option, remember to
+	 * register it in the list at the top of handle_revision_opt.
+	 */
 	if (!strcmp(arg, "--all")) {
 		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs(submodule, revs, *flags, head_ref_submodule);
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index fb8291c..f00cebf 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -69,6 +69,18 @@ test_expect_success 'rev-parse --glob=heads/subspace' '
 
 '
 
+test_expect_failure 'rev-parse accepts --glob as detached option' '
+
+	compare rev-parse "subspace/one subspace/two" "--glob heads/subspace"
+
+'
+
+test_expect_failure 'rev-parse is not confused by option-like glob' '
+
+	compare rev-parse "master" "--glob --symbolic master"
+
+'
+
 test_expect_success 'rev-parse --branches=subspace/*' '
 
 	compare rev-parse "subspace/one subspace/two" "--branches=subspace/*"
@@ -129,6 +141,12 @@ test_expect_success 'rev-list --glob refs/heads/subspace/*' '
 
 '
 
+test_expect_success 'rev-list not confused by option-like --glob arg' '
+
+	compare rev-list "master" "--glob -0 master"
+
+'
+
 test_expect_success 'rev-list --glob=heads/subspace/*' '
 
 	compare rev-list "subspace/one subspace/two" "--glob=heads/subspace/*"
@@ -213,4 +231,36 @@ test_expect_success 'rev-list --remotes=foo' '
 
 '
 
+test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
+
+	compare shortlog "subspace/one subspace/two" --branches=subspace &&
+	compare shortlog \
+	  "master subspace-x someref other/three subspace/one subspace/two" \
+	  --branches &&
+	compare shortlog master "--glob=heads/someref/* master" &&
+	compare shortlog "subspace/one subspace/two other/three" \
+	  "--glob=heads/subspace/* --glob=heads/other/*" &&
+	compare shortlog \
+	  "master other/three someref subspace-x subspace/one subspace/two" \
+	  "--glob=heads/*" &&
+	compare shortlog foo/bar --tags=foo &&
+	compare shortlog foo/bar --tags &&
+	compare shortlog foo/baz --remotes=foo
+
+'
+
+test_expect_failure 'shortlog accepts --glob as detached option' '
+
+	compare shortlog \
+	  "master other/three someref subspace-x subspace/one subspace/two" \
+	  "--glob heads/*"
+
+'
+
+test_expect_failure 'shortlog --glob is not confused by option-like argument' '
+
+	compare shortlog master "--glob -e master"
+
+'
+
 test_done
-- 
1.7.5.rc3
