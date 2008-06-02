From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash
Date: Mon, 2 Jun 2008 23:32:27 +0200
Message-ID: <200806022332.29853.jnareb@gmail.com>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com> <200806020019.23858.jnareb@gmail.com> <20080602092926.GJ18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Heq-0000bp-IY
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbYFBVcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbYFBVcl
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:32:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:36645 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYFBVcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:32:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so364010ugf.16
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kV+XcXB9E2K+lhTkpC3ZoaA9IY5EaG1E8/D4FnMcemU=;
        b=whL9JiOnqmNxNSrNFPhLVqklXgcIBfl6JTOF5WWeUH3d+8QBv3U6sTIQtORIJvYEt0
         UAK6jk4LwHxK6neLflhL1dAvw/cc1B5/fOqaOojS4/qVFs7CTt0OwBXy4Pak7utigOel
         43Q9Xx5KhGmKNlS3BeMHcVH3gQ5LdLk06nECE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GD/O+EUCXKq/ModE7Qx0vQhLJQIpWCxHV6VFCkwEUx5m4Dn9lxieEDYot5Uw5YOWjL
         SPYcRgIplr+qsrIn+JRCuY4GQD9raSVpV3l2US7BqAaFGwGPl00TDWyKrVmn/M1nPM4g
         0su5fgfGf4Vul2YDZmRalzEKc7IsYDKtS9/hc=
Received: by 10.210.65.2 with SMTP id n2mr7814403eba.48.1212442357535;
        Mon, 02 Jun 2008 14:32:37 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.244.52])
        by mx.google.com with ESMTPS id k5sm33360212nfh.39.2008.06.02.14.32.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:32:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080602092926.GJ18781@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83577>

On Mon, 2 June 2008, Petr Baudis wrote:
> On Mon, Jun 02, 2008 at 12:19:23AM +0200, Jakub Narebski wrote:
> > On Sat, 31 May 2008, Lea Wiemann wrote:
> > >
> > > We may need to have an explicitly implemented layer 0 (front-end 
> > > caching) in Gitweb for at least a subset of pages (like project pages), 
> > > but we'll see if that's necessary.
> > 
> > I think that front-end caching (HTML/RSS/Atom output caching) has sense
> > for large web pages (large size and large number of items), such as
> > projects list page if it is unpaginated (and perhaps even if it is
> > divided into pages, although I'm sure not for project search page),
> > commonly requested snapshots (if they are enabled), large trees like
> > SPECS directory with all the package *.spec files for distribution
> > repository, perhaps summary/feed for most popular projects. If (when)
> > syntax highlighting would got implemented, probably also caching
> > blob view (as CPU can become issue).
> > 
> > Front-end (HTML output) caching has the advantages of easy to calculate
> > strong ETag, and web server support for If-Match: and If-None-Match:
> > HTTP/1.1 headers.  You can easy support Range: request, needed for
> > resuming download (e.g. for downloading snapshots, if this feature is
> > enabled in gitweb).
> 
> Caching snapshots would definitely make sense, sure.

That reminds me to finally implement nicer (git-describe like)
[proposed] snapshot filenames.  For example for snapshot of state
given by some tag (snapshot of tagged release [1]), don't use
generic
  <project basename>-<40-chars sha1>.<suffix>
  git-b2a42f55bc419352b848751b0763b0a2d1198479.tar.gz
but
  <project basename>-<tag name>.<suffix>
  git-v1.5.5.3.tar.gz
(well, currently tags don't have 'snapshot' link, but this is easily
fixed).  What do you think about (ab)using 'fp' (file_parent)
parameter to pass proposed snapshot file name?

[1] Would it be good feature to add support for limiting snapshots
to snapshots only of tagged releases (which would be I guess more
important when gitweb caching gets implemented).
 
> > You can even compress the output, and serve it to clients which
> > support proper transparent compression (Content-Encoding).
> 
> What does this have to do with caching?

Well, only in a sense that with front-end caching (to choose if CPU
matters most) this can be done "for free", without incurring extra
CPU, at the cost of little more disk space.

Of course, if most clients understand (accept) Content-Encoding
(transfer encoding), you can store compressed output, with a little
CPU cost to decompress for non-conformant clients; this way frontend
caching can have cache size comparable to [parsed] data caching.

> > And of course it has the advantage of actually been written and tested
> > in work, in the case of kernel.org gitweb.  Although caching parsed
> > data was implemented in repo.or.cz gitweb, it was done only for
> > projects list view, and it is quite new and not so thoroughly tested
> >   http://article.gmane.org/gmane.comp.version-control.git/77469
> 
> This argument does have some value, but I don't think it matters too
> much, since as far as I understood, it is going to get largely
> reimplemented anyway.

What I'd like to see in a bit of time is some estimate how much time
would take implementing data caching almost from scratch (a bit of
code in repo's gitweb), compared to merging in kernel.org's gitweb
caching code...

> > It would be nice for front-end caching to have an option to use absolute
> > time for all time/dates, and to (optionally) not use adaptive
> > Content-Type...
> 
> I'd hate to have to do unnecessary compromises in order to get sensible
> caching.
> 
> Even in your excellent series on Gitweb caching series, I didn't spot
> any arguments that would put frontend caching in front of the
> intermediate data caching option; yes, it is the simplest solution
> implementation-wise, but also the least flexible one. My gut feeling is
> still to go with data caching instead of HTML caching.

As Lars Hjemli wrote in "[RFC/PATCH] gitweb: Paginate project list"
thread (unfortunately not all articles got to git mailing list)

  http://thread.gmane.org/gmane.comp.version-control.git/81838/focus=81875

  <quote>
  In cgit I've chosen "projectlist in a single file" and "cache html
  output". This makes it cheap (in terms of cpu and io) to both generate
  and serve the cached page (and the cache works for all pages).
  </quote>

  <quote>
  While I agree that caching search result output almost never makes
  sense, I think it's more important that cache hits requires minimal
  processing. This is why I've chosen to cache the final result instead
  of an intermediate state, but both solutions obviously got some pros
  and cons.
  </quote>

caching final output is important if you want to minimize processing
(CPU time).  I'd say also if you want to implement Range: for resumable
downloads (snapshots), because otherwise I think it would be quote hard
to do reasonably (with caching only data).

So I guess best solution would be mixed one: use output cache for large
or CPU intensive pages, use data caching to limit cache size and for
maximum flexibility (relative dates, sorting by columns: athough that
would be best solved using some DHTML/JavaScript, paginated output,
projects search etc.)


By the way, we have your (Petr 'Pasky' Baudis, based on repo.or.cz)
and John 'Warthog9' Hawley (based on kernel.org) statements that gitweb
performance is I/O bound, but I don't remember any hard data.

I have said wrongly that one can use 'fio' tool to check I/O
performance; it is not true, this tool can be used to test _filesystem_
by generating specified pattern of I/O load.  I don't know of any tool
which allow to measure if I/O is bottleneck for given application;
'iogrind' measures cold cache start, and it requires I think compiled
program, as it uses Valgrind.  You can measure CPU load, time to
response and memory usage using 'time' (running gitweb as script),
ApacheBench and top; you can measure latency using LatencyTOP.  

Is there some iotop tool, and can it be used to measure performance
bottlenecks of web scripts (web applications)?

-- 
Jakub Narebski
Poland
