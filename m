From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 13:36:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151324380.3162@localhost.localdomain>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain> <200908152119.56606.trast@student.ethz.ch> <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain> <7viqgoestz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 22:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McQ0D-0002ZX-GN
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 22:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbZHOUhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbZHOUhG
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 16:37:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52696 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752100AbZHOUhE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 16:37:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FKaEG1009152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 13:36:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FKaD30029510;
	Sat, 15 Aug 2009 13:36:13 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7viqgoestz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126027>



On Sat, 15 Aug 2009, Junio C Hamano wrote:
> 
> If you try that without --stat, i.e.
> 
>     $ git log -4 --pretty=format:%s | cat -e
>     $ git log -4 --pretty=tformat:%s | cat -e
> 
> I suspect you may then find that --pretty=format (not --pretty=tformat) is
> broken.

I disagree. The real brokenness is that we don't have any way to say "I 
want no newline at all after the format", and then having this mixup with 
the whole "terminator" thing - sometimes it's "between commits" (which is 
_correct_ any time you have stat info or something), and sometimes it's 
"after header" (which is almost always incorrect).

For an example of this, try to do a one-line format that shows the 
diffstat on the same line. IOW, what you really want is something like

	git log -4 --shortstat --format=%s%NOTERM

but you can't do it at all right now - and defaulting to the "tformat" 
thing is actually _worse_.

So I do agree that "format" is broken and confused. I just think that 
"tformat" is EVEN MORE broken and confused, it just happens to fix that 
one form of brokenness that "format" has.

Notice how "CMIT_FMT_ONELINE" use the "use_terminator" (like tformat), but 
then does things right (unlike tformat). In particular, it's this one:

        pp_header(fmt, abbrev, dmode, encoding, commit, &msg, sb);
        if (fmt != CMIT_FMT_ONELINE && !subject) {
                strbuf_addch(sb, '\n');
        }       
	..
        /* Make sure there is an EOLN for the non-oneline case */
        if (fmt != CMIT_FMT_ONELINE)
                strbuf_addch(sb, '\n');

and notice how we have no way to edit those from the "format" descriptors.

			Linus
