From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] handle empty notes gracefully
Date: Fri, 06 Feb 2009 16:50:17 +0100
Message-ID: <498C5C39.7020503@drmicha.warpmail.net>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-3-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0902061636320.7377@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:52:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSze-0005tW-T8
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZBFPuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbZBFPuY
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:50:24 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44310 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753165AbZBFPuX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:50:23 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 663C428B2AD;
	Fri,  6 Feb 2009 10:50:22 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 06 Feb 2009 10:50:22 -0500
X-Sasl-enc: NS3xWYv3xSGewRgEc8kP9cBfurPBY+SECafmt+7vI79m 1233935421
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DF1B3229B9;
	Fri,  6 Feb 2009 10:50:20 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902061636320.7377@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108745>

Johannes Schindelin venit, vidit, dixit 06.02.2009 16:38:
> Hi,
> 
> On Fri, 6 Feb 2009, Michael J Gruber wrote:
> 
>> Currently, git-notes barfs when asked to show an empty (i.e.
>> non-existing) note. Change this to explicitely say there is none.
>> ---
>>  git-notes.sh     |    2 ++
>>  t/t3301-notes.sh |    2 +-
>>  2 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-notes.sh b/git-notes.sh
>> index bfdbaa8..9cbad02 100755
>> --- a/git-notes.sh
>> +++ b/git-notes.sh
>> @@ -58,6 +58,8 @@ edit)
>>  		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
>>  ;;
>>  show)
>> +	git rev-parse -q --verify "$GIT_NOTES_REF":$COMMIT > /dev/null ||
>> +		die "No note for commit $COMMIT."
> 
> This looks good.
> 
>> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
>> index 4900dca..81d5028 100755
>> --- a/t/t3301-notes.sh
>> +++ b/t/t3301-notes.sh
>> @@ -36,7 +36,7 @@ test_expect_success 'need valid notes ref' '
>>  '
>>  
>>  # 1 indicates caught gracefully by die, 128 means git-show barfed
>> -test_expect_failure 'handle empty notes gracefully' '
>> +test_expect_success 'handle empty notes gracefully' '
>>  	git notes show || test 1 = $?
> 
> Completely forgot to mention that I think you want to use test_must_fail 
> here. 

What does test_must_fail mean? I don't see it in t/README.

> And maybe you want to be more explicit, by specifying which 
> commit's notes are expected not to be there.

Well, HEAD's notes. I can say HEAD explicitly, of course.

> We would not want the test to succeed for all the wrong reasons, would we?

Well, I could test for the friendly "No note for commit" message on
output, I just thought that is fragile.

You see, I did not even want to write a test for such a simple patch... ;)

OK, do we agree on the following intended behaviour for git notes show:
- return 0 if a note can be shown
- return 1 if there is none (i.e. die gracefully)
- return something else (i.e. die fatally) if something really bad happens

Then I should rewrite the test to check for "1" and only "1".

Now, the coffee...

Michael
