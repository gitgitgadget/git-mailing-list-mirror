From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 00/10] gitweb: Simple file based output caching
Date: Sun, 7 Feb 2010 00:56:30 +0100
Message-ID: <201002070056.31665.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net> <cover.1264198194.git.jnareb@gmail.com> <4B6CBD05.6040604@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 00:56:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NduWA-0000Co-59
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab0BFX4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 18:56:42 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:41119 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab0BFX4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 18:56:41 -0500
Received: by fxm3 with SMTP id 3so5801444fxm.39
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 15:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZV48EUpvemx3sHB+np+nzHtBc6vsIp3naM4aEo1MBwU=;
        b=nSsmHd1w8gU17XqgtbQBsTweXf7F0baWVN2t1DJO6lHVKDEOSQRNE2kBNzSDW4X7rW
         xCM3Ttfbx57NUHB06K8nGVhK4vW4UM/vWCWhLmnfifVC6Mo8z3Pg4buKQ3rz8k8/Rofs
         OgTEVkh5MwJImUUVIlpa+e4dlwOpQysnbJqqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H5XaKq+katFqDSn52+TO/Egwxxa6COHnWCb27czzBoC9FcC0x8bkf2EKOrJy8zpVwO
         S3qxnWu8esH2cU+Pk7TRrLDgIgA7sBEFRGd7LF4rHyF2n79BkLiXMHB23EhxmgL+Dgf/
         BEP4UIEe3fqHEIRaiqVsvVid4HrhwBlmRct14=
Received: by 10.103.87.28 with SMTP id p28mr3085571mul.83.1265500598764;
        Sat, 06 Feb 2010 15:56:38 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id n10sm4854232mue.44.2010.02.06.15.56.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 15:56:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B6CBD05.6040604@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139200>

On Sat, 6 Feb 2010, J.H. wrote:
> > Table of contents:
> > ~~~~~~~~~~~~~~~~~~
> >  [RFC PATCH 01/10] gitweb: Print to explicit filehandle (preparing
> >                    for caching)

I am working on v2 of this series, where this patch is not necessary.

It uses *STDOUT->push_layer(scalar => \$data) and *STDOUT->pop_layer()
from PerlIO::Util if it is available, and manipulation of *STDOUT (which
means *STDOUT = $data_fh and not $out = $data_fh).  But I must say that
doing capture of STDOUT (only; STDERR is not captured) without requiring
extra Perl modules (like recommended Capture::Tiny or e.g. IO::Capture),
and especially testing that it works correctly with capturing output
of cache_fetch is serious PITA.

This patch has the advantage that all operations are simpler.  In
particular it is easy to have section which should be not captured,
or where capture should be turned off (slightly different).

It has the disadvantage that all future contributions must use
"print $out <something>" / "print {$out} <something>", and that
contributions from before this change would have to be carefully
updated.  (Well, we could probably add the test that would check
that everything that needs to go to $out does, and everything that
shouldn't got to $out but to STDOUT doesn't.)


If I were to have such patch in new version of "gitweb output
caching" series, I would make the following changes:
* (optionally) use simpler 'print $out <sth>' instead of visually 
  distinct 'print {$out} <sth>', where from first glance one can
  see that $out is filehandle and not something to be printed
* use short filehandle name: $out, or $oh, or $o/$O.
* split above patch in 2 to 4 patches:
  - pure mechanical (scripted) change:
     + print <sth>     ->  print $out <sth>
     + printf(<sth>)   ->  printf($out <sth>)
     + binmode STDOUT  ->  binmode $out
    The last with possible exception of very first binmode call.
  - realign (purely whitespace change)
  - wrap too long lines (newlines and whitespace), optional
  - change $out to $bout/$bin ($binary_output_fh) where needed;
    but see comment below (optional)

> 
> This looks fine, I did some quick testing to verify that this would work
> - and it does.

I have only ran test, and didn't actually check that it works correctly.
This commit shouldn't change gitweb behaviour at all.

> 
> The only caveat that needs to be aware is that if the layer is going to
> output binary data it needs to flip the whole stream to :raw before
> outputting (this is going to be more specific to the caching layer).
> 
> One advantage to having the file handles separate is that it's easier to
> distinguish if the data is going to need to be binary data that will
> need to be flipped properly.

I don't think that it would be needed.  

First, all mode changing operations, i.e. calls to binmode are changed
to act on $out rather than on STDOUT it means.  It means that if we are
using 'in memory file' to capture output to scalar variable, then captured
data would be properly converted in variable.  So it would be enough to
save this variable in :raw mode to file.  If we are saving directly to
cache file, then of course saved data would go through layer and would
be converted properly.  In any case in cache file we would have _already_
_converted_ data.

This means that regardless whether $out used ':utf8' (pseudo)layer,
or ':raw' (pseudo)layer, if we read from cache file in ':raw' (binary mode)
and print data from cache to original (true) STDOUT also in ':raw' mode,
we would print correctly formatted data.

> 
> Also means you could cache the binary data differently than textual data.
> 
> I.E. binary data gets saved to disk, but page data gets saved to memcached.

That's true, but on the other hand it would be easy to add some extra
command marking data as binary below binmode.  Or we can examine IO
layers (using PerlIO::get_layers($out); the PerlIO module is in Perl
core) if there is 'utf8' layer or 'raw' (pseudo)layer.

