From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Fri, 11 Mar 2011 08:52:44 +0100
Message-ID: <4D79D4CC.7020806@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net> <7vtyfc7ymk.fsf@alter.siamese.dyndns.org> <4D7886FD.60109@drmicha.warpmail.net> <7vd3lz5me5.fsf@alter.siamese.dyndns.org> <4D78AC8B.7010308@drmicha.warpmail.net> <7v4o7a6dj3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 08:56:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxxCw-0006ue-SM
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 08:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab1CKH4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 02:56:17 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50407 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735Ab1CKH4R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Mar 2011 02:56:17 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 42C38206B6;
	Fri, 11 Mar 2011 02:56:16 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 11 Mar 2011 02:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=AJMOVNW2Iu5XPCIMVAtObOD0V98=; b=j3QjSqo80r3BTC+aK3tpnGdXKbqm2U0ega2DKGoVY6Ydf4AYjRsgGJ18TybE9ov37XlttKqlUaSIbV1sPM3m6ywqd7FKmK1+iVxXk4PbQnfHe8VTwhqdLp3nbr0fZwreZ4AKx4lpHiLoXZ08KatADabdlBmrsxRUr8bzW+3GEoI=
X-Sasl-enc: nz4dKXTR5GOBoHHQYv0393pyOE+ZUY9izn1PHjBN3yyP 1299830175
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5557140A25D;
	Fri, 11 Mar 2011 02:56:15 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7v4o7a6dj3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168887>

Junio C Hamano venit, vidit, dixit 10.03.2011 19:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> ...
>> Additionally, since parse_revision_opt (which calls handle_revision_opt)
>> is called from other sites for individual args we would need to do the
>> handling in the Y case (set pick when marking) right in
>> handle_revision_opt, not just in setup_revisions. It's a matter of a few
>> more if's and or's, but still.
>>
>> Taking these together, I wonder whether we shouldn't leave it as in v2.
> 
> The primary downside of keeping cherry_pick and cherry_mark as independent
> I see is what would happen to the "if (cherry_pick || cherry_mark)" when
> somebody comes up with the next bright idea to use the change equivalence
> computed in cherry_pick_list(). With the approach in v2, the natural way
> of enhancing this would be to add another "|| cherry_xyzzy" there, and the
> next bright idea would add another "|| cherry_frotz".
> 
> My gut feeling was that it would be a more maintainable implementation to
> have an internal bit that does not have to be exposed to the UI and that
> tells the revision machinery that we need to compute the equivalence, and
> an enum (if the three modes of using the equivalence are incompatible with
> each other) or a one-bit-per-feature bitset (if the three features that
> use the equivalence can be used at the same time) that tells the machinery
> what to do with the equivalence information. From the UI level, the user
> only asks for the feature(s) that use(s) the equivalence information, and
> asking for any of them would set the internal "need equivalence" bit.
> 
> The above is modeled after the way how revs.limited bit is used. That bit
> corresponds to the "internal bit" that is flipped by many features that
> can be triggered from the UI level that depends on having the history
> graph before they do their work.
> 
> Counting the number of "if (limited)" and tricky codepaths around it, and
> contrasting that with the number of ways we flip the "limited = 1" bit
> (which grew over time), I think you can understand where my fear of
> potential future complexity against "if (cherry_pick || cherry_mark)"
> comes from.

I see, thanks for the background!

Other callers of the revision walker have to remember that they need to
set revs->limited already when they want to use any limitting flags, so
revs->cherry_pick as in v3 would be no different.(*)

So maybe we should have another flag revs->cherry_process which is set
automatically when needed, after processing all options (same with
limited), and leave cherry_pick to keep track of --cherry-pick?

(*) Well, in fact they don't as long as they use the api correctly.
blame and shortlog call parse_revision_opt but use setup_revisions and
prepare_revision_walk afterwards.
pack-objects calls handle_revision_arg after setup_revisions but
prepare_revision_walk after. I was afraid of callers setting
revs->something inconsistently and then jumping into the walker.

So, maybe prepare_revision_walk is the most sensible place to set
revs->limited and revs->cherry_process when needed as indicated by other
flags (or set already), and take out their handling from the option parser?

Michael
