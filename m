From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-p4: test t9820-git-p4-editor-handling.sh failing
Date: Tue, 19 May 2015 08:44:53 -0700
Message-ID: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
References: <555ADAF7.5020001@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 19 17:45:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YujhU-000784-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 17:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbbESPo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 11:44:56 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36553 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761AbbESPoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 11:44:55 -0400
Received: by igbpi8 with SMTP id pi8so79048017igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5DFxaEFLoJi0l8W41OnIj+HNah5nY7eMXx8VBv3tjVA=;
        b=BZfH1mdk2EVDQkgeIzWBmURKAU1DtICMaTQ/MJ5nG0R4TxOVQBD4SXtwrh4LQ9pLwK
         nZm/tW2Us5f8j3nKY26E9iXFq6n98dMNca9K69hLGR9Nd+ByCLCDW9R2kLCm+UFLa29G
         Tn6n2vJRN2aHxbmEt1jABJnD3UfdlzPW31jB0xfGPrS+D6E5m4rjzVG1j+v+AgOJdv+B
         6LJk8gKlErswoEXxHWx1nqB+mZl5W8HYU4eUltAtgEYDvVvqLOhlzI07GeGeEk7jOV94
         1SHncy4kkKkW08smg31yG+doFjOYIqlpS0uXd2LB/poZla6j40UNtPmQjMFAhC/4rpVd
         8tmw==
X-Received: by 10.43.63.76 with SMTP id xd12mr42128020icb.11.1432050295098;
        Tue, 19 May 2015 08:44:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id l30sm10249714iod.12.2015.05.19.08.44.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 08:44:54 -0700 (PDT)
In-Reply-To: <555ADAF7.5020001@diamand.org> (Luke Diamand's message of "Tue,
	19 May 2015 07:40:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269363>

Luke Diamand <luke@diamand.org> writes:

> The test I put in recently for multi-word editor handling in git-p4,
> t9820-git-p4-editor-handling.sh, has started failing.
>
> It looks like the reason is the change to it that goes:
>
> -	P4EDITOR="touch \"$git/touched\"" git p4 submit &&
> +	P4EDITOR=": >\"$git/touched\"" git p4 submit &&
>
> The problem is that git-p4 invokes $P4EDITOR passing it the name of
> the submit template. After it returns, it checks that the editor has
> actually updated the file's modification time.

Sorry, that was an unwarranted and unnecessary amend.  Didn't
realize that touch was trying to affect two files.

But "touch" is not quite right, either.

Unlike human sitting in front of keyboard, our fake editor types
very fast and wallclock time may not change between the time when
"git p4" prepares the file to be edited and the fake editor returns.

Is it really *only* the modification time that is checked?  If our
fake editor adds one blank line and return very fast without
changing the modification time, doesn't the caller notice that (and
if not, shouldn't it be fixed to do so [*1*])?

If you absolutely need to change the timestamp to work around the
caller if it only checks the timestamp and does not notice the size
or contents are different, then test-chmtime would be the right
thing to use in the test suite to do this portably, something like.

    P4EDITOR=": >\"$git/touched\" && test-chmtime +5"

perhaps.

Thanks.

[Footnote]

*1* Yeah, I just checked.  It does check only mtime and wants the
    editor to spend at least one second to edit, which is silly X-<.
