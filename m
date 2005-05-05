From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel nightly snapshots..
Date: Thu, 5 May 2005 09:40:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505050846530.2328@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org> 
 <42797F9F.9030002@zytor.com>  <1115303933.16187.135.camel@hades.cambridge.redhat.com>
  <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org> 
 <1115305813.16187.143.camel@hades.cambridge.redhat.com>
 <1115307033.16187.146.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 18:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTjGv-00069U-H2
	for gcvg-git@gmane.org; Thu, 05 May 2005 18:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVEEQiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 12:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVEEQiw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 12:38:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:41880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262146AbVEEQid (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 12:38:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j45GcPU3030770
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 May 2005 09:38:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j45GcLU2026167;
	Thu, 5 May 2005 09:38:23 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115307033.16187.146.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 5 May 2005, David Woodhouse wrote:
> 
> Eep. That'll be a whole lot more useful if I do
> 	cg-diff -r $RELTREE:$CURTREE
> instead of 
> 	cg-diff -r $CURTREE:$RELTREE
> ... but it should be OK now. This is the md5sum of the correct one:
> 
> 21a0ee13c539e8b016682c1542bb9167  patch-2.6.12-rc3-git1.gz

Btw, if you want to, you could simplify and optimize things heavily by 
doign some very specific git internal mucking around, and using the new 
"-m" flag I added to "git-diff-cache".

The "-m" flag says that a file that isn't checked out will always match 
the cache, which means that you can create your magic diffs that modify 
the Makefile with something like this:

	export SNAP_TAG_DIRECTORY=/pub/linux/kernel/v2.6/snapshots/tags
	export BASE_DIRECTORY=/pub/scm/linux/kernel/git/torvalds/linux-2.6
	export SHA1_FILE_DIRECTORY=$BASE_DIRECTORY/objects

	RELNAME=`ls $BASE_DIRECTORY/refs/tags | tail -1`
	RELCOMM=`cat $BASE_DIRECTORY/refs/tags/$RELNAME`
	CURCOMM=`cat $BASE_DIRECTORY/HEAD`

	SNAPNAME=`ls $SNAP_TAG_DIRECTORY | grep -- "$RELNAME-git" | tail -1`
	if [ "$SNAPNAME" ]; then
		SNAPCOMM=`cat $SNAP_TAG_DIRECTORY/$SNAPNAME`
		[ "$SNAPCOMM" == "$CURCOMM" ] && exit 0
		OLDGITNUM=`echo $SNAPNAME | sed s/^.*-git//`
		NEWGITNUM=`expr $OLDGITNUM + 1`
		CURNAME="$RELNAME-git$NEWGITNUM"
	else
		CURNAME="$RELNAME-git1"
	fi

	EXTRAVERSION=-`echo $CURNAME | cut -f2- -d-`

	rm -rf tmp-empty-tree
	mkdir -p tmp-empty-tree/.git
	( cd tmp-empty-tree
	  git-read-tree $CURCOMM
	  git-checkout-cache Makefile
	  perl -pi -e "s/EXTRAVERSION =.*/EXTRAVERSION = $EXTRAVERSION/" Makefile
	  git-diff-cache -m -p $RELCOMM ) | gzip -9 > patch-$CURNAME.gz

	echo CURCOMM > $SNAP_TAG_DIRECTORY/$CURNAME

but it's entirely untested, and only written in my mail editor, so..

Anyway, here's explaining what it does:

 - it creates a new "tmp-empty-tree" thing, and points the object database 
   to _my_ tree (which is unwritable for you, but you don't care, you just
   want to read it)

 - it picks up my last tag as the release, and your last git tag from your 
   private snapshot tag directory as the last git thing. Then it takes my 
   current HEAD as the new thing to diff.

 - we read that current tree into this empty tree, but we don't check any
   of it out except for the Makefile. So the "tmp-empty-tree" should 
   literally just have the files "Makefile" and ".git/index" in it.

 - we edit the Makefile, and then we do "git-diff-cache -m -p" between the 
   result and the old base.

This _should_ work. Modulo bugs. And it should be reasonably efficient. It 
just needs my current git tree as of five minutes ago..

		Linus
