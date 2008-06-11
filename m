From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 10:52:32 -0700
Message-ID: <832adb090806111052p32a750c2n5f2d43e0ed1b910d@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>
	 <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
	 <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>
	 <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
	 <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>
	 <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
	 <832adb090806102318k5727bb06p6c3211a6aebbfbe9@mail.gmail.com>
	 <alpine.LFD.1.10.0806110752550.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:53:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6UW2-0001zV-Pa
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 19:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYFKRwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYFKRwh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 13:52:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:21954 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYFKRwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 13:52:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2193997fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HPGFL9mt6yWZC4B1dpqtBVGgq3mHJMeBwH7EqDhQi08=;
        b=Pw1w3idmAWNE1UxJrXbu6vSz1poNxHiqksI0UwijnflDI7oCXfColqfWNgIC3ftJXn
         2tOaMrQ2P0GCWoNAMTCoWzT8MoWkGGkToaGqbQdTAtlccYaeOhCBDDyS/Qe2/+QhS8rJ
         4ohv1SEdUHxZU/fkLH7BaSIDWS0m9lQCWTRG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ClBc/Pc4WuIxCVQyneszhlp/2QFZJWFShpQfgKPfw3GVLTDmu3zQ5mupuIbv7xF4em
         rBJW/bmz5vjGg7O3NsiVrkg/oioCbcBfz/RJVmiRWxjCpALtP4jn0W+jaDxWKcLDHw/A
         lKC9mRVtyki9uvPi/jVbmX1mpfK1yEcRhf7Pc=
Received: by 10.86.33.10 with SMTP id g10mr686042fgg.15.1213206753022;
        Wed, 11 Jun 2008 10:52:33 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Wed, 11 Jun 2008 10:52:32 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806110752550.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84627>

> I'm not sure why you think my patch that just did the zero-sized blob
> thing was slow? It's a 20-byte memcmp(). It takes no time at all.

I don't think the memcmp is slow. I think the ce_modified_check_fs in:

smudge() {
   ...
  if (ce_match_stat_basic(ce, &st))
                return;
  if (ce_modified_check_fs(ce, &st))
                ce->ce_size = 0;
}

is potentially slow, and I'm saying you could replace it with

smudge() {
   ...
  if (ce_match_stat_basic(ce, &st))
                return;
  ce->ce_size = ~0;
}

to avoid the ce_modified_check_fs call. But it is an unclean solution,
which is why I champion having an extra flag per file.

Also, I think we could set ce->ce_size to ~0 when we first realize
timestamp = mtime, and we'd no longer have to do index-wide smudging
on writes.

Thanks for the explanation by the way. I get why you can't modify the
SHA1. It is indeed what we asked git to record, right or wrong. I got
confused because I misread the code and thought ce_modified_check_fs()
would write the new SHA1 to disk.

-Ben
