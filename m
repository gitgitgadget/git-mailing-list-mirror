From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Wed, 27 Jul 2011 19:42:34 +0200
Message-ID: <20110727174234.GC29924@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-4-git-send-email-artagnon@gmail.com>
 <20110727041809.GB18470@elie>
 <CALkWK0kFngXcyrKeB4HM5GdHebkuXOQ5jBETxWuxZCzYL94tqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 19:42:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm88G-0004jy-EU
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 19:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab1G0Rmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 13:42:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57762 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab1G0Rmq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 13:42:46 -0400
Received: by ewy4 with SMTP id 4so1425954ewy.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U+0hbvEZam0LW5rshMTbka6ddh24v2FLeJ+uMz6UdQ8=;
        b=iVF7C9dPi61YS5T6/HqdScWSD5jmBZM5WYKxRpmFs+k9f/CLhrLazRVQ12msLaGy+P
         0PQC71ka81mcZOK3zzUdjpDFN94nl0pHQJTwRBhUYVShLXm6vy6BK84RE1uPjCLsbRWG
         Wu8hnX4BXNhChdfrT+AHgnOgS96mFXZCdr5SM=
Received: by 10.213.4.195 with SMTP id 3mr23580ebs.137.1311788564719;
        Wed, 27 Jul 2011 10:42:44 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id e48sm68017eeb.3.2011.07.27.10.42.42
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 10:42:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kFngXcyrKeB4HM5GdHebkuXOQ5jBETxWuxZCzYL94tqg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177985>

Ramkumar Ramachandra wrote:

>> Unfortunately it fails for me even after the patch. =C2=A0If the tes=
t looks
>> reasonable to you, it could be worth adding marked with
>> "test_expect_failure".
>
> Perhaps as part of a different series which addresses the issue of
> malformed objects in general.  I don't think it is relevant for this
> series.  The "other" series I'm thinking about should contain:

I don't want to work on that, personally...

But git already has a strategy for this.  It is quite simple: git can
give insane results when fed malformed objects, but it does not blindly
trust it and let scripts segfault, corrupt something else, escalate
privileges, etc.  Remember that malformed objects might even have been
received from a remote machine with "git fetch" --- one simply cannot
trust objects beyond the assertion "each object is a stream of bytes".

And on the other hand, git maintains sanity by _preserving_ invariants
and providing good behavior when it deals with valid objects.  To a
rough approximation, "valid object" is a synonym for "git fsck accepts
it" (but that approximation is only modulo bugs --- git fsck has both
false positives and false negatives).  It is perfectly legitimate for
commands to get confused and give a wrong result when working with
invalid objects, and this ability is a nice thing because it allows
for some optimizations.

As for the example at hand: perhaps we should teach "git fsck" to call
commit objects without a blank line after the header invalid.  After
all, historical implementations of commands like "git cherry-pick" are
not ready to cope with them.  But that is no excuse to pretend they
don't exist!  While the best thing about your patch (and the most
invasive aspect of it) is that it improves that situation, for some
reason you don't want to document this important aspect of its impact.
It leaves me completely puzzled.
