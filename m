From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Wed, 21 Nov 2007 10:38:33 +0800
Message-ID: <46dff0320711201838g5affba6bo21a8c837b0bef681@mail.gmail.com>
References: <1195503174-29387-1-git-send-email-pkufranky@gmail.com>
	 <474308A5.8070301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 03:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IufUO-0001Z3-7j
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 03:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXKUCig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 21:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbXKUCig
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 21:38:36 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:42788 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXKUCif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 21:38:35 -0500
Received: by py-out-1112.google.com with SMTP id u77so6907436pyb
        for <git@vger.kernel.org>; Tue, 20 Nov 2007 18:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=leWjX2LjewvfatrkwRP2bAz+7CCHde5MUbzz3hhQRQo=;
        b=RSs/am5t/H5Vf167BLE81kzPOaKBNL0YwdhEwSQUJG6bKQ8GxheodTrlOsqEUMY5Fss7NkXTSWBOtjRR2QhkZo2p4J0kb0OQiRbB1SODrPss30P5n/bqjl0Nx7pur4MoJMQVZhYy49w6GB02/GqG73UppGuYXwFnVImx09OuIIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AhilZzBlgCWbY/YPlshyNv+eotnGUc7agXymUZzgePR0T6f4xLOisOM+o5DFrvADRB89m5mQMTWb1jIUtzrmvztTr3dfhsZ3HHGRXxQ6TrX3Ay6ExsLMoa4o4DwBHefGG1JPqnTPSpaKDhrYwqQs7M5kJ5CB71HXFPBi3SSFsUU=
Received: by 10.64.203.4 with SMTP id a4mr15690773qbg.1195612713490;
        Tue, 20 Nov 2007 18:38:33 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Tue, 20 Nov 2007 18:38:33 -0800 (PST)
In-Reply-To: <474308A5.8070301@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65585>

On Nov 21, 2007 12:17 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Ping Yin schrieb:
> > This patch disables the auto closing behavious of start_command
> > and corrects all codes which depend on this kind of behaviour.
>
> I've thought about this a bit more, and I think that it is better to leave
> this auto-closing behavior unchanged and change your usage of this feature,
> like so:
>
> > +static void wt_status_print_submodule_summary(struct wt_status *s)
> > +{
> > +       struct child_process sm_summary;
> > +       memset(&sm_summary, 0, sizeof(sm_summary));
> > +       ...
> > +       sm_summary.out = fileno(s->fp);
>
>         fflush(s->fp);
>         sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
>
> > +       ...
> > +       run_command(&sm_summary);
> > +}
>
> This way the change is more local without affecting well-tested other callers.
>

This way works, but it is a tricky one, not a natural or graceful one.

> Furthermore, I don't think that it's correct to just set the .close_in or
> .close_out flags. This will close the fd only in finish_command(), which can
> be too late: Think again of a writable pipe end that remains open and keeps
> the reader waiting for input that is not going to happen.

This may happen. However, i have scanned all the git codes using the
auto closing behaviour and i don't discover the problem you mentioned.
So i think it deserves to correct the misbehaviour after carefully
testing. And we can make a clarification for that if necessary.

>
> -- Hannes
>
>



-- 
Ping Yin
