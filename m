From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 15:20:54 +0200
Message-ID: <200908191520.56436.jnareb@gmail.com>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com> <200908191418.08838.jnareb@gmail.com> <20090819124820.GC20381@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Rob (gmail)" <robvanb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 15:22:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdl7D-0001g3-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 15:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbZHSNVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 09:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbZHSNVF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 09:21:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:45945 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZHSNVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 09:21:03 -0400
Received: by fg-out-1718.google.com with SMTP id e12so793798fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ja+WPH/SXwF1O8bc4xsf1HiiTysuMjn7Nw/mAqL+V6U=;
        b=Y75TqiKvoaOII9L+RtbdhGrUcqoX4oP8rHGbEdJUqMOqNbjDBqR+ZGWi07MRJJb07k
         Cz8P7y4jp3q1wVx/hOS5o7Ki+NmUy+6n3TuLpIkkxcTEOwaqoD8ijSvcOs3hTyqR1/gM
         PjRYi9UzVvJdoG1ZgjyVFcqDFG0UZcQGKOQIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DVEnV91x72nCn6mwwrAK7wqC9gCksq6jjhwufMJji8jODFFOAiFAXK+c35cMHPHqEr
         vgNfDfjN6QX7/zX78kQBz5l4dx7D4z2PQBrCl4KadPMpyR6zhoUNHya2MKPYCvRpx1Qs
         m4Nh/0x6fOB8mbCn7LlZp0uD+Karbfvwrarug=
Received: by 10.86.20.8 with SMTP id 8mr4217096fgt.44.1250688063877;
        Wed, 19 Aug 2009 06:21:03 -0700 (PDT)
Received: from ?192.168.1.13? (abvk137.neoplus.adsl.tpnet.pl [83.8.208.137])
        by mx.google.com with ESMTPS id l19sm525323fgb.7.2009.08.19.06.21.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 06:21:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090819124820.GC20381@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126545>

On Wed, 19 August 2009, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 19, 2009 at 02:18:07PM +0200, Jakub Narebski wrote:
> 
> > More complicated solution, used by gitweb, requires Perl, not checked
> > that it works correctly, doesn't work with ancient repositories with
> > symlink HEAD.
> > 
> >  $ perl -e '
> >  use File::Find qw(find);
> >  my @list = ();
> >  find({follow_fast => 1, follow_skip => 2, dangling_symlinks => 0,
> >        wanted => sub {
> >          return if (m!^[/.]$!);
> >          return unless (-d $_);
> >          push @list, $_ if -e "$_/HEAD" 
> >        }});
> >  print join("\n", @list)."\n";
> >  '
> 
> That doesn't seem very accurate. It will find 'HEAD' in "logs/" of
> repositories with reflogs enabled, and "refs/remotes/*/" of cloned
> repositories, giving you a lot of false positives.

To be more exact it is simplified solution used by git; in this case 
_oversimplified_, as gitweb doesn't have problems with 'HEAD' in 
remote-tracking branches.

On the other hand gitweb currently does not detect submodules or 
submodule-like repositories, i.e. repositories inside working directory
of other repository.  So this could be improved...

> 
> If you want accuracy, you can ask git rev-parse to verify whether a
> directory is a git repo; it actually uses a few different heuristics to
> check. For example:
> 
>   find . -type d |
>     while read dir; do
>       if GIT_DIR=$dir git rev-parse --git-dir >/dev/null 2>&1; then

Or "git --git-dir=$dir rev-parse 2> /dev/null"

>         echo $dir
>       fi
>     done
> 
> but it is a bit slower, as you invoke rev-parse for every directory, and
> it actually does some verification of the contents of HEAD (so it is
> probably a bad idea for something like gitweb, which cares about
> performance).
> 
> If you want to do a cheap and fast check, searching for 'HEAD', 'refs',
> and 'objects' in the same directory is a reasonable heuristic.

If one follow preferred git conventions for naming non-bare repositories,
and one doesn't have anything funny,

  $ find . -name "*.git" -type d

should be sufficient.
-- 
Jakub Narebski
Poland
