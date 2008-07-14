From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Mon, 14 Jul 2008 23:23:21 +0200
Message-ID: <200807142323.22761.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738708-5212-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIVXA-0004Pn-EA
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 23:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbYGNVXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756128AbYGNVXh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 17:23:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:54768 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102AbYGNVXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 17:23:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2168001fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TvXjOuY1Zj+MpCAMfM1yWK1MV0LssWqxWmUJgma5gFg=;
        b=LroxraPE17c2BA4/kr1oEeaRk9BlN8P1bkHyEwZsJz/eMgPu/9R0w/jmfL+aMwkrAu
         PF1lYyGiY3FsOzopj4Sob+1NbkTsCQYPJ/TqfG0BSP5gy5Bhm+M9CxKQm1+XwHvhZR9r
         tJQjE8iKdqIN45bhwm8uWYPSf4NB5JLzrOAy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ML7bQsDYUADsoxrmDm5KjJaY1Z/jXiBBofqkayqkPCi4x7Jvw/bI0yNDt7XGmepmMP
         IsvPZbGlfR56n89FJDbuXYIl6TYZz8Mcok8CED9mtrUkq8O7g619p673lq+QXQ+M0LLH
         YcMMSqDT8qTRFGIbxE3wD+aOHo4ZVOxtsLTYs=
Received: by 10.86.1.11 with SMTP id 11mr14973814fga.27.1216070614035;
        Mon, 14 Jul 2008 14:23:34 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.43])
        by mx.google.com with ESMTPS id 12sm3223454fgg.0.2008.07.14.14.23.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 14:23:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1215738708-5212-1-git-send-email-LeWiemann@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88464>

On Fri, 11 July 2008, Lea Wiemann wrote:

> Gitweb now uses the Git::Repo API; this change is behavior-preserving,
> except for slightly more aggressive error handling; see below.

Good.

It was suggested to split this into separate commit from the following 
change, for making it easier to test (you can check that behavior is
the same, with the exception of error handling) and review (smaller
patch to read and review).
 
> This patch also adds an optional caching layer for caching repository
> data in memory and (for larger cacheable items, like blobs, snapshots,
> or diffs) on disk.

As it was said, if feasible it would be good idea to put this change
into separate commit.

> Other minor changes:
> 
> - Gitweb would previously accept invalid input and either (a) display
>   nothing, (b) display an obscure error message, or (c) proceed as
>   normal since the parameter happens to be unused in the particular
>   code path used.  This has changed in that gitweb will check for
>   parameter correctness more aggressively, and display meaningful
>   error messages.  This change is only relevant if you manually edit
>   gitweb's CGI parameters, since gitweb only generates valid links.

I understand that this change deals with treating invalid specifiers,
which point to either object that do not exists, are ambiguous, or point 
to object of invalid type.  Gitweb does check "syntactic" validity of 
input (of CGI parameters) already, even those that are not used for 
selected action.

BTW. such check was not feasible before implementing --batch and/or 
--batch-check options to git-cat-file; I think that possibly one more 
fork is not much price to pay for better error checking.

> - Empty projects:
> 
>   - Only display summary link for empty projects in project list to
>     avoid broken links (yielding 404).
> 
>   - Slim down summary page for empty projects to avoid some broken
>     links and unnecessary vertical space.
> 
>   - Sort empty projects at the bottom of the project list when sorting
>     by last change.
> 
>   - Add test for empty projects to t9503 (the Mechanize test), now
>     that there no broken links anymore.

Good.  The only thing that *might* be controversial is putting empty
projects at the bottom of sorted by age (by last change) projects list, 
instead of at top.

> - For HTML pages, remove the "Expires" HTTP response header, and add
>   "Cache-Control: no-cache" instead.  This is because pages can
>   contain dynamic content (like the subject of the latest commit), so
>   the Expires headers would be wrong.
> 
>   This makes gitweb's responsiveness slightly worse, but it will get
>   much better once If-Last-Modified is implemented.  It's better to be
>   correct than to be convenient here, since having to press the reload
>   button makes for lousy user experience (IOW, users should be able to
>   always trust gitweb's output).
> 
>   Raw diffs and blobs still get the Expires header, where appropriate.

I don't think it is a good change.

Gitweb generates two types of views (pages): transient and immutable.
An example of transient view (transient page/action) is for example RSS 
feed, or summary page.  When project (repository) is updated, they can 
change.

The opposite are immutable pages.  They are pages/actions/views where 
all specifiers are given by full SHA-1; to be more exact all specifiers 
that are needed to reconstruct object are given by SHA-1.  (It is 
enough to have sufficient check for immutability, i.e. such that if 
check succeeds, then page is immutable, but it doesn't need to be true 
in reverse.)

Gitweb sets expires to '+1d' which is one day to pages it considers 
immutable, while not defining expires for other pages (which results,
I think, in lack of expires header).  We could have set it to "forever", 
which in terms of Expires: HTTP header is half a year (from what
I remember).

Now I don't see *any* reason to not set long expires for immutable 
pages; I don't know if forbidding to cache transient pages even if in 
fact they are generated dynamically is a good idea...  Note that if 
caching is enabled, you can set expires to either time-to-expire of 
cache entries (simpler), or time left to live to invalidation of item 
in cache (better, but more complicated) perhaps also setting Age: 
header to appropriate value.


Sidenote: we would probably want to use Expires: for HTTP/1.0 requests, 
and Cache-Control: max-age=<seconds> for HTTP/1.1 requests.  But that 
might be left as improvement for later...

> - Add a $page_info option to display cache stats at the bottom of each
>   page; the option is named generically to allow for adding non-cache
>   page info there at some point (timings perhaps?).

Great idea!
 
> ---
> It's all documented of course :-), but for the impatient here's a
> snippet for gitweb_config.perl to activate caching:

Nice.

> use Cache::Memcached;
> $cache = Cache::Memcached->new( { servers => ['localhost:11211'],
>      compress_threshold => 1000 } );

IIRC you can use any Cache::Cache compatibile (is it explained later 
what it means?) cache here; IMVHO it would be nice if this info would 
be also in commit message.

> $large_cache_root = '/home/lewiemann/gitweb-cache';
> $large_cache_case_sensitive = 1;

Errr... I understand that it is your _private_ configuration, just 
copied here verbatim, but I don't think '/home/lewiemann/gitweb-cache'
is a good example: '/tmp/gitweb-cache' perhaps, that I can understand.

> # Invalidate cache on changes to gitweb without version number bump;
> # useful for development.
> $cache_key = (stat '/home/lewiemann/gitweb')[9] . 
>      (stat '/home/lewiemann/gitweb/gitweb.cgi')[9]; 

What should be used in production? "$cache_key = $version;"?

Besides hardcoding those paths is not a good idea.  You can always
use $ENV{'SCRIPT_FILENAME'}, or dirname of it.

> # Display detailed cache info at the bottom of each page.
> $page_info = 2;

Errr... what does "$page_info = <n>;" mean?

> A live demo is here: http://odin3.kernel.org/git-lewiemann/

Nice.  Thanks.

[...]
>  gitweb/README                          |   14 +

Very good.


[Comments on patch itself in separate email, later]
-- 
Jakub Narebski
Poland
