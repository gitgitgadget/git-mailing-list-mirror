From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: version 2.4 seems to have broken `git clone --progress`
Date: Mon, 11 May 2015 19:04:20 -0700
Message-ID: <xmqqfv721rh7.fsf@gitster.dls.corp.google.com>
References: <CA+6di1=Qvp3oaw0moMg8XMFd5vgc0v1L0CC2ppEDOF8QA9N6Mg@mail.gmail.com>
	<xmqq8ucu3jug.fsf@gitster.dls.corp.google.com>
	<20150512002242.GA8523@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jack O'Connor <oconnor663@gmail.com>, git <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 12 04:04:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrzYa-00078F-SX
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 04:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbbELCEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 22:04:24 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35013 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbELCEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 22:04:23 -0400
Received: by ieczm2 with SMTP id zm2so124467668iec.2
        for <git@vger.kernel.org>; Mon, 11 May 2015 19:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hrOAfNWpX/pCI6zfdjeX4EykBt9/yrBi5TmmAg/yU5k=;
        b=OS4OMtnkDP4nrb2m0zx1mkqDiZUc5/TyjjVq6O2X4gCxMWbbfz/tH1huwJPsvsy8UV
         7W2upe0TZvrwvYXciUrRU5mU4EcXIYThh1UZqP7zeR2hV0j8WnZp7Z0mrrVarQ/2UdmS
         /ST0FyM2vnsYykNvNjjcUvpT1UE7IjRI3ChjGT15fPwJM6z1pI41rZPEiKZLn0fbUIUF
         cafjp9uyncWuI04JElTrEK9xRoETNAH+RweipO+omxtZGizAi9Ig9UpRsTvN9V8icE9D
         0FvDebPslOXfNNnZEHA1FI+ADN3RcItYJUkiDjIBxkPtRmok2ZcvloW7BFj4vPP/6iWV
         Vhtg==
X-Received: by 10.43.40.130 with SMTP id tq2mr533655icb.46.1431396262872;
        Mon, 11 May 2015 19:04:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id k16sm311513igf.19.2015.05.11.19.04.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 19:04:21 -0700 (PDT)
In-Reply-To: <20150512002242.GA8523@glandium.org> (Mike Hommey's message of
	"Tue, 12 May 2015 09:22:42 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268836>

Mike Hommey <mh@glandium.org> writes:

> So, the reason this is happening is that 2879bc3 moved sending the
> progress helper option earlier, and for clone, it's early enough that
> transport_set_verbosity happens afterwards. Since
> transport_set_verbosity only sets the progress bit, and nothing re-emits
> a helper option command when it changes, we're left with the default,
> which is that no progress is shown if the output file descripto is not
> a tty.
>
> I can see two ways to fix this:
> - Make transport_set_verbosity call transport->set_option instead of
>   defering to standard_options() in transport-helper.c.
> - Declare that transport_set_verbosity must be used before any other
>   transport_set_option, and change clone to invoke it first. Note that
>   fetch and push already do that, so this is only currently a problem
>   for clone.
>
> Junio, what do you think?

The latter sounds like more appropriate as a lower-impact short-term
fix, so let's have that for now.

I however wonder if there are other settings that can be flipped
after we started talking to the helper to cause a similar issue,
and to prevent such breakages once and for all, we may have to
take the former route in the longer term.  But I think that can be
done later after the dust settles.

Thanks for a quick diagnosis.
