From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WRONG/PATCH 1/3] revisions: clarify handling of --no-walk and
 --do-walk
Date: Tue, 26 Apr 2011 10:19:11 +0200
Message-ID: <4DB67FFF.1060709@drmicha.warpmail.net>
References: <20110421102241.GA16185@elie> <20110421103926.GA16260@elie> <4DB02B24.4030503@drmicha.warpmail.net> <20110421213014.GB18418@elie> <4DB40941.5030903@drmicha.warpmail.net> <20110425002124.GB31168@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 10:19:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEdUY-0001VD-QE
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 10:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab1DZITX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 04:19:23 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55732 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081Ab1DZITS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 04:19:18 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 48BA020CCA;
	Tue, 26 Apr 2011 04:19:17 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 26 Apr 2011 04:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OJFPbqzy8Q9FttCsbFD2vdL50Yk=; b=LoNjOG6pRJ0SHzJYOYu+P7VADk9BLk5xgR5zo4NmwY6iVVZctVXPlWpsXQ2HtCPkg5rmMCXkGNA/Xxv+bMK3YY29s/oXlkvYrMPAv0nGDIyZuyuTi4KhI22wjpu2w/D2BSsqfRNh+4jvdM2pDu4feS5y8A3V4VFGG23rhNtB+o4=
X-Sasl-enc: wxtff048WFMesBIzlFMN1/4v/WcyFDXWa7P72qFc9XTc 1303805957
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6A4A8407A41;
	Tue, 26 Apr 2011 04:19:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110425002124.GB31168@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172076>

Jonathan Nieder venit, vidit, dixit 25.04.2011 02:21:
> Michael J Gruber wrote:
> 
>> We don't do the systematic approach now. In some situations, some
>> commands switch on the walker automatically (I think "show A..B") to
>> make things more useful (to most users) but less systematic, even less
>> predictable if you don't know these deviations/exceptions. I've
>> suggested such a "usefulness exception" myself (don't prune commits by
>> path for "show").
> 
> Ah.  To be clearer about the present state:
> 
>  - cmd_show reimplements much of get_revision, to work around the
>    revision walking machinery's lack of callbacks to print tags,
>    blobs, and so on.
> 
>  - ^A means "--do-walk ^A", and A..B means "--do-walk ^A B".  This
>    holds in rev-list, log, show, etc --- they all share the code that
>    does this.
> 
>  - Similarly, -5 means "--do-walk -5".
> 
>  - rev-parse shares a revision parser (get_sha1) with rev-list, but it
>    doesn't share an option parser (alas).
> 
> I personally kind of like the "don't prune commits by path with
> --no-walk" idea.  Not sure what happened to that.

It got dropped after the switch to the new cycle. The question/problem
was whether some people used "git show A B C -- path" as a kind of
commit filter, selecting only commits which touch path (i.e. prune
commits by path). I would claim it's the wrong command to do that and
was never documented anyways...

So, my choice would be "do not prune commits unless --do-walk was given"
(where "was given" may include "was switched on by our range=>walk logic").

Another choice would be "do not prune if there is only one rev argument
and no --do-walk".

> Ah.  To be clearer about the present state:
> 
>  - cmd_show reimplements much of get_revision, to work around the
>    revision walking machinery's lack of callbacks to print tags,
>    blobs, and so on.
> 

You mean, other than pretty formats... I think our code does a couple of
things by hand which could be done with a pretty format. Though a
callback may be more efficient, unless our formats are pre-parsed.

Michael
