From: David Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] fast-import: add 'ls' command
Date: Fri, 3 Dec 2010 09:51:04 +1100
Organization: Cordelta Pty Ltd
Message-ID: <201012030951.05020.david.barr@cordelta.com>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com> <20101202173722.GE3962@burratino> <7vr5e0q8wm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 23:53:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POI1T-0001oB-4S
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 23:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab0LBWxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 17:53:00 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47443 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab0LBWw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 17:52:59 -0500
Received: by yxt3 with SMTP id 3so3943106yxt.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 14:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=WJtVEm1T9EgRLNyhEh+ma+vynGNKjbMJ3K0qVEFuIUI=;
        b=Aw17NN/9Dy/ZOoQH4LqI+9ZwnN7YRjY1xg6KQDDjcwI9nyyDnTB1SyD8OXWPXf4EYy
         NdHUE2fRDnA4rY2nRkA2f1uudbJD9ILQke48o+FU5CvedvGdUWPh9gNGAZzAkm3Q59PU
         xl8GCZmiJHhALQXTSqnuPnsjseirM7EHdoxjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=BVPG5yEkrTx1mQmlMZDOPhXxyZSlvH63Xw/U/HioRJiiYt4mebjn2mMtavPW/xa/3O
         YKfj/uDDbqiNgeYliwnlHTNAlxYwuuk8uxHo0H9oIN2dadVd5pUxNvhsG5mMvD+m6Cyp
         620jbeyTUpxhw7VLmXuHPPpJR2pLiCZU0hsf8=
Received: by 10.150.140.6 with SMTP id n6mr2411467ybd.356.1291330378471;
        Thu, 02 Dec 2010 14:52:58 -0800 (PST)
Received: from dba.localnet (mailhost.cordelta.com [119.15.97.146])
        by mx.google.com with ESMTPS id q4sm52064yba.14.2010.12.02.14.52.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 14:52:55 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-23-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <7vr5e0q8wm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162751>

> > I somewhat agree.  Actually I would go further: the word "index" brings
> > to mind .git/index and its in-core counterpart, so at the same time as
> > documenting it better, we might look into making it more self-
> > explanatory.  Maybe a syntax like
> >
> >       ls current "path/to/entry"
> >
> > would make it clearer that this is about directory entries in
> > fast-import's active commit and not necessarily the usual index file?
> 
> I think that explains the feature better.  I was wondering if the stream
> somehow wanted to access the state the index of the repository happens to
> be.
> 
> > I am not sure what syntax other vcs-es use for tree-ishes.  To avoid
> > name clashes (what if 'current' is the low-level name of a tree-ish?),
> > an alternative might be
> >
> >       ls-tree :11 "path/to/historical/entry"
> >       ls "path/to/current/entry"
> 
> Is it an option to use "ls" for both cases and treat one-arg and two-arg
> cases differently?

I like that idea, its not hard to implement if we keep quoting mandatory.

--
David Barr.

---
diff --git a/fast-import.c b/fast-import.c
index 854398a..0b0f2a1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2922,8 +2922,7 @@ static void parse_ls(struct branch *b)
 
 	/* ls SP <treeish> SP <path> */
 	p = command_buf.buf + strlen("ls ");
-	if(!prefixcmp(p, "index")) {
-		p += strlen("index");
+	if(*p == '"') {
 		if (!b)
 			die("Not in a commit: %s", command_buf.buf);
 		root = &b->branch_tree;
@@ -2932,9 +2931,9 @@ static void parse_ls(struct branch *b)
 		root = new_tree_entry();
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
 		load_tree(root);
+		if (*p++ != ' ')
+			die("Missing space after tree-ish: %s", command_buf.buf);
 	}
-	if (*p++ != ' ')
-		die("Missing space after SHA1: %s", command_buf.buf);
 	if (unquote_c_style(&uq, p, &p))
 		die("Invalid path: %s", command_buf.buf);
 	if (*p)
