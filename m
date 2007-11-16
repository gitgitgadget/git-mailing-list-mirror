From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix and improve t7004
Date: Fri, 16 Nov 2007 22:11:48 +0100
Organization: glandium.org
Message-ID: <20071116211148.GA28966@glandium.org>
References: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org> <1195244917-25659-1-git-send-email-mh@glandium.org> <EEE710FA-0408-489F-8128-B4C1F06D34FF@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It8VH-0004W0-KF
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 22:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbXKPVNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 16:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbXKPVNI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 16:13:08 -0500
Received: from vawad.err.no ([85.19.200.177]:35226 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbXKPVNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 16:13:06 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1It8Uh-0001Kw-EB; Fri, 16 Nov 2007 22:12:57 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1It8Tc-0007aT-BN; Fri, 16 Nov 2007 22:11:48 +0100
Content-Disposition: inline
In-Reply-To: <EEE710FA-0408-489F-8128-B4C1F06D34FF@lrde.epita.fr>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65247>

On Fri, Nov 16, 2007 at 10:04:57PM +0100, Benoit Sigoure wrote:
> On Nov 16, 2007, at 9:28 PM, Mike Hommey wrote:
>
>> Brown paper bag fix to avoid using non portable sed syntax. The
>> test by itself didn't catch what it was supposed to, anyways.
>>
>> The new test first checks whether the user exited the editor
>> without editing the file, then whether what the user was
>> presented in the editor was any useful to her, which we define
>> as the following:
>>  * It begins with a single blank line, where the invoked editor
>>    would typically place the editing curser at so that the user
>>    can immediately start typing;
>>
>>  * It has some instruction but that comes after that initial
>>    blank line, all lines prefixed with "#".
>>
>>  * And it has nothing else, as the expected behaviour is "Hey
>>    you did not leave any message".
>>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>>  t/t7004-tag.sh |    9 ++++++++-
>>  1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 096fe33..42b1f97 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1004,10 +1004,17 @@ test_expect_failure \
>>  	'verify signed tag fails when public key is not present' \
>>  	'git-tag -v signed-tag'
>>
>> +test_expect_failure \
>> +	'git-tag -a fails if tag annotation is empty' '
>> +	GIT_EDITOR=cat git tag -a initial-comment > /dev/null 2>&1
>> +'
>> +
>>  test_expect_success \
>>  	'message in editor has initial comment' '
>>  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>> +	( read empty ;
>> +	  [ "$empty" ] && exit 1 ;
>
> What is this meant to do?  Did you mean [ -n "$empty" ] ?

Replacing with [ -n "$empty" ] would not work properly, except if you
replace the following ; with &&. Does that really make a readability
difference ?

>> +	  ! grep -ve "^#" > /dev/null 2>&1 ) < actual
>
> The double negation is harder to read.  May I suggest something along these 
> lines (which seems more readable to me):
>   while read line; do
>     case $line in #(
>       '#'*) ;; # Accept comments (
>       *) exit 1;;
>     esac
>   done

I'm not really convinced. What do other people have to say ?

Mike
