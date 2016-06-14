From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 21:11:55 +0200
Message-ID: <146593150503.20857.6674861809731777501@typhoon.lan>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
 <alpine.LFD.2.20.1606141245490.1714@knanqh.ubzr>
 <CsLdb3qLMBok7CsLebwX38@videotron.ca>
 <alpine.LFD.2.20.1606141347310.1714@knanqh.ubzr>
 <xmqqa8inaben.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, "Johannes Sixt" <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>,
	"Nicolas Pitre" <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:12:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCtkv-0006rc-9o
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 21:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbcFNTMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 15:12:05 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:36157 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbcFNTMD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 15:12:03 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id e39e1952
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Tue, 14 Jun 2016 21:12:00 +0200 (CEST)
In-Reply-To: <xmqqa8inaben.fsf@gitster.mtv.corp.google.com>
User-Agent: alot/0.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297322>

On Tue, 14 Jun 2016 at 20:11:12, Junio C Hamano wrote:
> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > It is not buffered as it writes to stderr. And some C libs do separate 
> > calls to write() for every string format specifier. So "%s%s%c" may end 
> > up calling write() 3 times depending on the implementation.  The example 
> > I gave in commit ed1902ef5c is real and I even observed it with strace 
> > back then.
> 
> I think you meant 9ac13ec9 (atomic write for sideband remote
> messages, 2006-10-11).
> 
> IIRC, back then we did't use to make as much use of strbuf API as we
> do today; if we were doing that commit today, we would be doing
> strbuf, I would suspect.

Thanks for looking up the right commit. I think I might see what is
going on; however, the situation is a bit different to the situation we
had at the time of writing 9ac13ec9 (atomic write for sideband remote
messages, 2006-10-11). Before that, we called write() manually a couple
of times. Now, we use fprintf() which makes stronger guarantees about
thread safety. However, if I understand correctly, there is still one
issue: It seems like in some places, we also directly write() to file
descriptor 2. So the following might happen: An fprintf() implementation
that calls write() once per format specifier is used. The fprintf()
function is called once from one thread, then interrupted between two
write() syscalls. In the meantime, output is written directly to file
descriptor 2 using write().

One possible solution is using strbuf and constructing the message as we
did before. However, that still relies on fprintf() only calling write()
once per format specifier. While that is probably true for all existing
implementations, I don't think it is guaranteed by some standard.
Shouldn't we always use the stderr stream when printing error messages
instead, especially when we care about thread safety?

Regards,
Lukas
