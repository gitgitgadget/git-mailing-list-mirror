From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Proper tracking of copies in git log and others
Date: Tue, 7 Jul 2009 10:59:28 -0400
Message-ID: <32541b130907070759j74831f2au19d90c2a5551e12d@mail.gmail.com>
References: <4A4F8258.5070701@trn.iki.fi> <4A535244.60502@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+dfhy@trn.iki.fi>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 17:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOC9M-0006VQ-8q
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 17:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbZGGO7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 10:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757936AbZGGO7y
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 10:59:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:17679 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287AbZGGO7x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 10:59:53 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1527607rvb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FkfjcKKjxlu3xCIy00zC6Sx7tPlqbHd41FSlsFYSt88=;
        b=nhDyz2ysWnLk64TLQIo+sp2ZwNCkI690ZNxjQes2cVskFcCnuxKLFu7byaL8Tk3ATl
         B7sb/C6MCsDGZ0aujLjkDntD++iZdE5GPQ6J5owHV0FHS/7iExv0ZqLYrFp11yy577c5
         dLmwDSiKrIsj2hLcNk0SZtH8XglJJGB839VXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ayelYWTNLv1UkrZkLBjUjimC3d21vRgLPR7Nygs5yafiBD/vWtiI6fPo7AFPrSNeZN
         VlNNRww5JB02MY+hpWfz5LeFrTVAP8TymRxWYB1O1ift8q14VrS94kNYoTjdcP0c8VQu
         vC1pM7ofEzXPhQopb+L/Kau5AQCcy+vP6KSsg=
Received: by 10.140.178.8 with SMTP id a8mr3634671rvf.161.1246978788577; Tue, 
	07 Jul 2009 07:59:48 -0700 (PDT)
In-Reply-To: <4A535244.60502@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122847>

On Tue, Jul 7, 2009 at 9:48 AM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
> While there is a pending patch as Sean pointed out it still has issues.
> For moves, "there is always only one", for copies there are at least
> two. So which one do you follow?

I think this is relatively easy, although the answer depends on
whether you're merging or logging.

Let's take the general case of n:m copies: n is the number of copies
in the second commit, and m is the number in the base commit.  So 1:1
is a move, and 2:1 is a copy, and (>2):1 is a multiple copy, and eg.
3:2 is an unclear case where you had more than one identical (or
near-identical) file in the first place.

A) Merges: if it's anything other than 1:1, it's totally non-obvious
what to do, so I'll forgive git for doing pretty much anything.  Bonus
points for triggering a conflict so that I have to look at it.

B) Logs:

 - if m > 1, choose the base file that's closest to the new one; its
history should be pretty close to the right one, and arguably the new
file could have come from there anyway.  If there's more than one file
of the same closeness, just pick one, because their histories are
interchangeable anyway.

 - if n > 1, each file needs to have its base selected separately.
It's totally okay for multiple files to have the same base.  If files
b, c, and d were all copied from a, I'd expect "git log --follow b c
d" to show the copying operation, and then the history of a.
Similarly for "git log --stat --follow b" for example.

All of this seems to work (at least well enough for me) with the 1:1
move case, and also for copies if you use "git log --stat -C -C" (not
restricting by filename).  "git log --stat -C -C b" (restricting by
filename) doesn't work for copies, and --follow doesn't help (the
documentation for that options suggests it's only useful for moves).

Unfortunately this also causes problems with following "effective
move" operations: copy the file in one commit, and delete the original
in the next.  I've been known to make this mistake, and it breaks 'git
log -C -C --follow filename', which is no fun.

Thanks,

Avery
