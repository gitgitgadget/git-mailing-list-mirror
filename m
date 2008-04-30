From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression?] "git status -a" reports modified for empty  
 submodule directory
Date: Wed, 30 Apr 2008 00:29:50 -0700
Message-ID: <7vej8n3imp.fsf@gitster.siamese.dyndns.org>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
 <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
 <7v4p9k7326.fsf@gitster.siamese.dyndns.org> <4818143C.6050206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 09:30:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr6m9-0002NJ-FG
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 09:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbYD3H37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 03:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754463AbYD3H37
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 03:29:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbYD3H36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 03:29:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B83DD3866;
	Wed, 30 Apr 2008 03:29:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CE4073865; Wed, 30 Apr 2008 03:29:53 -0400 (EDT)
In-Reply-To: <4818143C.6050206@viscovery.net> (Johannes Sixt's message of
 "Wed, 30 Apr 2008 08:39:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C3404D2-1687-11DD-9C37-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80803>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> "Ping Yin" <pkufranky@gmail.com> writes:
>> 
>>> In the super project super with empty submodule directory sub
>>> $ git diff
>>> diff --git a/sub b/sub
>>> deleted file mode 160000
>>> index f2c0d45..0000000
>>> --- a/sub
>>> +++ /dev/null
>>> @@ -1 +0,0 @@
>>> -Subproject commit f2c0d4509a3178c...
>> 
>> The repository used to have a subproject and now it doesn't.  Why
>> shouldn't it report the removal?
>
> Because you are not required to have a subproject checked out?

Yes, but.

This is a policy issue, which is not very well enforced currently.

I have been scratching my head to figure out where the right balance we
should strike at for the past week and a half.

For example, it has long been known ever since submodules were introduced
that if you work inside a sparsely checked out supermodule you have to use
"commit -a" with care, because the command notices missing submodule, and
there is no way for it to differenciate between the case you _want to_
remove it and the case you did not care about it, so you will end up
removing unchecked out submodules.

That quirk was something people could live with while submodule support
was merely a newly invented curiosity.  But I do not think a command at
high level (iow Porcelain) such as commit and status should be left
unaware of the Policy that equate missing submodule and unmodified one
forever.  We should actively enforce the policy, so that unless you
explicitly ask nicely, the command should consider a missing submodule
just as unmodified, e.g. "commit -a" should not remove unchecked out
submodules.

But then you would need a way to ask nicely.  How?  Perhaps using "git rm",
and low level "update-index --remove".  Do we even need "commit -A"?  I
doubt it --- you do not remove submodules every day.

We'd like to keep the lowest-level unaware of the Policy, which means that
"diff-files" and "diff-index" should report unchecked out submodules.
Otherwise script writers will be left with no way to differenciate missing
and removed submodules.

Once we start doing this, I think "git diff" Porcelain should fall into
Policy-aware category.
