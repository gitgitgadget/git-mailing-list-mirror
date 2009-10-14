From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Efficient cloning from svn (with multiple branches/tags
	subdirs)
Date: Tue, 13 Oct 2009 23:03:07 -0700
Message-ID: <20091014060307.GA17178@dcvr.yhbt.net>
References: <hb2fvu$8qi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxx1Z-00041z-1u
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 08:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbZJNGDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 02:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755029AbZJNGDr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 02:03:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36873 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbZJNGDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 02:03:46 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 6E8FA1F9AD;
	Wed, 14 Oct 2009 06:03:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <hb2fvu$8qi$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130256>

Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk> wrote:
> Hello,
>
> I'm trying to clone an existing subversion repository (Restlet:  
> http://restlet.tigris.org/source/browse/). I'm using Git 1.6.5. The  
> layout of the project is like this:
>   trunk/
>   branches/1.0
>   branches/1.1
>   tags/1.0/1.0b1
>   tags/1.0/1.0b2
>   ...
>   tags/1.0/1.0.1
>   ...
>   tags/1.1/1.1.0
>   tags/1.1/1.1.1
>   ...


Hi Bruno,

That looks like there's two levels of tags.  You should be able to do
this with your version of git in $GIT_CONFIG:

	[svn-remote "svn"]
		url = http://restlet.tigris.org/svn/restlet
		fetch = trunk:refs/remotes/svn/trunk
		branches = branches/*:refs/remotes/svn/*
		tags = tags/*/*:refs/remotes/svn/tags/*/*
		; note the */* to glob at multiple levels

> Therefore, I've tried to use this (with and without '-T trunk', but  
> that's a separate problem):
>
>   git init
>   git svn init --prefix=svn/ -t tags/1.0 -t tags/1.1 -t tags/1.2 -t  
> tags/2.0 -b branches/1.0 -b branches/1.1  
> http://restlet.tigris.org/svn/restlet
>   git svn fetch
>
>
> This takes a while (I've had to interrupt this) and this creates a  
> number of branches such as:
>   remotes/svn/tags/1.0b1
>   remotes/svn/tags/1.0b2
>   remotes/svn/tags/1.0b3
>   remotes/svn/tags/1.0b3@1883
>   remotes/svn/tags/1.0b3@323
>
>
> What surprises me is that it looks like it's looping over and over,  
> since sometimes it starts back from SVN revision 1 when it's trying to  
> import a new tag.

Yeah, that's an unfortunate thing about the flexibility of Subversion,
basically anything can be a "tag" or a directory and it's extremely
hard for git svn to support any uncommon cases for tags/branches
out-of-the box, so the manual config editing is needed.

-- 
Eric Wong
