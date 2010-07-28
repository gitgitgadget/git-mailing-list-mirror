From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 13
Date: Wed, 28 Jul 2010 21:56:29 +0530
Message-ID: <20100728162627.GA31912@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 18:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe9Ua-0001yS-2c
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 18:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0G1Q2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 12:28:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54742 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0G1Q2U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 12:28:20 -0400
Received: by pzk26 with SMTP id 26so1900290pzk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=QVV/UrMDeACYevy8QhCFyc7d9eNOu+m/zL8YnKXqZcI=;
        b=LENaYr8otAXIVn9gIXWbxVZrhvt8HWGYo8VCrEWV7vRPdutW8V657oeiMki6O5NagD
         WtArzB+B8mFo/up+KZi+sivayLpLM6ya9h/A+T8V4J0yQKIkjg6xhgIPWjWnH/klCmKv
         WkZc0DpLnFz5w179dF+DkHkbSl7/Q9M1O0iVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=uQoZmfmqYeHbQVdxmziGX5zZGV5KclxBD7VwYbv1Oa9nJ++hqgtedmNWumjW85zRvh
         U8D6wV+nIf9fKqyl88p/lfX1lq+OZyhtnOoOmITuXBaLsmjKuuKmwljDpIwrWQ7hsG+H
         rId7KsuDC2q6jN/tIQh7PVVr4Pu00/Qb2GGuY=
Received: by 10.114.135.7 with SMTP id i7mr9320038wad.20.1280334494106;
        Wed, 28 Jul 2010 09:28:14 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm11437948wam.19.2010.07.28.09.28.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 09:28:12 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152097>

Hi,

It looks like I've hit a wall with the dumping functionality in
svnrdump- it's merged in cleanly with tests to show where it passes
along with others that highlight the places that it fails. We've
determined that it cannot do better until the underlying
infrastructure (RA layer) is improved, so I've finally stopped working
on this. The dumpfile that it produces is completely valid, but
doesn't match exactly with the dumpfile that `svnadmin dump`
produces. Since Junio has recommended that I don't get svnrdump merged
into git.git, I'll maintain an out-of-tree version that compiles
against Subversion 1.6; however, git-remote-svn will have to spawn the
executable instead of just including a header and using the API that
it exposes atleast until the next Subversion release.

With my subcommand patch merged in, I've removed my svnrload branch
and started working on the "load" subcommand directly in trunk. The
functionality I expect to implement is "svnrdump load" -- it'll read a
dumpfile from stdin and commit the revisions that it represents to a
specified remote repository. Unfortunately, this is quite non-trivial,
and I'm working *really* hard to try and finish this before the end of
the SoC term. I've found a tool called svnmucc in the trunk that I can
use as reference while writing this.

svn-fe itself is in excellent shape in `pu` (thanks to Jonathan's
extensive cleanup and re-roll it while I was flying halfway across the
world) . I expect that it'll make it all the way to `master` without
any issues.

Although I've finished implementing an svndiff0 parser, I'm having
trouble integrating it into svn-fe; I'm currently attempting to
refactor the line_buffer library in svn-fe to load the diff into
memory all at once so that I can apply it. I've determined that unless
someone else helps out, I might not be able to finish this within the
timeline of the SoC (related: my email earlier this week calling for
manpower) and get it merged.

To make svn-fe filesystem-aware, a LOT of refactoring is required. In
short, when a blob is required, it should issue an `M 040000 <SHA1>`
to `git-fast-import` (see 334fba656b50 in `pu`) to fetch the right
tree object when an SVN copyfrom is seen. To be able to do this
however, it has to know the SHA1 of all the commits that it passes to
git-fast-import: this information must come from git-fast-import. It
needs another patch to print the SHA1 of the commit objects everytime
it finishes writing a commit. Related to this, there's a discussion
about how loose objects in the Git store aren't inaccessible by
callers (and how cat-file can be used in fast-import?). Again, I will
personally not be able to handle this in the SoC term.

-- Ram
