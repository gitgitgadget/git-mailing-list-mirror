From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Tue, 3 May 2005 19:50:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031947530.26698@ppc970.osdl.org>
References: <E1DSDER-0000kS-00@gondolin.me.apana.org.au> <4274FB10.6090600@dwheeler.com>
 <20050502091027.6753998e.pj@sgi.com> <427833AE.6030505@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Jackson <pj@sgi.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 04:42:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT9pt-0007D3-0m
	for gcvg-git@gmane.org; Wed, 04 May 2005 04:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVEDCsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 22:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEDCsQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 22:48:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:40075 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261441AbVEDCsL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 22:48:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j442m7U3014864
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 19:48:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j442m6iG032633;
	Tue, 3 May 2005 19:48:06 -0700
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <427833AE.6030505@dwheeler.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, David A. Wheeler wrote:
> 
> I wonder, does a top-level trap work? E.g.:
>   trap "" SIGPIPE

No.

But putting the traps _inside_ the loops seems to help. So something like 
the appended at least makes it somewhat useful

And yes, you need them at both levels, it appears. Or maybe that just 
changes the timing enough. Whatever.

			Linus
----
Index: cg-log
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-log  (mode:100755 sha1:aa2abf370753117a350818dbc91991b14d30ec6b)
+++ uncommitted/cg-log  (mode:100755)
@@ -47,10 +47,12 @@
 fi
 
 $revls | $revsort | while read time commit parents; do
+	trap "exit 1" SIGPIPE
 	[ "$revfmt" = "git-rev-list" ] && commit="$time"
 	echo $colheader""commit ${commit%:*} $coldefault;
 	git-cat-file commit $commit | \
 		while read key rest; do
+			trap "exit 1" SIGPIPE
 			case "$key" in
 			"author"|"committer")
 				if [ "$key" = "author" ]; then
