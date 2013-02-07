From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Thu, 07 Feb 2013 11:31:22 +0100
Message-ID: <5113827A.40801@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net> <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net> <20130206223656.GF27507@sigill.intra.peff.net> <51136E75.5060002@drmicha.warpmail.net> <20130207092640.GC15727@sigill.intra.peff.net> <5113784B.10103@drmicha.warpmail.net> <20130207095533.GA17110@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 11:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Old-0006AH-5E
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 11:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab3BGKbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 05:31:22 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59939 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753447Ab3BGKbW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 05:31:22 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6B7F920268;
	Thu,  7 Feb 2013 05:31:21 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 07 Feb 2013 05:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LV8GPgCFk/pq32h4payttq
	1DApw=; b=ROzDmmTBAvulYawqpkxrKOYs3rhwysqcUUs4pFb395H9jr6wEnenFK
	TLO80Fr30vnCPVuxrBUqfwLPGbL+2FQ7aKJNWolhqyu/ilJyZvmzcFS8OK5JrdPC
	LGfOpgFIQ+FzCgtRQ5lUhlHn152PMGwrbN4Yb9Sf6ZDBhzINuvv5o=
X-Sasl-enc: euBGLh7XNVcjiiHZsuDx4pLjO9tAwqqv6HH29HMUAW9R 1360233081
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C09904825C4;
	Thu,  7 Feb 2013 05:31:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130207095533.GA17110@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215690>

Jeff King venit, vidit, dixit 07.02.2013 10:55:
> On Thu, Feb 07, 2013 at 10:47:55AM +0100, Michael J Gruber wrote:
> 
>>> I'd be OK if we had an exterior object_context that could be handled
>>> in the same way. But how do we tell setup_revisions that we are
>>> interested in seeing the object_context from each parsed item, where
>>> does the allocation come from (is it malloc'd by setup_revisions?), and
>>> who is responsible for freeing it when we pop pending objects in
>>> get_revisions and similar?
>>
>> Do we really need all of tree, path and mode in object_context (I mean
>> not just here, but other users), or only the path? I'd try and resurrect
>> the virtual path name objects then, they would be just like "item"
>> storage-wise.
> 
> We need at least mode, since that is how the mode parameter of
> object_array_entry gets set. I do not know off-hand who uses "tree". I
> suspect the intent was to do .gitattributes lookups inside that tree,
> but I do not think we actually do in-tree lookups currently.
> 
>>> I don't think it's as clear cut.
>>>
>>> I wonder, though...what we really care about here is just the pathname.
>>> But if it is a pending object that comes from a blob revision argument,
>>> won't it always be of the form "treeish:path"? Could we not even resolve
>>> the sha1 again, but instead just parse out the ":path" bit?
>>
>> Do we have that, and in what form (e.g. magic expanded etc.)?
> 
> Ah, I should have mentioned that. :) We should have the original rev
> name in the object_array_entry's name field, shouldn't we? It's just a
> matter of re-parsing it.
> 
>> Another thing I noted is that our path mangling at least for grep has
>> some issues:
>>
>> (cd t && git grep GET_SHA1_QUIETLY HEAD:../cache.h)
>> ../HEAD:../cache.h:#define GET_SHA1_QUIETLY        01
> 
> Yuck.

And even more yuck:

(cd t && git grep --full-name GET_SHA1_QUIETLY HEAD:../cache.h)
HEAD:../cache.h:#define GET_SHA1_QUIETLY        01

Someone does not expect a "rev:" to be in there, it seems ;)

Michael
