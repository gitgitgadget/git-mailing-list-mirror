From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Thu, 07 Feb 2013 10:47:55 +0100
Message-ID: <5113784B.10103@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net> <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net> <20130206223656.GF27507@sigill.intra.peff.net> <51136E75.5060002@drmicha.warpmail.net> <20130207092640.GC15727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3O5h-0005LI-3n
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab3BGJr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:47:58 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38863 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962Ab3BGJrz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 04:47:55 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 92FAB21211;
	Thu,  7 Feb 2013 04:47:54 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 07 Feb 2013 04:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nBWh0P0mQsNY5qfv3RK4el
	xOx44=; b=pz7gy3KEwmCFkoXXrBpg0eGFg4Rg963CqxPBg9V1kCmw1m+pywg5wT
	V2Xe6f+1SYVziF1NDho32Bx8s8jEGDqgrSTpF1i59cLgecGEra0hCbe8XAR87FyX
	TR9V5QRYqRsCINHp4js3B5sIzcI8yRPW1Bk86PyewxOSdKG6tVEn8=
X-Sasl-enc: O2G+AaelvX6n3mtwcprHLtZPVhQSxswkcEvVYhhNZLcM 1360230474
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EB6228E0901;
	Thu,  7 Feb 2013 04:47:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130207092640.GC15727@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215687>

Jeff King venit, vidit, dixit 07.02.2013 10:26:
> On Thu, Feb 07, 2013 at 10:05:57AM +0100, Michael J Gruber wrote:
> 
>>>> @@ -265,9 +260,28 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
>>>>  	objects[nr].item = obj;
>>>>  	objects[nr].name = name;
>>>>  	objects[nr].mode = mode;
>>>> +	objects[nr].context = context;
>>>>  	array->nr = ++nr;
>>>>  }
>>>
>>> This seems a little gross. Who is responsible for allocating the
>>> context? Who frees it? It looks like we duplicate it in cmd_grep. Which
>>
>> Well, who is responsible for allocating and freeing name and item? I
>> didn't want to introduce a new member which is a struct when all other
>> complex members are pointers. Wouldn't that be confusing?
> 
> We cheat on those two. "item" is always a pointer to a "struct object",
> which lasts forever and never gets freed. When "name" is set by
> setup_revisions, it comes from the argv list, which is assumed to last
> forever (and when we add pending blobs for a "--objects" traversal, it
> is the empty string (literal).

I see, so they are really different.

> I'd be OK if we had an exterior object_context that could be handled
> in the same way. But how do we tell setup_revisions that we are
> interested in seeing the object_context from each parsed item, where
> does the allocation come from (is it malloc'd by setup_revisions?), and
> who is responsible for freeing it when we pop pending objects in
> get_revisions and similar?

Do we really need all of tree, path and mode in object_context (I mean
not just here, but other users), or only the path? I'd try and resurrect
the virtual path name objects then, they would be just like "item"
storage-wise.

> I don't think it's as clear cut.
> 
> I wonder, though...what we really care about here is just the pathname.
> But if it is a pending object that comes from a blob revision argument,
> won't it always be of the form "treeish:path"? Could we not even resolve
> the sha1 again, but instead just parse out the ":path" bit?

Do we have that, and in what form (e.g. magic expanded etc.)?

> That is sort of like what the repeated call to get_sha1_with_context
> does in your first patch. Except that we do not actually want to lookup
> the sha1, and it is harmful to do so (e.g., if the ref had moved on to a
> new tree that does not have that path, get_sha1 would fail, but we do
> not even care what is in the tree; we only want the parsing side effects
> of get_sha1).
> 
> Hmm.
> 
> -Peff
> 
> PS By the way, while looking at the object_array code (which I have not
>    really used much before), I noticed that add_pending_commit_list sets
>    the "name" field to the result of sha1_to_hex. Which means that it is
>    likely to be completely bogus by the time you read it. I'm not even
>    sure where it gets read or if this matters. And obviously it's
>    completely unrelated to what we were discussing; just something I
>    noticed.

Another thing I noted is that our path mangling at least for grep has
some issues:

(cd t && git grep GET_SHA1_QUIETLY HEAD:../cache.h)
../HEAD:../cache.h:#define GET_SHA1_QUIETLY        01

Taking everything right of ":" could still work.

Michael
