From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Fri, 8 Oct 2010 17:03:10 -0700
Message-ID: <FD4E6D0A-34E6-4FC4-AA7A-327E07AB58D4@sb.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <loom.20101008T234354-493@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Oct 09 02:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4MuE-0004jI-Sn
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 02:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759931Ab0JIADN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 20:03:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62963 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759848Ab0JIADN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 20:03:13 -0400
Received: by pzk34 with SMTP id 34so446773pzk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 17:03:12 -0700 (PDT)
Received: by 10.142.245.15 with SMTP id s15mr2640768wfh.263.1286582592873;
        Fri, 08 Oct 2010 17:03:12 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm4298165wfc.17.2010.10.08.17.03.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 17:03:12 -0700 (PDT)
In-Reply-To: <loom.20101008T234354-493@post.gmane.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158549>

On Oct 8, 2010, at 2:58 PM, Maaartin wrote:

> You don't. You can do something like
> 
> *.xcodeproj/*
> !.xcodeproj/subdir_with_project
> .xcodeproj/subdir_with_project/*
> !.xcodeproj/subdir_with_project/*.pbxproj
> 
> I'm a beginner but I just stumbled upon this very problem five minutes ago.

That's not the right layout. I'd have to do

*.xcodeproj/*
!*.xcodeproj/project.pbxproj
*/*.xcodeproj/*
!*/*.xcodeproj/project.pbxproj

And so on, once for each possible level of nesting.

> The reason for git ignoring everything in the directory without ever looking 
> there is efficiency.

That's not what's happening either. That happens if you ignore the directory itself, such as

*.xcodeproj/

That won't look in the directory at all to match non-ignore patterns. The problem I'm talking about is simply that you cannot write a pattern that includes a slash and have that pattern match at any nesting level.

Upon further reflection, if we stick with platform-provided fnmatch() we don't have to special-case a prefixed **/. We could simply define patterns as always matching in that way, and you can use the already-existing prefixed / to root it at the current level. So if my pattern looks like

*.xcodeproj/*

Then it will attempt to match this pattern against the last 2 path components of any path rooted in this directory. It can simply count the slashes to determine the number of path components. If I really want it to just match *.xcodeproj files in the current directory then my pattern should look like

/*.xcodeproj/*

-Kevin Ballard