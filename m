From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Sat, 8 Nov 2008 19:00:10 +0700
Message-ID: <fcaeb9bf0811080400h7ea5377cvaa8d658335811c23@mail.gmail.com>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
	 <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net>
	 <7vy6zvdt25.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0811072001o6df7ae00k1b1bffaadf75d3a1@mail.gmail.com>
	 <20081108092409.GD4030@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20081108114719.GA4989@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Yann Dirson" <ydirson@altern.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 13:01:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KymVQ-0008HW-4m
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 13:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbYKHMAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 07:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbYKHMAN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 07:00:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:3922 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYKHMAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 07:00:12 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1410309fgg.17
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 04:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tp+jnouCVwqvPlqdoLYUwaRaKEgKZmYnhjQ8Y2ldqqc=;
        b=GsV0JUWDYpSTftRNPLYNIp54qWwkzkSDumfXR7gfB/EvQfum7S5AdCvslKz8GgkAjN
         dZbz6wKo1So7Ck78txO/1VNiSCF+AUh10oC+FBv+eUy8Cd330d/7RF03vuDaSVjj2SW2
         DCo/BlykEzP7fnGlNPERmwZ4d5SZLzNJzSn4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=K4cyQWvPg2SHdKlS4eZa7ROpHwonSqMPntglkAguftVuBzxhvIKcZ4iH7IqF5zWihy
         7WeUDRibY/5NMyRrWZutWbtdT5/J7/4xOiXDzn3vdj8KEqePYR9Aay4O2oC1l4k+7n/5
         ntI3VbZhAriX7fKcncaHc9jRj0FTy8E75JfD8=
Received: by 10.86.52.6 with SMTP id z6mr4974776fgz.20.1226145610165;
        Sat, 08 Nov 2008 04:00:10 -0800 (PST)
Received: by 10.86.27.20 with HTTP; Sat, 8 Nov 2008 04:00:10 -0800 (PST)
In-Reply-To: <20081108114719.GA4989@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100398>

On 11/8/08, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 08, 2008 at 10:24:10AM +0100, Yann Dirson wrote:
>
>  > Well, it could be that an out-of-pathspec pair would have a better
>  > score than an in-pathspec one.  Maybe cache recording should be turned
>  > off when doing pathspec limitation ?
>
>
> One thing I notice is that the cache works at the level of "here is the
>  best rename for this commit." Maybe it could go down a level and say
>  "here is the inexact rename score between these blobs". Then you would
>  still find the best score between two blobs each time, but save the
>  really computationally intensive part (which is comparing the actual
>  _content_ of the blobs).
>  That should work in the face of path limiting or any other option,
>  because it is caching something immutable: this is the similarity score
>  between two pieces of content. And then you get arbitrary tree-to-tree
>  speedups for free, since such a cache would be valid for every commit.

I did that and realized the cost was not from each diff, in
--find-copies-harder case, but from the number of diffs you had to do.
Even with exact matching on linux-2.6.git, it could take significant
time (it was about 5 minutes in no-cache case, 1 minute without exact
match cache, and less than 1 sec if everything is cached).

>
>  The downsides are:
>
>   - your cache is potentially bigger, since you are caching the score of
>    every pair you look at, instead of just "good" pairs (OTOH, you are
>    not doing a per-commit cache, which helps reduce the size)

It is huge if you accidentially add --find-copies-harder to your
command, considering that every new file will be compared against
every files in tree (about 25k).

>   - you can still "lie" about a score to pre-seed imported SVN renames,
>    but such lying will actually apply to all commits.
-- 
Duy
