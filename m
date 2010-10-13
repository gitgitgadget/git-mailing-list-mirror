From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Wed, 13 Oct 2010 09:24:17 +0700
Message-ID: <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 04:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5r1K-00059o-D9
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 04:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab0JMCYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 22:24:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53457 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab0JMCYk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 22:24:40 -0400
Received: by wwj40 with SMTP id 40so5860283wwj.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TAaCPoGLYjvlC8+PYT610KbBHMyS21W2F3IfHrs2dn0=;
        b=xVqKV4cywfArvbNFmr/sxPCbk4UMQskikrS7HQBI5s031SVFZEl8DhPMACl0F/lae5
         rDnFE6GnPtFvo6BDIufzA0QmNetakMBc8QdPEOac6aQC7OZT6wPiWbw0Duemz9ZgFNLP
         4A5CfL26axv2RK3GJf/4XWnpLWugrlBXs+FDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=syBaxAyqDCMivCscXIffGnr74lwHmmLIlybc7TG2w1e274PBGzbSsCKKIh8HjgQaZ5
         B3t33+cbOxoSzak1tsu9FE5LeaUedIgdwRmNiAlzTX3QhSDXFNy0px3wN71iFVkDNpOX
         VdPbmju48gaOTUP41RNkuNbdMHdJCtHPPTik0=
Received: by 10.216.232.32 with SMTP id m32mr31972weq.4.1286936679010; Tue, 12
 Oct 2010 19:24:39 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Tue, 12 Oct 2010 19:24:17 -0700 (PDT)
In-Reply-To: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158903>

On Sat, Oct 9, 2010 at 4:26 AM, Kevin Ballard <kevin@sb.org> wrote:
> A number of times I've run into a problem with .gitignore in the handling of folder packages. For the unaware, a folder package on OS X is a folder which is treated as a file by the file browser and all UI-level tools. Ideally, Git would learn about these and treat them as files, but as a stopgap measure I like to set the binary attribute on various files inside these packages. Similarly, for foo.xcodeproj packages I like to ignore all contained files except project.pbxproj. Unfortunately, .gitignore has no good way of matching this sort of thing at anything other than the root level. Here's an example of my global ~/.gitignore file:
>
> *.xcodeproj/*
> !*.xcodeproj/*.pbxproj
>
> As you can see, this applies my rule for foo.xcodeproj globally, except it only works when the project is at the root of a repository. On any repository where this isn't the case, I have to duplicate this pattern into a .gitignore file at the right level. Similarly, I have the following in a repo's .gitattributes:
>
> *.xcmappingmodel/* binary
>
> This sets the binary attribute on all files inside of foo.xcmappingmodel/, but again I have to keep the .gitattributes at the right level. I would love to put this into a global ~/.gitattributes file but I can't.
>
> What I would really like is for the gitignore syntax to support ** a la zsh/bash v4. As I understand it, gitignore uses fnmatch() to do the actual lifting, and unfortunately fnmatch doesn't support this syntax. There's 2 reasonable possibilities I can see here for providing this functionality. The first is to provide our own implementation of fnmatch() that does support this syntax. We already have an implementation of fnmatch() inside of compat/, would there be any problem with using this implementation for everybody and updating it to support **? The second solution is to simply special-case having **/ at the very beginning of a pattern (similar to how we special-case !) and recursively apply the pattern to all nested path components until one matches or we run out of components. This 
 is obviously not ideal, but it would allow us to continue to use the system-provided fnmatch().

Special case "**/" (also "path/to/**/") is probably good enough. You
might need to handle all combinations of "**/" and other optimizations
in excluded_from_list() though. Can you make a patch (or a few
patches) for it?
-- 
Duy
