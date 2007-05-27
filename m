From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v3] Prevent megablobs from gunking up git packs
Date: Sat, 26 May 2007 22:46:20 -0700
Message-ID: <56b7f5510705262246o54a38a44xc0c261c4b4161155@mail.gmail.com>
References: <465887AB.1010001@gmail.com>
	 <alpine.LFD.0.99.0705262304200.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 27 07:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsBaL-00020z-S0
	for gcvg-git@gmane.org; Sun, 27 May 2007 07:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbXE0FqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 01:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbXE0FqY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 01:46:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:21253 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbXE0FqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 01:46:23 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1388790mue
        for <git@vger.kernel.org>; Sat, 26 May 2007 22:46:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UrgdENB74zEp1SmsrT+5HpE138ZsMgp09IUjrBR+hYH7rnlgeLczSzqIlejMCzuFjCCjj8gOtqwmy8usevVNISMz10kCQgdRgjPRtUK6zqUP8zjZ+2ipD+Xvius1O0Sghtm2+gvbQETb2K34VzZ8kcV0thaBn2BIMV7i/tHVbMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ro7+RP2nY9vWSP68l3pcRMVaBuNKFMRBwVXMxLVfQe7jaGBOiOzoZJmX1tNIYDN7T6dhnkR9PaH9IuY+nMq9q3czB0eMJ0JHXmJsdFRkHyFVBWDP5JWBT3K/1gcF699dw3cVXeEOyYbAQv0FICwq+MHkY3269dIfYnk/ygDXULc=
Received: by 10.78.131.8 with SMTP id e8mr1352902hud.1180244780273;
        Sat, 26 May 2007 22:46:20 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sat, 26 May 2007 22:46:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705262304200.3366@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48518>

On 5/26/07, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 26 May 2007, Dana How wrote:
> > Extremely large blobs distort general-purpose git packfiles.
> > These megablobs can be either stored in separate "kept" packfiles,
> > or left as loose objects.  Here we add some features to help
> > either approach.
> >
> > This patch implements the following:
> > 1. git pack-objects accepts --max-blob-size=N,  with the effect that
> >    only loose blobs less than N KB are written to the packfiles(s).
> >    If an already packed blob violates this limit (perhaps these are
> >    fast-import packs or max-blob-size was reduced),  it _is_ passed
> >    through if from a local pack and no loose copy exists.
>
> I'm still not convainced by this feature.  Is it really necessary?
>
> Wouldn't it be better if the --max-blob-size=N was instead a
> --trailing-blob-size=N to specify which blobs are considered "naughty"
> per our previous discussion? This way there is no incoherency with
> already packed blobs larger than the treshold that you have to pass
> through.
>
> This, combined with the option to disable deltification of large blobs
> (both options can be specified with the same size), and possibly the
> pack size limit, would solve your large blob issue, shouldn't it?

Unfortunately, it doesn't.

There are at least three reasonable ways to handle large blobs:
(1) git-repack -a repacks everything.  Naughty blobs get pushed to
     the end as discussed (possibly dominating later split packs).
(2) Naughty blobs accumulate in separate "kept" packs.
     git-repack -a only repacks nice blobs.  Separate scripts,
     or new options to git-repack,  are needed to repack the "kept" packs.
     A number of people have discussed ideas like this.
(3) Naughty blobs are kept loose.

We have 255GB compressed in our Perforce repository and
it grows by 2GB+ per week.  Although I'm only considering bringing ~10%
of this into git,  it would be good for me to be able to argue that
I could bring more.  Every day the equivalent of ~1K+ blobs are committed.
How often should I repack the shared repository [that replaces Perforce]?
With this level of traffic I believe I should do it every night.

I've been discussing these plans with IT here since they maintain
everything else.
They would like any part of the database that is going to be reorganized
and replaced to be backed up first.  If only (1) is available,  and I
repack every
night,  then I need to back up the entire repository every night as well.
If I use (2) or (3),  then I back up just the repacked portion each night,
back up the kept packs only when they are repacked (on a slower schedule),
and/or back up the loose blobs on a similar schedule.

Besides this back up issue,  I simply don't want to have to repack _all_
of such a large repository each night.  With (1), nightly repacks get longer
and longer, and harder to schedule.

I think the minimum features needed to support (2) and (3) are the same:
(a) An easy way to prevent loose blobs exceeding some size limit
     from migrating into "nice" packs;
(b) A way to prevent packed objects from being copied when
     (i) they no longer meet the (new or reduced) size limit AND
     (ii) they exist in some other safe form in the repository.
The behavior of --max-blob-size=N in this patch provides both of these
while deleting other behavior people didn't like.

You mentioned "incoherency" above;
I'm not too sure how to proceed on that.
If you have a more coherent way to provide (a) and (b) above,
please let me know.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
