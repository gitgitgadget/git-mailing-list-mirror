From: Johan Herland <johan@herland.net>
Subject: Re: branch description
Date: Tue, 22 Apr 2008 20:46:02 +0200
Message-ID: <200804222046.05175.johan@herland.net>
References: <alpine.DEB.1.10.0804221945060.3452@pollux.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:47:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoNW7-0008Na-Ej
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbYDVSqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbYDVSqK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:46:10 -0400
Received: from sam.opera.com ([213.236.208.81]:44250 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbYDVSqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 14:46:09 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m3MIk5pB021453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Apr 2008 18:46:05 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.10.0804221945060.3452@pollux.milkiway.cos>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92.1/6882/Tue Apr 22 17:33:01 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80158>

On Tuesday 22 April 2008, Michael Dressel wrote:
> On Friday 18 April 2008, Jakub Narebski wrote:
> > Let me sum up here proposals where to put branch description:
>
> what's the opinion of having a new branch object? Actually the tag
> object probably already does the job? This would spoil the elegant
> light weight current branch references. But tags are not that heavy.
>
> In this approach the tags would not reference commits but tags. And
> tags have annotation. The difference to the normal tags would be that
> these tags are referenced from refs/heads/<branch> instead of
> refs/tags.
>
> I have no clue how involved this change would become and if the
> benefit would justify the effort. I guess using proper objects for
> branches would only be justified if additional advantages could be
> achieved.
>
> Cheers,
>  	Michael

Nice idea, but it won't work, simply because branches are moving
targets, whereas tags are not.

To illustrate, here's how things are structured between the refs
(tags/branches) and the object DB:


refs/tags/lighweight  -------------------------> [commit object]

refs/tags/annotated   -----> [tag object] -----> [commit object]

refs/heads/branchname -------------------------> [commit object]


The annotated tag ref holds the SHA1 of the tag object which in turn
holds the SHA1 of the commit object, while the two other ref types
point directly at a commit object. The tag object works on the
assumption that the commit object pointed to by the tag never changes.
That's after all the whole point of a tag.

A branch - on the other hand - is _supposed_ to change. It changes by
adding a new commit on top of the current commit, and updating the
branch ref to point to the new commit. If we kept the branch description
in a tag object, and stuck this between the branch ref and the commit
object, we would suddenly have to rewrite the tag object every time we
added another commit on the branch. This would make commits much more
expensive, not to mention that for every commit you would drop the
tag object pointing to the previous commit, in effect generating one
garbage object per commit. This is clearly not what we want.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
