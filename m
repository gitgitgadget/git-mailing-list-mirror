From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 14:39:17 +0100
Message-ID: <200812101439.18526.jnareb@gmail.com>
References: <20081209224622.28106.89325.stgit@localhost.localdomain> <20081210124901.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 14:40:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAPIx-0002Ig-6t
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 14:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYLJNjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 08:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbYLJNjZ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 08:39:25 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:51169 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYLJNjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 08:39:24 -0500
Received: by ewy10 with SMTP id 10so660274ewy.13
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 05:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IGHvL7yb0OkPXOxObfuOrtVDMPKwddVpiGjfMTMfF/M=;
        b=A+GbNOeZ+R6vxxUTWOMRKAAv4GILtFQ11chS4ERz8mO03r75aAnr39vJ2/VAOofS6v
         f9Dj5JnXauJIU7xQCcWcUaLuqBsAE5nq2wTYxNvFAhgE/f7XX3ngwFxcmYDZvpaJ6/eA
         KnyednWU+HibECfEj1fm7LYWTFdkKJcuy3zWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=coWMMrhTnPK1x6/58eo3lHwtjp54kdE3yRI/Vehqyl9tkG9fJpU2MQJ35uwIWSY5II
         +T9iwzF4pI7Lt6pDFhhRE0sM1VCBbkdU27cdweia1mrDB0LTRDriF+rRlDtY21+WeelZ
         v9s10lW5ckgUM0aBJaFAWZZ+EIYrw3H5AUPe8=
Received: by 10.210.10.1 with SMTP id 1mr1643569ebj.126.1228916362113;
        Wed, 10 Dec 2008 05:39:22 -0800 (PST)
Received: from ?192.168.1.11? (abxf60.neoplus.adsl.tpnet.pl [83.8.255.60])
        by mx.google.com with ESMTPS id z37sm1581413ikz.5.2008.12.10.05.39.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 05:39:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20081210124901.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102684>

On Wed, 10 Dec 2008, Nanako Shiraishi wrote:
> Quoting Jakub Narebski <jnareb@gmail.com>:
> 
> > Unfortunately the implementation in 244a70e used one call for
> > git-rev-parse to find parent revision per line in file, instead of
> > using long lived "git cat-file --batch-check" (which might not existed
> > then), or changing validate_refname to validate_revision and made it
> > accept <rev>^, <rev>^^, <rev>^^^ etc. syntax.
> 
> Could you substantiate why this is "Unfortunate"?

Because it calls git-rev-parse once for _each line_, even if for lines
in the group of neighbour lines blamed by same commit $parent_commit
is the same, and even if you need to calculate $parent_commit only once
per unique individual commit present in blame output.
 
> Is the new implementation faster?  By how much?

File               | L[1] | C[2] || Time0[3] | Before[4] | After[4]
====================================================================
blob.h             |   18 |    4 || 0m1.727s |  0m2.545s |  0m2.474s
GIT-VERSION-GEN    |   42 |   13 || 0m2.165s |  0m2.448s |  0m2.071s
README             |   46 |    6 || 0m1.593s |  0m2.727s |  0m2.242s
revision.c         | 1923 |  121 || 0m2.357s | 0m30.365s |  0m7.028s
gitweb/gitweb.perl | 6291 |  428 || 0m8.080s | 1m37.244s | 0m20.627s

File               | L/C  | Before/After
=========================================
blob.h             |  4.5 |         1.03
GIT-VERSION-GEN    |  3.2 |         1.18
README             |  7.7 |         1.22
revision.c         | 15.9 |         4.32
gitweb/gitweb.perl | 14.7 |         4.71

As you can see the greater ratio of lines in file to unique commits
in blame output, the greater gain from the new implementation.

Footnotes:
~~~~~~~~~~
[1] Lines: 
    $ wc -l <file>
[2] Individual commits in blame output:
    $ git blame -p <file> | grep author-time | wc -l
[3] Time for running "git blame -p" (user time, single run):
    $ time git blame -p <file> >/dev/null
[4] Time to run gitweb as Perl script from command line:
    $ gitweb-run.sh "p=git.git;a=blame;f=<file>" > /dev/null 2>&1

Appendix A:
~~~~~~~~~~~
#!/bin/bash

export GATEWAY_INTERFACE="CGI/1.1"
export HTTP_ACCEPT="*/*"
export REQUEST_METHOD="GET"
export QUERY_STRING=""$1""
export PATH_INFO=""$2""

export GITWEB_CONFIG="/home/jnareb/git/gitweb/gitweb_config.perl"

perl -- /home/jnareb/git/gitweb/gitweb.perl

# end of gitweb-run.sh


> When "previous" commit information is available in the output from
> "git blame", can you make use of it? 

Yes, I could; but I don't think it got implemented.
-- 
Jakub Narebski
Poland
