From: Benny Halevy <bhalevy@tonian.com>
Subject: Re: [PATCH] git-remote rename should match whole string when renaming
 remote ref directory
Date: Tue, 27 Sep 2011 05:45:07 +0300
Message-ID: <4E8138B3.9090909@tonian.com>
References: <1317045186-25206-1-git-send-email-benny@tonian.com> <7v62kf41ud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 04:45:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Nfl-00071R-NP
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 04:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab1I0CpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 22:45:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45131 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1I0CpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 22:45:13 -0400
Received: by fxe4 with SMTP id 4so6676215fxe.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:45:12 -0700 (PDT)
Received: by 10.223.43.211 with SMTP id x19mr2460023fae.142.1317091511932;
        Mon, 26 Sep 2011 19:45:11 -0700 (PDT)
Received: from lt.bhalevy.com ([94.159.150.143])
        by mx.google.com with ESMTPS id c5sm21927890fai.2.2011.09.26.19.45.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 19:45:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <7v62kf41ud.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182205>

On 2011-09-26 21:04, Junio C Hamano wrote:
> Benny Halevy <benny@tonian.com> writes:
> 
>> From: Benny Halevy <bhalevy@tonian.com>
>>
>> Otherwise, with two remotes: test, test-2
>> 	git remote rename test test-
>> ends up with:
>> 	.git/refs/remotes/test-
>> 	.git/refs/remotes/test--2
>> ...
>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index f2a9c26..5443e71 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -571,7 +571,7 @@ static int read_remote_branches(const char *refname,
>>  	const char *symref;
>>  
>>  	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
>> -	if (!prefixcmp(refname, buf.buf)) {
>> +	if (!strcmp(refname, buf.buf)) {
> 
> At this point of the code, refname has "refs/remotes/test/foo" and it is
> queued to later rename it to "refs/remotes/test-/foo" (the next invocation
> of this function will see "refs/remotes/test/bar" in refname). And the
> strbuf buf.buf has "refs/remotes/test"; your !strcmp(refname, buf.buf)
> would never trigger, I suspect.
> 
> Isn't 60e5eee (remote: "rename o foo" should not rename ref "origin/bar",
> 2011-09-01) the correct fix for this issue?  It makes buf.buf properly
> terminated with a slash, to contain "refs/remotes/test/" so that prefixcmp
> properly matches it with "refs/remotes/test/foo" but not with refs under
> other hierarchies like "refs/remotes/test-2/anything".

OK, 60e5eee solves the problem too.
I wasn't aware of it as I was looking at the master branch.
FWIW, here's the test I used:

#!/bin/sh

git=git
cwd=$(pwd)

function fail ()
{
	echo $0: $*
	exit 1
}

for i in main test test-2; do
	mkdir $i || fail $i exists;
	$git init $i || fail git init $i failed
	echo $i > $i/foo
	( cd $i; git add foo; git commit -m $i )
done
cd main || fail cd main failed
for i in test test-2; do
	$git remote add $i file://$cwd/$i || fail git remote add $i failed
done
$git remote update || fail git remote update fail
$git remote rename test test-
$git show test-2/master || fail FAILED
echo PASSED

> 
> Thanks.
