From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] git-add--interactive.perl: Permit word-based diff
Date: Tue, 18 Jun 2013 09:22:16 +0200
Message-ID: <87k3lrzxw7.fsf@hexa.v.cablecom.net>
References: <CAMNuMARruu+1=kny=g5O1MoxCXuoT3BHdSEEPSqvyn2t2JsAYg@mail.gmail.com>
	<20130618063144.GA6276@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Abraham <mark.j.abraham@gmail.com>, <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:22:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoqFG-0005Ku-9b
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab3FRHWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:22:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25157 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab3FRHWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:22:21 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 09:22:16 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 09:22:17 +0200
In-Reply-To: <20130618063144.GA6276@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Jun 2013 02:31:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228166>

[I don't seem to have received a copy of the original mail, so I can
only guess...]

Jeff King <peff@peff.net> writes:

> On Sat, Jun 15, 2013 at 04:01:04PM +0200, Mark Abraham wrote:
>
>> Controlled by new configuration option
>> "color.word-diff-in-interactive-add". There is no existing support for
>> "git add" to pass a command-line option like "--word-diff=color" to
>> git-add--interactive.perl, so a configuration option is the only
>> lightweight solution.
>> 
>> With this feature, the added or deleted form of a hunk can be empty,
>> so made some necessary checks for $_ being defined.
>
> Hmm. We can't apply a word-diff, so presumably your "permit" here is
> just for the display, replacing the colorized bits. And that looks like
> what your patch does.
>
> Note that the number of lines in your --word-diff=color hunk and the
> actual diff will not necessarily be the same.  What happens if I split a
> hunk with your patch?

If it's actually what you hint at, there's another problem: the word
diff might not even have the same number of hunks.  For example, a
long-standing bug (or feature, depending on POV) of word-diff is that it
does not take opportunities to completely drop hunks that did not make
any word-level changes.

Consider this:

  diff --git a/foo b/foo
  index 5eaddaa..089eeac 100644
  --- a/foo
  +++ b/foo
  @@ -1,2 +1,2 @@
  -foo bar                                                                                               
  -baz                                                                                                   
  +foo                                                                                                   
  +bar baz

In word-diff mode that's

  diff --git a/foo b/foo                                                                                 
  index 5eaddaa..089eeac 100644                                                                          
  --- a/foo                                                                                              
  +++ b/foo                                                                                              
  @@ -1,2 +1,2 @@                                                                                        
  foo                                                                                                    
  bar baz

Arguably word-diff should be fixed to drop the hunk.  But if 'add -p'
depends on exact hunk correspondence, it will break.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
