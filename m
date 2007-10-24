From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 9/9] git-svn: Make fetch ~1.7x faster
Date: Tue, 23 Oct 2007 23:34:01 -0700
Message-ID: <20071024063401.GB10916@soma>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <1193118397-4696-7-git-send-email-aroben@apple.com> <1193118397-4696-8-git-send-email-aroben@apple.com> <1193118397-4696-9-git-send-email-aroben@apple.com> <1193118397-4696-10-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 08:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkZop-00053T-6t
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 08:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbXJXGeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbXJXGeF
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 02:34:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53139 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956AbXJXGeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 02:34:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A8B1D7DC0FE;
	Tue, 23 Oct 2007 23:34:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1193118397-4696-10-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62196>

Adam Roben <aroben@apple.com> wrote:
> We were spending a lot of time forking/execing git-cat-file and
> git-hash-object. We now use command_bidi_pipe to keep one instance of each
> running and feed it input on stdin.

Nice job!  I just got access to a very fast SVN repository for a project
I'm working on (not working on git-svn itself, unfortunately).

A few comments and small nitpicks below:

> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
>  git-svn.perl |   94 ++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 72 insertions(+), 22 deletions(-)

> +package Git::Commands;

Can this be a separate file, or a part of Git.pm?  I'm sure other
scripts can eventually use this and I've been meaning to split
git-svn.perl into separate files so it's easier to follow.

> +use vars qw/$_cat_blob_pid $_cat_blob_in $_cat_blob_out $_cat_blob_ctx $_cat_blob_separator
> +	    $_hash_object_pid $_hash_object_in $_hash_object_out $_hash_object_ctx/;

I have trouble following long lines, and most of the git code also wraps
at 80-columns.  Dead-tree publishers got this concept right a long
time ago :)

> +use strict;
> +use warnings;
> +use File::Temp qw/tempfile/;
> +use Git qw/command_bidi_pipe command_close_bidi_pipe/;
> +
> +sub _open_cat_blob_if_needed {
> +	return if defined($_cat_blob_pid);
> +	$_cat_blob_separator = "--------------GITCATFILESEPARATOR-----------";

Brian brought this up already, but yes, having pre-defined separators
instead of explicitly-specified sizes makes it all too easy for a
malicious user to commit code that will break things for git-svn users.

> +sub hash_object {
> +	my (undef, $fh) = @_;
> +
> +	my ($tmp_fh, $tmp_filename) = tempfile(UNLINK => 1);
> +	while (my $line = <$fh>) {
> +		print $tmp_fh $line;
> +	}
> +	close($tmp_fh);

Related to the above.  It's better to sysread()/syswrite() or
read()/print() in a loop with a predefined buffer size rather than to
use a readline() since you could be dealing with files with very long
lines or binaries with no newline characters in them at all.

> +	_open_hash_object_if_needed();
> +	print $_hash_object_out $tmp_filename . "\n";

Minor, but

	print $_hash_object_out $tmp_filename, "\n";

avoids creating a new string.

-- 
Eric Wong
