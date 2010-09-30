From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP PATCH] revision-walk: --parent option to find children of
 a parent
Date: Thu, 30 Sep 2010 17:12:51 +0200
Message-ID: <4CA4A8F3.3010805@drmicha.warpmail.net>
References: <99aa4cd5a60b2b2d3eae962acb8a49c2a62a8f77.1285842569.git.git@drmicha.warpmail.net> <20100930143234.GH4850@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 17:16:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1KsT-00051l-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab0I3PMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 11:12:43 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:45777 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753927Ab0I3PMm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 11:12:42 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F29F1AB;
	Thu, 30 Sep 2010 11:12:41 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 30 Sep 2010 11:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=K4UbW1nRSdu1L81NS4gncqTQ0mg=; b=XugaJ404rhFhiCGAxdNDz2nmE0tna37uYem/vSFG1VBCPKYjN46YDxm9wBxBRqocAo02DKlmrb0QCPJaH9Dm4/mc4qsjA/iz0LqdCTrirOLK/dn0lM87mD/K5jTKNaIHO3x14JsrKYizCyjVbgZT9rQxljKe7o3gbmWunSQmfrc=
X-Sasl-enc: cpmMZJ1b9QdbiY1403X+kPR+sWN41MbSkjMQoaJJ6gMo 1285859561
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4FCD25E1AF4;
	Thu, 30 Sep 2010 11:12:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20100930143234.GH4850@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157679>

Jonathan Nieder venit, vidit, dixit 09/30/2010 04:32 PM:
> Hi,
> 
> Michael J Gruber wrote:
> 
>> Introduce a new --parent=<commit> option for the revision walker which
>> limits the commits to those which have <commit> as one of their parents.
> 
> So this lists the direct children for a given commit.  Could you
> mention a use case?  Why would one want to use this instead of
> 
>  the_commit=$(git rev-parse --verify <commit>) &&
>  git rev-list --parents ... ^<commit> |
>  grep -F " $the_commit"

| cut -d' ' -f1 # or such :)

> 
> ?

Full disclosure: I didn't see that it can be scripted that easily,
simply because the description of "--parents" does not indicate at all
that it lists the commit along with its parents. I had the impression
that it outputs the parents only (same goes for --children.) so that
looping over the rev-list output would be required, which would have
been much slower.

As a use case, it not only tells you whether a specific commit is a fork
point, it's also a reverse of "rev-parse commit^@", so to say.

Personally, this was some exercise with the revision walker before
approaching something else there.

[It also helps with "Heck, I committed on top of a detached origin/next
yesterday, how did I tag that commit.", but there are other solutions,
of course...]

Speaking of that: It helps you "going forward(!)" from a commit that you
checked out (maybe for inspection). Just imagine trying to understand a
history by checking out versions iteratively. Say, you want to review
the last 10 revs, do a "checkout HEAD~10", then a "checkout HEAD~9" and
notice that's not quite the way to do it... (Again, there are
alternatives, of course.)

>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1149,6 +1149,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>>  {
>>  	const char *arg = argv[0];
>>  	const char *optarg;
>> +	unsigned char sha1[20];
> 
> Could this be given narrower scope?

Sure! I expected more rough edges (and some resistance) which is why I
sent a WIP first.

Michael
