From: "Chris O'Kelly" <chris@mapcreative.com.au>
Subject: Feature Request: provide cmdline args to git hooks
Date: Tue, 14 Apr 2015 13:42:45 +1000
Message-ID: <CAM-hpQcgOgrAJBAZrH4icDtJMiHUYOz1tynYkoj7qzyVMZ0eVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 05:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhrkY-0002r7-Le
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 05:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbbDNDm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 23:42:56 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34231 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbbDNDmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 23:42:47 -0400
Received: by iget9 with SMTP id t9so68178253ige.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 20:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=JdU51fBMdu9h2IdO+FsWO054FvnaKDFEVIHOqwbvM2M=;
        b=JGtz8oD7yC4N3mMSUDJ5iNzNSSQiMPjmrARN/S15TDb3i/GMy+zK/zBUX8BnUPe52p
         xPuYzq7Nx024VesZcSIt7pYYo9E3hHsD9ncIk6wkn8wHKepSqZAXnUaboQhi7zDgIbGe
         cgrZdx8Y5fakUn3lEkSUc5JjHmgTO0RoQsHnEfNlkF3MQmHEmuJy1+FAPkZfUkA6jAlD
         xWErE4m610KhH5a3S6bjLW1a3egiB7Dm8QQ8JkojBHwTOcS8kpJPnzF9jFakdXry96nA
         lGX8Bo4qX1xRzBjtn1nHb/Y60Nu8TnSqFQ3reT+X2mOXWmCvt0CxFt7aX/ytqfKmj/wG
         lEZw==
X-Gm-Message-State: ALoCoQkL6IutcnbSY0Y84u3cSgjx1ymqXycPE167WGj63tEi4VwBekvmZL0gEEO+0ZixBnsgqTx4
X-Received: by 10.42.226.4 with SMTP id iu4mr22503412icb.51.1428982966017;
 Mon, 13 Apr 2015 20:42:46 -0700 (PDT)
Received: by 10.64.76.84 with HTTP; Mon, 13 Apr 2015 20:42:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267112>

Hello,
Just a brief note about a feature I would find incredibly useful, were
it available.

A brief background of my use case:
I am wanting to write a pre-push hook to prevent tags being pushed to
our production servers. The production servers in our case are --bare
endpoints, and when we push a tag at them, they always checkout the
commit that tag is attached to via some post-receive magic (WPEngine,
FWIW). This behavior is even present when the tag was already pushed
to the repo previously, if for instance a normal push is made with the
--tags argument. In the past we have had problems when a developer is
using a GUI like SourceTree and accidentally leaves the 'push all
tags' option checked, pushing 100s of tags to the server, which then
dutifully begins checking out each in turn.

Currently I check for tag refs being pushed with:
#...SNIP...
while read local_ref local_sha remote_ref remote_sha
do
local_type=$(echo "$local_ref" | awk -F/ '{print $2}')
remote_type=$(echo "$remote_ref" | awk -F/ '{print $2}')
if [[ "$no_tags" -eq 1 && ($local_type = "tags" || $remote_type = "tags")]]
then
echo "Detected attempt to push tags to a no_tags repo! Exiting without push..."
exit 1
fi
#...SNIP...

which works fine the first time tags are pushed, but when they are
already up to date as of the last fetch, they are not passed to the
stdin for pre-push, so I cannot detect them.

in a linux environment we can inspect /proc/$PPID/cmdline or ps
-ocommand= -p $PPID to find the --tags argument (or any manually
specified tag refs, etc), however commonly developers are using
Windows with SourceTree, and the pseudo-nix environment it provides
lacks a /proc directory and uses the cut down cygwin version of ps. I
have considered going down the parsing route with general ps output,
reading line by line to find the appropriate ppid, then echoing the
output, but varying output and column order of ps between SourceTree
and various linux versions looks to make that infeasible as a portable
solution.

If we could access the original git push commandline inside the hook,
either through a parameter passed directly to the script or possibly a
GIT_* environment variable, it would make this possible. My specific
use case may not be incredibly common, but this could also be used to
check if, for example, a push is being forced in a portable fashion -
something I can see being useful for a pre-push hook in a variety of
circumstances.

Alternatively - am I missing the super easy (and probably super
obvious) way to do this with the existing tools?
