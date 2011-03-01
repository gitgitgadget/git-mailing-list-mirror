From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/WIP] attr: make attributes depend on file type
Date: Tue, 01 Mar 2011 08:46:39 +0100
Message-ID: <4D6CA45F.5000001@drmicha.warpmail.net>
References: <20110228130850.GB9054@sigill.intra.peff.net> <f35b1b4b57a563f57f169602440b3b0abdef5a07.1298906628.git.git@drmicha.warpmail.net> <20110228173037.GC24915@sigill.intra.peff.net> <7v39n8jbj2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 08:50:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuKLV-0002fa-KK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 08:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab1CAHuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 02:50:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54923 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755594Ab1CAHuF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 02:50:05 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E59C920A69;
	Tue,  1 Mar 2011 02:50:04 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 01 Mar 2011 02:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=o1r7dLBG3n8zaY5eYO8rYuQqciw=; b=AU3Ci8jx7ESEojv0Fz9DWSm6UEb+gVgFVyPosq6NaNFJZpVXWK3cUmofQjnpjv7SU7LnWywsM7EA0o8TzapcUhbBc34lmOpAvlT2IYTd+vUiI/Ubg15PnFzbXCacA185tFfnlPISvWeZFNY1gjr6p89auOHRY1vcBb3lfm+HGls=
X-Sasl-enc: 2Q3cNu0f8SyQd44Bg8pKk5T/mpitQzg9GZEowF64oFRS 1298965804
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4EFE84006DC;
	Tue,  1 Mar 2011 02:50:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7v39n8jbj2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168186>

Junio C Hamano venit, vidit, dixit 28.02.2011 18:48:
> Jeff King <peff@peff.net> writes:
> 
>> The only downside is that it is technically a regression if somebody was
>> using gitattributes for the bizarrely named file "symlink:". It seems
>> pretty unlikely, but possibly we should be carving out a syntactic
>> namespace like:
>>
>>   ^[a-z]+:
>>
>> or even:
>>
>>   ^[a-z]+(=[^:]*)?:
> 
> Or even '^:[a-z]+(=[^,=])?(,[a-z]+(=[^,=])?)*:' to
> 
>  (1) always have some special character at the beginning, to limit the
>      extent of the damage to existing funny pathnames (i.e. to collide
>      your pathname must begin with such a special character).  This also
>      has a nice side effect of making it clear that something special is
>      going on; and
> 
>  (2) allow more than one such special on the line, comma-separated.
> 
> But that is just a small bikeshed.  Other than that, I like what Michael
> and you are aiming for (I am only commenting on the general direction at
> this moment, as I haven't looked at the patch at all yet).

Thanks, Junio, and Jeff, for the helpful comments. I isolated the naming
convention (now "symlink:") to a single spot in attr.c so that changing
it (then ":symlink:") is always simple while this develops. (I was
afraid that the low likelikehood that someone's file names would collide
could be too much already.)

Having a standard pattern applied to regular files only is an intended
side-effect; more precisely: to non-symlinks right now. We could tighten
that to IS_REG, of course, and easily add others (or :other:, :nonreg:).

What I really would need help with is checking all call sites of
git_checkattr(), which gained a new mode parameter: I used the proper
mode where available (from diff_filespec, e.g., i.e.: taking mode from
index or tree) or by looking it up in the fs (using lstat() in
builtin/check-attr.c), and I used mode=0 in other cases, assuming that
this conveys IS_REG and that we're sure those call sites are about
regular files or blobs. I tried to avoid unmotivated lstat().

Michael
