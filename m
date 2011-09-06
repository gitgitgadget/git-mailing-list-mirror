From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 5/5] branch: allow pattern arguments
Date: Tue, 06 Sep 2011 16:21:35 +0200
Message-ID: <4E662C6F.7000205@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net> <0c487086643fbf0334140365f20fef62242b7dac.1314543252.git.git@drmicha.warpmail.net> <4E661BDE.1080204@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 16:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0wX6-0003Vw-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 16:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab1IFOVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 10:21:39 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41029 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752957Ab1IFOVi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 10:21:38 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 693D223413;
	Tue,  6 Sep 2011 10:21:37 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 06 Sep 2011 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ld0z8RVNXG3u15rQLy11xe
	UUzgw=; b=mSyIMz6DwKKe2cuQHGq9S3eAMzsfKlFefPrxeX0FUQCXOnqDsZGyxN
	qSBKBmPv9k+N/a7zkwW7VHf/klLvygKQKFdgjc8Bwn6IKlfLeQU91M3dCs13l1DL
	VT1uhXeUaKWGnSPq44imL0Pp2sRxK9TwM7tUHkjX1SbLFZh8mcrVg=
X-Sasl-enc: T5VGhlW3iMg/3Ug+0D+os/QPF6sePFApTtjHXa+aC3eI 1315318897
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AAFADB614B3;
	Tue,  6 Sep 2011 10:21:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E661BDE.1080204@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180802>

Michael Schubert venit, vidit, dixit 06.09.2011 15:10:
> On 08/28/2011 04:54 PM, Michael J Gruber wrote:
>> +static int match_patterns(const char **pattern, const char *refname)
>> +{
>> +	if (!*pattern)
>> +		return 1; /* no pattern always matches */
>> +	while (*pattern) {
>> +		if (!fnmatch(*pattern, refname, 0))
>> +			return 1;
>> +		pattern++;
>> +	}
>> +	return 0;
>> +}
> 
> Nitpick: maybe builtin/branch.c and builtin/tag.c could share match_pattern().?

I think all commands which list refs should share code - for-each-ref,
branch, tag, replace. I suggest to unify log and for-each-ref-formats
first, the unify ref listers.

> A second thought: the printed "remotes/" prefix could be confusing for users,
> since it seems to be part of the refname. For example:
> 
> $ git branch -a
> * master
>   maint
>   man
>   remotes/origin/master
>   remotes/origin/maint
>   remotes/origin/man
> 
> $ git branch -a --list remotes/origin*
> [no output]
> 
> but
> 
> $ git branch -a --list origin*
>   remotes/origin/master
>   remotes/origin/maint
>   remotes/origin/man
> 
> (Sorry in case I missed that) What's the reason you decided --list to show local
> branches only? Maybe --list could show all refnames without any extra prefix.?

I didn't decide anything here. "git branch" lists all local branches and
has been doing that forever, and "--list" is and should be a noop
without a pattern. That was the idea: -r/-a select refnames,
--list/-v/-vv activate the list mode(s), and the pattern is matched
against the selected refs.

(This is one reason why I didn't want it to be named --glob - the
pattern is a filter, not a selector.)

That being said, I find the fact that "-a --list remotes/origin/*" does
not match anything somewhat disconcerting, although it fits in with the
general idea of "git branch": it deals with branch names, not ref names.
Have you ever tried to delete a remote branch?

git branch -r -d origin/maint # workee
git branch -r -d remotes/origin/maint # no workee

Without -r, it doesn't work either.

So, the way it is it fits in with how "git branch" works, and is
different from for-each-ref (and rev-list --glob). I don't like it,
because you may have a local branch origin/maint (i.e.
refs/heads/origin/maint) which you can't distinguish from the remote
branch by a pattern, only by using or not using -r. But it's the same as
with "git branch -d", really.

Michael
