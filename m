From: Ilya Basin <basinilya@gmail.com>
Subject: Re[3]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Fri, 3 May 2013 10:42:48 +0400
Message-ID: <1379019858.20130503104248@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com> <20130501213031.GA13056@dcvr.yhbt.net> <7v1u9q5pu5.fsf@alter.siamese.dyndns.org> <20130502024926.GA12172@dcvr.yhbt.net> <12810110770.20130502213124@gmail.com> <20130502204017.GB26623@dcvr.yhbt.net> <77906182.20130503092642@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 08:44:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9jS-0001g2-In
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103Ab3ECGoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:44:34 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:52229 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762551Ab3ECGod (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:44:33 -0400
Received: by mail-la0-f47.google.com with SMTP id fh20so1240206lab.20
        for <git@vger.kernel.org>; Thu, 02 May 2013 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6P/WDU/Vf4PI+szEod+HC9fxa3YBD0ZG04ZqaQwtYa0=;
        b=BGgoKNGcv1KMA2KR9i5Pg9nxevfYZOJpd+X7mYp4OkDcYKuCMg/+1l3H8frUNXNkOb
         IfR+jEEoX9n5NtEj1YRg/gRDv97fazkvFgKMZ0SCGRIF33KTp36iWSuKwS+Wo/0LXLm5
         CMnNrRMeHY9Q52Pg08wZFSSM2xmafQt2pJGCTVpbTjPhIvVDAIRTr0PJJuDODzXopiER
         uoVDebai94sAkdUAgDBzbc5DcZilPYwAh+A5a1vqyAk9R+Aei1iomXks9ogtb7zhZPPh
         8Vmk0t81Ln4o7fT00Qii3eZvPCuImZnKJgLI/zpgTNR/hALBtVIEnON19KZ0GgbFhXWC
         +aww==
X-Received: by 10.112.89.36 with SMTP id bl4mr3413791lbb.94.1367563472137;
        Thu, 02 May 2013 23:44:32 -0700 (PDT)
Received: from [192.168.0.78] (92-100-233-8.dynamic.avangarddsl.ru. [92.100.233.8])
        by mx.google.com with ESMTPSA id c15sm3693194lbj.17.2013.05.02.23.44.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 23:44:30 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <77906182.20130503092642@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223289>

EW>> Ilya Basin <basinilya@gmail.com> wrote:
>>> Hi. I won't send you updated patches until I import and test my huge
>>> repo. Everything will be here:
>>> https://github.com/basinilya/git/commits/v1.8.2.2-git-svn-fixes
>>> 
>>> At the moment I've decided not to implement the Junio's proposal:
>>> > >> JCH> comment line "# added by git-svn only to keep the directory" and
>>> > >> JCH> consider a directory that has nothing but .gitignore that consists
>>> > >> JCH> of only that exact comment line an "added placeholder" directory to
>>> > >> JCH> work it around.
>>> 
>>> But the config file is not an option too: I have 400 tags, each has
>>> 200 empty folders.
>>> 
>>> Instead I decided to store the paths in a text file (see
>>> https://github.com/basinilya/git/commit/a961aedd81cb8676a52cfe71ccb6eba0f9e64b90 ).
>>> I'm not planning to push this change to you.
>>> 
>>> The last error I encountered is:
>>> r7009 = 39805bb078983e34f2fc8d2c8c02d695d00d11c0 (refs/remotes/DMC4_Basic)
>>> Too many open files: Can't open file '/home/il/builds/sicap/gitsvn/prd_dmc4.svn/db/revs/0/786': Too many open files at /.snapshots/persist/builds/git/git-git/perl/blib/lib/Git/SVN/Ra.pm line 282.
>>> 
>>> I think It's unrelated to empty dirs.

EW>> Can you get an lsof on the git-svn process right before this?
IB>     /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/A4O_OTQxWc
IB>     /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/LfpcENJduN
IB>     /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/Dkk7pN4Mpz
IB>     etc.

EW>> What's your open files limit?
IB> 1024

Why no call to close() from temp_release() in Git.pm?


-- 
