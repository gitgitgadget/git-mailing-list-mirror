From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 22:50:02 +0200
Message-ID: <505CD2FA.80200@kdbg.org>
References: <505C7C80.3000700@workspacewhiz.com> <7vy5k370n7.fsf@alter.siamese.dyndns.org> <505CB21E.4040607@workspacewhiz.com> <7vtxur3zxi.fsf@alter.siamese.dyndns.org> <505CCD2A.8020003@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:50:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAB0-0004lF-VA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074Ab2IUUuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:50:08 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:7272 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757922Ab2IUUuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:50:07 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1A229A7EB4;
	Fri, 21 Sep 2012 22:50:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0303F19F3CA;
	Fri, 21 Sep 2012 22:50:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <505CCD2A.8020003@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206162>

Am 21.09.2012 22:25, schrieb Joshua Jensen:
> ----- Original Message -----
> From: Junio C Hamano
> Date: 9/21/2012 2:04 PM
>> Joshua Jensen <jjensen@workspacewhiz.com> writes:
>>
>>>> Is there any particular reason you do that as two separate steps?
>>>> It would feel more natural, at least to me, to do something along
>>>> the lines of
>>>>
>>>>     git log --show-notes=p4notes -1000
>>>>
>>>>
>>> Thanks for the reply.
>>>
>>> I did not make clear above that I want to stop looking when I find the
>>> first commit that has the note.
>>>
>>> In the case of 'git log --show-notes=p4notes -1000', Git will process
>>> and hand me the log output for 1,000 commits.  It is rare I need to
>>> walk that deep.
>> I simply matched it with your initial "rev-list --max-count=1000".
>> The "log" command pages and you can hit 'q' once you saw enough (in
>> other words, you do not have to say -1000).
>>
> This is run via script without user intervention.  Presumably, Git will
> do 1,000 commits of work when it may only need to do 1 or 5 or 10?

The trick is to pipe 'git log' output into another process that reads no
more than it needs and exits. Then 'git log' dies from SIGPIPE before it
processed all 1000 commits because its down-stream has gone away.

For example:

  git log --show-notes=p4notes -1000 |
  sed -n -e '/^commit /h' -e '/P4@/{H;g;p;q}'

(The pipeline keeps track of the most recent 'commit' line, and when it
finds the 'P4@' it prints the most recent 'commit' line followed by the
'P4@' line.)

-- Hannes
