From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] receive-pack: GPG-validate push certificates
Date: Thu, 21 Aug 2014 17:11:18 -0700
Message-ID: <CAPc5daWqYaPaO4QSc_28oySVX4hLondk5e7fpEjS_w3edrWLrw@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <1408485987-3590-17-git-send-email-gitster@pobox.com> <1408553797.26173.3.camel@leckie>
 <CAPc5daXLBQdjPaWNxmwZqStiWu8qHRfDG6=JS=bhbzA+c5Ww5g@mail.gmail.com>
 <1408557408.1282.5.camel@leckie> <xmqqr40bt0i0.fsf@gitster.dls.corp.google.com>
 <1408665541.1282.12.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKcSG-000500-Vm
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 02:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbaHVALk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 20:11:40 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:63574 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbaHVALj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 20:11:39 -0400
Received: by mail-lb0-f173.google.com with SMTP id u10so8811736lbd.4
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vOVe3546NBTB/BnEw+itCOhBwmr/ALOp5gZZz5P5MGk=;
        b=zI15Bevy0x40nm1NIdvn71JWsfjqmzxJAaz0lPnm/rENGD7+wGQf7sp1o/JN9zBSFn
         6Ihu7G3AEc9KV8MY6q0rtuz1h1irUu3+PTANG9zmPhN2e8+M6X7roWJEzWvKkUqIXr63
         amEU+6aAp0DSab8pnlEIpGk84331VjeAXppHFb9+O5YBsHYMh+rQ1saH9LMzqR7ybr88
         iTXFKqAECXEYkhkaFVOoCFMWJEoYKBOWPBkULiwdZo9V3+riCOZi74t6zJI5xZfjw982
         jUxDOe6C+7TR9pWQeokQ7Nfh73ldTPrco64MVxcMWJe5oqcD3VAQJZPnrgxY0TC9AVSE
         ABHQ==
X-Received: by 10.152.22.199 with SMTP id g7mr1622184laf.6.1408666298155; Thu,
 21 Aug 2014 17:11:38 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Thu, 21 Aug 2014 17:11:18 -0700 (PDT)
In-Reply-To: <1408665541.1282.12.camel@leckie>
X-Google-Sender-Auth: KZnq7EIKk_XnFQNra6-pf1PvXkE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255649>

If you ignore the clock skew between the pusher and the receiver, then
you are correct,
but otherwise not quite.  Also by specifying that as <nonce>, not
<server-timestamp>,
the receiving end has a choice in how to generate and use the nonce
value. The only
requirement on the protocol is that the pusher must parrot it literally.

On Thu, Aug 21, 2014 at 4:59 PM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2014-08-20 at 12:38 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>>
>> > On Wed, 2014-08-20 at 10:29 -0700, Junio C Hamano wrote:
>> >> On Wed, Aug 20, 2014 at 9:56 AM, David Turner <dturner@twopensource.com> wrote:
>> >> > On Tue, 2014-08-19 at 15:06 -0700, Junio C Hamano wrote:
>> >> >> Reusing the GPG signature check helpers we already have, verify
>> >> >> the signature in receive-pack and give the results to the hooks
>> >> >> via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.
>> >> >>
>> >> >> Policy decisions, such as accepting or rejecting a good signature by
>> >> >> a key that is not fully trusted, is left to the hook and kept
>> >> >> outside of the core.
>> >> >
>> >> > If I understand correctly, the hook does not have enough information to
>> >> > make this decision, because it is missing the date from the signature.
>> >>
>> >> The full certificate is available to the hook so anything we can do the hook
>> >> has enough information to do ;-)  But of course we should try to make it
>> >> easier for the hook to validate the request.
>> >
>> > Excellent, then motivated hooks can do the right thing.
>> >
>> >> > This might allow an old signed push to be replayed, moving the head of a
>> >> > branch to an older state (say, one lacking the latest security updates).
>> >>
>> >> ... with old-sha1 recorded in the certificate?
>> >
>> > That does prevent most replays, but it does not prevent resurrection of
>> > a deleted branch by a replay of its initial creation (nor an undo of a
>> > force-push to rollback).  So I think we still need timestamps, but
>> > parsing them out of the cert is not terrible.
>>
>> As I aleady mentioned elsewhere, a more problematic thing about the
>> push certificate as presented in 15/18 is that it does not say
>> anything about where the push is going.  If you can capture a trial
>> push to some random test repository I do with my signed push
>> certificate, you could replay it to my public repository hosted at
>> a more official site (say, k.org in the far distant future where it
>> does not rely on ssh authentication to protect their services but
>> uses the GPG signature on the push certificate to make sure it is I
>> who is pushing).
>>
>> We can add a new "pushed-to <repository URL>" header line to the
>> certificate, next to "pushed-by <ident> <time>", and have the
>> receiving end verify that it matches to prevent such a replay.  I
>> wonder if we can further extend it to avoid replays to the same
>> repository.
>
> I think but am not certain that pushed-to <repository URL>, along with
> the pushed-by <ident> <time> means that the nonce is not needed. The
> nonce might make replays harder, but pushed-to/pushed-by makes replays
> useless since the receiving server can determine that the user intended
> to take this action at this time on this server.
>
