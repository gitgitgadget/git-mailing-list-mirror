From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 16/18] receive-pack: GPG-validate push certificates
Date: Wed, 20 Aug 2014 13:56:48 -0400
Organization: Twitter
Message-ID: <1408557408.1282.5.camel@leckie>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	 <1408485987-3590-17-git-send-email-gitster@pobox.com>
	 <1408553797.26173.3.camel@leckie>
	 <CAPc5daXLBQdjPaWNxmwZqStiWu8qHRfDG6=JS=bhbzA+c5Ww5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKA7z-0008UO-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbaHTR4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 13:56:51 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:43674 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbaHTR4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 13:56:50 -0400
Received: by mail-qc0-f177.google.com with SMTP id x13so8167981qcv.36
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 10:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/AYbQ3/4o/ZcNVlski23KkNH1xSF3efNcoZxas/OXms=;
        b=VrRtXyX6SYl/U0L/ddWYe2x28eEtxn6V0Z/aMYSJcZP2MNxFTOapFAWzjDQtcDuz4P
         SZ+cRxYbe/TosKDooR0Ub7jc8WMLVXCTMC3y5RoKg4QR6OoS7DxRPo4fS/HGeV8vEVxO
         zyjtu1YUIi+10vR/jRkqyGHN1ARv5zn2tgEK68L1ZrlqoM1yl2lwb6VlhdoIq3XvJC8z
         igz2HQlCdTBId1sVR9t3UpCfrAgaOEpoD3eSl12pHOmTWQP4wmqo0XALNazBMZTzrJlH
         pylts70ZoXzxS6xPoBIDvHNhbr8Z3E/R9XM0Lph1hYYAvaqr1uFVusHVeTnGFVgYQUuM
         XO3Q==
X-Gm-Message-State: ALoCoQm8jgYaM2KPzln5zh7mO1aMbVduTGaCZSrBNc4L8Qr7oltnyx0dyw7pwbQSryvYn5WtNDPc
X-Received: by 10.224.151.69 with SMTP id b5mr12520023qaw.37.1408557409957;
        Wed, 20 Aug 2014 10:56:49 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id n46sm26201521qgd.49.2014.08.20.10.56.48
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 10:56:49 -0700 (PDT)
In-Reply-To: <CAPc5daXLBQdjPaWNxmwZqStiWu8qHRfDG6=JS=bhbzA+c5Ww5g@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255579>

On Wed, 2014-08-20 at 10:29 -0700, Junio C Hamano wrote:
> On Wed, Aug 20, 2014 at 9:56 AM, David Turner <dturner@twopensource.com> wrote:
> > On Tue, 2014-08-19 at 15:06 -0700, Junio C Hamano wrote:
> >> Reusing the GPG signature check helpers we already have, verify
> >> the signature in receive-pack and give the results to the hooks
> >> via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.
> >>
> >> Policy decisions, such as accepting or rejecting a good signature by
> >> a key that is not fully trusted, is left to the hook and kept
> >> outside of the core.
> >
> > If I understand correctly, the hook does not have enough information to
> > make this decision, because it is missing the date from the signature.
> 
> The full certificate is available to the hook so anything we can do the hook
> has enough information to do ;-)  But of course we should try to make it
> easier for the hook to validate the request.

Excellent, then motivated hooks can do the right thing.

> > This might allow an old signed push to be replayed, moving the head of a
> > branch to an older state (say, one lacking the latest security updates).
> 
> ... with old-sha1 recorded in the certificate?

That does prevent most replays, but it does not prevent resurrection of
a deleted branch by a replay of its initial creation (nor an undo of a
force-push to rollback).  So I think we still need timestamps, but
parsing them out of the cert is not terrible.
