From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in
 .git/info/exclude
Date: Mon, 21 Nov 2011 15:17:01 +0700
Message-ID: <20111121081701.GA7985@do>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org>
 <4EC9FC81.3080306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 21 09:17:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSP4H-0003RD-0B
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 09:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab1KUIRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 03:17:11 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54955 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab1KUIRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 03:17:09 -0500
Received: by iage36 with SMTP id e36so6970955iag.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/JKcsc5sN6ADcobXI1WlEdpSYVpbL/yjIB5NLdIoyOY=;
        b=wGFnNXJ8FlDbGjYrkUBMXyEv/R6GGSW5sow9SxLZjDw2rkGFXJIXc1vSwMDZqfJ18f
         G6R4XMC1AGV4/b3LuENHuwX37XETPb83V4epQRtb4eS1DMtL0homlydYwsM5IDE63Ic7
         0OpErFQ5evDwIC/GaXLMpbUbd/BlM8Mr1bkEo=
Received: by 10.231.29.79 with SMTP id p15mr3017682ibc.16.1321863429073;
        Mon, 21 Nov 2011 00:17:09 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.42.172])
        by mx.google.com with ESMTPS id a2sm24767711igj.7.2011.11.21.00.17.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 00:17:07 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 21 Nov 2011 15:17:01 +0700
Content-Disposition: inline
In-Reply-To: <4EC9FC81.3080306@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185737>

On Mon, Nov 21, 2011 at 08:23:45AM +0100, Johannes Sixt wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> It is an unintended accident that entries matched by .git/info/exclude are
> considered precious, but entries matched by .gitignore are not. That is,
> 'git checkout' will overwrite untracked files matched by .gitignore, but
> refuses to overwrite files matched by .git/info/exclude.
> 
> It is a lucky accident: it allows the distinction between "untracked but
> precious" and "untracked and garbage". And it is a doubly lucky accident:
> .gitignore entries are meant for files like build products, which usually
> affect all consumers of a repository, whereas .git/info/exclude is
> intended for personal files, which frequently are precious (think of a
> TODO file).
> 
> Add a test that codifies the accident as wanted behavior.

If you want to keep this accident (which is a bug to me), you may want
to add the reason: callers to unpack_trees() are supposed to also
setup exclude rules in .git/info/exclude before calling
unpack_trees(), which they don't.

So .git/info/exclude is entirely dismissed. This patch makes t2023.3
fail. I haven't dug into history to see if this is on purpose though.

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a80772..c2fc2ba 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -412,6 +412,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir = ".gitignore";
+		if (!access(git_path("info/exclude"), R_OK))
+			add_excludes_from_file(topts.dir, git_path("info/exclude"));
 		tree = parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   EMPTY_TREE_SHA1_BIN);
-- 8< --
--
Duy
