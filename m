From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] receive-pack: GPG-validate push certificates
Date: Wed, 20 Aug 2014 10:29:04 -0700
Message-ID: <CAPc5daXLBQdjPaWNxmwZqStiWu8qHRfDG6=JS=bhbzA+c5Ww5g@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <1408485987-3590-17-git-send-email-gitster@pobox.com> <1408553797.26173.3.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK9hT-0001C8-3l
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 19:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbaHTR31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 13:29:27 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:55188 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaHTR30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 13:29:26 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so7422883lab.26
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4FPCoXlqTytPLph8PS3hgUTuESlscpWl8ADhHSpJ9dw=;
        b=hKjFZWG9pUiNhNEM3sVPgHUZmtW2hRZezViR2Qo8eQvhtUzjtszwkVy2nZbT8DbuOS
         C04Scv3UiAPKMUIl+qhyCZmMJEMVQShiUQU+np1/g+oH0SfBUT9itPD6uv7fQmWZgGRr
         /V8LJ6SaPyaORNMZI87N+ahMbR3c94eMFCESr/saHabbXH0/dzus13JbmuBS8M5Y+7kR
         M4gQdSlZvOJ8640SAP35fHa6mK0RkRgibw/ROQqU1w+MCHzrjuqwYStPuyiVzVg6HGJ2
         LGAFHLs0cDN4xXk5XPDkqw/YaCIy9kwl0q0QlGTxYdA+8x4qI4Tr4wYgA82mXp0rzJOs
         mhdQ==
X-Received: by 10.112.160.38 with SMTP id xh6mr41856326lbb.21.1408555764393;
 Wed, 20 Aug 2014 10:29:24 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Wed, 20 Aug 2014 10:29:04 -0700 (PDT)
In-Reply-To: <1408553797.26173.3.camel@leckie>
X-Google-Sender-Auth: angHU6Si_4w1Yssdsyj-oEEwpzM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255575>

On Wed, Aug 20, 2014 at 9:56 AM, David Turner <dturner@twopensource.com> wrote:
> On Tue, 2014-08-19 at 15:06 -0700, Junio C Hamano wrote:
>> Reusing the GPG signature check helpers we already have, verify
>> the signature in receive-pack and give the results to the hooks
>> via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.
>>
>> Policy decisions, such as accepting or rejecting a good signature by
>> a key that is not fully trusted, is left to the hook and kept
>> outside of the core.
>
> If I understand correctly, the hook does not have enough information to
> make this decision, because it is missing the date from the signature.

The full certificate is available to the hook so anything we can do the hook
has enough information to do ;-)  But of course we should try to make it
easier for the hook to validate the request.

I am not opposed to extract the timestamp from pushed-by header in the cert
and export it in another environment before calling the hook, but I am not sure
it is worth it, as that is already a single liner text information.

> This might allow an old signed push to be replayed, moving the head of a
> branch to an older state (say, one lacking the latest security updates).

... with old-sha1 recorded in the certificate?
