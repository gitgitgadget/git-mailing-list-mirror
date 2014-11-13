From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/1] Add another option for
 receive.denyCurrentBranch
Date: Thu, 13 Nov 2014 20:21:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411132020570.13845@s15462909.onlinehome-server.info>
References: <cover.1415629053.git.johannes.schindelin@gmx.de> <cover.1415876330.git.johannes.schindelin@gmx.de> <7bd583cb3c7097811cff81cada9720eb30c3585e.1415876330.git.johannes.schindelin@gmx.de> <xmqq7fyz2dlj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 20:22:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xozxv-0002s5-8w
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 20:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933843AbaKMTVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 14:21:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:52532 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171AbaKMTVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 14:21:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LZynd-1YGOlx2OtB-00liAH;
 Thu, 13 Nov 2014 20:21:52 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq7fyz2dlj.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:bl63qykZiK+guyTlyHNXuo14aoYs6gNZe4O8UVrnnVHQwxOaBOH
 K4jnojXyBeGhTrFVkq37qjR6yfTIYmBN/9eQDJuP00SeGo+flx3VpqroJirCV6ExJ+kKcF/
 gHjbKQh+0MqWfe151Vru8ZXZ0+WtMdt2UqY7tBz5Hj2TkZNPnH5oez7R2eCYdPSjdwCmpUd
 ZIgtRG2Y1m0d/YCcmcVlw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 13 Nov 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> > index f4da20a..ba002a9 100755
> > --- a/t/t5516-fetch-push.sh
> > +++ b/t/t5516-fetch-push.sh
> > @@ -1330,4 +1330,21 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
> >  	)
> >  '
> >  
> > +test_expect_success 'receive.denyCurrentBranch = updateInstead' '
> > +	git push testrepo master &&
> > +	(cd testrepo &&
> > +		git reset --hard &&
> > +		git config receive.denyCurrentBranch updateInstead
> > +	) &&
> > +	test_commit third path2 &&
> > +	git push testrepo master &&
> > +	test $(git rev-parse HEAD) = $(cd testrepo && git rev-parse HEAD) &&
> > +	test third = "$(cat testrepo/path2)" &&
> > +	(cd testrepo &&
> > +		git update-index --refresh &&
> > +		git diff-files --quiet &&
> > +		git diff-index --cached HEAD --
> > +	)
> > +'
> > +
> 
> This new feature has two sides.  Update when we can and more
> importantly fail the update safely.  This tests the "success" case,
> but not the "safely fail" one.
> 
> For the latter "test_must_fail git push" on the sending side, and
> "original HEAD stays the same and the working tree changes are
> preserved when there are local changes before the push" on the
> receiving side needs to be tested.

Right.

I have amended this for the upcoming v4 (but I'll wait whether there are
other things I need to change before submitting that):

-- snipsnap --
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ba002a9..b8df39c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1343,8 +1343,12 @@ test_expect_success 'receive.denyCurrentBranch =
updateInstead' '
 	(cd testrepo &&
 		git update-index --refresh &&
 		git diff-files --quiet &&
-		git diff-index --cached HEAD --
-	)
+		git diff-index --cached HEAD -- &&
+		echo changed > path2 &&
+		git add path2
+	) &&
+	test_commit fourth path2 &&
+	test_must_fail git push testrepo master
 '
 
 test_done
