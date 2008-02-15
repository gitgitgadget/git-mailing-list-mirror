From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain messages
Date: Fri, 15 Feb 2008 13:37:49 -0500
Message-ID: <76718490802151037m87995c2gacf29667259eae41@mail.gmail.com>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
	 <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:38:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ5SX-0008UE-Cz
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760893AbYBOShw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760882AbYBOShw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:37:52 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:20334 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760857AbYBOShu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 13:37:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1297043wah.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ocMOL5cA6VZnYpXYWsffa5yC6m5PSDTsbENiQgjxRj4=;
        b=TRepJW/yxgaNmtCNnm6gPP6TzT94meEFrIJEihpqpgUqYHx3m7y9ens9HpNc1cHnpO5yZe/5k5rK6GZ0Vu24YPHXvbhc1kmlyVSJbyneOOWXB+lBIz25QFvd3hGOm6Hn3k8Oe67wcVF/Qxo00h6c/0Z7EXZutTTMPOCPtc1JZdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ks7JGo+e3O2VoFunRwp6MaGLchTT15c1wWnhW1sX0Wa+xQGAKX8zsWBjuBWO3YA0N+0u0h2C4x+pZMbbVe1f+Ho+rDnciCJVD/LEZSKuFSS0yJtdzONLVRFonuUbxCGT39lu7CV4kHAPmkII1IN4UzJdI6hgp+5CD1KQGt5uh84=
Received: by 10.114.154.1 with SMTP id b1mr2125024wae.118.1203100669535;
        Fri, 15 Feb 2008 10:37:49 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 10:37:49 -0800 (PST)
In-Reply-To: <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73973>

On Fri, Feb 15, 2008 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I really do not like this.

Ugh.

>  format=flowed instructs the receivers MUA that it is Ok to
>  reflow the text when the message is presented to the user.

No, it indicates that the MUA sender mangled the message, but did so in
a way that it can be unmanged* as long as the receiving MUA implements
RFC 3676.

* Trailing whitespace removed by the MUA before sending is the one
  exception that cannot be unmangled; I'll address this further below.

>  You review the patch, decide to apply or reject, and then
>  finally apply.  Unmangling of corrupt contents should be done
>  before you review, not before you apply.

As long as you're reviewing the patch in an MUA which implements RFC
3676, you'll be reviewing the unmangled patch. By your reasoning,
mailinfo shouldn't decode QP or BASE64 either. If you want to make 100%
sure you're reviewing *exactly* what you plan to apply, then you need to
run it through git-am first and then review it via git-diff, no?

If you're reviewing in your MUA, your MUA may already be taking care of
QP or BASE64 for you. If the MUA is RFC 3676 aware, it's un-flowing
format=flowed too. mailinfo should do the same.

>  format=flowed is completely opposite --- you are
>  giving your and recipients MUA freedom to reflow the text, but
>  there is no valid reason to allow that when sending patches.

Not all MUA's can be configured to disable format=flowed. Sure, it's
best if folks send 100% plain/text w/o any mangling, but their MUA may
already be doing B64 or QP out of their control.

>  We do not even encourage MIME attachments and ask senders to try
>  sending uncorrupt patch in-line, _even though_ MIME attachments
>  is a way to try harder not to corrupt the payload.  Why should
>  we encourage format=flowed

We're not trying to encourage it, just accommodate it where the sender
can't disable it.

>  The format is not meant for the exact transmission of text (like
>  "patch") but more for paragraphed prose that can be re-fit on
>  narrower display like phones.  Section 5. even goes to say
>  "Hand-aligned text, such as ASCII tables or art, source code,
>  etc., SHOULD be sent as fixed, not flowed lines."

Again, some MUA's aren't configurable. They apply format=flowed to any
text/plain message.

>  Side note.  I did not look at the patch very carefully, but can
>  you salvage a deleted text in the patch that removes a line that
>  consists of "- " (minus followed by a single space and then
>  end-of-line), or any deleted or added text that ends with a SP
>  without making them misinterpreted as "flowed" line for that
>  matter?
>
>  I even suspect that the sending MUA client may misbehave for
>  such a patch line.  In fact, doesn't section 4.2 say "a
>  generating agant should trim spaces before user-inserted hard
>  line breaks."?  It implies to me that you cannot have a fixed
>  line that ends with SP.

Yes, the sending MUA likely striped trailing whitespace and this cannot
be recovered. Let's look at this in practice to see where it can be a
problem.

Existing code generally shouldn't have trailing whitespace nor
whitespace only lines. However, let's say that it does and that the
patch refers to one of these lines (either as context or a subtraction).
In this case that hunk will fail to apply, unless we teach git-apply to
be lenient if the only difference between the line in the patch and the
existing code is trailing whitespace.

In the case of an addition, the patch *shouldn't* contain trailing
whitespace anyway. If it did, git-apply would in its default
configuration flag it as a whitespace error. So arguably, the MUA is
doing you a favor by stripping whitespace on such lines. :-)

>  So just reject the patch when somebody sends you format=flowed
>  and ask them to re-send without =flowed, and the world will be
>  a much better place.

I don't get it. Why not accommodate fascist RFC 3676 MUAs if we can for
the same reasons we accommodate QP, BASE64, and attachments instead of
inline? I guess I can only think of two reasons:

1) We need to accommodate QP, BASE64, etc since they may be due to the
   MTA. By contrast, format=flowed is always an MUA issue.

2) The other transformations are 100% safe in getting back exactly the
   patch the user intended. format=flowed isn't. But per above, I'm not
   sure the trailing-whitespace loss is a problem in practice.

j.
