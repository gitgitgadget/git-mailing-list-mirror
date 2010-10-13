From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Tue, 12 Oct 2010 19:32:54 -0700
Message-ID: <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 04:33:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5r9N-0006xK-NG
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 04:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab0JMCdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 22:33:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64361 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab0JMCc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 22:32:59 -0400
Received: by pwi4 with SMTP id 4so72752pwi.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:32:59 -0700 (PDT)
Received: by 10.142.221.3 with SMTP id t3mr7094227wfg.198.1286937179402;
        Tue, 12 Oct 2010 19:32:59 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id v19sm8752493wfh.12.2010.10.12.19.32.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 19:32:58 -0700 (PDT)
In-Reply-To: <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158906>

On Oct 12, 2010, at 7:24 PM, Nguyen Thai Ngoc Duy wrote:

> On Sat, Oct 9, 2010 at 4:26 AM, Kevin Ballard <kevin@sb.org> wrote:
>> A number of times I've run into a problem with .gitignore in the handling of folder packages. For the unaware, a folder package on OS X is a folder which is treated as a file by the file browser and all UI-level tools. Ideally, Git would learn about these and treat them as files, but as a stopgap measure I like to set the binary attribute on various files inside these packages. Similarly, for foo.xcodeproj packages I like to ignore all contained files except project.pbxproj. Unfortunately, .gitignore has no good way of matching this sort of thing at anything other than the root level. Here's an example of my global ~/.gitignore file:
>> 
>> *.xcodeproj/*
>> !*.xcodeproj/*.pbxproj
>> 
>> As you can see, this applies my rule for foo.xcodeproj globally, except it only works when the project is at the root of a repository. On any repository where this isn't the case, I have to duplicate this pattern into a .gitignore file at the right level. Similarly, I have the following in a repo's .gitattributes:
>> 
>> *.xcmappingmodel/* binary
>> 
>> This sets the binary attribute on all files inside of foo.xcmappingmodel/, but again I have to keep the .gitattributes at the right level. I would love to put this into a global ~/.gitattributes file but I can't.
>> 
>> What I would really like is for the gitignore syntax to support ** a la zsh/bash v4. As I understand it, gitignore uses fnmatch() to do the actual lifting, and unfortunately fnmatch doesn't support this syntax. There's 2 reasonable possibilities I can see here for providing this functionality. The first is to provide our own implementation of fnmatch() that does support this syntax. We already have an implementation of fnmatch() inside of compat/, would there be any problem with using this implementation for everybody and updating it to support **? The second solution is to simply special-case having **/ at the very beginning of a pattern (similar to how we special-case !) and recursively apply the pattern to all nested path components until one matches or we run out of components. This
  is obviously not ideal, but it would allow us to continue to use the system-provided fnmatch().
> 
> Special case "**/" (also "path/to/**/") is probably good enough. You
> might need to handle all combinations of "**/" and other optimizations
> in excluded_from_list() though. Can you make a patch (or a few
> patches) for it?

As soon as I find the time, I'll be working on a patch for this. I only wrote up the proposal because I want to make sure that what I end up implementing is actually something that will be accepted. At this point I'm actually in favor of simply assuming all paths that don't start with / can be matched at any level but I recognize that this is a change to existing functionality, though I personally think that all patterns that are meant to match only at the current level should be prefixed with / anyway. Would such a change to existing behavior be rejected out-of-hand?

-Kevin Ballard