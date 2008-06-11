From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 17:02:31 -0700
Message-ID: <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
	 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
	 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
	 <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 02:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6DoF-0006pD-RB
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 02:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbYFKACe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 20:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbYFKACe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 20:02:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:32105 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbYFKACd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 20:02:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1952013fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fGuYN2HE+yw4FjdEQEEzUwLW6Q1ZvxgUzQnW0RdNYi8=;
        b=v2ul6LL9eYivlAY6gXQ8GGJZ5DnTF0unAuA3YbK8qx87RrgP+sT04Zc3g2pxtW2UYc
         IaM9YJkTPNiH8TTI0KXSl/x6vwu8pbIdPJOo4/5Ad5Pzke9v6vr9xY8zLxsvSoA7mIK8
         Q5F7OsFoBoCwBlYf8utWkftNy/QWoxhp4q8WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TJzqulTyH78pLIUTbf/hl0rfcBczJ7+PfsQx2wUDfNtVuLSvxPws5vWuLO2m3NVGoV
         HStSuYfatwQjm0TxtI8cgYm3+HlS4abjAADmaHonMlHpICERThtvlG0tYZgtvygATgcR
         mm9M1ReZTEUM1MxFn4OKI7mxXQWwySp2d8TWc=
Received: by 10.86.100.19 with SMTP id x19mr6387867fgb.61.1213142551567;
        Tue, 10 Jun 2008 17:02:31 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 17:02:31 -0700 (PDT)
In-Reply-To: <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84563>

>> I had thought about this. I hacked some code up where the index looks
>> at the current system time when updating a cache entry to determine if
>> the hash is racy. Is doing one time(NULL) call per file reasonable?
>> I'm guessing it must be cheaper that a stat call.
>
> Hmm, sorry, could you elaborate how you would plan to use the return value
> from time(2) per file?

My bad, I was extremely unclear. I meant I had thought about not
bothering to look at the index file timestamp (I'm not sure why, but I
instinctively trust the system clock more!). I'm making the same
assumptions, i.e. files are not touched while they're being indexed. I
suppose with the way I'm doing things, you can touch a file right up
to the point where the index wants to stat that particular file and
maybe look at its contents, but not afterwards. (And this is pretty
useless, because how are you going to know which file the index is up
to?)

I maintain a flag per file, and after computing its SHA1, I compare
the mtime with the current system time. If it matches, then that means
the hash can't be trusted (because of the race condition) and I set
the flag. This way, I avoid examining the index timestamp.

I call time(NULL) for each file out of laziness. I could cache the
value somewhere the first time, but that means I'd have to pass around
an extra argument to a whole bunch of functions, because of the way
I've written my code. But I don't think it's much of a drawback,
because I stat() each file anyway.

Actually, what Linus describes would be desirable in some sense. If
the index mtime timestamp were always later than the time you
performed the indexing (and accurate) because it always took a long
time, assuming no one messes with files while you're indexing, there
would be no race condition to worry about.

-Ben
