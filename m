From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Re: Race condition with git-status and git-rebase
Date: Tue, 8 Apr 2014 22:20:12 +0300
Message-ID: <20140408191914.GA7630@abyss.hitronhub.home>
References: <20140408184421.GD5208@abyss.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 21:20:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXbZQ-0002am-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 21:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396AbaDHTUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 15:20:24 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:41781 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285AbaDHTUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 15:20:23 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so1061530eei.14
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MaWO4wZdrWeLXho0Hm2gHYjKYjcB1p4H9jaqoSkzNVo=;
        b=tbxfxAYLFGbVd8Z5lmPy+OSRq8l0EOF6uFJKGamKwCirfruW9kPyYwgaqnBDIs3tSE
         FxUflI9aTNZT+e4zS740HI7t6Q+UV8SNrG17fcD+i5KmhAjlc6OH5M6owoJFbti9w3co
         hyC4K7t0UcZqj1BQXqQmFRQwxLpCcFK0ANDPeFilljA8K/d9PL6SQ5D/VgIGwTLuzgxo
         Uz456p5oFi4vwL1W1+YEs4Yi3EmvKviJKsPVqKPFn7E9P/pN/mugu24O4nc/cVpDkynN
         q+1x2Wr73BFgMTkeunYf955JHAazhupebdVwgzT7KZNgmHF5WVUm8E+KRQ87TbS8IzS+
         srlg==
X-Received: by 10.14.113.194 with SMTP id a42mr2553335eeh.115.1396984822340;
        Tue, 08 Apr 2014 12:20:22 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id n41sm6471009eeg.4.2014.04.08.12.20.20
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Apr 2014 12:20:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140408184421.GD5208@abyss.hitronhub.home>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245950>

Maybe you will find it useful: this is one way that I use to manually
debug the race condition (and it works in Linux):

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..c0511f6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1283,6 +1283,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_status_usage, builtin_status_options);
 
 	status_init_config(&s, git_status_config);
+	printf("read_cache() finished, press enter to continue.\n");
+	getchar();
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index df46f4c..6ffd986 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -61,8 +61,8 @@ else
 		return $?
 	fi
 
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
-		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
+	git am $git_am_opt -i --rebasing --resolvemsg="$resolvemsg" \
+		${gpg_sign_opt:+"$gpg_sign_opt"} "$GIT_DIR/rebased-patches"
 	ret=$?
 
 	rm -f "$GIT_DIR/rebased-patches"
diff --git a/read-cache.c b/read-cache.c
index ba13353..a6f73a7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1778,6 +1778,8 @@ static int has_racy_timestamp(struct index_state *istate)
  */
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
+	printf("cache_changed: %d  has_racy_timestamp: %d\n",
+	       istate->cache_changed, has_racy_timestamp(istate));
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
 	    !write_index(istate, lockfile->fd))
 		commit_locked_index(lockfile);
