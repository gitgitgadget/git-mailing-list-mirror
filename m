From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/5] path.c: Don't discard the return value of vsnpath()
Date: Fri, 07 Sep 2012 20:52:31 +0100
Message-ID: <504A507F.9030802@ramsay1.demon.co.uk>
References: <50463A1A.9000801@ramsay1.demon.co.uk> <7vipbt8q7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA4we-0003Rw-7X
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 22:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2IGUOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 16:14:21 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:41159 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752047Ab2IGUOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 16:14:20 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 17AFCA0C4A6;
	Fri,  7 Sep 2012 21:14:19 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 55DA8A0C4A5;	Fri,  7 Sep 2012 21:14:18 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Fri,  7 Sep 2012 21:14:17 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vipbt8q7r.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204995>

Junio C Hamano wrote:
> cleanup_path() is a quick-and-dirty hack that only deals with
> leading ".///" (e.g. "foo//bar" is not reduced to "foo/bar"), and
> the callers that allocate 4 bytes for buf to hold "foo" may not be
> able to fit it if for some reason there are some bytes that must be
> cleaned, e.g. ".///foo".
> 
> The worst part of its use is that buf and ret could be different,
> which means you cannot safely do:
> 
> 	char *buf = xmalloc(...);
>         buf = git_snpath(buf, n, "%s", ...);
>         ... use buf ...
>         free(buf);

Hmm, this seems very unnatural to me; it would never have occurred to
me to use anything other than a stack allocated buffer (or *maybe* a
global buffer) when calling git_snpath().

In this situation (ie a dynamically allocated buffer used to hold the
result), why would you not use git_pathdup()? (which does not suffer
this problem.)

I guess it does not matter what I find unnatural, ... :(

> but instead have to do something like:
> 
> 	char *path, *buf = xmalloc(...);
>         path = git_snpath(buf, n, "%s", ...);
>         ... use path ...
>         free(buf);
> 
> And this series goes in a direction of making more callers aware of
> the twisted calling convention, which smells really bad.

Note that, prior to commit aba13e7c ("git_pathdup: returns xstrdup-ed
copy of the formatted path", 27-10-2008), git_snpath() was calling
cleanup_path() in the non-error return path. I suspect that this
commit did not intend to "fix the git_snpath() interface" and only
did so by accident. (That's a guess, of course)

However, I much prefer git_snpath(), git_pathdup() and git_path()
return the same result string given the same inputs! :D

ATB,
Ramsay Jones
