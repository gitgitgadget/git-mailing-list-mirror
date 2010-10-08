From: Kevin Ballard <kevin@sb.org>
Subject: [PROPOSAL] .gitignore syntax modification
Date: Fri, 8 Oct 2010 14:26:41 -0700
Message-ID: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 08 23:27:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4KSw-0007if-1b
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 23:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab0JHV0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 17:26:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37454 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145Ab0JHV0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 17:26:44 -0400
Received: by pzk34 with SMTP id 34so423184pzk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 14:26:44 -0700 (PDT)
Received: by 10.114.79.1 with SMTP id c1mr3523799wab.1.1286573203934;
        Fri, 08 Oct 2010 14:26:43 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id d2sm6123381wam.2.2010.10.08.14.26.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 14:26:42 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158542>

A number of times I've run into a problem with .gitignore in the handling of folder packages. For the unaware, a folder package on OS X is a folder which is treated as a file by the file browser and all UI-level tools. Ideally, Git would learn about these and treat them as files, but as a stopgap measure I like to set the binary attribute on various files inside these packages. Similarly, for foo.xcodeproj packages I like to ignore all contained files except project.pbxproj. Unfortunately, .gitignore has no good way of matching this sort of thing at anything other than the root level. Here's an example of my global ~/.gitignore file:

*.xcodeproj/*
!*.xcodeproj/*.pbxproj

As you can see, this applies my rule for foo.xcodeproj globally, except it only works when the project is at the root of a repository. On any repository where this isn't the case, I have to duplicate this pattern into a .gitignore file at the right level. Similarly, I have the following in a repo's .gitattributes:

*.xcmappingmodel/* binary

This sets the binary attribute on all files inside of foo.xcmappingmodel/, but again I have to keep the .gitattributes at the right level. I would love to put this into a global ~/.gitattributes file but I can't.

What I would really like is for the gitignore syntax to support ** a la zsh/bash v4. As I understand it, gitignore uses fnmatch() to do the actual lifting, and unfortunately fnmatch doesn't support this syntax. There's 2 reasonable possibilities I can see here for providing this functionality. The first is to provide our own implementation of fnmatch() that does support this syntax. We already have an implementation of fnmatch() inside of compat/, would there be any problem with using this implementation for everybody and updating it to support **? The second solution is to simply special-case having **/ at the very beginning of a pattern (similar to how we special-case !) and recursively apply the pattern to all nested path components until one matches or we run out of components. This is
  obviously not ideal, but it would allow us to continue to use the system-provided fnmatch().

Any thoughts/problems/suggestions?

-Kevin Ballard