From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] Disconnect stash from its base commit
Date: Thu, 3 Jul 2008 01:24:01 +0530
Message-ID: <20080702195401.GA17214@toroid.org>
References: <20080702195947.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0807021447200.9925@racer> <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE8Pw-00074s-FY
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYGBTyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYGBTyF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:54:05 -0400
Received: from fugue.toroid.org ([85.10.196.113]:42671 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbYGBTyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:54:04 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id DFEE255840C;
	Wed,  2 Jul 2008 21:54:01 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 3B314ADC305; Thu,  3 Jul 2008 01:24:01 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87187>

At 2008-07-02 12:01:35 -0700, gitster@pobox.com wrote:
>
> 	But that imaginary "stash branch" command would always give you
> 	the exact state you were in and creates a clean fork to finish
> 	what you were doing, and continue.

Nice idea. Something as simple as the appended diff?

I reversed the stash/branch arguments so that one need specify only the
branch name. Playing with it a little, it feels very useful.

-- ams

diff --git a/git-stash.sh b/git-stash.sh
index 4938ade..d5ecd24 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -218,6 +218,21 @@ drop_stash () {
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
 }
 
+apply_to_branch () {
+	have_stash || die 'Nothing to apply'
+
+	test -n "$1" || die 'No branch name specified'
+	branch=$1
+
+	if test -z "$2"
+	then
+		set x "$ref_stash@{0}"
+	fi
+	stash=$2
+
+	git-checkout -b $branch $stash^ && apply_stash $stash
+}
+
 # Main command set
 case "$1" in
 list)
@@ -264,6 +279,10 @@ pop)
 		drop_stash "$@"
 	fi
 	;;
+branch)
+	shift
+	apply_to_branch "$@"
+	;;
 *)
 	if test $# -eq 0
 	then
