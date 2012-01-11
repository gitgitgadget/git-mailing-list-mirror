From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH RFC] commit: allow to commit even if there are
 intent-to-add entries
Date: Wed, 11 Jan 2012 05:02:22 -0600
Message-ID: <20120111110222.GA32173@burratino>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 <7vr4z67jbb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 11:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkvs8-0001bY-BF
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 11:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874Ab2AKK5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 05:57:30 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41377 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab2AKK53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 05:57:29 -0500
Received: by iabz25 with SMTP id z25so951468iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 02:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VtwYBMxKythTzXBvBh0ZMfBVbzSuCkQ/aNlY5OeCEKQ=;
        b=XSe6v17orklv+x1lwWpHdZ0cHhKT9ctGEj6e582MEWD7bW955tEv+YdXa7wourm3Ox
         i5IhakIzUNj0DOMXA4kHS1D7ee8Y0v+/rBRzNzdQFSXEM+VZnXXUNnBhvEK3vd0pfdn+
         gGvZvkQdijLkxhkQ8PDw/bFpTEy5lxee0BDh4=
Received: by 10.50.222.233 with SMTP id qp9mr6288020igc.1.1326279448718;
        Wed, 11 Jan 2012 02:57:28 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xu6sm2118546igb.7.2012.01.11.02.57.28
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 02:57:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vr4z67jbb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188354>

Hi,

Junio C Hamano wrote:

> I have a mild suspicion that in earlier incarnation of the patch we used
> to let empty blobs committed, and then we used to instead not commit
> anything at all for such a path, and the real users were bitten by either
> of these approaches, forgetting to add the contents to the final commit.

I remember the empty blob era. :)  I don't think I ever saw something
like this patch, though, and a quick search finds that the first
iteration of the bugfix to stop commiting empty blobs was the one that
was used:

 http://thread.gmane.org/gmane.comp.version-control.git/101881/focus=101894

I suspect that at the time, introducing an intent-to-add flag (which
was always the right thing to do) provided enough momentum to avoid
any worries about smaller details like whether to error out or skip
those entries on commit, which could always be changed later (today).

> So I am not sure if this is such a good idea.

My first reaction was the same, but on reflection, I think this is a
good idea as long as the "git status" output in the editor says
something appropriate.

The response Duy mentioned[1] to a report about the unenlightening
message "error building trees" was also memorable:

> When running "commit" and "status" with files marked with "intent to add",
> I think there are three possible interpretations of what the user
> wants to do.
[ (1) thanks for stopping me, I had forgotten about that file;
  (2) I changed my mind, please leave that file out; or (3) please
  dwim and add the file ]

I think (3) was a trick --- no one that does not use the "-a" option
would want that. :)

At the time, I did not understand what (2) meant.  Now I see why ---
in interpretation (2), the user did not change her mind at all.  She
said "I will be adding this file at some point, so please keep track
of it along with the others for the sake of commands like 'git diff'
and 'git add -u', but that does not mean "I will be adding this file
at some point _before the next commit_".

So at the time I thought (1) was the only sensible behavior but kept
my mouth shut; and now I see that (1) and (2) both fit into reasonable
workflows.

However.  A person using "git diff" to review remaining changes and
"git add" to mark files once they have reached their final form would
benefit even more from a switch for "git commit" to error out if _any_
files in the worktree do not match the index.  So if we are to take
this workflow seriously, treating "git add -N" as a special case is
not helping.  What we currently provide for this workflow is a
reminder in the status area of changes that were not marked with "git
add".

I suspect no longer erroring out might feel eerie for a period for
people that were relying on "git add -N" as a reminder but that as
long as the "git status" output is sensible enough, Duy's proposed
behavior would end up seeming just as natural.

(2) makes intent-to-add entries just like any other tracked index
entry with some un-added content.  It is conceptually pleasant and
fits well in all workflows I can imagine[2].

Hope that helps, and sorry for the ramble,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/170651/focus=170658
[2] Ok, that is a small lie.  In "git stash", a commit is used to save
the state of the index, so the user would want the presence of the
intent-to-add entry to be stored somehow in the commit, and none of
(1), (2), or (3) will make her happy.  Using "git commit" this way is
not going to work when there are unmerged entries, for example,
either, so I think it is okay to ignore that problem here.
