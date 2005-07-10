From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.7
Date: Sun, 10 Jul 2005 05:25:30 -0700 (PDT)
Message-ID: <20050710122531.15175.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 14:26:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drasa-0001Q1-OL
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 14:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVGJMZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 08:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVGJMZi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 08:25:38 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:30068 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261922AbVGJMZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 08:25:35 -0400
Received: (qmail 15177 invoked by uid 60001); 10 Jul 2005 12:25:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wk8qTu9V/xuhJWNP3jxr7KhOULq0yMQLe5GJGjsACPMcT5dHoghkdUKIsIxrjY9TmX6Ml20+yMvzC1XcfivywP1neuoKsHp73Sl0785DIGklfQe8o+bXXWeEmkfdPOTktqNF7jwumFC0kzxxCySr1mWqPaf0g/ybkHeJ9AsoxI0=  ;
Received: from [151.42.108.207] by web26303.mail.ukl.yahoo.com via HTTP; Sun, 10 Jul 2005 05:25:30 PDT
To: mingo@elte.hu
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar wrote:

>
>the bad news: except for annotations. I started qgit in the current 
>kernel GIT repository, and clicked on the following commit:
>
>  5bbcfd9000887c0da7d57cc7b3ac869fc0dd5aa9
>
>then i clicked on sched.c to see the annotated file. 

Interesting enough sched.c is one of the files I used as my internal test of
annotate function.

I test again annotate with commit 5bbcfd9000887c0da7d57cc7b3ac869fc0dd5aa9 but
 my numbers are:

123 revisions in history list

4 seconds to show file content of rev 5bbcfd9000887c0da7d57cc7b3ac869fc0dd5aa9

16 seconds after annotate is shown

No 'Merge' string found

And no freeze at all on my box also because of some calls
to main event loop (qApp->processEvents()) scattered along the heaviest routines.

So I cannot reproduce the bug. Please can you be so kind to apply this:

--- a/src/annotate.cpp
+++ b/src/annotate.cpp
@@ -198,7 +198,7 @@ void Annotate::getReachability(ReachList
 			}
 		}
 	}
-	//printReachList(rl);
+	printReachList(rl);
 }
 
 QString Annotate::getRoot(SRef sha, const ReachList& rl) {


and send me the output?


>
>then the annotations were plain wrong. Almost all lines are attributed 
>to Tony Luck, while much of the file comes from the initial repository.  
>So something's quite fishy here. 

This is just a choice, peraphs wrong ;-). Because it is possible to call
annotate at any time, also while loading, snapshotting the history,
 there is no a univoque meaning of "Inital import" so I choose first rev in list's author
instead. But anyway, this is the patch (above the first one)

--- a/src/annotate.cpp
+++ b/src/annotate.cpp
@@ -273,7 +273,7 @@ QStringList Annotate::getFirstAnnotation
 	QString fileSHA = rf.filesSHA[pos];
 	git->getFile(fileSHA, NULL, true); // calls mainExec and event loop
 	int lineNum = git->mainBuffer.contains('\n');
-	QString author = getAuthor(shaHist[idx], shaHist);
+	QString author = "Initial import";
 	QStringList first;
 	first.insert(first.begin(), lineNum, author);
 	return first;



Also, a number of lines were attributed 
>to 'merge', which isnt very informative.
>

This is not a choice but a bad behaviour. 'Merge' is used as author name
as a mark to help unify() routine to join 2 branches annotations and
should be substituted by second branch author if everything it is ok.
This is not your case ;-).


Marco






		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 
