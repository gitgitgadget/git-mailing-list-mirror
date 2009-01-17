From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn fails to fetch repository
Date: Sat, 17 Jan 2009 01:51:47 -0800
Message-ID: <20090117095147.GA29598@dcvr.yhbt.net>
References: <loom.20090113T185918-397@post.gmane.org> <20090113203922.GD30404@atjola.homenet> <loom.20090113T204616-845@post.gmane.org> <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com> <loom.20090113T211437-12@post.gmane.org> <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com> <loom.20090113T213400-985@post.gmane.org> <76718490901131658l108852f2y9a25eb9133d6e96d@mail.gmail.com> <loom.20090114T083207-942@post.gmane.org> <76718490901141006n6c70eb2cw67ad814b3739786e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Vladimir Pouzanov <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 10:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO7rf-000796-3a
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 10:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbZAQJvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 04:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbZAQJvu
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 04:51:50 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42960 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbZAQJvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 04:51:49 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFF21F44D;
	Sat, 17 Jan 2009 09:51:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <76718490901141006n6c70eb2cw67ad814b3739786e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106036>

Jay Soffian <jaysoffian@gmail.com> wrote:
> On Wed, Jan 14, 2009 at 3:32 AM, Vladimir Pouzanov <farcaller@gmail.com> wrote:
> > Jay Soffian <jaysoffian <at> gmail.com> writes:
> >> So you're adding the "use Carp..." and "warn..." lines.
> >>
> >> Then try the import again. That should at least show why the svn_delta
> >> temp file is being acquired twice.
> >
> > Output is pretty long so I've put in on pastebin:
> > http://pastebin.com/m210be905
> 
> Okay, this is beyond me. git-svn (among other things) implements a
> so-called delta editor (part of the subversion API). The driver for
> that editor is apparently calling the editor's apply_textdelta()
> method twice in a row w/o an intervening call to the editor's
> close_file() method.
> 
> I don't understand when and/or why it would do this. This part of the
> Subversion API seems not that well documented, and I got lost trying
> to follow all the indirections in the Subversion source code (esp
> w/the swig'ified Perl bindings). AFAICT, this should not be happening.

Thank you Jay for your help and patch so far.  I'm sorry you had to go
through the craziness that is the Subversion library (and associated
craziness that leaked into git-svn) to try an debug this problem.

> I could ask you to insert some more debugging statements to try to
> track it to a specific file (or files), but I think at this point I'll
> going to wait to see if the git-svn author has any ideas.

Putting "print" and "print Dumper(\@_)" everywhere is pretty much
how I figured out how to use the delta interface the first time around.

Vladimir:

I can't reproduce this problem at all, either.  git-svn dups the file
handle in question, maybe your combination of (SVN/Perl/OSX) somehow
handles dup'd file descriptors differently?

Does the following patch (a shot in the dark) work for you?
(it generates a lot of warnings for me)

diff --git a/git-svn.perl b/git-svn.perl
index ad01e18..23e6925 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3361,6 +3361,7 @@ sub apply_textdelta {
 	seek $base, 0, 0 or croak $!;
 	$fb->{fh} = $fh;
 	$fb->{base} = $base;
+	$fb->{dup} = $dup;
 	[ SVN::TxDelta::apply($base, $dup, undef, $fb->{path}, $fb->{pool}) ];
 }
 
@@ -3408,6 +3409,7 @@ sub close_file {
 
 		Git::temp_release($fb->{base}, 1);
 		Git::temp_release($fh, 1);
+		eval { Git::temp_release($fb->{dup}, 1) };
 	} else {
 		$hash = $fb->{blob} or die "no blob information\n";
 	}

> BTW, it doesn't help any that the order that files are checked out
> seems not to be consistent. Not only is my git-svn clone working, the
> order my files are checked out in is different from yours.
> 
> Oh, one other thing I don't understand is why the debugging output is
> now showing that some files are being added for you (the lines
> beginning with \tA). Before you weren't getting that. I had thought
> these lines might be getting lost in stdout buffering, but git-svn
> disables buffering on stdout, so color me confused.

With that comment and my attempted fix above, I'm almost under the
impression that something on Vladimir's system (or Perl) is
configured to handle I/O in some weird/broken way...

-- 
Eric Wong
