From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 1/2] Implement parsing for new core.whitespace.* options.
Date: Sat, 3 Nov 2007 13:35:35 +1100
Message-ID: <ee77f5c20711021935u16fe0eb2n202dfca3fc220e2d@mail.gmail.com>
References: <11940160932021-git-send-email-dsymonds@gmail.com>
	 <7v3avo2z6x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Andreas Ericsson" <ae@op5.se>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 03:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io8ra-0003YL-Ro
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 03:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbXKCCfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 22:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbXKCCfh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 22:35:37 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:6117 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbXKCCfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 22:35:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so949901rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ug8CF+D0st1n1jVx/PqDiyRwLmQdmMRToqjKr1ymrT8=;
        b=g7Sqka41+YKYFw7MBdOW67p5BEyRbE2KeHxFLaaUDS3qZGMPT9n+DpgH8rkrmZiewxTeHREHFwNmLzb/w7gEKJ2ZOqqOXu6v72h2ss5hXjGYDouOOdtj0Bf0+wqS6c5rWQAQksaAcq7rYwsYmVBPW9RpiATn6slT/DLhODGFpuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IPdmtMLBE1UI5e6E4f3Wb3yh8lgOvIs8zMLXikmZxjtIRHyASHepBu6I1agtJupM9Z8fA/C7ULfc0aYyJZsk9kdYgwx9OHSLxluoCWPkh3smRS0S0KGObUUPGk53uxu0JplWWgkot5KQmswqez0U0G3Y+UKunU0HrKVGgbdM1H4=
Received: by 10.141.79.12 with SMTP id g12mr1239913rvl.1194057335889;
        Fri, 02 Nov 2007 19:35:35 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 19:35:35 -0700 (PDT)
In-Reply-To: <7v3avo2z6x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63199>

On 11/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> David Symonds <dsymonds@gmail.com> writes:
>
> > Each of the new core.whitespace.* options (enumerated below) can be set to one
> > of:
> >       * okay (default): Whitespace of this type is okay
> >       * warn: Whitespace of this type should be warned about
> >       * error: Whitespace of this type should raise an error
> >       * autofix: Whitespace of this type should be automatically fixed
>
> Many problems at the conceptual level (I haven't look at the
> patch yet).

Sure, I thought there might be. I'm still finding my way around the git code.

> We call these options (nowarn,warn,error,strip) in
> apply.whitespace.  "strip" is a bit of misnomer, as we only
> handled the trailing whitespace initially.  We should add "fix"
> as a synonym to "strip".

I can whip that up in a separate patch if you'd like. However, it
still doesn't allow for different handling of the different whitespace
errors, does it?

> The intention is to define what is an anomaly with
> core.whitespace and then define what to do with it with
> apply.whitespace.

That seems a little counterintuitive to be splitting like that. For
overriding, a simple environment variable like GIT_EXTRA_CONFIG (or
whatever) could pass in arbitrary one-shot configuration parameters,
which seems like a better (more general) solution.

> Adding the "error" and "fix" to "diff" is a mistake --- there is
> no error condition nor fixing there.  That shows how the
> approach of your patch is inappropriate by trying to mix what
> core.whitespace (give the definition of what is an error) and
> apply.whitespace (specify what to do with an error) are designed
> to do.

Yes, I agree that there's no place for "error" or "fix" in git-diff;
that was the reason for me resending the series, because I adjusted
the diff warnings to happen whenever the relevant setting was anything
but "okay", with the idea being that any incorrect whitespace should
be flagged in git-diff, and there's a natural split between "okay" and
"warn"/"error"/"fix".

> Defaulting to "nowarn" is wrong.  Trailing whitespace errors and
> space before tab errors should be turned on by default as
> before.

Yes, you're correct. That's easy to fix.


Dave.
