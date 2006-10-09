From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Mon, 9 Oct 2006 09:13:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
 <4529B77A.707@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dongsheng Song <dongsheng.song@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 18:16:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWxmL-0003vi-8u
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 18:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbWJIQNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 12:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbWJIQNd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 12:13:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932967AbWJIQN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 12:13:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k99GDFaX016137
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Oct 2006 09:13:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k99GDE0T003662;
	Mon, 9 Oct 2006 09:13:15 -0700
To: Liu Yubao <yubao.liu@gmail.com>
In-Reply-To: <4529B77A.707@gmail.com>
X-Spam-Status: No, hits=-0.466 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28572>



On Mon, 9 Oct 2006, Liu Yubao wrote:
> 
> IMHO, I don't think keyword substitution is a good idea, as it will confuse
> the external diff/merge tools.

There are other reasons why it's a _horrible_ idea, like the fact that it 
can mess up binary files etc (so if you do keyword substitution, you also 
need to suddenly care _deeply_ whether a file is binary or not).

The whole notion of keyword substitution is just totally idiotic. It's 
trivial to do "outside" of the actual content tracking, if you want to 
have it when doing release trees as tar-balls etc.

So:
 - inside of the SCM, keyword substitution is pointless, since you have 
   much better tools available (like "git log filename")
 - outside of the SCM, keyword substitution can make sense, but doing it 
   should be in helper scripts or something that can easily tailor it for 
   the actual need of that particular project.

For example, we actually do a certain kind of keyword subtituion for the 
kernel. Look at the -git snapshots: the script that generates the snapshot 
diffs has a simple sequence in it to "keyword substitute" the Makefile for 
the EXTRAVERSION flag, so the diff will result in the Makefile having the 
knowledge of which git SHA1 version the resulting patch was, even though 
the thing isn't a git tree any more:

	...
	git-read-tree $CURCOMM
	git-checkout-index Makefile
	perl -pi -e "s/EXTRAVERSION =.*/EXTRAVERSION = $EXTRAVERSION/" Makefile
	git-diff-index -m -p $RELTREE | gzip -9 > $STAGE/patch-$CURNAME.gz
	...

So this is how to do keyword substitution in a _sane_ way.

Sure, we could do something like this as a git script, and support it 
"natively", but the fact is, keyword substitution is just stupid.

		Linus
