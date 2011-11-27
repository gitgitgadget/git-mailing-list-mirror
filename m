From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Switch from svn to git and modify repo completely
Date: Sun, 27 Nov 2011 11:56:22 +0100
Message-ID: <4ED21756.70705@fechner.net>
References: <4EC7E32A.9040903@fechner.net> <20111119225048.384189bc@zappedws> <4EC97D52.1010308@fechner.net> <20111121070247.GA16708@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexey Shumkin <alex.crezoff@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 11:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUcPq-0000YF-Bb
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 11:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab1K0K4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 05:56:34 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:49775 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1K0K4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 05:56:33 -0500
Received: from server.idefix.lan (ppp-93-104-88-159.dynamic.mnet-online.de [93.104.88.159])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id pARAuNU8024261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 27 Nov 2011 11:56:28 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id 797D46B643;
	Sun, 27 Nov 2011 11:57:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6UOMk_ciP7BF; Sun, 27 Nov 2011 11:57:51 +0100 (CET)
Received: from [IPv6:2001:a60:f035:1:4422:7925:f429:c9e0] (unknown [IPv6:2001:a60:f035:1:4422:7925:f429:c9e0])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id DAD9E6B634;
	Sun, 27 Nov 2011 11:57:51 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111121070247.GA16708@elie.hsd1.il.comcast.net>
X-Enigmail-Version: 1.3.3
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Sun, 27 Nov 2011 11:56:29 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185983>

Am 21.11.2011 08:02, schrieb Jonathan Nieder:
> The section "CHECKLIST FOR SHRINKING A REPOSITORY" from the
> git-filter-branch(1) manual page has some hints.  In particular, "git
> clone --no-hardlinks" still _copies_ all objects --- you probably
> would want "git clone file://$(pwd)/repo-orig" to make sure the
> ordinary transfer negotiation kicks in.
> 
> It's very important that the documentation not be misleading, so if
> you can point to places where the wording can be less confusing, that
> would be very welcome.

it would be fantastic if exactly this information is noted in the
manual. For me it is not really clear what is the difference between a
git clone with and without --no-hardlinks.

I was now able to convert my svn repo to a git repo and split the new
git repo in several different ones, including the complete history.

Here a short summary for all how need to do the same.
At first convert the svn into a git reposity:
git svn clone file:///path/to/svn -A authors -s gitrepo.git

To create the authors file, check the man page.

To get a list of all files:
git show --pretty="format:" --name-only startrev..endrev | sort | uniq

Maybe you want to remove some branches from the repo because svn users
used it in a completely wrong way:
git branch -rd badbranch

Now clone the repo and remove files from it you do not want anymore:
git clone gitrepo.git tofilter.git
cd tofilter.git
git filter-branch -f --tree-filter 'rm -Rf file1 file2.bla dir1 \
projekt1/dir2' --prune-empty -- --all
git gc
cd ..

Repeat this step for all combination you need.

Now create a bare repository and enable some options to use it as a
central repo:
git clone --bare tofilter.git tofilter_bare.git
cd tofilter_bare.git
git config core.sharedRepository 1
git config receive.denyNonFastForwards true
git gc
cd ..

Now you can copy the repo to the target server/directory and clone it
from there.

Bye
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
