From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Fri, 09 Nov 2012 10:28:28 +0100
Message-ID: <509CCCBC.8010102@drmicha.warpmail.net>
References: <5093DC0C.5000603@drmicha.warpmail.net> <20121108200919.GP15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 10:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWktK-000132-DI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 10:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab2KIJ2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 04:28:33 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57088 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976Ab2KIJ2b (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2012 04:28:31 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2DCE920A79;
	Fri,  9 Nov 2012 04:28:30 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 09 Nov 2012 04:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Am2hPtTPzyWkrmsHwjTmiP
	PGk9M=; b=uko30AruSe7p6zakgnmhsNC7zbZzNN0bsWGR+pBNmQMqso5yHh8Phf
	DT6TTbDMeZBBtulnkB26icbgHqVbEanJSbOtQASkiYtjZlfT7CR32dEKlW4pxfEq
	fzU0qSkzooUiIeJN+Ko7YJW1aPShqoHKV0SN8xhjAJj1fs8uGvwpc=
X-Sasl-enc: NcWBEdXV8IwgvJtf2toIVvX0Gb3Ys5kEWtn4OQgiaWTh 1352453309
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A162B8E0506;
	Fri,  9 Nov 2012 04:28:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <20121108200919.GP15560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209209>

Jeff King venit, vidit, dixit 08.11.2012 21:09:
> On Fri, Nov 02, 2012 at 03:43:24PM +0100, Michael J Gruber wrote:
> 
>> It seems that our fast-import is super picky with regards to author
>> names. I've encountered author names like
>>
>> Foo Bar<foo.bar@dev.null>
>> Foo Bar <foo.bar@dev.null
>> foo.bar@dev.null
>>
>> in the self-hosting repo of some other dvcs, and the question is how to
>> translate them faithfully into a git author name.
> 
> It is not just fast-import. Git's author field looks like an rfc822
> address, but it's much simpler. It fundamentally does not allow angle
> brackets in the "name" field, regardless of any quoting. As you noted in
> your followup, we strip them out if you provide them via
> GIT_AUTHOR_NAME.
> 
> I doubt this will change anytime soon due to the compatibility fallout.
> So it is up to generators of fast-import streams to decide how to encode
> what they get from another system (you could come up with an encoding
> scheme that represents angle brackets).

I don't expect our requirements to change. For one thing, I was
surprised that git-commit is more tolerant than git-fast-import, but it
makes a lot of sense to avoid any behind-the-back conversions in the
importer.

>> In general, we try to do
>>
>> fullotherdvcsname <none@none>
>>
>> if the other system's entry does not parse as a git author name, but
>> fast-import does not accept either of
>>
>> Foo Bar<foo.bar@dev.null> <none@none>
>> "Foo Bar<foo.bar@dev.null>" <none@none>
>>
>> because of the way it parses for <>. While the above could be easily
>> turned into
>>
>> Foo Bar <foo.bar@dev.null>
>>
>> it would not be a faithful representation of the original commit in the
>> other dvcs.
> 
> I'd think that if a remote system has names with angle brackets and
> email-looking things inside them, we would do better to stick them in
> the email field rather than putting in a useless <none@none>. The latter
> should only be used for systems that lack the information.
> 
> But that is a quality-of-implementation issue for the import scripts
> (and they may even want to have options, just like git-cvsimport allows
> mapping cvs usernames into full identities).

That was more my real concern. In our cvs and svn interfaces, we even
encourage the use of author maps. For example, if you use an author map,
git-svn errors out if it encounters an svn user name which is not in the
map. On the other hand, we can map all (most?) svn user names faithfully
without using a map (e.g. to "username <none@none>").

Hg seems to store just anything in the author field ("committer"). The
various interfaces that are floating around do some behind-the-back
conversion to git format. The more conversions they do, the better they
seem to work (no erroring out) but I'm wondering whether it's really a
good thing, or whether we should encourage a more diligent approach
which requires a user to map non-conforming author names wilfully.

Michael
