From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 24/24] merge script: learn --[no-]rerere-autoupdate
Date: Tue, 17 Aug 2010 02:13:40 -0500
Message-ID: <20100817071340.GX22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGOb-0004EV-CT
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab0HQHPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:15:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55404 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab0HQHPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:15:21 -0400
Received: by yxg6 with SMTP id 6so2289746yxg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lpwW4tJT03835S375OZp1ZKLYx5bFM2OaxaFDuCuzRI=;
        b=tPfqoqP0qX0olrmcawCx6VVRJWt2PtiEFzYTEe5Z+m6tleVhWqObG9UkjV1ViwFoau
         SxYN/Jp9aXtvEsml3WrPPqQsik43UKDerFONy8Qqotbj7FcFn5pEZr1wkegvv5Lnkdkm
         VrNU00vObM1bATMkr991bvTS3d+I+nHCRejtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OxaQWNuoSfDebk0B1LVL1L2a6Q+cSntfsvaBvLrLSr9KrbC49CjsThWN+ayUXsl59S
         jQ+5Nqebukmo4WHfAo3y13jwmB5HeGDlIJD/3uJkgCSZnW9bacv6pyTtR0nj77EU8RcW
         23TrfmNA9guga5H3ZnCl6xQczHknvmWYKKXLg=
Received: by 10.101.75.5 with SMTP id c5mr7029117anl.190.1282029320541;
        Tue, 17 Aug 2010 00:15:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f22sm11784666anh.4.2010.08.17.00.15.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:15:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153727>

Port v1.7.0-rc0~83^2 (Teach --[no-]rerere-autoupdate option to
merge, revert and friends, 2009-12-04) to the example merge script.

After this change, all tests pass for me with the scripted
merge.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
To test: remove cmd_merge from the builtins list in git.c,
build git, and then run:

 cp contrib/examples/git-merge.sh .
 make SCRIPT_SH=git-merge.sh git-merge
 cd t && make

That's the end of the series.  Thanks for reading.

 contrib/examples/git-merge.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index bed55a4..7b922c3 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -16,6 +16,7 @@ squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge succeeds (default)
 ff                   allow fast-forward (default)
 ff-only              abort if fast-forward is not possible
+rerere-autoupdate    update index with any reused conflict resolution
 s,strategy=          merge strategy to use
 X=                   option for selected merge strategy
 m,message=           message to be used for the merge commit (if any)
@@ -48,7 +49,7 @@ xopt=
 allow_fast_forward=t
 fast_forward_only=
 allow_trivial_merge=t
-squash= no_commit= log_arg=
+squash= no_commit= log_arg= rr_arg=
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -200,6 +201,8 @@ parse_config () {
 			test "$allow_fast_forward" != f ||
 				die "You cannot combine --ff-only with --no-ff."
 			fast_forward_only=t ;;
+		--rerere-autoupdate|--no-rerere-autoupdate)
+			rr_arg=$1 ;;
 		-s|--strategy)
 			shift
 			case " $all_strategies " in
@@ -612,6 +615,6 @@ Conflicts:
 		sed -e 's/^[^	]*	/	/' |
 		uniq
 	} >>"$GIT_DIR/MERGE_MSG"
-	git rerere
+	git rerere $rr_arg
 	die "Automatic merge failed; fix conflicts and then commit the result."
 fi
-- 
1.7.2.1.544.ga752d.dirty
