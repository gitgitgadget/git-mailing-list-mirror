From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] Gitweb caching v7
Date: Sun, 31 Oct 2010 11:21:54 +0200
Message-ID: <201010311021.55917.jnareb@gmail.com>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net> <m3k4l0girs.fsf@localhost.localdomain> <7v1v773s7e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 10:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCU7B-000233-D9
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 10:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab0JaJWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 05:22:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62204 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058Ab0JaJWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Oct 2010 05:22:03 -0400
Received: by fxm16 with SMTP id 16so4222320fxm.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vTVL3/YaUrHAWpCryzluK0s9rCzYOFw49dXiDh2MGek=;
        b=wzOdqRMvb0z8HwiEHAXb4I+YLDNWBgpVrAjkha3hXp2JzavJ90Zyem4zGY7vHB4VKv
         H9n9TlZ4wbuY/37IpgJK6VkIPSZ+H4R+3eUpelNI8Eol12b5KK9DtOL1+TgdnB0vsKDr
         IMH5+bYeNW2DLU3A+rhrWqn9P5Qr5tzuSSITw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Tr1WGqDGY9lRSzewB+EWGzHGbWO1+TlWs/AOE5ZYqRBt1aEp/0METJWFR9OgejsczE
         9akiXVqL0efmFwUqy7QbWSXQTLXVN6Uh30xJucJMfO8jO5B6DMb2HZCKTOhBxFeF5Z1i
         1jjAu+lKvXSXAx3zAcmLP+c/N9CI+P7Kt+0cw=
Received: by 10.223.74.143 with SMTP id u15mr135237faj.27.1288516921672;
        Sun, 31 Oct 2010 02:22:01 -0700 (PDT)
Received: from [192.168.1.13] (abva95.neoplus.adsl.tpnet.pl [83.8.198.95])
        by mx.google.com with ESMTPS id z25sm1889386fam.2.2010.10.31.02.21.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 02:21:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1v773s7e.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160430>

On Sun, 31 Oct 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> I am getting this in the gitweb.log:
>>> 
>>>     [Fri Oct 29 22:21:12 2010] gitweb.perl: Undefined subroutine 
>>>     &main::cache_fetch called at .../t/../gitweb/gitweb.perl line 1124.
>>> 
>>> which seems to cause t9500 to fail.
>>
>> This is caused by three issues (bugs) in v7 caching code.
>>
>> First is the reason why t9500 exhibits this bug.  The gitweb caching
>> v7 includes file with subroutines related to caching in the following
>> way:
>>
>>   do 'cache.pm';
>>
>> Note that the relative path is used; for t9500 it is relative from
>> somewhere witjin 't/', and not from 'gitweb/', so "do 'cache.pm';"
>> doesn't find it.
> 
> John, where should cache.pm go in the installed system?  Does it typically
> go next to gitweb.perl?
> 
> I think "do 'that-file'" honors path specified by the -I option, so I do
> not think "do $cache_pm" is necessary.  My preference is to run gitweb
> tests with appropriate -I pointing at the cache.pm in the directory.

>From `perldoc -f do`

      do 'stat.pl';

   is just like

      eval 'cat stat.pl';

   except that it's more efficient and concise, keeps track of the current
   filename for error messages, searches the @INC libraries, and updates %INC
   if the file is found.        ^^^^^^^^^^^^^^^^^^^^^^^^^^^

So I think it respects '-I<directory>' given to perl interpreter.

On the other hand I don't know how it would work with mod_perl (uwing
ModPerl::Registry handler), whether it wouldn't too require extra
configuration.

So I think a better solution would be to base 'Gitweb caching v7' plus
necessary fixes and improvements on top of 

  gitweb: Prepare for splitting gitweb

This means that the directory that gitweb is in would be added to @INC
via

  use lib __DIR__.'/lib';

The 'cache.pm' or 'cache.pl' file would be moved to 'gitweb/lib', but
that is cosmetic change.

> 
>> ...  It should be
>>
>>   do $cache_pm;
>>   die $@ if $@;
>>
>> at least.
> 
> Catching failure is a good thing to do.

Right.  And this is only one-line addition.
 
