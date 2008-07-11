From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Fri, 11 Jul 2008 03:06:43 +0200
Message-ID: <4876B223.4070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 03:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH77u-00025y-LD
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 03:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722AbYGKBHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 21:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbYGKBHS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 21:07:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:58586 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbYGKBHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 21:07:16 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2199165waf.23
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 18:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:content-type:content-transfer-encoding
         :from;
        bh=QZ/u55POim85t+pyWOWHITZDw6TagFHLthpInkkKrc0=;
        b=pW5yod7tCONOoONRA4bU/Aw2a0bbESDTTCmCGt9RZ8ZYuN7zt0mEO7BS6x4duTyYuZ
         V1VjRDHnA7/peedxbs2z4QyGgw1nDgwUaj0xcrEoDFkvELobdNuwu71hEqm2u0Hr429r
         xrXJS8HKBlJItsymu+qLhzD0yIMUBArZOm4DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding:from;
        b=AjCHI7B4y582xowYzmZocAkuRUxIE3OHmh/M3Ef4gX19P/g62EKlWfrHL9aVwpyD9O
         J3gZCZN9/uET/B7tChultP25H2tz3jbfg4mWoXZqvv7q93my3pvY2UDgKEu0nqiR6ELf
         F9uoZ+8/250paaiC+GNzaSZPsRHGzPAXfoXLw=
Received: by 10.114.124.12 with SMTP id w12mr12688055wac.210.1215738435650;
        Thu, 10 Jul 2008 18:07:15 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.220.178])
        by mx.google.com with ESMTPS id 31sm1971250fkt.7.2008.07.10.18.06.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 10 Jul 2008 18:07:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88068>

Hi everyone,

As follow-ups to this message, I'll be sending three patches for

1) adding the Mechanize tests,
2) adding the Git::Repo API, and (the important part:)
3) making gitweb use the Git::Repo API, and adding caching to gitweb.

The patches apply on master or next: they're viewable live in action,
with cache statistics temporarily enabled at the bottom of each page,
at: http://odin3.kernel.org/git-lewiemann/

Patch (3) basically makes two large changes in one patch, but it was
pretty hard to separate them during development.  I could try to split
them up after the fact, but it would take at least an hour or two, since
the changes that introduce caching are spread all over the code.  I
don't think that having separate commits ([a] use Git::Repo API, [b] add
caching) brings enough benefit to justify the effort.

There are some other changes in (3) as well, but they fell out as part
of the refactoring, so I didn't separate them either -- same thing.

The Mechanize tests succeed before and after patch (3) is applied, so
I'm reasonably confident that my refactoring didn't introduce any
(major) bugs.

And since you all are curious about the API thing :-), I've added some
notes about why I didn't use Git.pm in the patch message of patch (2).

To all reviewers: Since the patches are quite long, I suggest that for
anything but major changes that require either discussion or work on my
end, you simply send a patch that applies on top of my patches.  (Just
sending a patch with a bunch of trivial/small changes without comment
should be fine; the reasons for simple improvements are normally obvious.)

On my to-do list:

- Benchmarks.  I'm planning to time a replay of kernel.org's gitweb logs
on the test server, with and without caching.  Nothing fancy.  (The
performance of the test setup on odin3.kernel.org is not representative
of gitweb's actual performance under load.)

- Implement support for Last-Modified or ETags, since those basically
fall out for free with the current implementation.  (This will require
mod_perl, since CGI doesn't allow for accessing arbitrary request
headers AFAIK.)  That will make the site a tad more responsive, I hope,
and it will also hugely reduce the load for RSS/Atom requests, which
currently make up almost half of all requests to kernel.org's gitweb and
get served in full each time (i.e. "200 OK" instead of "304 Not Modified").

- Make gitweb use more parts of the Git::Repo API; in particular, the
commit and tag parsing code should be ripped out, and gitweb should use
the (much prettier) Git::Commit/Git::Tag API instead.  Perhaps some more
functions (like ls_tree) can be generalized into the API as well; I went
the easy route for now and simply replaced most "open '-|'" calls with
$repo->cmd_output calls.

-- Lea
