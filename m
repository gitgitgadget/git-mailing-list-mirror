From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Tue, 15 Jul 2008 01:03:16 +0200
Message-ID: <487BDB34.7010002@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738708-5212-1-git-send-email-LeWiemann@gmail.com> <200807142323.22761.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIX5h-0005Pk-Kv
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758740AbYGNXDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758748AbYGNXDV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:03:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:4148 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758744AbYGNXDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:03:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2181470fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=usQvggvpRAVmSKjrK9j3ZBJ3F8bJkPVGINbh/2peHTs=;
        b=IsrFh1YvNWkgt448+pAKpCs6Ynuso7Tryybd4cTMrAZToRhAk8sKRJoLuvcl1LfEpw
         SpCcUR/tMMXyO2WeZAOPkn8QD9dS+4RJINA1y0DZFtNe0kBCIWSoDrBAxs2oAJpO5Ldv
         1qoatcXZjyLR+pJrpYGS3MsM8849OjmCDEf8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=Ixt1H4V2xM/Y4UxdpsDZdgj83E0mDi0oMvuQSG2CMaK7VPbbHOdD5hkJQDPrMHPeAB
         VqAs6ingR8QkYflsBsPEQcVdlKi3F4oCbKY2GyKVYZhU4jV6hLF4GEZTWyXaq8Ie+do6
         Uwyw5QsYqZIMcHKuOFroNmK5/IicoYdAvb6Nw=
Received: by 10.86.80.5 with SMTP id d5mr15055275fgb.26.1216076598385;
        Mon, 14 Jul 2008 16:03:18 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id d6sm3198721fga.2.2008.07.14.16.03.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 16:03:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807142323.22761.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88474>

Jakub Narebski wrote:
> It was suggested to split this into separate commit

Yup; I'll probably send updated patches tomorrow night (also for patch 2/3).

>> - gitweb will check for parameter correctness more aggressively,
> 
> I understand that this change deals with treating invalid specifiers,
> which point to either object that do not exists, are ambiguous, or point 
> to object of invalid type.

Yes, that's right.  (I don't believe we have any point where ambiguity
might come up though.)

>> - Empty projects: [...]
> 
> Good.  The only thing that *might* be controversial is putting empty
> projects at the bottom of sorted by age (by last change) projects list, 
> instead of at top.

Yup; let's see if anyone objects though.  If I sort the list by "Last
Change", I usually want to see projects with recent activity, not dead
project, at the top, which is why I changed it (since I was touching
that line anyway).

>> - For HTML pages, remove the "Expires" HTTP response header, and add
>>   "Cache-Control: no-cache" instead.  This is because pages can
>>   contain dynamic content (like the subject of the latest commit)
> 
> I don't think it is a good change.

Hm; I thought transient titles could slip in (e.g. try opening the tree
of some commit and remove the hb parameter; the URL will seem cacheable,
but the page contains the title of the HEAD commit), but I can't find
any URL right now where mainline actually sets a wrong Expires header.
I'll look into it; if you don't see me posting about it again I'll
re-add the Expires header.

> Note that if caching is enabled, you can set expires to either
> time-to-expire of cache entries (simpler), or time left to live to
> invalidation of item in cache (better, but more complicated)

Gitweb's cache is actually never out-of-date, and cache invalidation
happens automatically.  It uses some (long) expiry times to guard
against non-standard modification of the repository, but it's nothing
the HTTP client should be concerned with.

>> $cache = Cache::Memcached->new( { servers => ['localhost:11211'],
> 
> IIRC you can use any Cache::Cache compatibile cache here;
> IMVHO it would be nice if this info would be also in commit message.

I'll add that.

>> $large_cache_root = '/home/lewiemann/gitweb-cache';
> 
> Errr... I understand that it is your _private_ configuration, just 
> copied here verbatim, but I don't think '/home/lewiemann/gitweb-cache'
> is a good example: '/tmp/gitweb-cache' perhaps, that I can understand.

Yup. ;-)  Or /var/cache/gitweb.

>> # Invalidate cache on changes to gitweb without version number bump;
>> # useful for development.
>> $cache_key = (stat '/home/lewiemann/gitweb')[9] . 
>>      (stat '/home/lewiemann/gitweb/gitweb.cgi')[9]; 
> 
> What should be used in production? "$cache_key = $version;"?

No, nothing.  $version is used automatically as a cache key; I'll add
that to the documentation for $cache_key.

> You can always use $ENV{'SCRIPT_FILENAME'}, or dirname of it.

That one doesn't exist with my thttpd, or any other environment variable
that'd be usable.  It's just a hack anyway, so hardcoded paths are OK.
:)  I don't think gitweb should check its own mtime by default.

>> # Display detailed cache info at the bottom of each page.
>> $page_info = 2;
> 
> Errr... what does "$page_info = <n>;" mean?

Display no (0) / short (1) / detailed (2) page (cache) info at the
bottom of each page.  It's documented in gitweb.perl.

> [Comments on patch itself in separate email, later]

Thanks!
