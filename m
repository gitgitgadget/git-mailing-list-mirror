From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 18:15:42 +0200
Message-ID: <4C7D2AAE.9000701@drmicha.warpmail.net>
References: <4C7CD65F.10509@atlas-elektronik.com> <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net> <20100831160145.GC11014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:15:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTUx-0004V4-Nx
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab0HaQPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 12:15:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53839 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183Ab0HaQPl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 12:15:41 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D1E39415;
	Tue, 31 Aug 2010 12:15:40 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 31 Aug 2010 12:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Pa9r7/6ga9rmyicGHKQLf7uMN0I=; b=NWj1Yie4v/2FweX3zyN7DtCaRh2aAcDcBODh6UE6OiZBji8mZduwcZARNexNFyr0VxIyP6FUY6R956twXsVhj05aGL+tiZUVehIL1jOgHOxL984opGAvJZTVDjEXLF4YdWJV3U5cuV7vjrsDkD6Ytox7zELHB1pJ39SSWQfS4pg=
X-Sasl-enc: h6009iQJ0lwCdRgYNrRWM3oJE/h5bhb5ldwdFD9e+viK 1283271340
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 19BAD406676;
	Tue, 31 Aug 2010 12:15:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <20100831160145.GC11014@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154932>

Jeff King venit, vidit, dixit 31.08.2010 18:01:
> On Tue, Aug 31, 2010 at 05:16:17PM +0200, Michael J Gruber wrote:
> 
>> Currently, "git notes" behaves like "git commit --allow-empty" when
>> committing notes trees. In particular, removing nonexisting notes leads
>> to empty commits "commits with no diff".
>>
>> Change this to avoid unnecessary notes commits.
> 
> Is this a sufficient check in the case of notes? Is it possible that we
> re-balanced the fanout of the notes tree and got a different tree sha1,
> even though there is nothing interesting to commit?

Yes, but I don't think this hurts. The main thrust here is to catch the
case of repeated "git notes remove". Also, we might even want to record
the history when there is rebalancing since this is indeed a tree change.

Johan's (later ;) ) approach, while being more intrusive, catches this
at the point of removal - if there's nothing to remove, nothing gets
rewritten.

> 
>> +	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
>> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
> 
> I didn't check, but I can imagine you can drop the parse_tree here. We
> should know the object sha1 once the commit is parsed.

parse_commit() does a lookup_tree() but I don't think that it parses the
tree, i.e. I don't hink it fills in tree->object.sha1. At least it
segfaulted without that ;)

Michael
