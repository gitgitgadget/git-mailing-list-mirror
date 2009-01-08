From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: gitweb index performance (Re: [PATCH] gitweb: support the	rel=vcs-*
 microformat)
Date: Thu, 08 Jan 2009 15:53:16 -0800
Message-ID: <496691EC.1070805@eaglescrag.net>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com> <20090107184515.GB31795@gnu.kitenet.net> <20090107190238.GA3909@gnu.kitenet.net> <20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org> <20090108195446.GB18025@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 00:54:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL4iE-00070o-Vw
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 00:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbZAHXxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 18:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbZAHXxa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 18:53:30 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:55749 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZAHXx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 18:53:29 -0500
Received: from [172.19.0.11] (c-67-164-30-157.hsd1.ca.comcast.net [67.164.30.157])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n08NrNMO025236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2009 15:53:23 -0800
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090108195446.GB18025@gnu.kitenet.net>
X-Virus-Scanned: ClamAV 0.88.7/8845/Thu Jan  8 08:52:13 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Thu, 08 Jan 2009 15:53:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104968>

Joey Hess wrote:
> Giuseppe Bilotta wrote:
>   
>>> There is a small overhead in including the microformat on project list
>>> and forks list pages, but getting the project descriptions for those pages
>>> already incurs a similar overhead, and the ability to get every repo url
>>> in one place seems worthwhile.
>>>       
>> I agree with this, although people with very large project lists may
>> differ ... do we have timings on these?
>>     
>
> AFAICS, when displaying the project list, gitweb reads each project's
> description file, falling back to reading its config file if there is no
> description file.
>
> If performance was a problem here, the thing to do would be to add
> project descriptions to the $project_list file, and use those in
> preference to the description files. If a large site has done that,
> they've not sent in the patch. :-)
>   

No because all the large sites have pain points and issues elsewhere in 
the app.  Most of the large sites (which I can at least speak for 
Kernel.org) went and have built in full caching layers into gitweb 
itself to deal with the problem.  This means that we don't have to worry 
about nickle and dime performance improvements that are specific to one 
section, but can do a very broad sweep and get dramatically better 
performance across all of gitweb.  Those patches have all made it back 
out onto the mailing list, but for a number of different reasons none 
have been accepted into the mainline branch.

> With my patch, it will read each cloneurl file too. The best way to
> optimise that for large sites seems to be to add an option that would
> ignore the cloneurl files and config file and always use
> @git_base_url_list.
>
> I checked the only large site I have access to (git.debian.org) and they
> use a $project_list file, but I see no other performance tuning. That's
> a 2 ghz machine; it takes gitweb 28 (!) seconds to generate the nearly 1
> MB index web page for 1671 repositories:
>   

Look at either Lea's or my caching engines, it will help dramatically on 
something of that size.

> /srv/git.debian.org/http/cgi-bin/gitweb.cgi  3.04s user 9.24s system 43% cpu 28.515 total
>
> Notice that most of the time is spent by child processes. For each
> repository, gitweb runs git-for-each-ref to determine the time of the
> last commit.
>
> If that is removed (say if there were a way to get the info w/o
> forking), performance improves nicely:
>
> ./gitweb.cgi > /dev/null  1.29s user 1.08s system 69% cpu 3.389 total
>
> Making it not read description files for each project, as I suggest above,
> is the next best optimisation:
>
> ./gitweb.cgi > /dev/null  1.08s user 0.05s system 96% cpu 1.170 total
>
> So, I think it makes sense to optimise gitweb and offer knobs for performance
> tuning at the expense of the flexability of description and cloneurl files.
> But, git-for-each-ref is swamping everything else
The problem is the knobs are going to be very fine grained, you really 
are better off looking at one of the caching engines that's available 
now.  Performance options are hard, because it's difficult to relay to 
anyone the complex tradeoffs, thus keeping knobs like that to a minimum 
are really a necessity.

- John 'Warthog9' Hawley
