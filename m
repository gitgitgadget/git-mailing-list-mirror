From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 20/20] transport-helper: implement marks location as
 capability
Date: Sun, 19 Jun 2011 20:29:37 -0500
Message-ID: <20110620012937.GB25836@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-21-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 03:29:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYTJF-0000mf-4F
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 03:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab1FTB3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 21:29:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54872 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab1FTB3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 21:29:43 -0400
Received: by iyb12 with SMTP id 12so1575643iyb.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 18:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=O3pDlay66R/KVM3QHEcy5JRbL6+iwF+DkqEw2/jxr9A=;
        b=QKHnb1sEjG+T4Cf+7f2XANusDlNSND8A4Owrhx7mY0PDCmGs2n88JFPjxSWxUc7Vk9
         0dFXU5XEirW5j7HTzpXqDc6E0A4zl0AjTZCKPmQZndwy8ecqH0/n1/i2PraHDe1k0GwS
         +J9B+mE/DamXQtdn3eELBMWtRy3wqOaMmwt1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qzq/u7CXplaO3tlVi36Y13y1YwEVaTuXL/cOj9/hhUGGzlcPn7LxvezwL9rAGFEDN0
         wmC4El/IgGFZv5OpxcIiXxKHhGspvjvHFxZwHteMlONGuxDHMvbYCILCjrFbnGNlqLQt
         fwIa/g/1Vb5kJc9CTJXGNaXXeMQl6fGFM9Ado=
Received: by 10.43.58.15 with SMTP id wi15mr5720075icb.411.1308533383263;
        Sun, 19 Jun 2011 18:29:43 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id d8sm5041382icy.9.2011.06.19.18.29.40
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 18:29:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308496725-22329-21-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176046>

Sverre Rabbelier wrote:

> [Subject: transport-helper: implement marks location as capability]
>
> While this requires the helper to flush stdout after listing 'gitdir'
> as capability, and read a command (the 'gitdir' response from the
> remote helper infrastructure) right after that, this is more elegant
> and does not require an ad-hoc exchange of values.

Probably I'm not thinking straight, but it's not obvious how the subject
connects to the content.  I suppose the pieces I'm missing are that:

 - this patch introduces new undocumented "import-marks" and
   "export-marks" capabilities that take a pathname as parameter;

 - for remote-testgit, that pathname is based on $GIT_DIR, so to
   retrieve that value we flush stdout and read the gitdir immediately
   rather than hoping the gitdir arrives on stdin in time for it to
   be used later.

But that still leaves a couple of other questions unanswered:

Why do we use a "gitdir" capability for this at all, instead of
exporting the GIT_DIR environment variable as Tomas has suggested?
(Not about this patch, but a separate patch explaining that in the
documentation would be nice.)

How does this interact with fast-import's --relative-marks feature
(if at all)?

[...]
> +++ b/transport-helper.c
[...]
> @@ -718,26 +728,6 @@ static int push_refs_with_export(struct transport *transport,
>  
>  	write_constant(helper->in, "export\n");
>  
> -	recvline(data, &buf);
> -	if (debug)
> -		fprintf(stderr, "Debug: Got export_marks '%s'\n", buf.buf);
> -	if (buf.len) {
> -		struct strbuf arg = STRBUF_INIT;
> -		strbuf_addstr(&arg, "--export-marks=");
> -		strbuf_addbuf(&arg, &buf);
> -		export_marks = strbuf_detach(&arg, NULL);
> -	}
> -
> -	recvline(data, &buf);
> -	if (debug)
> -		fprintf(stderr, "Debug: Got import_marks '%s'\n", buf.buf);

Hm, it seems there is a silent (but good) change in the behavior of
the "export" command, too.

Except where noted already, the patches look good, and the series
seems to make the remote helper infrastructure a little saner.
Thanks.