>> Perhaps even better would be to simply turn off caching
>> support if there is an error in 'cache.pm'
> 
> That can come later.
> 
> Jakub, can we have an absolute minimum fix-up, so that we can give
> this wider exposure?  I think there are only
> four issues:
> 
>  (1) exclude Ajax-y stuff from caching;

Easy, but only if check whether to do capturing and caching is moved
out of cache_fetch to caller, i.e. to gitweb script.  See also comments
below about what need and should be done.

Another solution is to turn off Ajax-y stuff when caching is enabled.
It can be done quite easily, just sprinkle some !$caching_enabled
(see comment below about naming and semantic of this config variable)
in appropriate place.

>  (2) install cache.pm the same way gitweb.perl is installed via
>      the Makefile;

With "gitweb: Prepare for splitting gitweb" as introductory patch this
would be just adding

  # gitweb output caching
  GITWEB_MODULES += cache.pm

(or cache.pl - it is not a proper Perl package!) e.g. above GITWEB_REPLACE
sed script in gitweb/Makefile.

>  (3) running tests with appropriate -I so that cache.pm is found; and

No change to test necessary if we use "use lib __DIR__.'/lib';" in
gitweb.perl

I'd like to port from my rewrite change to t/t9500-gitweb-standalone-no-errors.sh
adding minimal test to check if running gitweb with caching enabled
doesn't generate any warnings, and (modified) change to the
t/t9502-gitweb-standalone-parse-output.sh, adding minimal test that
gitweb produces the same output with and without caching.

>  (4) die if 'cache.pm' cannot be "done".

O.K. (4) is one liner.

There is are also other issues

   (5) naming and semantic of gitweb config variables configuring caching;
       at least change $cache_enabled enum to $caching_enabled boolean
   (6) do not change anything in gitweb behavior if caching is disabled;
       move 'if ($caching_enabled)' test to gitweb.perl, and remove code
       from cache_fetch

About (5): names and semantics of configuration variables are gitweb API,
so we should at least try to keep backward compatibility with old names
(see for example 'backward compatibility: legacy gitweb config support'
section in %known_snapshot_format_aliases).  

There is no much problem with $minCacheTime, $maxCacheTime, $backgroundCache
etc. (besides bleh, camelCase ;-) but I would prefer to have *boolean*
$caching_enabled (true-ish value means cache is enabled, false-y value
including undef means caching is disabled) to currently two-value *"enum"*
$cache_enable called "binary" (sic!) in docs and comments.  See also
issue (6).


About (6): I would prefer to move check if caching should be enabled
higher, to gitweb.perl (to its own configure_caching() subroutine, rather
than sprinkling it in top scope), and not even include 'cache.pm'
if caching is disabled (default).  But because we use 'do' and not
'require', we would have to check %INC to not include it twice...

Anyway, whether we include 'cache.pm' conditionally or not, I'd prefer
to use

  if ($caching_enabled) {
  	cache_fetch($action);
  } else {
  	$actions{$action}->();
  }

in dispatch() subroutine, and simply remove all code dealing with
'$cache_enable == 0' case from 'cache.pm'.

Remember, config variables are forever :-)

> 
> I think the change in gitweb-cache v7 is small and safe enough that we
> should fast-track it to give usability to the real world sites.  It may be
> a low-risk "obviously correct" approach that is quick-and-dirty, but that
> is exactly why this should be fast-tracked.  It does not touch the logic
> or formatting in any way, just bypasses the page generation altogether
> when it can clearly do so when it can tell the output cannot possibly be
> incorrect (albeit sometimes it might be stale if in certain cases, e.g. it
> is relative to HEAD).

My rewrite also does the same.  I have changed it to do the same STDOUT
redirection that J.H. gitweb caching v7 does (I used select($fh) based
capture) - work in progress, not yet pushed to my repository:

  git://repo.or.cz/git/jnareb-git.git
  http://repo.or.cz/w/git/jnareb-git.git (gitweb)

> 
> I know you and others were aiming to split things up, but I think the
> amount of the effort that is needed for that line of work on top of the
> current codebase is not much different from what is needed on top of
> gitweb-cache v7.

Well, I'd have to add support for configuration variables used in this
patch series, but with exception of $cache_enable -> $caching_enabled
it wouldn't be much extra work.

-- 
Jakub Narebski
Poland
