From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Thu, 29 Nov 2007 00:24:46 +0700
Message-ID: <fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
References: <20071128165837.GA5903@laptop>
	 <Pine.LNX.4.64.0711281703470.27959@racer.site>
	 <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
	 <Pine.LNX.4.64.0711281717460.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQnI-0008Cc-DJ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761634AbXK1RYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 12:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761631AbXK1RYt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:24:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:20481 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761593AbXK1RYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:24:48 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1477883nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=d6aSGNc4jjz7RuVQSZYJmOsuKDJtgPDU3nZjDzsqccs=;
        b=pAZnDSGQC68yHez6RG+DxBV3njZA567ZnhpvbM2oBhKX48Iv+5KqMaA2YxY4rUu3pNo04eTuTtCcKlf9OTpEplnjuCBZj6UUUrjsyxk/WANyswyaPgRp8TKlVhS164RHlD5P2ccnwwsidBxRvT85726vh/l3IMBGzJzwBrE8BUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X4BmT4lYbCLD6fWjjFxVC7xvm7s7jGaOR0AcuFOzAbgddLhmoN8snqzhwkE5SW21ksKbFaLZEhr4SO9gt7Qdrl/fuftae8b86ISyMGBlKsRLl8rpJZeCuNKYli6lx2ezjdiHaUfLYlS5pQAEfF1LDQ6a4+H+cnQzRpkoJuUMzxQ=
Received: by 10.86.1.1 with SMTP id 1mr5187679fga.1196270686577;
        Wed, 28 Nov 2007 09:24:46 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 28 Nov 2007 09:24:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711281717460.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66392>

On Nov 29, 2007 12:18 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 29 Nov 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On Nov 29, 2007 12:05 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Wed, 28 Nov 2007, Nguyen Thai Ngoc Duy wrote:
> > >
> > > > @@ -246,8 +246,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
> > > >                       static char buffer[1024 + 1];
> > > >                       const char *retval;
> > > >
> > > > -                     if (!work_tree_env)
> > > > -                             return set_work_tree(gitdirenv);
> > > > +                     if (!work_tree_env) {
> > > > +                             retval = set_work_tree(gitdirenv);
> > > > +                             /* config may override worktree */
> > > > +                             check_repository_format();
> > > > +                             return retval;
> > > > +                     }
> > > > +                     check_repository_format();
> > >
> > > Why not move this check before the if?  Other than that, ACK.
> >
> > If so it would be called twice if work_tree_env is not set.
>
> Well, I would have left the original
>
>                         if (!work_tree_env)
>                                 return set_work_tree(gitdirenv);
>
> alone...
>
> If that is not possible, it might be good to add a comment as to why.

I did, and the tests failed. I also added a comment "config may
override worktree". set_work_tree() will reset git_work_tree_cfg but
the correct behaviour is config takes precedence (from comment of
set_work_tree). The comment is clearly not clear enough. Maybe this?

+                     if (!work_tree_env) {
+                             retval = set_work_tree(gitdirenv);
+                             /* config may override worktree (see
set_work_tree comment) */
+                             check_repository_format();
+                             return retval;
+                     }

> Ciao,
> Dscho
>
>



-- 
Duy
