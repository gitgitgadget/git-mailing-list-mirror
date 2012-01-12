From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] diff --word-diff: use non-whitespace regex by default
Date: Thu, 12 Jan 2012 08:52:49 +0800
Message-ID: <CALUzUxo3DcKqC6sQFQ1Oi0vgASFSHCcmOgHAj2_4c3vEjy663w@mail.gmail.com>
References: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
	<1326302702-4536-2-git-send-email-rctay89@gmail.com>
	<87lipexawp.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 12 01:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl8uV-0005Lx-Sq
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 01:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab2ALAwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 19:52:51 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:35823 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2ALAwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 19:52:50 -0500
Received: by werm1 with SMTP id m1so982672wer.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 16:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=B8k9hQNIow0b8OUGiiNX/w0sBsh5hLAj/aICnPCRdZU=;
        b=L8k0wNwFcQ5A9CMHXUwIeyWDTit7WCuNDVaJfQqIc7KJuHKcUuvTUSZSyEJrFWJOW/
         81PLzHu1UELtHDdBtco1yJeqDZsY+wLe6uY6puxN9cO7+3kkscKVJD7bmw6M3xsyKt3v
         71nCG/5yjeWWYi61fyQSFOkTIPwHUphazlPCQ=
Received: by 10.180.96.7 with SMTP id do7mr14870043wib.16.1326329569490; Wed,
 11 Jan 2012 16:52:49 -0800 (PST)
Received: by 10.223.92.135 with HTTP; Wed, 11 Jan 2012 16:52:49 -0800 (PST)
In-Reply-To: <87lipexawp.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188409>

Hi,

Thomas, first off, thanks for looking through this.

On Thu, Jan 12, 2012 at 4:05 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Factor out the comprehensive non-whitespace regex in use by PATTERNS=
 and
>> IPATTERN and use it as the word-diff regex for the default diff driv=
er.
>
> Why?
>
> I seem to recall that the motivation for keeping the original code as=
-is
> instead of just emulating its behavior with a default regex was that =
it
> is faster. =A0So disabling the default mode should at least have an
> advantage?
>
> </devils-advocate>

If you're talking about speed, yeah, that's probably true.

But I think it's worthwhile to trade-off performance for a sensible
default. Something like

  matrix[a,b,c]
  matrix[d,b,c]

gives

  matrix[[-a-]{+d+},b,c]

and when we have

  ImagineALanguageLikeFoo
  ImagineALanguageLikeBar

we get

  ImagineALanguageLike[-Foo-]{+Bar+}

(But I cheated. Foo and Bar have no common characters in common; if
they did, the word diff would be messy.)

Both of which seem sensible. From a usability/effectiveness
standpoint, I think it's more useful than what the current word-diff
defaults to - the whole line is taken as a "word", with the pre-image
shown as deleted and the post-image as added; we don't even try to run
LCS on it.

Examples are lifted from:
[1] http://article.gmane.org/gmane.comp.version-control.git/105896
[2] http://article.gmane.org/gmane.comp.version-control.git/105237

--=20
Cheers,
Ray Chuan
