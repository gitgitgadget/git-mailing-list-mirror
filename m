From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/WIP/PATCH v2] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Sun, 15 Jun 2008 20:45:32 +0200
Message-ID: <4855634C.8060606@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <1213487844-685-1-git-send-email-LeWiemann@gmail.com> <200806152001.34350.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 20:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7xF5-0002LC-DU
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 20:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbYFOSpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 14:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbYFOSpY
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 14:45:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:37473 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYFOSpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 14:45:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3122050fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=yDaAVDESG/UY1GFxNpJq+/EmTWZqoH1vrzSxuxahC7o=;
        b=dkMDlKNMhzL/Yl84Hp7o9yTCGUvdKwi7yBrh5/M27qsFHlvXqpTdK3YZh4HhdcEtK2
         urcZQZue3KxmuSj+1iWAVVVOYTV16bzsR4QzC2t+PPHM319fKD+Qt9+qMKIuuTfZwEe/
         zFa5g4pbeZExjT192ZwfjZnnQV9UFGLqCAtqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=sjIiDJUuQlGhXI2bdUzxiEwH8IaPcK2D652NqeSb/HJRwZm+D4sZu/siUqMAyXxj8b
         ILJ4thLT+O8rMGZL5SEUDkll358iJqgYlXLXSlL2f3uWdcBnSu1sdh9xDHvhjFNT09Ah
         QL6EYygsObiAozyMMgJ+8UbVDBjjkPGwOjl3E=
Received: by 10.86.70.11 with SMTP id s11mr7110222fga.71.1213555519815;
        Sun, 15 Jun 2008 11:45:19 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.242.85])
        by mx.google.com with ESMTPS id e20sm10722710fga.1.2008.06.15.11.45.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 11:45:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806152001.34350.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85107>

Jakub Narebski wrote:
> 1.) Should we put all tests in one file, or should they be split

I'd suggest we leave it in a single file until test execution time 
becomes an issue.  Then (when it has become too large) we'll be able to 
figure out good boundaries along which to split the test suite.

> 2.) What invariants should we test [...]  Checking for example if all items
>     are listed in a 'tree' view, or if all inner links (#link) are
>     valid would be a good start... 

Yup; completeness of item lists is especially relevant for paginated 
output.  Also check for the presence and validity of links (like 
"parent" links, etc.), and for the presence of certain elements (like 
the file modes in the tree view).

Also, with a $ENV{LONG_GIT_TEST} variable or so, we could automatically 
validate all links for each page we're checking -- it takes a long time, 
but it's still way more efficient than exhaustive spidering of the whole 
site.

> (by the way, is there some Perl module for RSS, Atom and OPML validation?)

I can't find anything on Google right now, but piping them into external 
validators might be just as fine.  Also, since those formats are 
generated using print statements (which is really error-prone for XML 
formats), I'd say that a good start would be to check for XML validity.

> 3.) What invariants you want to test for your caching efforts, e.g.
>     checking if cached output matches non-cached

How about this:

1. Run the Mechanize tests (and possibly also the existing t9500 tests) 
*without* caching, recording the URL's and contents of all pages the 
test suite accesses.

2. Get all those URL's again *with* caching (from a cold cache), and 
assert that the output is identical.

3. Get all those URL's again *with* caching (from a warm cache), and 
assert that the output is identical.  Perhaps also assert that no call 
to the git binary is made (i.e. everything has actually been cached). 
(Of course we might need options for the production site to not cache 
certain things, but let's defer this discussion.)

-- Lea
