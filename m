From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 16:22:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0712111611570.1671@alien.or.mcafeemobile.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
 <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
 <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
 <7vprxcdhis.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2FNQ-00084B-NZ
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 01:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbXLLAWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 19:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbXLLAWn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 19:22:43 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:52093 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbXLLAWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 19:22:42 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S263EEB> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 11 Dec 2007 19:22:41 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67974>

On Tue, 11 Dec 2007, Linus Torvalds wrote:

> On Tue, 11 Dec 2007, Linus Torvalds wrote:
> > 
> > and while I suspect xdiff could be optimized a bit more for the cases 
> > where we have no changes at the end, that's beyond my skills.
> 
> Ok, I lied.
> 
> Nothing is beyond my skills. My mad k0der skillz are unbeatable.
> 
> This speeds up git-blame on ChangeLog-style files by a big amount, by just 
> ignoring the common end that we don't care about, since we don't want any 
> context anyway at that point. So I now get:
> 
> 	[torvalds@woody gcc]$ time git blame gcc/ChangeLog > /dev/null
> 
> 	real    0m7.031s
> 	user    0m6.852s
> 	sys     0m0.180s
> 
> which seems quite reasonable, and is about three times faster than trying 
> to diff those big files.
> 
> Davide: this really _does_ make a huge difference. Maybe xdiff itself 
> should do this optimization on its own, rather than have the caller hack 
> around the fact that xdiff doesn't handle this common case all that well?

I didn't follow the thread, but I can guess from the subject that this is 
about memory, isn't it?
Libxdiff already has a xdl_trim_ends() that strips all the common 
beginning and ending records, but at that point files are already loaded.
Since libxdiff works with memory files in order to keep any sort of 
system dependency out of the window, so the optimization would be 
useless on libxdiff side. This because the user would have to have 
already the file loaded in memory, to pass it to libxdiff.
If this is really about memory, this better be kept on the libxdiff caller 
side, so that it can avoid loading the terminal file sections altogether.
About your code, you may want to have an extend-till-next-eol code after 
the trimming part, since the last line may be used for context in the 
diffs.




- Davide
