From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool sends malformed path to exernal tool on Windows
Date: Sun, 16 Mar 2014 00:27:47 -0700
Message-ID: <CAJDDKr7=OVF0eJQFjFqrzNvOW0K0pZfRJL+CHB32kHoJFJ_csg@mail.gmail.com>
References: <011301cf2c2d$90442810$b0cc7830$@lsst.org>
	<20140221103821.GA21414@gmail.com>
	<000801cf317f$ac1be2b0$0453a810$@lsst.org>
	<CAJDDKr751=c2AOBfjbg2_im6UCBvwWSVjJ7QX8=76vXMsLSw4g@mail.gmail.com>
	<00bc01cf3737$b1474280$13d5c780$@lsst.org>
	<20140305082517.GA86532@gmail.com>
	<019d01cf3a1f$4ebfe5f0$ec3fb1d0$@lsst.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Lotz <plotz@lsst.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 08:28:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP5Ub-0001E1-K8
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 08:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbaCPH1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 03:27:49 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:45036 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbaCPH1s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2014 03:27:48 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so4677834qcv.16
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ioRiZQZc2DD9SPse32SjgtJiz4r+0+hXS2jD9dclmH8=;
        b=qK2kcTOXA2MhTF6kIUNsv5fd68PNhzMbxW1iPME4wh1DvzW1Lj7TqJ7YJ/i2CworVG
         R6V4luZtEfAUupT2PyzgAIv7BrFi6M4xNa9ixYYMPtD1duj8nOEGL8LlXbZ2OlGwzI8f
         LgDTLNl+xU4eMAaSEGARBAtiG8rS2zQ/lSBrNYsCtbumF2FCpacd37l3681dgh81COrZ
         LrIGhh1kcEWliCBYnOEhehm7pGo/QDpxVRxdcW93ViAXVEd4RERBuPPk+cLZEaYZo/2G
         X7yrflbtS91cznvuT9BQYNBPPUOgUWHSDAFuIwIRu1Uiq24PSyOEZGYq5ZTtHaXOVBn9
         itDA==
X-Received: by 10.140.37.214 with SMTP id r80mr19536434qgr.61.1394954867289;
 Sun, 16 Mar 2014 00:27:47 -0700 (PDT)
Received: by 10.229.163.75 with HTTP; Sun, 16 Mar 2014 00:27:47 -0700 (PDT)
In-Reply-To: <019d01cf3a1f$4ebfe5f0$ec3fb1d0$@lsst.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244181>

On Fri, Mar 7, 2014 at 8:07 AM, Paul Lotz <plotz@lsst.org> wrote:
> David,
>
> I investigated further and found that \"$LOCAL\" \"$REMOTE\" return the remote and local files (reversed).  (One can easily see this in my 2/28 e-mail.)  Reversing these (\"$REMOTE\" \"$LOCAL\") does indeed reverse the output.  It is easy to work around this issue, but how can this be?
>
> Paul

It's probably working as intended.

The $LOCAL and $REMOTE names come from "git mergetool", where they
have better defined semantics.

In the context of a diff, where we're really comparing "A" and "B"
they have a little less meaning, but the behavior is well-defined.

When you modify a file locally, the default behavior for "git diff" is
to compare your working tree against the index.

The diff will show the changes that will permute the index's copy into
the the worktree's copy. In a sense, your modifications are the
"remote" thing that is being compared against.

That's why you see a temporary file for $LOCAL ("A") and your
worktree's file for $REMOTE (B).

If compare two other things, e.g. "git difftool HEAD~3 HEAD~" then
$LOCAL is HEAD~3 and $REMOTE is HEAD~, and they'll all be temporary
files.

One analogy is that the $LOCAL thing is the starting point and the
$REMOTE thing is what was modified (by the merge) if you think of it
from the merging perspective.

Specific tools (e.g. lvcompare) may need the arguments to be specified
in a specific order for them to make sense, so it's perfectly
acceptable for specific tools to require that $LOCAL and $REMOTE are
swapped.

BTW.. we went through a lot of back-and-forth getting the difftool
setup correct for lvcompare. In the Git source tree there's a
mergetools/ directory where all of the built-in diff/merge tools are
defined. Do you think you might be able to contribute a scriptlet for
lvcompare so that it is natively supported? That'll save future poor
souls from needing to rediscover the correct recipe for getting
lvcompare working with difftool.  Just a thought.

cheers,
-- 
David
