From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH 2/2] builtin-reflog: fix deletion of HEAD entries
Date: Sun, 10 Aug 2008 21:04:56 +0200
Message-ID: <9746FE5D-816C-4818-B32F-EE0028918F72@ai.rug.nl>
References: <7vd4kh4r9m.fsf@gitster.siamese.dyndns.org> <1218360901-36215-1-git-send-email-pdebie@ai.rug.nl> <7vej4w3dou.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 21:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSGF3-0002Lz-8L
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 21:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYHJTFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 15:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYHJTFK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 15:05:10 -0400
Received: from frim.nl ([87.230.85.232]:34781 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752844AbYHJTFJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Aug 2008 15:05:09 -0400
Received: from ip63-33-210-87.adsl2.static.versatel.nl ([87.210.33.63] helo=[192.168.1.244])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KSGDw-00036v-8F; Sun, 10 Aug 2008 21:05:04 +0200
In-Reply-To: <7vej4w3dou.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91877>


On Aug 10, 2008, at 8:52 PM, Junio C Hamano wrote:

> Pieter de Bie <pdebie@ai.rug.nl> writes:
>
>> On Aug 10, 2008, at 3:01 AM, Junio C Hamano wrote:
>>> -		if (!dwim_ref(argv[i], spec - argv[i], sha1, &ref)) {
>>> +		if (!dwim_log(argv[i], spec - argv[i], sha1, &ref)) {
>>
>> This is also what add_reflog_for_walk() does, but that function  
>> tries to resolve
>> the argv[i] part first, without doing the dwim_log().
>>
>> Perhaps we can also ...
>
> Sorry, I do not understand what you meant by the above comment.

Sorry, it was early in the morning ;)

> - "This is also what add_reflog_for_walk() does" -- I take it you mean
>   the use of dwim_log() instead of dwim_ref()?

Yes

> - "... but that function tries to resolve the argv[i] part first" --  
> do
>   you mean the resolve_ref("HEAD"...) call inside "if (!*branch)"
>   codepath?
>
>   That one serves different purposes than "delete HEAD@{42}".  It is
>   about showing "@{42}" --- in order to show reflog for "the current
>   branch", it figures out the current branch by resolving "HEAD".

No, I meant this part:

reflogs = read_complete_reflog(branch);
if (!reflogs || reflogs->nr == 0)
	if (dwim_log(branch, strlen(branch), sha1, &b) == 1) {
		branch = b;
		reflogs = read_complete_reflog(branch);
	}

Which seems to suggest that the read_complete_reflog() may produce  
different results if dwim_log() is not called. However, I did not  
follow the codepath to see why.

> In any case, what confuses me is I cannot tell if you do or do not  
> have
> issues that I did not think of with the "s/dwim_ref/dwim_log/" change.
> Are you saying "no that cannot be a correct fix; see the way  
> dwim_log() is
> used in add_reflog_for_walk() -- it does more than your one-liner"?

I think the change looks ok. The only 'problem' I had was the chunk  
above, because I do not know if the double call to  
read_complete_reflog, once without a dwim_log and optionally once  
with, is significant. However, I'm not familiar enough with the code  
to make any observation other than that, which is why my reply had no  
conclusion ;)

Hope that clears things up.

> By the way, I think the idea of "Perhaps we can also..." part is good.

I'll send in a better patch.

- Pieter
