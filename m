From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test gitweb output
Date: Sat, 14 Jun 2008 20:59:52 +0200
Message-ID: <200806142059.52373.jnareb@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <200806142007.35288.jnareb@gmail.com> <48540E70.4030507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 21:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7azw-0004ov-96
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 21:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbYFNS75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYFNS75
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:59:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:65396 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYFNS74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:59:56 -0400
Received: by ug-out-1314.google.com with SMTP id h2so226799ugf.16
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lZf8xWP1gKCgAb4PKBNqUvrEW6wRKI5P052qxfK4o3o=;
        b=iczjAiDteRM+aneizZ5X4yGnRaGru4dB8QB+66las4la/nDHRaPHV13361BNeRYUkG
         fBfpZ2tYMRltYl5vyk+mkRKa3zu6zrECV0hvnX7phTGOHqRVY6O9/5uEqinLpTH0vXBo
         tP4eP+Dfe4++e+ZVf1z51l4WClDGNcLq/9Tcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AzdtGTFNDtA6djMgMKjBBWkc/NTMQhKJOFQOItjVi5JPl8agsXwil9RPjF4FMSpeb2
         wXlMSTf8ZhxkZeDeKeM/RMy1IKmyYrbUFQ1IFo/jMzvSpYkbRRZwEBk6pKtujM12+1Oe
         TSso/EymFnBHxNOBqvXBoingl2VrLmyrf63Eg=
Received: by 10.210.92.8 with SMTP id p8mr4171699ebb.182.1213469994644;
        Sat, 14 Jun 2008 11:59:54 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.84])
        by mx.google.com with ESMTPS id i6sm7691163gve.4.2008.06.14.11.59.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 11:59:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48540E70.4030507@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85037>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>> Lea Wiemann wrote:
>>
>>> I think that gitweb should not be writing stuff to stderr unless an
>>> internal or serious error occurs
>>
>> There is no option to git-rev-list to not write any output to stderr
> 
> Okay, this one will go away with the new API I'm writing, which uses 
> cat-file --batch-check instead of rev-list.

Won't work.  Well, it would work for p=commit;h=non-existent, but it
would not work for p=log;h=non-existent, where git-rev-list
(or git-log) is really needed.  And I'd rather have parse_commit()
(used in 'commit' view) and parse_commits() (used in log-like views)
share the same commit parser, parse_commit_text(), so it's rev-list
also for git_commit, not cat-file.

But using git-cat-file --batch-check would improve other cases.

>                                             In the meantime (and in  
> other cases) I guess diverting stderr in the test code is fine.  (I 
> wouldn't want to ignore stderr in all cases, even where you're not 
> expecting any output on stderr, since that might actually indicate an 
> error.)

Well, I'd divert stderr in tests cases (or use simply 'test_external'),
or better filter stderr, only in those cases where there is spurious
but not dangerous thing on stderr.

But again, I think the solution would be either to add feature to
Git.pm, something like command_output_pipe_no_stderr, which would
redirect stderr to /dev/null, or modify git wrapper to redirect
stderr to /dev/null in scripts / when calling script, and redefine
die and warn for built-ins (or close stderr).

>> [snip]  It should work.  test-lib.sh sets up $PATH to have 'git' binary
>> (just compiled git binary) in it...
> 
> Since you're accessing http://localhost/ URLs, the web server's PATH is 
> in effect,...

It isn't.  http://localhost/ is just access convention, and
WWW::Mechanize::CGI actually calls system()[*1*] on provided path made
absolute (hence error when it contains whitespace), setting CGI
environmental variables before calling it.

[*1*] it would be nice to have perl_application in WWW::Mechanize::CGI,
which would simply setup %ENV and use do() instead of system() on
provided application.  Perhaps it would be better in meantime to
simply craft $mech->cgi( sub { ... } ), and do not use generic
$mech->cgi_application($path); we could do without all the checking,
too.

-- 
Jakub Narebski
Poland
