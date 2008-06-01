From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash
Date: Mon, 2 Jun 2008 00:19:23 +0200
Message-ID: <200806020019.23858.jnareb@gmail.com>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com> <m3lk1q24nb.fsf@localhost.localdomain> <4841471E.2070302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 00:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2vue-0000dT-BJ
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 00:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYFAWTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 18:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYFAWTf
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 18:19:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:4002 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbYFAWTe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 18:19:34 -0400
Received: by nf-out-0910.google.com with SMTP id d3so328582nfc.21
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 15:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=sWyIcMKUEOXECofKn+OuuLS+5cxtcTU+6E+mpQ0MWEM=;
        b=iFVkbKqW+MyiAPkFGraI/qZ8qJ6x/2La+3DzFVwDWqE5TqtWnnvFnr5oe32U039+vC9sfNecmypD8M619ewu/gew+YpnjDsjqvq74qmkw8CjvflP43Z5LQS89OhjjHyrb/UAwzhZ21uQINz22lup0pTz5DgMczoSIU5Gc0QRFc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=G3PzSEvA+VspGaXDaiGW1YgTjwaCJs0P1TkYNgfEqWXkdgmyJWwQPRBFoThZTF3o9miYq5NH6dgku90vWk6HYTqkjidIJt9HvTB3Tt7dQ/ps/TD0eLCwLfk7zpofQ93/EIKcP8i0Ebt0nvcfewSey4WqE9K1uR+r0YQrSD+dOTk=
Received: by 10.210.90.10 with SMTP id n10mr230059ebb.179.1212358772479;
        Sun, 01 Jun 2008 15:19:32 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.195.117])
        by mx.google.com with ESMTPS id z33sm3362300ikz.0.2008.06.01.15.19.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 15:19:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4841471E.2070302@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83474>

On Sat, 31 May 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> But I'm not sure for example [that] parsing subroutines [that parse the
>> output of the git commands should be in Git.pm].
>> 
>> [...] IMVHO caching command output is bad idea.  I'd rather have gitweb
>> cache _parsed_ data (i.e. Perl structures).
> 
> Yes, I agree with you that parsed data should be cached, but for that 
> reason I think that the subroutine that parse git's output should be in 
> Git.pm, not in Gitweb:

This not necessarily follows.  First, I'm not sure if gitweb's parse_*
subroutines are generic enough; please take into account that Git.pm 
is used also by other git commands coded in Perl: git-cvsexportcommit
(but not git-cvsserver?), git-send-email, git-svn and (internal)
git-add--interactive.  Second, caching of _parsed_ data can be
implemented in gitweb, or in Gitweb::Cache / Gitweb::Caching.

> If you want to cache parsed data, you need the caching layer in between 
> the application (= Gitweb) and the repository access layer (= command 
> output parsing), or you would have to insert cache code at every call to 
> the repository access layer.  

Not every.  Please don't assume that we would want to cache _all_ the
data; herein madness lies.

But there is another reason to have caching as a layer, namely having
caching optional (i.e. enabled or disable), although this can be also
achieved by choosing 'Null'/'None' caching engine.

> So you end up with these layers: 
> 
> (Layer 0: Front-end [HTML] caching.)
> Layer 1: Application (Gitweb)
> Layer 2: Back-end caching
> Layer 3: Repository access (command parsing)
> Layer 4: Calls to the git binary
> 
> Layer 3 and 4 are application-independent (i.e. not Gitweb specific), 
> and since they form a usable API, they might as well be written as a 
> separate API rather than lumped together with Gitweb.  Git.pm is a start 
> of such an API (it does layer 4 and a little bit of layer 3), so it 
> seems natural for me to extend it.

This assumes that command parsing used by gitweb are generic enough
to put them in Git.pm.  But some IMVHO are very gitweb-specific, for
example the part in parse_commit_text() beginning with 
  # remove leading stuff of merges to make the interesting part visible
and the 'age_string*' keys there, parse_difftree_raw_line() which
currently does not support '-z' output, parse_from_to_diffinfo() which
is _very_ gitweb specific, git_get_heads_list() which is not generic
enough (it gets info which gitweb needs, but no more), etc.

> Layer 2 is application-independent as well, so it can become an extra 
> class in Git.pm or a separate module.  (It should stay independent of 
> layers 3 and 4).

I think it would be better as separate module.  Would it be Git::Cache
(or Git::Caching), Gitweb::Cache, or part of gitweb, that would have
to be decided.  Besides, I'm not sure if it is really application-
-independent as you say: I think we would get better result if we
collate data first, which is application dependent.  Also I think
there is no sense to cache everything: what to cache is again
application dependent.

> We may need to have an explicitly implemented layer 0 (front-end 
> caching) in Gitweb for at least a subset of pages (like project pages), 
> but we'll see if that's necessary.

I think that front-end caching (HTML/RSS/Atom output caching) has sense
for large web pages (large size and large number of items), such as
projects list page if it is unpaginated (and perhaps even if it is
divided into pages, although I'm sure not for project search page),
commonly requested snapshots (if they are enabled), large trees like
SPECS directory with all the package *.spec files for distribution
repository, perhaps summary/feed for most popular projects.  If (when)
syntax highlighting would got implemented, probably also caching
blob view (as CPU can become issue).

Front-end (HTML output) caching has the advantages of easy to calculate
strong ETag, and web server support for If-Match: and If-None-Match:
HTTP/1.1 headers.  You can easy support Range: request, needed for
resuming download (e.g. for downloading snapshots, if this feature is
enabled in gitweb).  You can even compress the output, and serve it to
clients which support proper transparent compression (Content-Encoding).

And of course it has the advantage of actually been written and tested
in work, in the case of kernel.org gitweb.  Although caching parsed
data was implemented in repo.or.cz gitweb, it was done only for
projects list view, and it is quite new and not so thoroughly tested
  http://article.gmane.org/gmane.comp.version-control.git/77469


It would be nice for front-end caching to have an option to use absolute
time for all time/dates, and to (optionally) not use adaptive
Content-Type...

>> Caching git command output (something like IPC::Cmd::Cached?)
>> would only repeat bad I/O patterns of git commands.
> 
> I hope you're not assuming that the back-end cache will reside on disk 
> -- the problem is IO throughput, so having a cache on disk can really 
> only work for a front-end cache.  For the back-end cache, we *will* have 
> to use a memory cache (or no cache at all).

Don't assume, check (in this case: benchmark[1]).  

But I reallu don't know enough about caching to say if it is one way
or the other...

[1] http://cpan.robm.fastmail.fm/cache_perf.html (a bit old)
-- 
Jakub Narebski
Poland
