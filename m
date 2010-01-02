From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: Filename quoting / parsing problem
Date: Sat, 2 Jan 2010 21:48:47 +0100
Organization: SUSE Labs
Message-ID: <201001022148.47841.agruen@suse.de>
References: <201001011844.23571.agruen@suse.de> <201001021236.26947.agruen@suse.de> <7v8wcge4kr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 21:49:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRAuG-0002Dr-UL
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 21:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab0ABUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 15:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022Ab0ABUsw
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 15:48:52 -0500
Received: from cantor2.suse.de ([195.135.220.15]:36624 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141Ab0ABUsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 15:48:50 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 290778726A;
	Sat,  2 Jan 2010 21:48:49 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7v8wcge4kr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136049>

On Saturday 02 January 2010 07:37:08 pm Junio C Hamano wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > On Friday 01 January 2010 09:01:19 pm Junio C Hamano wrote:
> >> > Both "b file" and "c file " are parsed by "git apply" perfectly fine.
> >
> > Right, the "diff --git" lines are technically still parseable when the
> > file name stays the same.  With renames, lines like "diff --git a/f a/f
> > b/f" or "diff --git a/f b/f b/f" are possible, but then there will also
> > be "renamed from" and "renamed to" headers which will disambiguate
> > things.  Still, it doesn't seem like a good idea to allow such
> > ambiguities in the first place.
> 
> You already realized that there is no ambiguity because "diff --git" lines
> are parsable and renames have explicit names.  Why do you still maintain
> that we are allowing such "ambiguities" when there is none?

Don't get so aroused ...

Right now, git generates lines like "diff --git a/f a/f b/f b/f" in some 
corner cases, and from such lines alone, it is not possible to tell what the 
two file names are (either "a/f a/f" and "b/f b/f", or "a/f a/f b/f" and 
"b/f").  I can only find that out by looking at the other header lines.

I would prefer a format which I can parse line by line without ambiguities in 
the first place, because this would keep things much simpler and easier to 
debug.  (Think of other implementations of the extended diff format which may 
not produce the exact same output as git.)

So I would be happy with either of this:

  * Also quote spaces in the "diff --git" line so that I can always reliably
    parse it, or

  * Add an additional extended header line with the file name in case there
    are no other header lines giving the file names away already (as for
    renames, copies, or when there are "---" and "+++" lines).

After our discussion so far, option two would probably be easier for everyone: 
you could add it without risking to break anything, and I could avoid parsing 
the "diff --git" line altogether.

> >> Having said all that, I don't think we would mind a change to treat a
> >> pathname with trailing SP a bit specially (iow, quoting "c file " in the
> >> above failed attempt to reproduce the issue).
> >
> > I would prefer quoting file names which contain spaces anywhere,...
> 
> The only reason I said I don't think we would mind changing the trailing
> SP case is because the reduced risk of getting our patches corrupted by
> MUA _might_ outweigh the benefit of not quoting to avoid an eyesore [*1*].
> 
> But what you said would add to eyesore of quoted names (which you omitted
> from your quote) without any justification other than "I would prefer".
> The pros-and-cons in such a change is quite different; as we have already
> established that there is no ambiguity, "disambuguation" is not a "pro" in
> this comparison.
>
> [Footnote]
> 
> *1* Strictly speaking, it is not just "an eyesore" that is an issue.  Our
> diff output without renames are designed to be grokkable by other people's
> patch implementations (e.g. GNU patch), and the quoted pathnames are not
> understandable by them.

GNU patch doesn't look at "diff --git" lines or extended header lines at all 
so far, so there are no compatibility issues yet.  Quoting spaces in "---" and 
"+++" lines would lead to problems with current GNU patch though.  (So does 
the quoting of several other characters like ", of course.)

> Even though our final version of quoted path format came from the GNU
> diff/patch maintainer (back then, at least):
> 
>     http://article.gmane.org/gmane.comp.version-control.git/10103
> 
> I don't think it happened in the GNU land yet, and you would be the person
> to know about it ;-).

I'm working on it ...

Thanks,
Andreas
