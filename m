From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 11:56:22 +0530 (IST)
Message-ID: <16219.81556.qm@web95005.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: GIT SCM <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 08:27:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf7Yc-0000Mt-WD
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 08:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbYIOG00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 02:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYIOG00
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 02:26:26 -0400
Received: from n2b.bullet.mail.in2.yahoo.com ([203.104.19.41]:46305 "HELO
	n2b.bullet.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751187AbYIOG0Z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 02:26:25 -0400
Received: from [202.86.4.170] by n2.bullet.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 06:26:23 -0000
Received: from [203.104.18.53] by t1.bullet.in.yahoo.com with NNFMP; 15 Sep 2008 06:26:23 -0000
Received: from [127.0.0.1] by omp105.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 06:26:23 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 129909.11841.bm@omp105.mail.in2.yahoo.com
Received: (qmail 82095 invoked by uid 60001); 15 Sep 2008 06:26:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=th/lDJYpKHx4ASQkY9s6Aglrg/ZCnWgyQ2cEbHYyS+JhqlNCKuHrY6LSv4gbLcOGng9i5ucFS4mvvS1plL4/nLB9ocsNekCbn5Gtvi2ULCkik9lgoRc/GvjYOsUATuz0sMg2dhyWs494b43BODox7yw1Nzh4FVeIlRNw/N+yujQ=;
X-YMail-OSG: C0x3uzIVM1m2t4_ueno3IHD0fla2nSudDXoh8K4tODXVzeg.MlPw5wyRCyWD5bwr8w--
Received: from [202.3.112.9] by web95005.mail.in2.yahoo.com via HTTP; Mon, 15 Sep 2008 11:56:22 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95880>

Hi,

 If you have p4 files with 'ktext' enabled, it will expand RCS keywords. Here is how it goes wrong.

1. Clone from p4 with files of 'ktext' type
2. git-p4, converts "$Id:........" to "$Id$"
3. So, the file in p4 and git are different as RCS keywords are modified
4. You locally edit and commit into git a p4 file of type 'ktext'
5. The change history in your local git commit will not have any hunks to track the RCS keyword as they are not modified locally
6. Someone edits the same file on p4 and submits
7. you do a git rebase (which pulls in the new modifications and strips the RCS keyword change, p4 submit would have incremented the $Id:....$)
8. The git diffs is now not aware of the change in RCS keyword
9. You try to submit your local changes back to p4
10. Applying your local changes as patch sets will fail with missing hunks tracking RCS keyword changes

I have personally experienced more often and hence decided to dig into git-p4 and fix it. All C/C++ source code is created in our p4 repo as 'ktext' and I keep stumbling on this very often. Ideally, if they were just 'text' type in p4, I would never have seen this problem. 

-dhruva

PS: Simon Hausmann, I missed adding you in CC of the patch as my .gitconfig was still under stablizing. I apologize for that. I have finally set up my ..gitconfig with 'git-p4' identity to add you in loop when I submit.


----- Original Message ----
> From: David Brown <git@davidb.org>
> To: Dhruva Krishnamurthy <dhruva@ymail.com>
> Cc: GIT SCM <git@vger.kernel..org>; Junio C Hamano <gitster@pobox.com>
> Sent: Monday, 15 September, 2008 11:39:55 AM
> Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
> 
> On Mon, Sep 15, 2008 at 11:28:51AM +0530, Dhruva Krishnamurthy wrote:
> 
> >Modifying RCS keywords prevents submitting to p4 from git due to missing hunks.
> >New option git-p4.kwstrip set to true or false controls the behavior.
> 
> I'm a little curious about what the problem here is.  I've been
> stripping keywords out of P4 and submitting changes for many years,
> and never had a problem.
> 
> I'm just wondering if we're not fixing the wrong problem here.
> 
> David
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Connect with friends all over the world. Get Yahoo! India Messenger at http://in.messenger.yahoo.com/?wm=n/
