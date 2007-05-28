From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 12:54:23 +0200
Message-ID: <200705281254.23297.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705271608.02122.johan@herland.net>
 <alpine.LFD.0.98.0705272131370.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 28 12:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HscsB-0001XK-0f
	for gcvg-git@gmane.org; Mon, 28 May 2007 12:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXE1Kyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 06:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbXE1Kyj
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 06:54:39 -0400
Received: from smtp.getmail.no ([84.208.20.33]:65009 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXE1Kyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 06:54:38 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIQ00J0FZN1I100@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 12:54:37 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIQ00H4PZMNGJC0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 12:54:23 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIQ00CINZMND560@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 12:54:23 +0200 (CEST)
In-reply-to: <alpine.LFD.0.98.0705272131370.26602@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48614>

On Monday 28 May 2007, Linus Torvalds wrote:
> 
> On Sun, 27 May 2007, Johan Herland wrote:
> > 
> > I've been working on combining tag objects and --decorate into a useful
> > proof-of-concept that provides the after-the-fact commit annotations I
> > requested above, and here's the result:
> 
> Ok, looks fine to me. I do have a few questions:
>  - why don't you just let people name their notes, the same way we name 
>    tags (and then actually using it as the note name?)
> 
>    Putting them in the refs/notes/ filesystem by their SHA1 seems a bit 
>    wasteful, and it would seem that it could be quite nice to name the 
>    notes some way?

Well, when I first designed them, I thought of notes more as an extension
to the commit message than as a special case of tags. Therefore naming
them didn't seem natural at that point. But now that it all seems to
blend together (cf. Junio's answer), I'm not opposed to putting names
on notes at all. But I don't want to make naming mandatory. It should
still be possible to add a note like "Fixes bug #12345" in a jiffy,
without having to think up a note name as well (or having a badly
thought-up name pollute some namespace).

So I guess we end up with two kinds of objects/entities:
1. tags, with mandatory naming and optional comment/message
2. notes, with optional naming and mandatory comment/message

To some degree we can say that the name is the ref, and the
comment/message is the object. We therefore get:

1. tags, with mandatory ref and optional tag object (we have this today)
2. notes, with optional ref and mandatory object

Today, a note needs its ref in order to stay alive, but this is purely a
(badly designed) technical measure. When we get the proper reverse mapping
done (as discussed in Junio's answer), notes will stop polluting refs/ and
we can instead allow naming of notes by adding simple (tag-type) refs to
note objects.

Also, as mentioned by Junio, we want to do the reverse mapping for regular
tags as well.

At this point, there's no real difference between tags and notes (some
would say there never were a difference), and we can stop caring about
whether a note is a note or a tag, etc, at least in the plumbing.

We may still want to enforce a difference in the procelain, though.
When presenting tags/notes (e.g. with --decorate), users might be
interested in classifying and filtering their tags/notes in different
categories. Categories might be ("note", "tag"), or we can make it
user-extensible, like Junio's "keyword" idea). Either way, we'll have
to make room for this classification in the tag object by adding another
header ("tagtype", "keyword", whatever...).

And while we're on the subject of changing the tag object, I'd like for
the "tag" header (the one holding the tag name) to become optional.
When doing my ref <-> name trick above, I conveniently forgot this little
bugger. Basically the only reason for this one to exist is to include the
name of the tag in the data passed to gpg for signing. This is of course
necesssary in order to make renaming a signed tag impossible. (Allowing
renaming would make it possible to replace it with a malicious tag with
the original name.) Therefore the "tag" header must be mandatory for
signed tags. But for all other tags (including notes) this header is
pretty much useless.

>  - This will probably scale horribly badly if you have tens of thousands 
>    of notes, even when they are packed. Do we care?

I can't see why the current implementation would scale any worse than an
equivalent number of (annotated/signed) tags. But then again, the tag
system might not have been designed with tens of thousands of tag objects
in mind. :)

> Other than that, it looks straightforward and sane.

Thanks for the feedback


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
