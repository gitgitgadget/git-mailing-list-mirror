From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/24] merge script: handle --no-ff --no-commit correctly
Date: Tue, 17 Aug 2010 02:11:03 -0500
Message-ID: <20100817071103.GV22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGLk-0003Db-Li
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab0HQHMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:12:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57437 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0HQHMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:12:38 -0400
Received: by ywh1 with SMTP id 1so2274283ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sdP/tl2oARrG3gN/+VPVrel7YnWuMwWcubTPcErW8Kg=;
        b=XNkglic4heVM5rq+a8wicn5sIn69/jwzSRhTw26qIxqoBqY/xANwsqbJN1gj9dmNjv
         BTyCZ6OpEHYZ+RwzzD+1ojJJW/6Uv/fkc2XE6pKBLYi45OBabuJbLO6JQ6yqKfHJNSnq
         TeCmwWJkOlm63S+jRFcwMtZU37ZHO75WHWZf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GwUQJ3W5ieRqIU3xw/CtuBc2AofsY1oFn9S3WEie7LeU+oZsngcaRqBRQEDFC9m+kl
         LtLRgpskU3+SbYKV1A5FaCe3IfN9XVvz6+9PU04bZ1ucxvDHg89W6a2olSFQof9q/4qH
         lWmp4CJqy7Obg7XiuPOpR2z1vHaZm7pBazkow=
Received: by 10.101.8.8 with SMTP id l8mr7103386ani.84.1282029158303;
        Tue, 17 Aug 2010 00:12:38 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i30sm11769969anh.29.2010.08.17.00.12.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:12:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153725>

In a --no-ff merge with conflicts, "git commit" used to forget the
--no-ff when used to complete the merge.  That was fixed by
v1.6.1-rc1~134^2 (builtin-commit: use reduce_heads() only when
appropriate, 2008-10-03) for the builtin merge.  Port the change to
the merge script in contrib/examples.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index dfd6e17..5a2addd 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -52,7 +52,7 @@ squash= no_commit= log_arg=
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
-		 "$GIT_DIR/MERGE_STASH" || exit 1
+		 "$GIT_DIR/MERGE_STASH" "$GIT_DIR/MERGE_MODE" || exit 1
 }
 
 savestate() {
@@ -585,7 +585,15 @@ else
 	do
 		echo $remote
 	done >"$GIT_DIR/MERGE_HEAD"
-	printf '%s\n' "$merge_msg" >"$GIT_DIR/MERGE_MSG"
+	printf '%s\n' "$merge_msg" >"$GIT_DIR/MERGE_MSG" ||
+		die "Could not write to $GIT_DIR/MERGE_MSG"
+	if test "$allow_fast_forward" != t
+	then
+		printf "%s" no-ff
+	else
+		:
+	fi >"$GIT_DIR/MERGE_MODE" ||
+		die "Could not write to $GIT_DIR/MERGE_MODE"
 fi
 
 if test "$merge_was_ok" = t
-- 
1.7.2.1.544.ga752d.dirty
