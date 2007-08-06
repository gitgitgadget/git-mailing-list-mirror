From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Some ideas for StGIT
Date: Mon, 6 Aug 2007 10:36:25 +0100
Message-ID: <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com>
References: <1186163410.26110.55.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 11:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHz0p-00011L-4L
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 11:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760806AbXHFJg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 05:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760495AbXHFJg1
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 05:36:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:58489 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760323AbXHFJg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 05:36:26 -0400
Received: by ug-out-1314.google.com with SMTP id j3so611397ugf
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:36:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m1XBh6bstb6LT5ti+NIY1svkjS0Too5B917c82gmVHAd/EbFHOc3qezwFYVofqCFKeVdKtO4o5PYga9PDTiKWIfhxmYB5g2rwvXwR0oY3hu4hSwtsIClxnrhUypbH2oPPU4YWGFcceXNYgiG3b6DUki6cW85HXHx9iaPtECkiQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k8RKwsHfRtIoxrFkgQb+fOFvnLppnuvKknT07CL5X97+Evkgsn5ndutORNtW0pGaXPobGGQTxxifmEz7BkNcxQz/DSVV9vdnyR6efmnLDfnMjOsv+ITo2uOPVCWb7xfVYn6VNw+TD0221dmGbeJ02mYIZGxTcOnboUxSR9Moi4w=
Received: by 10.66.252.18 with SMTP id z18mr5055248ugh.1186392985080;
        Mon, 06 Aug 2007 02:36:25 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Mon, 6 Aug 2007 02:36:25 -0700 (PDT)
In-Reply-To: <1186163410.26110.55.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55128>

Hi Pavel,

All the interesting discussion usually happen during my holidays :-).

On 03/08/2007, Pavel Roskin <proski@gnu.org> wrote:
> I was recently disappointed to learn that one of the Linux drivers
> (bcm43xx_mac80211, to be precise) switched from git to quilt.  I asked
> whether StGIT was considered, a discussion followed, and I think the key
> points need to be shared with StGIT developers.  I'll add some of my
> ideas to the mix.

Thanks for the feedback.

> The main point in favor of quilt is that it allows to edit the patches
> with the text editor.  One can pop all patches, edit them and push the
> all back.

If this is the main feature they need, they probably don't need git at
all and quilt would be enough. I was using quilt before starting StGIT
but the main problem I had with plain patches approach was the
conflict solving.

StGIT does a 'git-diff | git-apply' as a patch push optimization and
we could even cache the diff but the current algorithm is that if
git-apply fails, StGIT falls back to a three-way merge and even an
interactive user merge (via xxdiff for example). I find the three-way
merging (automatic or interactive) much more powerful than fuzzy patch
application.

If we would allow patch editing, the 'stg push' algorithms wouldn't
know when git-apply failed because the patch was edited or the base
was changed. Falling back to the three-way merge would lose the edited
patch. If one doesn't need three-way merging, quilt is good enough.

Other advantages of the three-way merging is the detection of full
patches or hunks merged upstream (the former can also be achieved by
testing the reverse-application of the patches).

I don't usually edit patches during development, I prefer to edit the
source files and review the diff. It happens many times to move hunks
between patches but I usually towards the bottom patches in the stack
(using stg export and emacs) and the three-way merging automatically
removes the merged hunks from top patches.

> I don't suggest that StGIT gives up on the git-based storage, but this
> mode of operation could be implemented in two ways.
>
> One is to have a command opposite to "export".  It would read the files
> that "export" produces, replacing the existing patches.

As Yann said, we already have 'stg import --replace'. I mainly use
this feature with series sent to me and when they need some editing to
apply cleanly. There is also 'stg import --ignore' to ignore the
patches already applied (mainly when the importing fails in the middle
of a series, there is no need to re-import the first patches).

> Another approach would be to reexamine the patch after "stg refresh -es"
> and to apply it instead of the original patch.  If the patch doesn't
> apply, the options would be to discard the edits or to re-launch the
> editor.

That's an interesting idea but maybe we should have a separate command
like --edit-full to edit the full patch + log (part of the
functionality already available in import).

> Next issue is that it should be possible to create a patch in one
> operation.  StGIT follows quilt too closely here in requiring "new" and
> "refresh", instead of utilizing the advantage of the workflow that
> allows immediate editing of the sources without any commands.
>
> Basically, I want one command that:
>
> 1) shows user what was changed
> 2) allows user to name the patch
> 3) allows user to describe the patch
> 4) allows user to exclude files from the patch
> 5) doesn't require another command to put the changes to the patch
>
> I think the most natural approach would be to enhance "stg new".  I see
> "stg new -s" is supposed to show the changes, but it's currently broken.

Thanks for reporting this. I don't use the --showpatch options much
and we don't have any tests (yet) for the interactive options.

> Finally, it would be great to have TLS support in the mail command.
> Mercurial has it, and looking at their mail.py, it doesn't seem to be
> much work.

Indeed, the SMTP Python objects already provide support for TLS via starttls().

-- 
Catalin
