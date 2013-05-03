From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Fri, 3 May 2013 09:26:42 +0400
Message-ID: <77906182.20130503092642@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com> <20130501213031.GA13056@dcvr.yhbt.net> <7v1u9q5pu5.fsf@alter.siamese.dyndns.org> <20130502024926.GA12172@dcvr.yhbt.net> <12810110770.20130502213124@gmail.com> <20130502204017.GB26623@dcvr.yhbt.net>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 03 07:28:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY8Xq-0004RF-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 07:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab3ECF2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 01:28:24 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:58971 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab3ECF2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 01:28:24 -0400
Received: by mail-la0-f48.google.com with SMTP id eg20so1215847lab.35
        for <git@vger.kernel.org>; Thu, 02 May 2013 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=G6zUx3i82557PwcnGYtwruuT3GXP/HRJ2oGrArbjYsQ=;
        b=p0MEgZ2wLiOXtUszLJHNgpVFp9bcwGv7qj/H7MKjLNL8WFl25a2gCN0E5h46WgD7kL
         o3EhmVgHa6NFHz9deauAXQ0RkriSg/XJLlK7lX8yRm9dmuDeerILWz5JmGFYy3In1QGA
         DFMHo8awMl5Pu/IKP04VGNJtuwrgAFDRpZRg+NJpt2T4TI0eIzWjaknv7UQ3LMAXcpBi
         hCdtfafH7iZOXUA/1a9mtgXu4IwtEb+HpW98iarFULfZp8DGYWoM2gUNgpyrVrlwXQJ0
         JgcjomO3HB7+reXW/pdZIV/XqXvTKttdP8WS0+obTvNZ8d9zQ45/fQTXzuEisQWANN8C
         nOyg==
X-Received: by 10.112.168.197 with SMTP id zy5mr3771604lbb.18.1367558902405;
        Thu, 02 May 2013 22:28:22 -0700 (PDT)
Received: from [192.168.0.78] (92-100-239-74.dynamic.avangarddsl.ru. [92.100.239.74])
        by mx.google.com with ESMTPSA id h2sm3751051lah.4.2013.05.02.22.28.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 22:28:20 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130502204017.GB26623@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223280>

EW> Ilya Basin <basinilya@gmail.com> wrote:
>> Hi. I won't send you updated patches until I import and test my huge
>> repo. Everything will be here:
>> https://github.com/basinilya/git/commits/v1.8.2.2-git-svn-fixes
>> 
>> At the moment I've decided not to implement the Junio's proposal:
>> > >> JCH> comment line "# added by git-svn only to keep the directory" and
>> > >> JCH> consider a directory that has nothing but .gitignore that consists
>> > >> JCH> of only that exact comment line an "added placeholder" directory to
>> > >> JCH> work it around.
>> 
>> But the config file is not an option too: I have 400 tags, each has
>> 200 empty folders.
>> 
>> Instead I decided to store the paths in a text file (see
>> https://github.com/basinilya/git/commit/a961aedd81cb8676a52cfe71ccb6eba0f9e64b90 ).
>> I'm not planning to push this change to you.
>> 
>> The last error I encountered is:
>> r7009 = 39805bb078983e34f2fc8d2c8c02d695d00d11c0 (refs/remotes/DMC4_Basic)
>> Too many open files: Can't open file '/home/il/builds/sicap/gitsvn/prd_dmc4.svn/db/revs/0/786': Too many open files at /.snapshots/persist/builds/git/git-git/perl/blib/lib/Git/SVN/Ra.pm line 282.
>> 
>> I think It's unrelated to empty dirs.

EW> Can you get an lsof on the git-svn process right before this?
    /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/A4O_OTQxWc
    /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/LfpcENJduN
    /.snapshots/persist/builds/sicap/gitsvn/aaa/.git/Dkk7pN4Mpz
    etc.

EW> What's your open files limit?
1024

-- 
