From: David Brown <git@davidb.org>
Subject: Re: preserving mtime
Date: Sun, 18 Nov 2007 13:44:04 -0800
Message-ID: <20071118214403.GA7182@old.davidb.org>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se> <20071117182236.GD23659@blorf.net> <20071118084511.GC16863@glandium.org> <46a038f90711180134j411bb9c9uf2476f564f9abb6@mail.gmail.com> <20071118184724.GA494@old.davidb.org> <46a038f90711181236o1acd00d4id9c5aeffd3065b80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Mike Hommey <mh@glandium.org>, Wayne Davison <wayne@opencoder.net>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 22:44:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItrwU-0002ah-Uo
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 22:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbXKRVoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbXKRVoV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 16:44:21 -0500
Received: from mail.davidb.org ([66.93.32.219]:57992 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbXKRVoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 16:44:20 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1Itrvw-0002Cj-0W; Sun, 18 Nov 2007 13:44:04 -0800
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Mike Hommey <mh@glandium.org>, Wayne Davison <wayne@opencoder.net>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90711181236o1acd00d4id9c5aeffd3065b80@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65391>

On Mon, Nov 19, 2007 at 09:36:52AM +1300, Martin Langhoff wrote:

>Hmmm. After a bit of googling I've found conflicting descriptions of
>the mtime/ctime semantics (I thought - for 10 years now - that ctime
>was "creation time", it is "changed time"). Some people think that
>anything that updates mtime also updates ctime, and others say the
>opposite.

One of them is wrong.  All modifications to the file change the ctime.
Some modifications change the mtime.  There is also a call to change the
mtime (which will touch the ctime).  It's been this way for a long time.
I think most of the confusion comes from the 'c' in ctime.

It doesn't help that the Posix spec is so hard to read on this.  Basically,
you have to look up every command that might modify a file to figure out
which time changes it is supposed to modify.

>Wikipedia says (at http://en.wikipedia.org/wiki/MAC_times and
>http://en.wikipedia.org/wiki/Stat_%28Unix%29 ) that mtime is about the
>content, and ctime about metadata (owner, permissions, moved inode,
>etc). Changes in content "touch" mtime + ctime.
>
>With that in mind, I think it makes sense for things like make and
>amanda to read mtime as referring to a real change of that concrete
>file. The abstract notion of the file having changed in the big DSCM
>in the sky is useful, but putting that data in mtime messes things up.

Backup software should _never_ look at the mtime (other than to save it).
Both GNU tar and dump use the ctime field exclusively for incremental
purposes.

Think about this:

   wget .../linux-2.4.tar.gz
   tar -xzf linux-2.4.tar.gz

I've just expanded lots of files on my machine.  Tar is going to set the
mtime to the date they were at when the tarball was made, which was
probably several years ago.  It is crucial, though, that any backup
software I run still back these files up, since they are newly added.

There are backup programs that use mtime, but they are just broken, plain
and simple.

>> However, it will make 'make' very confusing, since it uses the mtime to
>> determine if files are out of date.  If moving to an older version of a
>> file causes the file to become older, make won't recompile.  This is
>> arguably a defect in make, but that is how it works.
>
>It's not a bug in make. mtime has a definite meaning, and make is
>using that meaning. Same with amanda.

It is very much a bug (well, a feature) in make.  But the whole date
comparison model of make is completely wrong.  It should rebuild a file if
it has changed, not if it is newer.  Most make replacements do something
more intelligent (often similar to the index cache git uses).

I haven't used Amanda for a while, but it at least used to do the right
thing (using ctime).  They might have had to break things to support FAT,
but I would guess it still works on a real filesystem.

David