> 
> Just food for thought, I'm not sure which way makes more sense
> personally, though I would have a tendency to err on the side of
> flexibility and have both.

It might be good idea... but nevertheless I'd like to have short name
for binary filehandle, if we decode to keep it.  What should it be?
$bout, $bin, $B, $bin_out, $out_bin, $bin_fh?

> 
> >  [RFC PATCH 02/10] gitweb: href(..., -path_info => 0|1)
> 
> note: delaying additional comment till I've finished reading through the
> basics of the following patches.

This is to use later _full_ _normalized_ URI as cache key for given page.
IIRC in your original patch you ignored path_info; but on the other hand
git.kernel.org has path_info feature turned off...

> 
> >  [RFC PATCH 03/10] gitweb/cache.pm - Very simple file based caching
> 
> Ok this is quite the departure from what I had, I'm unsure that it's the
> right way to go, but it obviously has merits (I.E. much simpler addition
> of any Cache::Cache or CHI compatible caching layer)
> 
> This patch itself looks fine, and as it states it borrows heavily from
> my basic implementation - just wraps it differently.  I might have some
> thoughts on extending this a bit to be a bit more flushed out from a
> basic standpoint.
> 
> Need to dig through it some more, but I'm generally ok with it.

Note that the new implementation in (not send yet) new version of 
"gitweb output caching" series is based more on newer and more modern
CHI unified interface rather than older Cache::Cache interface.  It
is I think much cleaner and easier to read.

The major difference from your implementation is that in my version
the gitweb caching engine uses "save to temporary file + rename file
to final name" method to have atomic write to cache (atomic cache
filling).  It should be more robust, but OTOH it introduces a bit of
performance penalty.  With locking and single writer we could use
predictable temporary file name rather than using tempfile/mkstemp
or equivalent from File::Temp, or UUID based filename like CHI does
it.

Also, tests.


Current code (even the v2 version) lacks proper error detection, error
signalling and logging.

> 
> >  [RFC PATCH 04/10] gitweb/cache.pm - Stat-based cache expiration
> 
> Looks fine to me, though the note about getting the errors should get
> moved to previous patch, as it says.

I wanted to get this series out faster, that is why it is not polished.

> 
> Note: I'm going to stop here as the following are WIP and I want to play
> around with this particular direction on my own a little more before
> further comment.  There's some ideas running around I want to try and
> get down in code first.  Me moving on and trying these other ideas is
> not a reflection on the following patches, just some alternative
> thinking before I discuss some other ideas on the following patches.

Take a look at gitweb/cache-kernel-v2 branch (the new caching series).
Note however that it would be subject to rebasing / changes.

> 
> Also I've been sitting on this e-mail in this state for almost a week
> while I've been playing with this and having to fight other fires and I
> know that Jakub has been looking for commentary on this.

Thank you very much for your commentary, in spite of your heavy load.

> 
> >  [RFC PATCH 05/10] gitweb: Use Cache::Cache compatibile (get, set)
> >                    output caching (WIP)
> >  [RFC PATCH 06/10] gitweb/cache.pm - Adaptive cache expiration time (WIP)
> >  [RFC PATCH 07/10] gitweb: Use CHI compatibile (compute method) caching (WIP)
> >  [RFC PATCH 08/10] gitweb/cache.pm - Use locking to avoid 'stampeding herd'
> >                    problem (WIP)
> >  [RFC PATCH 09/10] gitweb/cache.pm - Serve stale data when waiting for
> >                    filling cache (WIP)
> >  [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
> >                    regenerating cache (WIP)

There is new version of this series in gitweb/cache-kernel-v2 in my
git/jnareb-git.git fork (clone) of git.git repository at repo.or.cz.
Now all commits have proper description (for first series one had to
read comment section in emails for commit description), and all features
are tested (at least on API level, and to some extent) -- full tests
do require having PerlIO::Util installed (I have done it following
local::lib and installing it from 'cpan' client), though.

Also all features are fully configurable, to even greater extent than
in original series by J.H. (this what what v1 was lacking).  And there
is (see diffstat) section about caching in gitweb/README.

The following changes since commit d5f8a3d6f4d946c33459e00edf02819f89711777:
  Junio C Hamano (1):
        Merge branch 'master' into next

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-v2

You can view it via gitweb at:

  http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/gitweb/cache-kernel-v2
  http://repo.or.cz/w/git/jnareb-git.git/log/refs/heads/gitweb/cache-kernel-v2

SHORTLOG (10):
      gitweb: href(..., -path_info => 0|1)
      gitweb/cache.pm - Very simple file based caching
      gitweb/cache.pm - Stat-based cache expiration
      gitweb: Use Cache::Cache compatibile (get, set) output caching
      gitweb/cache.pm - Adaptive cache expiration time
      gitweb: Use CHI compatibile (compute method) caching
      gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
      gitweb/cache.pm - Serve stale data when waiting for filling cache
      gitweb/cache.pm - Regenerate (refresh) cache in background
      gitweb: Show appropriate "Generating..." page when regenerating cache

 gitweb/README                          |   70 +++++
 gitweb/cache.pm                        |  527 ++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl                     |  301 +++++++++++++++++-
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   19 ++
 t/t9503-gitweb-caching.sh              |   32 ++
 t/t9503/test_cache_interface.pl        |  380 +++++++++++++++++++++++
 t/test-lib.sh                          |    3 +
 8 files changed, 1319 insertions(+), 15 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl

-- 
Jakub Narebski
Poland
