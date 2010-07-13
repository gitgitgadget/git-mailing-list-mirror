From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of commit 
	header in $GIT_EDITOR
Date: Tue, 13 Jul 2010 09:46:58 +0800
Message-ID: <AANLkTin9vUliwD5Ufa1vMTC2RZ7TSiyNaPmnDNtz1FQd@mail.gmail.com>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
	<1278764821-32647-2-git-send-email-ayiehere@gmail.com>
	<7vbpadfd4r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 03:47:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYUaS-0002mI-EI
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 03:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab0GMBrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 21:47:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35912 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab0GMBrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 21:47:00 -0400
Received: by wyf23 with SMTP id 23so3829691wyf.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=FTtatioa2iqJ/fRcyDDwMMCFED8Xv2ADPFeJVhBBgfw=;
        b=gkJQmavdHpyO0wOW2wL4I8PrgFr8uJfkvLRkJuBXJdvD6z2KwzmXjJraDGtjMNT/QO
         rsdFpbdk3v3FJbDQGksXBqZgwjxUNAeZnzrtkeljf1UvnrFLk1ZbthcukMoSHgnMXd7v
         1GPZ+2Gp8gaKCgNNFxZbDgicheeq+rg4MbCRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=t4Fn8Bx+OmhIr3qiQA2Eugv5AZW3VBZk7fb479lmZHfLrgSr/7pErHWYmZm7Nk9HYO
         KM9u2noH0JC+Wj7tNXz2V0Z1atkyxT3AWH2q0IHzwHi25panEnK96WXVTVnsviYeUVw2
         0jdXCNgymyPsfwHijLmbA1sW0TwySqnqQP0+A=
Received: by 10.216.180.145 with SMTP id j17mr9416837wem.109.1278985618784; 
	Mon, 12 Jul 2010 18:46:58 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Mon, 12 Jul 2010 18:46:58 -0700 (PDT)
In-Reply-To: <7vbpadfd4r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150867>

On Mon, Jul 12, 2010 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If the current code removes whitespaces at the beginning, I would actually
> say that it is cleaning up the mess while preparing the instruction sheet
> for you to edit, i.e. it is a good thing, and the patch might be making
> things worse.

Consider this situation:

	$ git log --reverse --oneline HEAD~3..
	cafebabe a commit header
	deadbeef   badly formatted commit header
	falaafe1 another commit header

Without the patch (let's call this "exhibit 1"):

	$ GIT_EDITOR=cat git rebase -i HEAD~3
	cafebabe a commit header
	deadbeef badly formatted commit header
	fa1aafe1 another commit header

With the patch (and let's call this "exhibit 2"):

	$ GIT_EDITOR=cat git rebase -i HEAD~3
	cafebabe a commit header
	deadbeef    badly formatted commit header
	fa1aafe1 another commit header

> I find it difficult to come up with good reasons to convince myself that I
> should be interested in what this patch tries to do.

I guess it boils down to your answer to this:

When you want to reword the badly formatted commit header, would you
prefer the see the output like the one shown in exhibit 1 over that of
exhibit 2 in your $GIT_EDITOR?

The example I gave has only one commit header with beginning whitespace.
What if for some reason you end up with more than a couple of commits
headers that have whitespaces at the beginning and you would like to
rebase them to fix it and what you see is the one similar to exhibit 1?

Isn't it harder to distinguish those badly formatted commits in that case?

> Here are some of the things that came to my mind while doing so.
>
> What happens if you have trailing whitespaces, excess whitespaces in the
> middle, etc. with or without this patch?  What _should_ happen in an ideal
> world?

Trailing/excess whitespaces are non issue. The intention of this patch is to
present the commit headers "as-is".

> What happens if you have a malformed commit object whose first line is
> blank (i.e. no "Subject" line),or there is _no_ commit log message
> whatsoever with or without this patch?  What _should_ happen in an ideal
> world?

When there is no commit log message the behavior is the same with or
without this patch.

I can't test for when the commit has no "Subject" line because I don't
know how to make one.  One thing for sure that in this case, with this
patch, what is shown in $GIT_EDITOR will be exactly the same as what

        $ git log $sha1_for_that_commit --format="pick %h %s"

shows.

If you agree with my arguments here then I'll proceed with modifying the
first patch in this series as per the discussion in the thread started by
1278764821-32647-1-git-send-email-ayiehere@gmail.com.

nazri
