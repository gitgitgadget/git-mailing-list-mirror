From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/24] merge script: merge -X<option>
Date: Tue, 17 Aug 2010 02:05:10 -0500
Message-ID: <20100817070510.GP22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGG4-00012J-Sn
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab0HQHGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:06:47 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64815 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129Ab0HQHGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:06:46 -0400
Received: by mail-yx0-f174.google.com with SMTP id 6so2286218yxg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kdeD80zLqKtPYTuC6v0JjvIgxtCghOfY7hRE5bzwKc4=;
        b=rGqXlPjme7Qd4KQQkwIdOevoJIkQi0f55DP/xTZ98AKgrglvdFJmOPrxSz6eooXCIu
         KeaR78+mzOQCC7m/6VIxZkG2/QvECF53OuaPEG9DpI3CCFc4XTaUOej0KQl8c3YcIxhU
         a2mjP2weRlMX0PqiMwFjpoDdq0kT389k3wRqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=p6hVoZq9VAL/bNJ2p7p/btcMTmHP9JAfYufQDn6q10T8NnE0munHfMpIMkXZHBPQ8R
         KgwLyWHsMvGRDlW0KaMxg5vnE/X84CyvpWFxaOfvg9fTzU5Oin5EM8+FYLxWg6Z8NX+g
         KJiiqcC86v1YMovPmaGbMWfP/tH4VIJyxoz0w=
Received: by 10.151.62.5 with SMTP id p5mr6726032ybk.55.1282028806303;
        Tue, 17 Aug 2010 00:06:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 18sm573766ybk.7.2010.08.17.00.06.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:06:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153719>

Without this support, the scripted merge cannot pass t6037.

Based on v1.7.0-rc0~55^2~5 (git merge -X<option>, 2009-11-25).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index d491566..0d53735 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -16,6 +16,7 @@ squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge succeeds (default)
 ff                   allow fast-forward (default)
 s,strategy=          merge strategy to use
+X=                   option for selected merge strategy
 m,message=           message to be used for the merge commit (if any)
 "
 
@@ -40,6 +41,7 @@ default_octopus_strategies='octopus'
 no_fast_forward_strategies='subtree ours'
 no_trivial_strategies='recursive recur subtree ours recursive-ours recursive-theirs'
 use_strategies=
+xopt=
 
 allow_fast_forward=t
 allow_trivial_merge=t
@@ -196,6 +198,10 @@ parse_config () {
 				die "available strategies are: $all_strategies" ;;
 			esac
 			;;
+		-X)
+			shift
+			xopt="${xopt:+$xopt }$(git rev-parse --sq-quote "--$1")"
+			;;
 		-m|--message)
 			shift
 			merge_msg="$1"
@@ -469,7 +475,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy
 
-    git-merge-$strategy $common -- "$head_arg" "$@"
+    eval 'git-merge-$strategy '"$xopt"' $common -- "$head_arg" "$@"'
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
-- 
1.7.2.1.544.ga752d.dirty
