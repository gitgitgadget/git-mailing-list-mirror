From: Jeff King <peff@peff.net>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor
 with no changes written
Date: Wed, 3 Feb 2010 04:31:51 -0500
Message-ID: <20100203093150.GA23956@coredump.intra.peff.net>
References: <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
 <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com>
 <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
 <32541b131002021540g7a2834c9hacf2be5962f66515@mail.gmail.com>
 <20100203061535.GA6566@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 10:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcbaZ-0002md-If
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 10:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab0BCJby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 04:31:54 -0500
Received: from peff.net ([208.65.91.99]:57213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756360Ab0BCJbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 04:31:53 -0500
Received: (qmail 25286 invoked by uid 107); 3 Feb 2010 09:31:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Feb 2010 04:31:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2010 04:31:51 -0500
Content-Disposition: inline
In-Reply-To: <20100203061535.GA6566@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138818>

On Wed, Feb 03, 2010 at 01:15:35AM -0500, Larry D'Anna wrote:

> * Avery Pennarun (apenwarr@gmail.com) [100202 18:41]:
> > You can however add *new* stuff.  That's why I suggested adding an
> > option.  You could even make it a config option so you only have to
> > set it once (just like setting your preferred editor).
> 
> Or, he can set his $EDITOR to a script that checks the mtime.

Agreed. It could even look like this:

-- >8 --
$ cat >vi-must-edit <<'EOF'
#!/usr/bin/perl
sub mtime { (stat $_[0])[9] }
my $old = mtime($ARGV[-1]);
system('vi', @ARGV) and die "vi failed";
if (mtime($ARGV[-1]) == $old) {
  print STDERR "Aborting unmodified message\n";
  exit 1;
}
exit 0
EOF
$ chmod +x vi-must-edit
$ GIT_EDITOR=$PWD/vi-must-edit; export GIT_EDITOR
$ git commit --amend ;# and then quit the editor immediately
Aborting unmodified message
error: There was a problem with the editor 'vi-must-edit'.
Please supply the message using either -m or -F option.

-- 8< --

Do note, though, that there is a subtle race condition in using the
mtime. If you make a change and save within a second of the editor
starting, it will be ignored. To be thorough, you would probably want to
check the size and inode, as well.

-Peff
