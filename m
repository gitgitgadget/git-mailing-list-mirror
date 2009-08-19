From: Jeff King <peff@peff.net>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 08:48:21 -0400
Message-ID: <20090819124820.GC20381@coredump.intra.peff.net>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
 <m3ab1wnsie.fsf@localhost.localdomain>
 <a2db4dd50908190400x1cbb1506sa38c60e31587f49d@mail.gmail.com>
 <200908191418.08838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Rob (gmail)" <robvanb@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 14:48:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdkaa-0000TI-7A
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 14:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbZHSMsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZHSMsT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 08:48:19 -0400
Received: from peff.net ([208.65.91.99]:40878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbZHSMsT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 08:48:19 -0400
Received: (qmail 19475 invoked by uid 107); 19 Aug 2009 12:48:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 19 Aug 2009 08:48:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Aug 2009 08:48:21 -0400
Content-Disposition: inline
In-Reply-To: <200908191418.08838.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126538>

On Wed, Aug 19, 2009 at 02:18:07PM +0200, Jakub Narebski wrote:

> More complicated solution, used by gitweb, requires Perl, not checked
> that it works correctly, doesn't work with ancient repositories with
> symlink HEAD.
> 
>  $ perl -e '
>  use File::Find qw(find);
>  my @list = ();
>  find({follow_fast => 1, follow_skip => 2, dangling_symlinks => 0,
>        wanted => sub {
>          return if (m!^[/.]$!);
>          return unless (-d $_);
>          push @list, $_ if -e "$_/HEAD" 
>        }});
>  print join("\n", @list)."\n";
>  '

That doesn't seem very accurate. It will find 'HEAD' in "logs/" of
repositories with reflogs enabled, and "refs/remotes/*/" of cloned
repositories, giving you a lot of false positives.

If you want accuracy, you can ask git rev-parse to verify whether a
directory is a git repo; it actually uses a few different heuristics to
check. For example:

  find . -type d |
    while read dir; do
      if GIT_DIR=$dir git rev-parse --git-dir >/dev/null 2>&1; then
        echo $dir
      fi
    done

but it is a bit slower, as you invoke rev-parse for every directory, and
it actually does some verification of the contents of HEAD (so it is
probably a bad idea for something like gitweb, which cares about
performance).

If you want to do a cheap and fast check, searching for 'HEAD', 'refs',
and 'objects' in the same directory is a reasonable heuristic.

-Peff
