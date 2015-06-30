From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 06/10] bisect: don't mix option parsing and non-trivial code
Date: Tue, 30 Jun 2015 08:56:26 -0700
Message-ID: <xmqqk2ul8a1h.fsf@gitster.dls.corp.google.com>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435592435-27914-7-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqbnfy9s3v.fsf@gitster.dls.corp.google.com>
	<vpq7fqla06v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9xtl-0006jA-Bd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 17:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbF3P4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 11:56:32 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36641 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbF3P4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 11:56:31 -0400
Received: by igrv9 with SMTP id v9so54514692igr.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=laVIZogc9qt/U0uG+vSo4nk/qotTQx6890qObH0YBXU=;
        b=xIfHgl8B+7wd04QTFmjoNevaF/6SaRFInTp6lqOxTCo/Z06g1q9k7CsID55R4l1pNA
         i+pCyLrB++eZwVLmKvG/2c5iJje6fitg81x3DE3ZigFgmfiqe5nfQo+h5QV/iNydeg6B
         PZplt+wlMo5eJCGI+RP0c5gMuGcqmHDfgh4oPSaIPKbqMwqFfGs5Ho9ui93tB5M1VCd/
         s/GkpYEfRxggckt+tY5Kabb4EvAmotV1WS50GMN9YT75ROnMYyvpCm+NEALBJGukezKU
         kUxZIqbbetxyhCmLPZzKmEHknnVHRavD1s/3F2y8pZvr4iAqCplxDKRysNa+PRjOJPh9
         U0og==
X-Received: by 10.50.50.204 with SMTP id e12mr21666207igo.0.1435679790437;
        Tue, 30 Jun 2015 08:56:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id p196sm30270772iop.15.2015.06.30.08.56.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 08:56:29 -0700 (PDT)
In-Reply-To: <vpq7fqla06v.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	30 Jun 2015 13:46:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273071>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu, are you allowing your editor to corrupt the number of
>> lines in the hunk on the @@ ... @@ hunk header?  "diff" mode in
>> Emacs does that,
>
> Indeed. There's magic in Emac's diff-mode to keep the header up to date,
> but it seems totally buggy. I manually deleted a tab (no line added, no
> line removed) and it changed the number of lines in the header.

I'd hesitate to call it "totally buggy", but (without reading its
code, merely an observation of its behaviour from the outside) it
seems that this behaviour comes from the fact that its theory of
operation is fundamentally flawed.

If it trusted the the original @@ ... @@ hunk header line and then
adjusted the numbers as the user adds, deletes or modifies lines, we
wouldn't be seeing this problem.  Instead, it seems to totally
ignore the original number of lines recorded on the hunk header, and
counts what it deems to be part of the patch.

The thing is, when people edit a patch, they do not start from
scratch.  They somehow prepare a patch with a tool, and its output
is far more likely than not to record the correct number of lines on
the hunk header.  Not reading and trusting these numbers to see
where the original patch before it lets the user edit it, and
incorrectly including text outside the original patch in its own
count, is simply being silly.

Often, the last hunk of format-patch output has the "-- " signature
marker, which looks to Emacs as if the patch wants to delete a line
that has a dash and a space on it at the end.

> I see that you still managed to apply the series in pu, thanks and sorry
> for the inconvenience.

It's just the matter of realizing how it was corrupt and then
recounting the number of lines---a minor annoyance, not a big deal.

Thanks.
