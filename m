From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 15:26:23 +0100
Message-ID: <49B6788F.2080609@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302> <49B64ADC.2090406@viscovery.net> <49B64C3A.50909@viscovery.net> <alpine.DEB.1.00.0903101236480.14295@intel-tinevez-2-302> <49B659B4.5000705@viscovery.net> <alpine.DEB.1.00.0903101343530.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 15:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh2w8-0003H4-7a
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 15:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbZCJO0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 10:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbZCJO0e
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 10:26:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4916 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbZCJO0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 10:26:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lh2uW-0007zM-98; Tue, 10 Mar 2009 15:26:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F28D24FB; Tue, 10 Mar 2009 15:26:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903101343530.14295@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112818>

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 10 Mar 2009, Johannes Sixt wrote:
> 
>> Johannes Schindelin schrieb:
>>> FWIW GitTorrent may be implemented as part of git-daemon, if Sam's 
>>> ideas become reality.  And then, sideband transport is _the_ means to 
>>> do asyncrounous communication while pushing bytes.
>> I do not see how recv_sideband() in its current form could be helpful 
>> here (assuming that you really are thinking of sending binary data over 
>> band #2).
> 
> I think it is a safe bet that the side band would be a good way to 
> exchange updates to the mirror list as well as the refs list.

Binary or not - the purpose and suitability of the sideband *protocol* for
this task are undisputed.

But you don't want to have "remote:" thrown in at seemingly random places
in the demultiplexed stream that comes fromt he current implementation of
recv_sideband().

>>> On Tue, 10 Mar 2009, Johannes Sixt wrote:
>>>> And it really is: Did you notice that stuff that recv_sideband sends 
>>>> over the channel named 'err' (before my patch) has "remote: " 
>>>> prepended on every line? That's certainly not an implementation that 
>>>> you want if you send binary data over that band!
>>> Yes, that is unfortunate, but can be fixed easily.
>> I don't believe this. Every treatment of "remote: " that you take away
>> from recv_sideband() you must insert somewhere else. Perhaps easy, but
>> certainly not as trivial as my patch.
> 
> AFAICT it would be a matter of
> 
> 	unsigned pf = isatty(err) ? strlen(PREFIX) : 0;

But don't you see that are mixing a high-level concept of "terminal" into
the low-level function that you want it to be? In its current form,
recv_sideband() is *not* a low-level utility, it's already at a high level
that knows about the line-oriented nature of band #2. What you need for
GitTorrent is a different function that *only* demultiplexes the sideband
protocol data into different streams without munging them. That's a
totally different function that *maybe* can share some code with the
current recv_sideband().

>> Just a reminder: You proposed to override write() on Windows in a 
>> non-trivial way, and we are discussing the topic above because I think 
>> that is not a good idea. The reasons are:
>>
>> - write() is a fundamental operation, and we should not mess with it out 
>>   of caution.
> 
> But we do not mess with it!  We ask explicitely if we are talking about a 
> tty.

With reference to Peter's reply, I'm not the only one who gets nervous if
write() is replaced in a non-trivial way.

After all, you are sneaking the high-level concept "terminal emulation"
into the low-level write() function.

>> - Your proposal is not a catch-all. For example, combine-diff.c uses 
>>   puts() in dump_quoted_path(). If your goal was to not touch code 
>>   outside of compat/ then you need to override at least puts(), too.
> 
>>From compat/mingw.h:
> 
> -- snip --
> /*
>  * ANSI emulation wrappers
>  */
> 
> int winansi_fputs(const char *str, FILE *stream);
> [...]
> #define fputs winansi_fputs
> -- snap --
> 
> ... added in c09df8a, SOBbed by yourself ;-)

My point was that you cannot get away without modifying code outside of
compat/ (if that was your motivation to override write()). I don't care
whether we change this instance to fputs() or fprintf(). But we already
*have* something, and don't need *yet another* override.

>> - All code that writes ANSI escapes should use fprintf() anyway.  
>>   (Currently that is not the case, but all cases I'm aware of can be 
>>   fixed trivially.)
> 
> I disagree that all ANSI escapes have to go through fprintf().  Sometimes 
> you have a buffer, and I do not like doing extra work with %.*s there.

But on the other hand you risk breaking write() semantics and give us a
colorful mix of concepts.

I don't insist in that ANSI escapes must go through fprintf(), but they
should really not go through a level that is lower than stdio. Basic file
IO should really not be muddied with terminal emulation.

> BTW I hope that you are not annoyed by the discussion; I think it is 
> necessary and important.  I am certainly not married to my current POV; so 
> far, I am still in favor of it, though.

I'm absolutely not annoyed. And I am as married to my POV as you are to
yours. ;) In this case we perhaps need a tie-breaker.

-- Hannes
