From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5] Add default merge options for all branches
Date: Fri, 6 May 2011 16:59:47 -0500
Message-ID: <20110506215946.GF20182@elie>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <7v7ha3zhv0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIT42-0004EX-8c
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338Ab1EFV7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 17:59:53 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37005 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1EFV7w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 17:59:52 -0400
Received: by gyd10 with SMTP id 10so1341433gyd.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5vJmeQmYnmJmNALKh5809Su/htF8v+naPZexaOVywcI=;
        b=KiDmvTSBpVYVboIDMhs26GsogMeDmzqg+5Ky6f6NrcUQwU9K15tBVHX8Bq6QkNPiGa
         JOESliT2vAQuTcSUrWsRgUj8FhaL9G07XUw81N9WL8E2FEzqYZBG1D7SRgYjfigjOf6p
         AUc8YfyoNZI2guOCJ3RFvTci4ZiEXhqdCPxl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BcVx+ostkx/Kpsvns+A0JNwheDgiALMfVPWt3yLPXG4Sa9SuGpVYQIrqi+CDbuCmid
         hnN2PsmP8eDPoEpYZTLH3DmjHdNAsA/S4VRrySi99OTnWa99vXfQsotgyQnYUKBPfipt
         p9XD/bWPkxfzWm9xu8ccNgaAIgIanPdmOVexw=
Received: by 10.236.154.197 with SMTP id h45mr5087174yhk.397.1304719191936;
        Fri, 06 May 2011 14:59:51 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id i21sm1679491yha.89.2011.05.06.14.59.50
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 14:59:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7ha3zhv0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173017>

Junio C Hamano wrote:

> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -16,6 +16,16 @@ merge.defaultToUpstream::
>  	to their corresponding remote tracking branches, and the tips of
>  	these tracking branches are merged.
>  
> +merge.ff::
[...]
> +	line). When set to `only`, only such fast-forward merges are
> +	allowed (equivalent to giving the `--ff-only` option from the
> +	command line).

A habitual "git pull" user that uses git in a read-only fashion to get
the latest development snapshot of a project's code would probably
find this handy.

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -550,6 +550,15 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  		if (is_bool && shortlog_len)
>  			shortlog_len = DEFAULT_MERGE_LOG_LEN;
>  		return 0;
> +	} else if (!strcmp(k, "merge.ff")) {
> +		int boolval = git_config_maybe_bool(k, v);
> +		if (0 <= boolval) {
> +			allow_fast_forward = boolval;
> +		} else if (v && !strcmp(v, "only")) {
> +			allow_fast_forward = 1;
> +			fast_forward_only = 1;
> +		} /* do not barf on values from future versions of git */

Perhaps deserves a test, like so (meant for squashing)?

-- >8 --
Subject: tests: check git does not barf on merge.ff values for future versions of git

Maybe some day in the future we will want to support a syntax
like

	[merge]
		ff = branch1
		ff = branch2
		ff = branch3

in addition to the currently permitted "true", "false", and "only"
values.  So make sure we continue to treat such configurations as
though an unknown variable had been defined rather than erroring out,
until it is time to implement such a thing, so configuration files
using such a facility can be shared between present and future git.

While at it, add a few missing && and start the "combining --squash
and --no-ff" test with a known state so we can be sure it does not
succeed or fail for the wrong reason.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7600-merge.sh |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 89e0b77..1e20f2e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -35,6 +35,7 @@ printf '%s\n' 1 2 3 4 5 6 7 8 '9 X' >file.9
 printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >result.1
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
+>empty
 
 create_merge_msgs () {
 	echo "Merge commit 'c2'" >msg.1-5 &&
@@ -475,8 +476,8 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'combine branch.master.mergeoptions with merge.ff' '
 	git reset --hard c0 &&
-	git config branch.master.mergeoptions --ff
-	git config merge.ff false
+	git config branch.master.mergeoptions --ff &&
+	git config merge.ff false &&
 	test_tick &&
 	git merge c1 &&
 	git config --remove-section "branch.master" &&
@@ -485,7 +486,18 @@ test_expect_success 'combine branch.master.mergeoptions with merge.ff' '
 	verify_parents "$c0"
 '
 
+test_expect_success 'tolerate unknown values for merge.ff' '
+	git reset --hard c0 &&
+	git config merge.ff something-new &&
+	test_tick &&
+	git merge c1 2>message &&
+	git config --remove-section "merge" &&
+	verify_head "$c1" &&
+	test_cmp empty message
+'
+
 test_expect_success 'combining --squash and --no-ff is refused' '
+	git reset --hard c0 &&
 	test_must_fail git merge --squash --no-ff c1 &&
 	test_must_fail git merge --no-ff --squash c1
 '
-- 
1.7.5.1
