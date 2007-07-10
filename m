From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Wed, 11 Jul 2007 01:41:59 +0200
Organization: At home
Message-ID: <f715g6$2sv$1@sea.gmane.org>
References: <3bbc18d20707091552l29fb81b6v34da9cef3ec0df58@mail.gmail.com> <1184023318.9703.1.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 01:42:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8PLW-0001sd-Pk
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 01:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597AbXGJXmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbXGJXmO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 19:42:14 -0400
Received: from main.gmane.org ([80.91.229.2]:36876 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbXGJXmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 19:42:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8PLJ-0006Zv-M3
	for git@vger.kernel.org; Wed, 11 Jul 2007 01:42:05 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 01:42:05 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 01:42:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52120>

Matt McCutchen wrote:

> - Centralize knowledge about snapshot formats (mime types, extensions,
>   commands) in %known_snapshot_formats and improve how some of that
>   information is specified.  In particular, zip files are no longer a
>   special case.
> 
> - Add support for offering multiple snapshot formats to the user so
>   that he/she can download a snapshot in the format he/she prefers.
>   The site-wide or project configuration now gives a list of formats
>   to offer, and the "_snapshot_" link is replaced with, say,
>   "snapshot (_tbz2_ _zip_)".
> 
> - Fix out-of-date "tarball" -> "archive" in comment.
> 
> Alert for gitweb site administrators: This patch changes the format of
> $feature{'snapshot'}{'default'} in gitweb_config.perl from a list of three
> pieces of information about a single format to a list of one or more formats
> you wish to offer from the set ('tgz', 'tbz2', 'zip').  Update your
> gitweb_config.perl appropriately.

Quite nice and I think needed refactoring of a snapshot code. Nevertheless
I have some comments on the changes introduced by this patch; not only
change to gitweb_config.perl is needed (which gitweb admin has control
over), but also repo config for individual repositories might need to
be changed (which gitweb admin might not have control over, and which is
much harder to do).

> +# information about snapshot formats that gitweb is capable of serving
> +# name => [mime type, filename suffix, --format for git-archive,
> +#          compressor command suffix]
> +our %known_snapshot_formats = (
> +     'tgz'  => ['application/x-gzip' , '.tar.gz' , 'tar', '| gzip' ],
> +     'tbz2' => ['application/x-bzip2', '.tar.bz2', 'tar', '| bzip2'],
> +     'zip'  => ['application/zip'    , '.zip'    , 'zip', ''       ],
> +);

First, is full mimetype really needed? Earlier code assumed that mimetype
for snapshot is of the form of application/<something>, and it provided
only <something>.

Second, I'd rather have 'gzip' and 'bzip2' aliases to 'tgz' and 'tbz2',
so the old config continues to work. I can see that it would be hard
to do without special-casing code, or changing the assumption that list
of default available snapshot formats is keys of above hash.

> -     # and in project config gitweb.snapshot = none|gzip|bzip2|zip;
> +     # and in project config, a comma-separated list of formats or "none"
> +     # to disable.  Example: gitweb.snapshot = tbz2,zip;

I would relax the syntax, so "tbz2, zip" would also work, or even
"tbz2 zip". I'd like for old config to also work, meaning that "gzip"
would be the same as "tgz" and "bzip2" as "tbz2".

> -     if ($val eq 'gzip') {
> -             return ('x-gzip', 'gz', 'gzip');
> -     } elsif ($val eq 'bzip2') {
> -             return ('x-bzip2', 'bz2', 'bzip2');
> -     } elsif ($val eq 'zip') {
> -             return ('x-zip', 'zip', '');
> -     } elsif ($val eq 'none') {
> -             return ();

Very nice getting rid of this swith-like statement...

> +     if ($val) {
> +             @fmts = ($val eq 'none' ? () : split /,/, $val);

... but I would relax this regexp.

> +# Generates undef or something like "snapshot (tbz2 zip)", linked.
> +# Pass the hash.
> +sub format_snapshot_links {
> +     my ($hash) = @_;
> +     my @snapshot_fmts = gitweb_check_feature('snapshot');
> +     if (@snapshot_fmts) {
> +             return "snapshot (" . join(' ', map $cgi->a(
> +                     {-href => href(action=>"snapshot", hash=>$hash, snapshot_format=>$_)}, "$_"),
> +                     @snapshot_fmts)
> +             . ")";
> +     } else {
> +             return undef;
> +     }
> +}

Nice separation into subroutine.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
