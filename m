From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error
 back to client
Date: Sat, 01 Nov 2008 12:34:36 +0100
Message-ID: <490C3ECC.1000301@op5.se>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>	 <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de>	 <alpine.LFD.2.00.0810312218300.13034@xanadu.home>	 <alpine.DEB.1.00.0811010334010.22125@pacific.mpi-cbg.de.mpi-cbg.de> <b97024a40810312035v5416b578v51b5bed528ca8d39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:36:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEm1-0005Ee-Jo
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbYKALe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYKALe4
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:34:56 -0400
Received: from mail.op5.se ([193.201.96.20]:59287 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbYKALez (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:34:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8555E1B803EA;
	Sat,  1 Nov 2008 12:29:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ndlxaLbDhbi; Sat,  1 Nov 2008 12:29:33 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id A25751B800AF;
	Sat,  1 Nov 2008 12:29:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <b97024a40810312035v5416b578v51b5bed528ca8d39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99736>

Tom Preston-Werner wrote:
> On Fri, Oct 31, 2008 at 7:35 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Fri, 31 Oct 2008, Nicolas Pitre wrote:
>>
>>> On Sat, 1 Nov 2008, Johannes Schindelin wrote:
>>>
>>>> On Fri, 31 Oct 2008, Tom Preston-Werner wrote:
>>>>
>>>>> The current behavior of git-daemon is to simply close the connection
>>>>> on any error condition. This leaves the client without any
>>>>> information as to the cause of the failed fetch/push/etc.
>>>>>
>>>>> This patch allows get_remote_heads to accept a line prefixed with
>>>>> "ERR" that it can display to the user in an informative fashion.
>>>>> Once clients can understand this ERR line, git-daemon can be made to
>>>>> properly report "repository not found", "permission denied", or
>>>>> other errors.
>>>>>
>>>>> Example
>>>>>
>>>>> S: ERR No matching repository.
>>>>> C: fatal: remote error: No matching repository.
>>>> Makes sense to me.
>>> Note that this behavior of not returning any reason for failure was
>>> argued to be a security feature in the past, by Linus I think.
>> Yes.  And it might still be considered one.  You do not need to patch
>> git-daemon to use that facility (note that Tom's patch was only for the
>> client side).
>>
>> But for hosting sites such as repo.or.cz or GitHub, that security feature
>> just does not make sense, but it makes for support requests that could be
>> resolved better with a proper error message.
> 
> We could also have the error messages sent back conditionally based on
> a command line switch. I've begun porting the changes I made in our
> Erlang git-daemon back to the C code, so maybe I'll give that a try.
> We *definitely* need good error messages for GitHub and I see no
> security risk in doing so.
> 
> Maybe this is worth asking the question: does anybody use git-daemon
> for private code? If so, why are they not using SSH instead? And in
> that case, how are informative error messages a security risk?
> 

Because it can potentially allow attackers to gain a lot of information
about your system. For instance, if you have /var/lib/rpm on your system,
you're likely running an RPM-based installation. Otoh, if you have
/usr/bin/apt-get, you're most likely running a dpkg-based one. Such info
is vital for the attacker to know what version of a certain server-program
you're using, and can then be used to scan the very helpful world wide web
for security issues concerning your exact distribution.

I'm not saying that's possible with git-daemon now (although I haven't tried),
but if, one day, a git-daemon were to accept a path such as ../../../, we'd
be in real trouble, and an attacker would have no problems what so ever
doing educated guesses on exactly what kind of software is running on your
server.

So, please don't enable any such feature by default. Bury it somewhere deep
in documentation so that users do not enable it by default, or attach a big
fat warning to the docs mentioning it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
