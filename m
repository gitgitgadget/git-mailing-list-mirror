From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Wed, 18 Jul 2012 13:47:23 +0100
Message-ID: <20120718124723.GA17379@beczulka>
References: <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka>
 <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net>
 <20120711214019.GF30213@beczulka>
 <7vmx35dhzo.fsf@alter.siamese.dyndns.org>
 <20120718074908.GA23460@beczulka>
 <20120718112722.GA22042@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTfD-0001KD-Hf
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab2GRMrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:47:31 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57877 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab2GRMr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:47:29 -0400
Received: by wibhm11 with SMTP id hm11so4735994wib.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 05:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=92IfJAB/4j9THcNlP48SjNCd+i9bkDEX06Y51jcXCbs=;
        b=N9lKtS8ICl7hCrMQXPoOes5RbjK+vO/0s9eNWRrg5/wTe57uzfyzoH4eSLqKtCFuJL
         zHIi7L4kiYDaQyuoChJU3u9zEMzYUnFbGnCHI1Zp6CQy1XYCRG09ejdBx/ICP789/PoA
         jZcBR/8wqvCuST+zSBlVMoHdG6TiQdkR9nK1ZOU3HbcO0x+nJSfy8x1NVrK4AmRE4rDX
         tmB0P70TTszaaK8UK6YaJiWHQSUCQBI6uiKUE4CrriASI/PW9QhLlIekRn71DNZt8TWO
         ZTFGb3yTFgYm271R9r2cD7c9aVEsuiUfN7eiChXGxKlr2CH4jf1c1TcGiPFIiHJcYK8A
         GY9w==
Received: by 10.180.81.193 with SMTP id c1mr6303288wiy.12.1342615647644;
        Wed, 18 Jul 2012 05:47:27 -0700 (PDT)
Received: from beczulka (dhcp-172-26-143-156.dub.corp.google.com [172.26.143.156])
        by mx.google.com with ESMTPS id ep14sm33233161wid.0.2012.07.18.05.47.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 05:47:26 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1SrTf1-0000H8-CY; Wed, 18 Jul 2012 13:47:23 +0100
Content-Disposition: inline
In-Reply-To: <20120718112722.GA22042@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQmWMVNVmPjwuPBaU+W6ExxJJZv6MeShFnjHbzHHYiMOMuhk6M3owLwuFb6hrE3Kg6L5rlZk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201687>

On Wed, Jul 18, 2012 at 11:27:22AM +0000, Eric Wong wrote:
> Marcin Owsiany <marcin@owsiany.pl> wrote:
> > On Wed, Jul 11, 2012 at 03:56:43PM -0700, Junio C Hamano wrote:
> > > If the caller does not handle errors, it could be even clearer to
> > > write it like
> > > 
> > > 	command_noisy(qw(update-ref HEAD), $gs->refname) ||
> > > 		die "Cannot update HEAD!!!";
> > 
> > Turns out that command_noisy()
> >  - has a meaningless return value
> >  - throws an exception on command failure
> > so the "||" bit does not work.
> > Also, for some reason command_noisy does not check for the command being
> > killed by a signal, so I'd prefer to leave the verify_ref there.
> 
> Ugh, I always forget the Git.pm API, too.  Perhaps command_noisy should
> be made to respect signals in exit codes (the rest of git-svn is
> compromised by this behavior in command_noisy, too, it turns out... :x)
> 
> I'm not sure what else would break if command_noisy were changed,
> git-svn appears to be the only user in git.git.

Other "command" flavours should probably also be changed to match?

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
