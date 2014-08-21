From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 16/18] receive-pack: GPG-validate push certificates
Date: Thu, 21 Aug 2014 19:59:01 -0400
Organization: Twitter
Message-ID: <1408665541.1282.12.camel@leckie>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	 <1408485987-3590-17-git-send-email-gitster@pobox.com>
	 <1408553797.26173.3.camel@leckie>
	 <CAPc5daXLBQdjPaWNxmwZqStiWu8qHRfDG6=JS=bhbzA+c5Ww5g@mail.gmail.com>
	 <1408557408.1282.5.camel@leckie>
	 <xmqqr40bt0i0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:59:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKcG8-0006rc-Vw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 01:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbaHUX7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 19:59:08 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:49880 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaHUX7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 19:59:07 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so8823754qaq.25
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 16:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vH6orXRXg4De7jFjH8dLM3YX60IIgz+SAF2hG2f8nGI=;
        b=co5sEMXajtSjo3Ij2kE+nPq6MC3Ub63x6NuDuoG4uKaEIXtTo0ZYeuOm8HSXpoKjDr
         PbHIvdV6QklW5u3tFX3l0aCB4tibKZGHKIpcs8DE1do7YzdaB7lZC0jnsL/FsHW7JTof
         9xnPfwq/KkBUFapJN3e0gwPVOh2GD3O3sVYJnGFA/CDDrMcCVykYSRmO5bD0UXtDfQ73
         CLYmIkTfnXj416cFSJB+6fUkLwzVT8SeM5QtVk7KogbCvDypkRhjBy+KuaZxCQlofiNW
         7jb+bqKuE3DxOmgWWKvoFucYc5Z+4wNNFaGq5Hx0p4m2flroI4fUokzzS5c5J35oF/OU
         3jvw==
X-Gm-Message-State: ALoCoQlQuTGTK7m82lHD3NhCWPt0BF4IgjZuCPxd4sHrMHexHal0Osr+Th6SXOW1t1FVc2ppRIrU
X-Received: by 10.224.22.134 with SMTP id n6mr2555326qab.27.1408665545743;
        Thu, 21 Aug 2014 16:59:05 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id 10sm49711017qal.39.2014.08.21.16.59.04
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 21 Aug 2014 16:59:05 -0700 (PDT)
In-Reply-To: <xmqqr40bt0i0.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255648>

On Wed, 2014-08-20 at 12:38 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Wed, 2014-08-20 at 10:29 -0700, Junio C Hamano wrote:
> >> On Wed, Aug 20, 2014 at 9:56 AM, David Turner <dturner@twopensource.com> wrote:
> >> > On Tue, 2014-08-19 at 15:06 -0700, Junio C Hamano wrote:
> >> >> Reusing the GPG signature check helpers we already have, verify
> >> >> the signature in receive-pack and give the results to the hooks
> >> >> via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.
> >> >>
> >> >> Policy decisions, such as accepting or rejecting a good signature by
> >> >> a key that is not fully trusted, is left to the hook and kept
> >> >> outside of the core.
> >> >
> >> > If I understand correctly, the hook does not have enough information to
> >> > make this decision, because it is missing the date from the signature.
> >> 
> >> The full certificate is available to the hook so anything we can do the hook
> >> has enough information to do ;-)  But of course we should try to make it
> >> easier for the hook to validate the request.
> >
> > Excellent, then motivated hooks can do the right thing.
> >
> >> > This might allow an old signed push to be replayed, moving the head of a
> >> > branch to an older state (say, one lacking the latest security updates).
> >> 
> >> ... with old-sha1 recorded in the certificate?
> >
> > That does prevent most replays, but it does not prevent resurrection of
> > a deleted branch by a replay of its initial creation (nor an undo of a
> > force-push to rollback).  So I think we still need timestamps, but
> > parsing them out of the cert is not terrible.
> 
> As I aleady mentioned elsewhere, a more problematic thing about the
> push certificate as presented in 15/18 is that it does not say
> anything about where the push is going.  If you can capture a trial
> push to some random test repository I do with my signed push
> certificate, you could replay it to my public repository hosted at
> a more official site (say, k.org in the far distant future where it
> does not rely on ssh authentication to protect their services but
> uses the GPG signature on the push certificate to make sure it is I
> who is pushing).
> 
> We can add a new "pushed-to <repository URL>" header line to the
> certificate, next to "pushed-by <ident> <time>", and have the
> receiving end verify that it matches to prevent such a replay.  I
> wonder if we can further extend it to avoid replays to the same
> repository.

I think but am not certain that pushed-to <repository URL>, along with
the pushed-by <ident> <time> means that the nonce is not needed. The
nonce might make replays harder, but pushed-to/pushed-by makes replays
useless since the receiving server can determine that the user intended
to take this action at this time on this server. 
