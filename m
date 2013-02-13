From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pushing a git repository to a new server
Date: Wed, 13 Feb 2013 09:08:36 +0100
Message-ID: <511B4A04.1000104@drmicha.warpmail.net>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com> <20130211075040.GJ5210@localhost.localdomain> <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com> <20130211162714.GB16402@sigill.intra.peff.net> <511A2775.9050209@drmicha.warpmail.net> <20130212204210.GA25330@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ethan Reesor <firelizzard@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 09:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5XW4-0002x6-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 09:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122Ab3BMIQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 03:16:09 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49668 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754588Ab3BMIQH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2013 03:16:07 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2013 03:16:07 EST
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CFE81209DD;
	Wed, 13 Feb 2013 03:08:34 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 13 Feb 2013 03:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=HoYps12cnfkXbYVCXJ0Xy2
	eJzTM=; b=K3oqQYI0Np/bQKMM0fgETjDNDGdAaTW0VHL3gM8+rs3eN7lEvKHOAk
	VNpz4BugE3A46Em9d2V6mYpfApkfJMpHGHc5akTqdkFuWGDuiNtgBeMTCULskMiG
	Mr8iajS/hYUG1cntPPg+T2Sq36aQg4eAOHoTKBs2Pzw7Yu+ka4DOM=
X-Sasl-enc: BwoaAsn73AOrlyYzmKVRIH0QSiqg2hDvMEE2OosyWbbm 1360742914
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 170A88E04E8;
	Wed, 13 Feb 2013 03:08:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130212204210.GA25330@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216238>

Jeff King venit, vidit, dixit 12.02.2013 21:42:
> On Tue, Feb 12, 2013 at 12:28:53PM +0100, Michael J Gruber wrote:
> 
>> I'm not sure providers like GitHub would fancy an interface which allows
>> the programmatic creation of repos (giving a new meaning to "fork
>> bomb"). But I bet you know better ;-)
> 
> You can already do that:
> 
>   http://developer.github.com/v3/repos/#create

Nice.

I knew you knew ;)

> We rate-limit API requests, and I imagine we might do something similar
> with create-over-git. But that is exactly the kind of implementation
> detail that can go into a custom create-repo script.
> 
>> An alternative would be to teach git (the client) about repo types and
>> how to create them. After all, a repo URL "ssh://host/path" gives a
>> clear indication that "ssh host git init path" will create a repo.
> 
> But that's the point of a microformat. It _doesn't_ always work, because
> the server may not allow arbitrary commands, or may have special
> requirements on top of the "init". You can make the microformat be "git
> init path", and servers can intercept calls to "git init" and translate
> them into custom magic. But I think the world is a little simpler if we
> define a new service type (alongside git-upload-pack, git-receive-pack,
> etc), and let clients request it. Then it's clear what the client is
> trying to do, it's easy for servers to hook into it, we can request it
> over http, etc. And it can be extended over time to take more fields
> (like repo description, etc).
> 
> I'm really not suggesting anything drastic. The wrapper case for ssh
> would be as simple as a 3-line shell script which calls "git init" under
> the hood, but it provides one level of indirection that makes
> replacing/hooking it much simpler for servers. So the parts that are in
> stock git would not be much work (most of the work would be on _calling_
> it, but that is the same for adding a call to "git init").
> 
> I think the main reason the idea hasn't gone anywhere is that nobody
> really cares _that_ much. People just don't create repositories that
> often. I feel like this is one of those topics that comes up once a
> year, and then nothing happens on it, because people just make their
> repo manually and then stop caring about it.
> 
> Just my two cents, of course. :)

Most repos are probably created by a local "git init" or "git clone", or
by clicking a button on a provider's web interface. The need for
git-create-repo seems to be restricted to:

- "command line folks" who use a provider for it's hosting service and
don't fancy a web interface for repo creation

- noobs who need to get their head wrapped around local, remote,
push/pull 'n' stuff...

For the server side git-create-repo to take off we would probably need
two things (besides the client support):

- Implement and ship a git-create-repo which makes this work for git
over ssh seamlessly. (Will take some to trickle down to servers in the
wild.)

- Get a large provider to offer this.

Gitosis/Gitolite are probably to follow easily. I'm beginning to like
idea ;)

Michael
