From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Mon, 28 Jan 2013 21:12:39 +0100
Message-ID: <5106DBB7.70007@web.de>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com> <1359290777-5483-2-git-send-email-hjemli@gmail.com> <7vk3qywiqf.fsf@alter.siamese.dyndns.org> <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com> <20130128081006.GA2434@elie.Belkin> <7vham1xktx.fsf@alter.siamese.dyndns.org> <CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com> <7vr4l5w385.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzv72-0003HS-LE
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab3A1UPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:15:07 -0500
Received: from mout.web.de ([212.227.17.12]:58874 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab3A1UPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:15:05 -0500
Received: from [192.168.178.41] ([79.193.83.234]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MGRI8-1UD8TC2CfY-00DNS2; Mon, 28 Jan 2013 21:12:43
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vr4l5w385.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:M96khW7NsYuviZMP6BQyiBkXIM5P8t3DYiEEIkyPUXb
 0M5cNjzYauhHAiOu11RIPDCiOKD9K54PNiT2NE2pCUnjA3MNOT
 eBfe4p1c4b3xCDdncs7/Q7um0xy/mFh9H9YD5+/xq6d8vlR9jg
 24KnJXWZssZeF1ancXKqE0VK7ZHfDkC39Y3ZzHvxbmlSQYMwqE
 S6fieQAcz63XoXj6/9X5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214862>

Am 28.01.2013 19:51, schrieb Junio C Hamano:
> Lars Hjemli <hjemli@gmail.com> writes:
> 
>>> Come to think of it, is there a reason why "for-each-repo" should
>>> not be an extention to "submodule foreach"?  We can view this as
>>> visiting repositories that _could_ be registered as a submodule, in
>>> addition to iterating over the registered submodules, no?
>>
>> Yes, but I see some possible problems with that approach:
>> -'git for-each-repo' does not need to be started from within a git worktree
> 
> True, but "git submodule foreach --untracked" can be told that it is
> OK not (yet) to be in any superproject, no?

Hmm, I'm not sure how that would work as it looks for gitlinks
in the index which point to work tree paths.

>> -'git for-each-repo' and 'git submodule foreach' have different
>> semantics for --dirty and --clean

I'm confused, what semantics of --dirty and --clean does current
'git submodule foreach' have? I can't find any sign of it in the
current code ... did I miss something while skimming through this
thread? Or are you talking about status and diff here?

> That could be a problem.  Is there a good reason why they should use
> different definitions of dirtyness?

I don't see any (except of course for comparing a gitlink with the
HEAD of the submodule, which is an additional condition that only
applies to submodules). But I think the current for-each-repo
proposal doesn't allow to traverse repos which contain untracked
content (and it would be nice if the user could somehow combine
that with the current --dirty flag to have both in one go).

>> -'git for-each-repo' is in C because my 'git-all' shell script was
>> horribly slow on large directory trees (especially on windows)
> 
> Your for-each-repo could be a good basis to build a new builtin
> "submodule--foreach" that is a pure helper hidden from the end users
> that does both; cmd_foreach() in git-submodule.sh can simply delegate
> to it.

I like that approach, because the operations are very similar from
the user's point of view. But please remember that internally they
would work differently, as submodule foreach walks the index and
only descends into those submodules that are populated (and contain
a .git directory or file) while for-each-repo scans the whole work
tree, which makes it a more expensive operation.

>> All of these problems are probably solvable, but it would require
>> quite some reworking of git-submodule.sh
> 
> Of course some work is needed, but we do not have to convert all the
> cmd_foo in git-submodule.sh in one step.  For the purpose of
> unifying for-each-repo and submodule foreach to deliver the
> functionality sooner to the end users, we can go the route to add
> only the submodule--foreach builtin, out of which we will get
> reusable implementation of module_list and other helper functions we
> can leverage later to do other cmd_foo functions.

I really like that idea!
