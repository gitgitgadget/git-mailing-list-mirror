From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] help git-upload-pack find git
Date: Tue, 16 Sep 2008 15:15:47 +0200
Message-ID: <48CFB183.1090205@drmicha.warpmail.net>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <1221495891-12600-1-git-send-email-git@drmicha.warpmail.net> <7vzlm9b3v4.fsf@gitster.siamese.dyndns.org> <48CEC3FB.5070101@drmicha.warpmail.net> <48CF4F6A.6080604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 15:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfaQQ-0001Jo-Be
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbYIPNPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 09:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbYIPNPw
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 09:15:52 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54284 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753214AbYIPNPv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 09:15:51 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 3006B163178;
	Tue, 16 Sep 2008 09:15:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 16 Sep 2008 09:15:50 -0400
X-Sasl-enc: +zRbZ+2ewI4R9zByvwxj3MorTJ024aCMb7DCEx8Vc3CJ 1221570949
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6CC801FB33;
	Tue, 16 Sep 2008 09:15:49 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48CF4F6A.6080604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96001>

Johannes Sixt venit, vidit, dixit 16.09.2008 08:17:
> Michael J Gruber schrieb:
>> I was actually surprised that setup_path() uses argv0_path without
>> setting it, same as with argv_exec_path. I assumed this is for a good
>> reason, I'm lacking the code base overview to judge this myself.
> 
> It argv_exec_path comes from git --exec-path=..., hence, git (via git.c)
> is the only caller of setup_path() that is able to set it. We can leave
> that one out of the equation.
> 
>> In any case, git.c sets argv0_path early, messes a bit with argv[0] and
>> calls setup_path afterwards anyways. So adding the path in setup_path()
>> should not hurt any "git foo" command.
>>
>> One could construe situations where even that wouldn't help, because
>> git-upload-pack can't pass --exec-dir to git and they can be in
>> different locations - but I think that's crazy.
>>
>> git.c, upload-pack.c, receive.pack.c and shell.c are the only callers.
>> setup_path() needs to get a parameter. If shell.c should profit from the
>> change then it needs to be taught how to pass an absolute path to
>> do_{generic,cvs}_cmd().
>>
>> So, I guess the general approach (change setup() path and have every
>> caller profit) is OK. OK with you?
> 
> Have you studied the commit message of e1464ca7bb0d (Record the command
> invocation path early) and the context in which this commit occurs? It's
> about relocatable git installations and how system_path() derives various
> other paths from argv[0].

That is what I meant by my lack of overview ;)
I might have implemented what amounts to a revert of e1464ca7bb0d otherwise.

> Please show how you think you could change setup_path(), but keep in mind
> that in git.c you neither can do the equivalent of git_set_argv0_path()
> later nor setup_path() earlier.

Well, I'd be happy with the change in upload-pack as submitted. Junio
suggested the more general approach. In fact I'd prefer everyone set
their path, but not everyone seems to be allowed to in their restricted
environments.

Why is it that setup_path() cannot be done before commit_pager_choice()?
We need the pager in case list_common_cmds_help() is triggered, but why
can't setup_path() be before that? Not because of "--", really.

Michael
