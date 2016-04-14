From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Ambiguous sha-1 during a rebase
Date: Thu, 14 Apr 2016 11:09:06 +0200
Message-ID: <vpqr3e8wo99.fsf@anie.imag.fr>
References: <20160413222919.GA10474@glandium.org>
	<xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
	<20160413225234.GA21602@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 11:09:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqdHW-0005tp-CH
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 11:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbcDNJJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 05:09:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41224 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531AbcDNJJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 05:09:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3E995bg005406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 14 Apr 2016 11:09:05 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3E996rY028954;
	Thu, 14 Apr 2016 11:09:06 +0200
In-Reply-To: <20160413225234.GA21602@glandium.org> (Mike Hommey's message of
	"Thu, 14 Apr 2016 07:52:34 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 14 Apr 2016 11:09:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3E995bg005406
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461229746.45826@WnZ8Y+YabsaKv64L7AGZzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291515>

Mike Hommey <mh@glandium.org> writes:

> On Wed, Apr 13, 2016 at 03:42:44PM -0700, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> 
>> > Should git-rebase use full sha-1s under the hood to avoid these type of
>> > races?
>> 
>> It already should be doing so since Aug 2013, IIRC.
>
> I'm using 2.8.1. Would there have been a regression?

I guess you managed to get into a corner-case which isn't managed
properly. With my git version 2.8.1.53.g7ee34ab, I just checked the
normal use-case:

$ git rebase -i HEAD^^

The editor pops up with short sha1. I insert a "exec false" like this:

,----[ git-rebase-todo ]
| pick 0c722f9 foo
| exec false
| pick 6305d56 commited
`----

The execution goes on like this:

  Executing: false
  Execution failed: false
  You can fix the problem, and then run
  
          git rebase --continue
  

And I can check:

$ cat .git/rebase-merge/git-rebase-todo
pick 6305d56f7218b6f04451bab3ff27adb80dd6dad4 commited
...


I suspect you did:

$ git rebase -i
# editor pops up
# switch to another terminal and fetch from elsewhere
# close editor

Then only, git turns short sha1s into long ones, and does not have the
information to resolve ambiguities.

We could save a map (short -> long) before poping the editor and use
this map in priority when normalizing the todo-list to use long sha1s,
but we currently don't.

But I'm tempted to say that you just went very, very unlucky, and it's
not worth fixing ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
