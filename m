From: "Mark Levedahl" <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Mon, 19 Feb 2007 08:29:22 -0500
Message-ID: <erc8nm$feg$1@sea.gmane.org>
References: <1171838852534-git-send-email-mdl123@verizon.net> <Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 14:29:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ8aY-0006tC-Qa
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 14:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXBSN3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 08:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbXBSN3v
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 08:29:51 -0500
Received: from main.gmane.org ([80.91.229.2]:39819 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224AbXBSN3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 08:29:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJ8aE-0001KT-W0
	for git@vger.kernel.org; Mon, 19 Feb 2007 14:29:36 +0100
Received: from sahara.mdnt.com ([12.109.151.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 14:29:34 +0100
Received: from mdl123 by sahara.mdnt.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 14:29:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: sahara.mdnt.com
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40126>

"Johannes Schindelin" <Johannes.Schindelin@gmx.de> wrote in message 
news:Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de...
> Hi,
>
> Sorry to be such a PITA, but I really, really think that it is wrong 
> to
> make a tar dependency here. You said your cygwin has problems with 
> binary
> files. Could you please try this:
>
> $ echo -ne '\x1a\x1b\x15\x10\0abc' | cat | wc
>
Same result on Cygwin and FC6:
~>echo -ne '\x1a\x1b\x15\x10\0abc' | cat | wc
      0       1       8

> If it returns anything else than "<tab>0<tab>1<tab>8", then your setup
> works differently from mine. I fit returns what I expect it to, then 
> we
> can use cat directly and do not have to move the tar bloat around (it 
> is
> inherently block based, so it wastes a lot of space, and it also 
> stores
> other things we'll never use, like permissions for all files).


To repeat an earlier message, I tried the following:

cat bundle | (
      while read <header stuff> do
        <prcess header stuff>
      done
      git-pack-index --stdin
)

and it worked, MOST of the time, most being the important word here. My 
memory is already fuzzy about the failure rate, but it was something 
like 2 of 7 bundle files I passed through resulting in git-pack-index 
reporting a corrupted pack file: when I manually edited out the header 
stuff  and passed the remains of the file directly to git-pack-index 
things were fine. The same experiment worked perfectly on my FC6 system, 
so it was definitely some part of Cygwin, not the script. If git is 
worried about tickling "which" on ancient Solaris, I think it is a bit 
out of balance to simultaneously require a not yet written version of 
Cygwin (that will get fixed after someone has time to reduce this 
problem to a simple testcase and push back to the Cygwin maintainers).

A bundle file *is* an archive. We can use an existing archiver or write 
a new one. I don't really favor writing one but that is personal 
preference for not reinventing the wheel, nothing more. However, given 
Cgywin's problems an archiver written in shell isn't going to work for 
binary files. We could uuencode / uudecode the pack files and make 
bundles pure ascii text. Or, we could use tar. Of course, rewriting this 
as a builtin offers the ability to write a purpose built archiver as 
well, but I was trying to avoid that.

</unsolicited ignoreable gripe>Has anyone considered how much easier all 
of git would be if it were written in c + python, rather than c + every 
variant of shell + core utils + non-core utils known to mankind since 
the dawn of unix?</unsolicited ignorable gripe>

Mark
