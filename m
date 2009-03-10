From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 13:14:44 +0100
Message-ID: <49B659B4.5000705@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302> <49B64ADC.2090406@viscovery.net> <49B64C3A.50909@viscovery.net> <alpine.DEB.1.00.0903101236480.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 13:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh0sk-0000SD-Tp
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 13:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbZCJMO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 08:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbZCJMO4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 08:14:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27849 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZCJMOz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 08:14:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lh0r6-0005Lg-Jt; Tue, 10 Mar 2009 13:14:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 49AC54FB; Tue, 10 Mar 2009 13:14:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903101236480.14295@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112809>

Johannes Schindelin schrieb:
> FWIW GitTorrent may be implemented as part of git-daemon, if Sam's ideas 
> become reality.  And then, sideband transport is _the_ means to do 
> asyncrounous communication while pushing bytes.

I do not see how recv_sideband() in its current form could be helpful here
(assuming that you really are thinking of sending binary data over band #2).

> On Tue, 10 Mar 2009, Johannes Sixt wrote:
>> Johannes Sixt schrieb:
>>> For use-cases that you have in mind in GitTorrent, the *protocol* may 
>>> be a good choice, but the current implementation is definitely a 
>>> special case.
>> And it really is: Did you notice that stuff that recv_sideband sends over
>> the channel named 'err' (before my patch) has "remote: " prepended on
>> every line? That's certainly not an implementation that you want if you
>> send binary data over that band!
> 
> Yes, that is unfortunate, but can be fixed easily.

I don't believe this. Every treatment of "remote: " that you take away
from recv_sideband() you must insert somewhere else. Perhaps easy, but
certainly not as trivial as my patch.


Just a reminder: You proposed to override write() on Windows in a
non-trivial way, and we are discussing the topic above because I think
that is not a good idea. The reasons are:

- write() is a fundamental operation, and we should not mess with it out
of caution.

- Your proposal is not a catch-all. For example, combine-diff.c uses
puts() in dump_quoted_path(). If your goal was to not touch code outside
of compat/ then you need to override at least puts(), too.

- All code that writes ANSI escapes should use fprintf() anyway.
(Currently that is not the case, but all cases I'm aware of can be fixed
trivially.)

-- Hannes
