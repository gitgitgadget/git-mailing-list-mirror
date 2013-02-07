From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Thu, 07 Feb 2013 10:05:57 +0100
Message-ID: <51136E75.5060002@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net> <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net> <20130206223656.GF27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3NR0-0001Kg-OG
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab3BGJF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:05:59 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51088 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962Ab3BGJF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 04:05:57 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 55C3020A3B;
	Thu,  7 Feb 2013 04:05:57 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 07 Feb 2013 04:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=IGVIeZcRWLR4SfoXnziFN/
	km9XM=; b=ThTBI7Z2l6gka7n/H9g7VtTUG2UqlavpMaGl2DcBVK21LtsIF1Fgs3
	LOOM9SY1socrHirsJ7hzDYvEQw9ihr/Lkdf1jXo9VvXimEYz3FlctLyn+tEuaEq8
	lTqKZegxPnsvH2U3Y9PUsGeXU2iyW3OPB+8FXxixH4oR2SWAiH7rE=
X-Sasl-enc: xNRVXihfMH3xwSYprx+dnDkkwxyWjSdRcVcrjOvtQvbQ 1360227956
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6E560482524;
	Thu,  7 Feb 2013 04:05:56 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130206223656.GF27507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215681>

Jeff King venit, vidit, dixit 06.02.2013 23:36:
> On Wed, Feb 06, 2013 at 04:08:53PM +0100, Michael J Gruber wrote:
> 
>> -			add_object_array(object, arg, &list);
>> +			add_object_array_with_context(object, arg, &list, xmemdupz(&oc, sizeof(struct object_context)));
> 
> If we go this route, this new _with_context variant should be used in
> patch 1, too.
> 
>> @@ -265,9 +260,28 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
>>  	objects[nr].item = obj;
>>  	objects[nr].name = name;
>>  	objects[nr].mode = mode;
>> +	objects[nr].context = context;
>>  	array->nr = ++nr;
>>  }
> 
> This seems a little gross. Who is responsible for allocating the
> context? Who frees it? It looks like we duplicate it in cmd_grep. Which

Well, who is responsible for allocating and freeing name and item? I
didn't want to introduce a new member which is a struct when all other
complex members are pointers. Wouldn't that be confusing?

> I think is OK, but it means all of this context infrastructure in
> object.[ch] is just bolted-on junk waiting for somebody to use it wrong
> or get confused.  It does not get set, for example, by the regular
> setup_revisions code path.

Sure, it's NULL when there is no context info, just like in many other
cases.

> It would be nice if we could just always have the context available,
> then setup_revisions could set it up by default (and replace the "mode"
> parameter entirely). But we'd need to do something to avoid the
> PATH_MAX-sized buffer for each entry, as some code paths may have a
> large number of pending objects.

If the information is always available even if we don't need it then it
always takes space. The only way out would be pointing into a pool of
path names rather having a copy in each entry. It's not like I hadn't
talked about providing virtual (blob) objects for path names keyed by
their sha1 before... It's just that I want my grep --textconv now ;)

Michael
