From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: git auto-repack is broken...
Date: Fri, 2 Dec 2011 08:22:00 -0800
Message-ID: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 02 17:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWVsZ-0007hy-Us
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 17:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981Ab1LBQWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 11:22:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46359 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab1LBQWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 11:22:22 -0500
Received: by faaq16 with SMTP id q16so2204657faa.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=0TLSrU6n7KhMYzQFJ79uSsnhaLL80LESuEiBVyi16+4=;
        b=EMSiZyXt0BBzyTCofnddp3akvV9s/vBz97CLFX8xRxnb+c+u/7pCCvhPhsT3JTvxgl
         rPH1sSVII6oPfRTnRWJai5Fwt8w63VW0U4cyATyBthOEBKHwXP6gy48ZboMQ28At+mzs
         w1OTETTZ2hNVbQAyxVX9JQrremDVs0lAi48pE=
Received: by 10.180.19.42 with SMTP id b10mr13760853wie.39.1322842941231; Fri,
 02 Dec 2011 08:22:21 -0800 (PST)
Received: by 10.216.58.140 with HTTP; Fri, 2 Dec 2011 08:22:00 -0800 (PST)
X-Google-Sender-Auth: 8pDgIv9unuNc9bbKs_3O-_hbrC4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186226>

I actually tend to repack things pretty religiously (ok, not really,
but I do "git gc" reasonably regularly, so I was surprised to see
thig:

  Auto packing the repository for optimum performance. You may also
  run "git gc" manually. See "git help gc" for more information.

followed by this pitiful effort:

  Counting objects: 8, done.
  Delta compression using up to 4 threads.
  Compressing objects: 100% (8/8), done.
  Writing objects: 100% (8/8), done.
  Total 8 (delta 0), reused 0 (delta 0)

Ok, those 8 objects will *not* help anything at all, and the
autorepack is broken.

So what's going on? It turns out that I have a fair amount of
unreachable objects in this repository, because I do things like
fetching things without then merging them, etc. So the "git gc --auto"
will happily do "git repack -A" or whatever, and that in turn does
*nothing* what-so-ever (or rather, it packs my latest merge commit
like the above and generates that pack of a whopping 8 objects).

I can fix it with "git gc --prune=now", so it's not like I personally
really care, but since the whole point of "git gc --auto" is to allow
people who don't know what they are doing to ignore the whole issue of
GC and pruning, I do think this is a real UI bug.

I don't really have any suggestions for fixing it, though. Maybe we
should make "git gc --auto" remove any unreachable objects? That would
be potentially dangerous in shared repository situations, though. Or
have an extra option to "git repack -A" to also pack any loose objects
it finds at the end (whether reachable or not)?

                         Linus
