From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Use NullProgressMonitor.INSTANCE and indent for
	loop
Date: Wed, 6 May 2009 13:54:44 -0700
Message-ID: <20090506205444.GN30527@spearce.org>
References: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com> <1241642224-6914-2-git-send-email-alex.blewitt@gmail.com> <20090506204849.GM30527@spearce.org> <46FFA889-7EFA-4CF2-9493-81DF5A319B6C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1o8n-00057g-5L
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760673AbZEFUyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757468AbZEFUyo
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:54:44 -0400
Received: from george.spearce.org ([209.20.77.23]:47342 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZEFUyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 16:54:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2E818381CE; Wed,  6 May 2009 20:54:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <46FFA889-7EFA-4CF2-9493-81DF5A319B6C@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118389>

Alex Blewitt <alex.blewitt@gmail.com> wrote:
> I've been using git send-email --format-patch, which doesn't appear to  
> add the signed by line. If I do it as the commit, will it add the  
> signed-by when it gets committed, and thus I can use send-email? git  
> format-patch just seems to dump a load of files into the directory, and 
> (as noted elsewhere) the git-rebase doesn't appear to work for me.

IIRC, "git send-email --format-patch -- -s" would pass -s to the
format-patch script, adding the line automatically.  But that's
an undocumented feature of send-email.

Personally, I put the SOB line in with "git commit -s" when I write
the change.  Then its there when I dump it out with format-patch.

As for format-patch making a ton of files, yea, that's its job.
I actually use the following pair of scripts to manage sending,
as this lets me edit _sop/OUT/* before firing it off.

--8<--
#!/bin/sh
if [ -n "$(git rev-parse --show-cdup)" ]; then
	cd $(git rev-parse --show-cdup) || exit
fi

mkdir -p _sop/OUT &&
rm -f $(find _sop/OUT -name '*.patch' | grep -v '0000-cover-letter') &&
base="${1:-master}" &&
if [ $(git rev-list ^$base HEAD | wc -l) -gt 1 ]
then
	n="--numbered --cover-letter"
fi &&
git format-patch \
	--output-directory _sop/OUT \
	--subject-prefix='JGIT PATCH' \
	-M \
	$n \
	$base || exit
----

--8<--
#!/bin/sh
if [ -n "$(git rev-parse --show-cdup)" ]; then
	cd $(git rev-parse --show-cdup) || exit
fi

ls -1 _sop/OUT
read

git send-email \
	--to 'Robin Rosenberg <robin.rosenberg@dewire.com>' \
	--cc 'git@vger.kernel.org' \
	--chain-reply-to \
	--suppress-cc self \
	--smtp-server localhost \
	--smtp-server-port 8025 \
	_sop/OUT
----

-- 
Shawn.
