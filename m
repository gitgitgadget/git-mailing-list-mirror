From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: weaning distributions off tarballs: extended verification of git tags
Date: Sat, 28 Feb 2015 15:34:41 -0500
Message-ID: <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing List <git@vger.kernel.org>
To: Colin Walters <walters@verbum.org>
X-From: git-owner@vger.kernel.org Sat Feb 28 21:34:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRo64-0008Cr-HQ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 21:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbbB1Uen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 15:34:43 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34096 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbB1Uem (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 15:34:42 -0500
Received: by iecrp18 with SMTP id rp18so39120073iec.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VL+mfoh/5zSgu1xnM+Obv+Yft348RLBmB71SEaCz5Mk=;
        b=HdyqfpxtiZbkZIofKM0639n88AUhtLkGpsm8mM1UNg4ObAhZepnveREbziwKEQub13
         tyyyYfQMXWpkLSTKf8JUS27a3RonqY/Cs4rBM3VGqXrwuxPj7opKX3ZNGuurZWP0m83E
         6CaRZC53xzvD92YefiVHgsER05XOqM5ULbGt3Ei3643/xg9R7ebolXcPlciSkEXwjQ05
         buUm8S4uqmNQVPO8To5SxR5F9jMsRjkthejCjqhZHugWEDlK2yG/WFy0rLu5Z8/BeF6T
         Wq+om+WecqIvJLmOYUciewHRCQ3Hus20fMVdaNH38Pvs6gy+ytH3wwTrTkK3muW11O0n
         VcOg==
X-Received: by 10.107.32.14 with SMTP id g14mr27808076iog.3.1425155681968;
 Sat, 28 Feb 2015 12:34:41 -0800 (PST)
Received: by 10.36.84.129 with HTTP; Sat, 28 Feb 2015 12:34:41 -0800 (PST)
In-Reply-To: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264537>

Is there a point to including a different checksum inside
a git tag?  If someone can break the SHA-1 checksum
in the repository then the recorded SHA-256 checksum can
be changed.  In other words, wouldn't you be just as well
off handing someone a SHA-1 commit id?

If you can guard the SHA-256 with a signature, you can
do the same thing to the SHA-1.  Or the tarball for that matter.

Unrelatedly, your assumptions:

Tar balls have too many degrees of freedom to rely on them
being created identically in the future.

> - The assumption that this source has been run through some tests

A perfectly valid assumption for some build systems, notably
autotools.  "make distcheck" is the only way my tarballs get
made and they only get made when the checks succeed.
(If your point was that many projects have too few tests,
well, then I agree.)

M.



On Sat, Feb 28, 2015 at 9:48 AM, Colin Walters <walters@verbum.org> wrote:
> Hi,
>
> TL;DR: Let's define a standard for embedding stronger checksums in tags and commit messages:
> https://github.com/cgwalters/homegit/blob/master/bin/git-evtag
>
> I think tarballs should go away as a source distribution mechanism in favor of pure git.  I won't go into too many details of the "why" here (hopefully most of you agree!) but that's the background.
>
> Now, there are a few things that the classical tarball model provides:
>
> - Version numbers compatible with dpkg/rpm/etc
>   -> Do the same with your tag names, and use a well known scheme like "v$VERSION"
> - The assumption that this source has been run through some tests
>   -> Broken assumption, and regardless you want to rerun tests downstream
> - Hosting providers typically offer a strong checksum over the entire source
>   -> The topic of this post
>
> The above strawman code allows embedding the SHA256(git archive | tar).  Now,
> in order to make this work, the byte output of "git archive" must never change in the
> future.  I'm not sure how valid an assumption this is.  Timestamps are set to the
> commit timestamp, but I could imagine someone wanting to come along later
> and tweak the output to be compatible with some variant of tar or something.
>
> We could define the checksum to be over the stream of raw objects, sorted by their checksum,
> and that way be independent of archiving format variations.
>
> Is there agreement that something like this makes sense in the git core?  Does the
> concept make sense?  Does anything like this exist today?  Other thoughts/objections?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
