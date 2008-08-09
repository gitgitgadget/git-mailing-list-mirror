From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Fri, 8 Aug 2008 23:25:21 -0700
Message-ID: <20080809062521.GA10480@untitled>
References: <1218235313-19480-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sat Aug 09 08:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRhuI-0008Mq-Iq
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 08:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbYHIGZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 02:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbYHIGZY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 02:25:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57847 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbYHIGZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 02:25:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 801742DC01B;
	Fri,  8 Aug 2008 23:25:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218235313-19480-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91743>

Marcus Griep <marcus@griep.us> wrote:
> Currently, git-svn would create a temp file on four occasions:
> 1. Reading a blob out of the object db
> 2. Creating a delta from svn
> 3. Hashing and writing a blob into the object db
> 4. Reading a blob out of the object db (in another place in code)
> 
> Any time git-svn did the above, it would dutifully create and then
> delete said temp file.  Unfortunately, this means that between 2-4
> temporary files are created/deleted per file 'add/modify'-ed in
> svn (O(n)).  This causes significant overhead and helps the inode
> counter to spin beautifully.
> 
> By its nature, git-svn is a serial beast.  Thus, reusing a temp file
> does not pose significant problems.  "truncate and seek" takes much
> less time than "unlink and create".  This patch centralizes the
> tempfile creation and holds onto the tempfile until they are deleted
> on exit.  This significantly reduces file overhead, now requiring
> at most three (3) temp files per run (O(1)).

Wow.  I've considered this in the past didn't think there would be a
significant difference (of course I'm always network I/O bound).  Which
platform and filesystem are you using are you using for tests?

I don't notice any difference running the test suite on Linux + ext3
here, but the test suite is not a good benchmark :)

> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1282,6 +1282,8 @@ use Carp qw/croak/;
>  use File::Path qw/mkpath/;
>  use File::Copy qw/copy/;
>  use IPC::Open3;
> +use File::Temp qw/ :seekable /;

qw/ :seekable / does not appear in my version of Perl (5.8.8-7etch3 from
Debian stable)  Just having "use File::Temp;" there works for me.

>  sub resolve_local_globs {
> @@ -2932,6 +2935,23 @@ sub remove_username {
>  	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
>  }
>  
> +sub _temp_file {
> +	my ($self, $fd, $autoflush) = @_;
> +	if (defined $TEMP_FILES{$fd}) {
> +		truncate $TEMP_FILES{$fd}, 0 or croak $!;
> +		seek $TEMP_FILES{$fd}, 0, 0 or croak $!;

Perhaps a sysseek in addition to the seek above would help
with the problems you mentioned in the other email.

		sysseek $TEMP_FILES{$fd}, 0, 0 or croak $!;

(It doesn't seem to affect me when running the test suite, though).

> +	} else {
> +		$TEMP_FILES{$fd} = File::Temp->new(
> +									TEMPLATE => 'GitSvn_XXXXXX',
> +									DIR => File::Spec->tmpdir
> +									) or croak $!;

Way too much indentation :x

> +		if (defined $autoflush) {
> +			$TEMP_FILES{$fd}->autoflush($autoflush);
> +		}

Given how much we interact with external programs, I'd rather force
every autoflush on every file handle to avoid subtle bugs on
different platforms.  It's faster in some (most?) cases, too.


Also, this seems generic enough that other programs (git-cvsimport
perhaps) can probably use it, too.  So maybe it could go into Git.pm or
a new module, Git/Tempfile.pm?

-- 
Eric Wong
