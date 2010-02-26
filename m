From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: [RFC][PATCH 0/3] Different views on a repository
Date: Thu, 25 Feb 2010 23:30:33 -0500
Message-ID: <c376da901002252030p49126bf5tc5ffdca9f2ad13c1@mail.gmail.com>
References: <cover.1267029680.git.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Fri Feb 26 05:30:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkrqa-0007Ta-RI
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 05:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935201Ab0BZEaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 23:30:35 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:61240 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935174Ab0BZEae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 23:30:34 -0500
Received: by bwz1 with SMTP id 1so86036bwz.21
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 20:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Q9xPyrBFMxxirde3AI8fOQlKzXRgWgt4mZQwmJmH1lI=;
        b=YY2tmbJnuA/aB7n0DVsHqWiQSL9XkIezLjN2Q5VXH0pA3Uye2FvBR4ozboXUEI9lK3
         Fusv+JVn5Wz50z4ZD5VVvq1CCfsXdOFI2K+tOSRNcyFsb3lq6gTfKPs4vqtbmbAuCWue
         Mb7BkPMeWkEEjjsfxyMOtO/A3p19IlMOYB/Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mMV4n7mfM4prV1iKBI1uFE/uOWUqNIYTWsEJ5gmoafL2Zfr+fuOFeukriykiOjMNKe
         B+Gy1yAe6e6eTwucpus/s2tweXsS6wURLdpGCxexM8Pyjw3oHHq6yuh7Vj7iJQDRv7Ja
         54dtwLiAlkqYJBPm0pdeglViRSBIYOhIcWVmQ=
Received: by 10.204.135.154 with SMTP id n26mr569361bkt.18.1267158633515; Thu, 
	25 Feb 2010 20:30:33 -0800 (PST)
In-Reply-To: <cover.1267029680.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141103>

On Wed, Feb 24, 2010 at 11:41 AM, Andreas Gruenbacher <agruen@suse.de>wrote:

> Hello,
>
> we have a use case with groups of repositories which share lots of
> objects, but which are logically independent.  There is no strict
> hierarchy between the repositories, the development modl is arbitrary.
> The alternates mechanism for sharig objects between repositories won't
> work.
>

I don't know what you're trying to accomplish, but for what it's
worth, I do something similar with a couple of shell scripts.

My goal was to make bundles (basically thin packs) smaller by taking
advantage of files I knew were available on the far side of the
air-gap even if they weren't in a the repository I was bundling that
particular day.

The idea was to push from all of my repositories into a super
repository with a fancy (and auto-generated) refspec.  The actual code
is impenetrable, but reconstructing it in everybody's favorite IDE,
gmail, I came up with

#!/bin/bash
PROJECTS=$HOME/projects
SUPER=$HOME/projects/.git-super-repo

[[ -d "$SUPER" ]] || \
 (mkdir "$SUPER"; git --git-dir="$SUPER" init)

for i in $PROJECTS/*/.git; do
 name=$(basename "$(dirname "$0")")
 echo "$SUPER/objects" > $i/.git/objects/info/alternates
 git --git-dir="$i" push -f "$SUPER" "*:refs/$name/*"
done

git --git-dir="$SUPER" gc --aggressive

for i in $PROJECTS/*/.git; do
 git --git-dir="$i" repack -Ad #unnecessary?
 git --git-dir="$i" gc --aggressive
done

Clearly I can lose data if I try to rebase $SUPER or something, but I
think it's pretty safe for normal use.

In your case, the "projects" are called "views".

Adam
