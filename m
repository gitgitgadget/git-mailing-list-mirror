From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Sat, 31 Jul 2010 13:48:36 +1000
Message-ID: <AANLkTi=HGqwg1HUMej-NeYgCf2454erOo1EYp7z-LT1D@mail.gmail.com>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
	<20100730013534.GB2182@burratino>
	<AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
	<20100730195022.GB2448@burratino>
	<20100731010439.GB5817@burratino>
	<AANLkTi=n-LYGiYw=g4QsO=9GtvzHc8Vn=m99pcDR5r00@mail.gmail.com>
	<20100731033339.GB1607@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 05:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of348-0002Dq-Un
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 05:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab0GaDsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 23:48:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62128 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab0GaDsh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 23:48:37 -0400
Received: by wyb39 with SMTP id 39so1787717wyb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xAMPs41Bc73qhGvwDQ5HZLOhwhYQn4Z2U/Q2hZVCzKE=;
        b=j552mxQQxTglij5srRARm7xPwQMcTknwD6SVUn/+eTIo+rML1nJUok4lCHrxawtjgn
         M0CQxEP2LWoaW6sRRNTr7wbv5EAHu0JExvwX62Gm+7KXWMOaDbUGuVu9T0xLrVQKnvtH
         uPCvfSXdlIknJ0nr/gUuoImjU0Nfu/SJE6CTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=awSfwPQTFQpkRtnooT0NeUbDbDaTc/p+3HKinmmRHMrups+OuKQG9edMwAa+VBKRvz
         tLw7zlm4/PL7Watzmgy/xDEKKIMoz1GF4uRHkscVdL4qtn41CMrtUYPrt9LlwLoYHfdh
         33Ua3HYDq2E9gVGW9gh9Lug4SG9FfMWACi2mo=
Received: by 10.216.30.207 with SMTP id k57mr2425527wea.88.1280548116138; Fri, 
	30 Jul 2010 20:48:36 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 30 Jul 2010 20:48:36 -0700 (PDT)
In-Reply-To: <20100731033339.GB1607@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152298>

On Sat, Jul 31, 2010 at 1:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Nguyen Thai Ngoc Duy wrote:
>
>> maybe we should move the CE_UPDATE/CE_WT_REMOVE removal code into
>> apply_sparse_checkout().
>
> Not a bad idea regardless.

Yeah, something like this, perhaps. It's not tested. I'll repost the
patch later, incorporating all your suggestions.

diff --git a/unpack-trees.c b/unpack-trees.c
index f2d148c..48654b3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -153,6 +153,26 @@ static int apply_sparse_checkout(struct
cache_entry *ce, struct unpack_trees_opt
 		ce->ce_flags &= ~CE_SKIP_WORKTREE;

 	/*
+	 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
+	 * area as a result of ce_skip_worktree() shortcuts in
+	 * verify_absent() and verify_uptodate().
+	 * Make sure they don't modify worktree if they are already
+	 * outside checkout area
+	 */
+	if (was_skip_worktree && ce_skip_worktree(ce)) {
+		ce->ce_flags &= ~CE_UPDATE;
+
+		/*
+		 * By default, when CE_REMOVE is on, CE_WT_REMOVE is also
+		 * on to get that file removed from both index and worktree.
+		 * If that file is already outside worktree area, don't
+		 * bother remove it.
+		 */
+		if (ce->ce_flags & CE_REMOVE)
+			ce->ce_flags &= ~CE_WT_REMOVE;
+	}
+
+	/*
 	 * We only care about files getting into the checkout area
 	 * If merge strategies want to remove some, go ahead, this
 	 * flag will be removed eventually in unpack_trees() if it's
@@ -793,19 +813,7 @@ int unpack_trees(unsigned len, struct tree_desc
*t, struct unpack_trees_options
 				ret = -1;
 				goto done;
 			}
-			/*
-			 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
-			 * area as a result of ce_skip_worktree() shortcuts in
-			 * verify_absent() and verify_uptodate().
-			 * Make sure they don't modify worktree.
-			 */
-			if (ce_skip_worktree(ce)) {
-				ce->ce_flags &= ~CE_UPDATE;
-
-				if (ce->ce_flags & CE_REMOVE)
-					ce->ce_flags &= ~CE_WT_REMOVE;
-			}
-			else
+			if (!ce_skip_worktree(ce))
 				empty_worktree = 0;

 		}
-- 
Duy
