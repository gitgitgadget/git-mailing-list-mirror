From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Tue, 23 Aug 2011 12:58:37 -0700
Message-ID: <20110823195837.GA10935@dcvr.yhbt.net>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Gross <jgross@MIT.EDU>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 21:58:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvx7T-0000sq-LR
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 21:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab1HWT6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 15:58:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52352 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486Ab1HWT6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 15:58:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5D6296976;
	Tue, 23 Aug 2011 19:58:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179965>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > Jason Gross <jgross@MIT.EDU> wrote:
> >>  		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
> >
> > Can we make the caches sharable by encoding variables like
> > $Config{use64bitint} and $Storable::VERSION into $cache_path?
> >
> > Something like this (untested):
> >
> > 	use Config;
> >
> > 	my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
> > 	$cache_path .= "$Config{use64bitint}.$Storable::VERSION/";
> >
> > We'll blow everybody's cache away once during the git-svn upgrade, but
> > in the future people will be able to share the same working tree between
> > different versions of perl/Storable/whatnot without needing extra code
> > to detect croaks, different build options, and nuking each other's
> > caches.
> 
> Meaning multiple directories and people share with those with systems with
> similar characteristics?

Yes.

> It certainly is better than silently getting confused or barfing when
> reading 32LE data on 64BE box, and presumably it would be easy to
> implement, but is that the best we can do with memoize?
> 
> I am wondering if memoize can be told to use a platform independent
> serializer backend that is reasonably efficient.

Storable nstore only guarantees endian-neutrality.  JSON/YAML/XML are
all platform-neutral options but (AFAIK) none are standard parts of all
Perl versions we support.  There's Data::Dumper + eval which should
work, but a Memoize::* interface needs to be implemented/imported.

-- 
Eric Wong
