From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Tue, 15 Jul 2008 02:52:51 +0200
Message-ID: <200807150252.52604.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807150114.44402.jnareb@gmail.com> <487BE7C4.2050207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 02:54:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIYnn-0002uX-BO
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 02:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778AbYGOAw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757627AbYGOAwz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 20:52:55 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:26552 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548AbYGOAwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 20:52:55 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3034735fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=30u8UXyzXzyN0b2p1KG49WAb+hFh0qLp6yUwgMNsgeA=;
        b=xHOmkwMg0wmpGToF5vgEkXO1rOfw8aTemiweYOIutYQ0LLCXuxnUvli5u5kHHFnLM0
         jKW9mHPXLsPnwQU25s2ekc3+VPifmHSL2lFYuFVzOhjHKiJLJx9GBIZ+cjognw8SBCZ+
         fYojSmx++uhHWEXWrN0kqHyDRibLOE7CIWYXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EPzKu8J6PuFLssyEE4xHIx2U4Ax7rnEsFJXORSpNn+HDqjXdbjfs3Y6XMgzVYvAoQO
         u6/3PSHs7xTSPblA3iBJ6bEKFjzSSEOu8N3WMafe/Cy0Y0ZREI7fpDKRWNmw6S8F1Cxr
         DxhVNLzs+kvhAVxppKVPoFKelaSgfiZBn/D/o=
Received: by 10.187.191.13 with SMTP id t13mr2079687fap.7.1216083173066;
        Mon, 14 Jul 2008 17:52:53 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.43])
        by mx.google.com with ESMTPS id 28sm13025523fkx.1.2008.07.14.17.52.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 17:52:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <487BE7C4.2050207@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88491>

On Tue, 15 July 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
> > 
> > Could you explain then how gitweb cache is invalidated?
> 
> Sure; from gitweb.perl:

I'll try to read and comment on patch itself soon.
 
> # Transient cache entries (like get_sha1('HEAD')) are automatically
> # invalidated when an mtime of either the repository's root directory
> # or of the refs directory or any subdirectory changes.  This
> # mechanism *should* detect changes to the repository reliably if you
> # only use git or rsync to write to it,

Nice idea... for project pages.  I'm not so sure about projects_list
page, if wouldn't be better to have expire time for *this* page.  You
would have/have to stat a lot of files/directories to detect changes.

BTW. some summary of the above should be IMHO in the commit message.
In short, you should write, I think, that caching mechanism uses
any Cache::Cache compatible cache for caching data, that large objects
can be cached on filesystem (or perhaps not, at it is a detail), that
cache validity is checked by stat-ing refs area.
 
> IOW, gitweb will do a small number of (inexpensive) stat calls on those
> directories each time it's called, and use the most recent mtime as part
> of the cache key for transient entries.  Hence those transient entries
> will automatically become invalid once the most recent mtime changes.
> 
> (If any of the relevant directories has been modified since the last
> time gitweb checked, gitweb will re-scan the whole tree to check for new
> directories, and record their mtimes as well.  See get_last_modification
> if you're interested in more gory details.)
> 
> The punchline is, the cache never returns outdated data.

In this case you don't have any basis to set expires for transient views;
on the other hand situation doesn't differ much from serving static
files (wrt. cache validation) so perhaps no expires but no "no-cache"
would be a good solution.

P.S. is there any cache evision mechanism (to limit cache size)
in gitweb cache, or just those implemented by caching backend?
-- 
Jakub Narebski
Poland
