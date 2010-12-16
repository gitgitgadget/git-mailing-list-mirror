From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 04/14] lib-git-svn.sh: Add check for missing mod_dav_svn
 module
Date: Thu, 16 Dec 2010 20:00:00 +0000
Message-ID: <4D0A6FC0.5030106@ramsay1.demon.co.uk>
References: <4D07B63A.2020501@ramsay1.demon.co.uk> <7v8vzsuq48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, normalperson@yhbt.net,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMVn-0000Ml-M9
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab0LPWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:12 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:49975 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab0LPWlJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:09 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMVX-0005Wl-lO; Thu, 16 Dec 2010 22:41:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v8vzsuq48.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163831>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
>> index 919d45a..154f3d3 100644
>> --- a/t/lib-git-svn.sh
>> +++ b/t/lib-git-svn.sh
>> @@ -101,6 +101,11 @@ start_httpd () {
>>  		echo >&2 'SVN_HTTPD_PORT is not defined!'
>>  		return
>>  	fi
>> +	if test ! -e "$SVN_HTTPD_MODULE_PATH/mod_dav_svn.so"
>> +	then
>> +		echo >&2 'Apache module "mod_dav_svn.so" not found'
>> +		return 1
>> +	fi
> 
> Others seem to check with "test -f" for things like this.

OK, do you want me to send an updated patch?

> Also why "return 1" only on this codepath?

This test, along with t9115-*.sh, t9118-*.sh and t9120-*.sh, have
been written in such a way that it can access the svn repo using
either file or http urls. By default (SVN_HTTPD_PORT not set), it
uses file urls so that, despite it noisily printing to stderr that
"SVN_HTTPD_PORT is not defined!", lack of an Apache installation is
not a problem. (In fact, I suspect very few people run it with
SVN_HTTPD_PORT defined).

So, the initial test (of SVN_HTTPD_PORT) and return is not particularly
noteworthy, let alone an error. (Yes I have a patch to remove the
message, see below). However, *if* the user requests the test be run
with http urls and the mod_sav_svn.so module is missing, then we want
to fail the test noisily; thus we return 1. 

Note that we could easily reset SVN_HTTPD_PORT and return, thus silently
converting to the "use file urls" case, but I don't think that would be
acceptable.

The reason I didn't submit the patch to remove the above message is
because I felt I should add a note about how/why you would use the
SVN_HTTPD_PORT variable to the t/README file. However, that started
me thinking about other similar variables like:
    SVN_HTTPD_{PATH,MODULE_PATH}, LIB_HTTPD_{PATH,PORT,SSL,DAV,SVN},
    GIT_SVN_NO_OPTIMIZE_COMMITS, GIT_TEST_HTTPD, .....
So, that patch never got finished! :-P

ATB,
Ramsay Jones
