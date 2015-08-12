From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 14:43:17 -0700
Message-ID: <CA+P7+xpsjX=4j=7w7DJ+EnO-uBfq53_Bmwk8AZ4frAy=iTQ7ZQ@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
 <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
 <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com> <CA+P7+xrSAo43=-3q-7SPxerYPKU3+T75dG5dTE=H8odicRDxSg@mail.gmail.com>
 <xmqqa8twl3x9.fsf@gitster.dls.corp.google.com> <CA+P7+xournf+1Cqnr-AAO+EzUee3KfEevFQLhXkqyfQGBvPRpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:43:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPdoD-0003DM-TC
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbbHLVni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:43:38 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36657 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbHLVnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:43:37 -0400
Received: by igxp17 with SMTP id p17so9136754igx.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VO94TKN9eb553QdI93RbhdVa5ur7kXTNSz12SJ5pBXA=;
        b=WRLGUmo1QLsTXpinJdVSkLNu3xXXXPDVUsZlpYwJ66gO3H1RANZW4Kahy71K+YnGN1
         LMp6mErhG3svLf11MnrHnN2ZwzPwZJibluy2uF5oe8LKSzaVY1e/hRW/UEiwtTE4WAEX
         g61i4V6r40JBUTfRw38HBXSjgOXBF4O56EEBITFnGjxBRXe3Xj4K5xQCx2FFkmCKYxsL
         oQx+xsqL9EvpslMAulGFkImEHKFFdKOUD/889QDxgLwAdAlNd/k6hqDJhFw4jngjB3rp
         GZzgkCJ3NlR/cxxRjN7vkLwcNWvzacoECVe0FOnUSqVBr10SpvtC7qp3rcvJaAfrz/K4
         +MpA==
X-Received: by 10.50.124.97 with SMTP id mh1mr27107763igb.92.1439415817035;
 Wed, 12 Aug 2015 14:43:37 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 14:43:17 -0700 (PDT)
In-Reply-To: <CA+P7+xournf+1Cqnr-AAO+EzUee3KfEevFQLhXkqyfQGBvPRpQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275812>

On Wed, Aug 12, 2015 at 12:16 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Oh interesting. I did a test. If you provide a fully qualified ref not
> inside refs/notes, then it assumes you meant refs/notes/refs/foo/y
> rather than refs/foo/y
>
> I need to do some more digging on this to determine the exact thing going on...
>
> Regards,
> Jake

I did some more digging. If you pass a notes ref to "--refs" option,
that requires all notes to be bound to refs/notes/* and does not allow
passing of arbitrary refs. However, you can set the environment
variable GIT_NOTES_REF or core.notesRef to a fully qualified
reference.

That seems very arbitrary that --ref works by expanding notes and the
environment variable and configuration option do not... [1]

I think this inconsistency is very weird, because *most* people will
not use refs/notes/* etc. This makes it so that --refs forces you to
use refs/notes/* or it will prefix it for you... ie: you can use
notes/x, refs/notes/x, x, but if you use refs/tags/x it will DWIM into
refs/notes/refs/tags/x

I think this is very confusing that --refs doesn't behave the same as
other sections... either we should enforce this on all refs or we
should fix the DWIM-ery to be consistent.

that is, we should fix DWIM-ery to be:

(1) if it starts with refs/* leave it alone

(2) if it starts with notes/*, prefix it with refs/

(3) otherwise prefix it with refs/notes/

But that way, refs/some-other-notes/ will work fine instead of
becoming something else.

We should also fix reads of environment variable etc such taht we
enforce these values always are fully qualified and begin with refs.
Otherwise, use of --refs and the environment variable don't allow the
same formats.

Regards,
Jake

[1] 8ef313e1ec3b ("builtin/notes.c: Split notes ref DWIMmery into a
separate function")
