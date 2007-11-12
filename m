From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Mon, 12 Nov 2007 20:52:36 +1100
Message-ID: <ee77f5c20711120152i4955ed3bh484c9ac76a7f1f5c@mail.gmail.com>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>
	 <47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se>
	 <7v6409f4eh.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com>
	 <473818FA.1060400@viscovery.net>
	 <ee77f5c20711120124m6281fddfs9403a46cf354b993@mail.gmail.com>
	 <473821CE.8050907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVyP-0002bY-Ai
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258AbXKLJwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbXKLJwi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:52:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:59796 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbXKLJwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:52:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1126305rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 01:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4+9GqQ2QAAg7YVdjStRTEy5jbYDZYNfYsEITsRewiSY=;
        b=TBwGlRMZ0fWad5JimJBaAhxdtun9ucWDfjjJNMYRIAKWDpFbrnSe8XA9+dGQHgHddoLpTYBCQR+1sEiuNXurB/FTzNT6AlZbJYwly3XPXJSxfWYO2YnES1ScJQBfOxe8qd/pgm4BlJx0z5CBcT5txrn6/1xD684b3qv0PLB7OGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iHeK9IraKxW2Gjte3snnmndrddrUo677EB4hUScPEj24OYXJoANkuwx46GU5dWPno21kr6PKDcRs2ScyBtHzuoQlCbs97pD/mDNxxaLiYAnVU3vpsgkAngxrs1R/laFLD+7MAG51cGlP4SdeBM2DSG773JH+WnOqvn8+o39g7og=
Received: by 10.140.163.3 with SMTP id l3mr2270735rve.1194861156186;
        Mon, 12 Nov 2007 01:52:36 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Mon, 12 Nov 2007 01:52:36 -0800 (PST)
In-Reply-To: <473821CE.8050907@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64586>

On Nov 12, 2007 8:50 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> David Symonds schrieb:
> > On Nov 12, 2007 8:12 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> >> David Symonds schrieb:
> >>> I don't think I have __GLIBC_PREREQ defined anywhere I can find.
> >> Turn the && in that line into || and it should work.
> >
> > Nope, no dice. Plus, that'd change the logic. I also tried turning the
> > (!X && !Y) into (X || Y) to no avail.
>
> Ok, then how about this?
>
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 3d147b6..276a437 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -184,7 +184,13 @@ void *gitmemmem(const void *haystack,
>                   const void *needle, size_t needlelen);
>   #endif
>
> -#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
> +#ifdef __GLIBC_PREREQ
> +#if __GLIBC_PREREQ(2, 1)
> +#define HAVE_STRCHRNUL
> +#endif
> +#endif
> +
> +#ifndef HAVE_STRCHRNUL
>
>   #define strchrnul gitstrchrnul
>   static inline char *gitstrchrnul(const char *s, int c)
>   {

Yep, that works just fine. Ack.


Dave.
