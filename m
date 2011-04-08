From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t3306,t5304: avoid clock skew issues
Date: Fri, 08 Apr 2011 22:30:38 +0200
Message-ID: <4D9F706E.2090309@drmicha.warpmail.net>
References: <b384c3adae96498eafb2a1faddeaabe85a0f7225.1302285490.git.git@drmicha.warpmail.net> <7vipuo336t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:30:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8IKM-00051P-5b
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873Ab1DHUal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 16:30:41 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35705 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757843Ab1DHUal (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 16:30:41 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C20E620B05;
	Fri,  8 Apr 2011 16:30:40 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 08 Apr 2011 16:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kq43mfJSw8f64gvMs7ZgWU9VFk0=; b=updWTt50fEWu3qlJx86dFMm5M2P60EE6hHydzaV3xVm4Hh73WE6YYz2rBsaVq4+W3NX5qV1w0LOUpUzXbbfbBahMo0QwVXWTmDwt2X+tIAk1oNyDVxWWzB+SjTn5JLN3X3pJnAnR+xKK78dHIMAJJ+3HYZQigMTNa0M+1wWzji0=
X-Sasl-enc: 4Yj/6dOmT+j9m7+mwNrnHwFVxHTk1oqd/bQ4tGj13eRi 1302294640
Received: from localhost.localdomain (p54858E4C.dip0.t-ipconnect.de [84.133.142.76])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2A5CE4465E6;
	Fri,  8 Apr 2011 16:30:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vipuo336t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171161>

Junio C Hamano venit, vidit, dixit 08.04.2011 22:20:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> On systems where the local time and file modification time may be out of
>> sync (e.g. test directory on NFS) t3306 and t5305 can fail because prune
>> compares times such as "now" (client time) with file modification times
>> (server times for remote file systems). I.e., these are spurious test
>> failures.
>>
>> Avoid this by setting the relevant modification times to the local time.
>>
>> Noticed on a system with as little as 2s time skew.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> I don't think we can safeguard prune itself properly. A filesystem may be out
>> of time sync sporadically (and produce incorrect time stamps) but then be in
>> sync when "git prune" is run so that we can't detect it.
>>
>>  t/t3306-notes-prune.sh |    4 ++++
>>  t/t5304-prune.sh       |    3 ++-
>>  2 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
>> index c428217..3114972 100755
>> --- a/t/t3306-notes-prune.sh
>> +++ b/t/t3306-notes-prune.sh
>> @@ -20,6 +20,10 @@ test_expect_success 'setup: create a few commits with notes' '
>>  	git add file3 &&
>>  	test_tick &&
>>  	git commit -m 3rd &&
>> +	COMMIT=$(git rev-parse HEAD) &&
>> +	COMMIT_FILE=.git/objects/$(echo $COMMIT | sed "s/^../&\//") &&
> 
> Hmm, the remainder of the test script seems to know this commit is 5ee1c35
> all over the place.  Do the above two lines worth it?

I found that use of concrete sha1s a bit strange (I didn't run blame...)
but have no objection against keeping the new bit in line with the
existing test, i.e.

+	COMMIT_FILE=.git/object/5e/e1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&

instead of the 2 lines above.

Michael
