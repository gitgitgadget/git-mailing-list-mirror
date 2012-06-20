From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Tue, 19 Jun 2012 22:50:15 -0500
Message-ID: <20120620035015.GA4213@burratino>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 05:50:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShBw5-0003ob-FO
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 05:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab2FTDuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 23:50:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64017 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab2FTDuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 23:50:24 -0400
Received: by yhmm54 with SMTP id m54so5459465yhm.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 20:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8/EHY3y6uIfjgnP/A9ItQUoihNIfSG/IuTWH0BajZ7w=;
        b=yyOuQFB9Pwwl7MtmXgnHdr1srTUv7uP34fP0be0p0/9tvg/2hbWHYnHVin95SAme22
         DV4tnNkbGoBD/mVYIvDCd/p1CIbNV6TrmwQay9CB7m8FUvykXuM+16Zuks/zDYzobKQr
         xKUaX6OoMQ+WcShDnyql8wSe07r/Nd0DJ3yRG4UHSBb3e6WmGTYQfzl4GrQZTfDUFOzc
         Qf4dh8WuNcBjeeFKu+WZLVzwBMVd7Giw6lZBwggyY1kDAZcXbGgYLtackF+zMQ4vtrZg
         7G33CSFtpXzK1m1v2HMm56555cEk+cPhRsi+qo/bXNdUnKgsJ2WlI86HZ87n8Blk06dz
         YNbA==
Received: by 10.50.217.137 with SMTP id oy9mr3230099igc.56.1340164222642;
        Tue, 19 Jun 2012 20:50:22 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id y5sm25169667igb.11.2012.06.19.20.50.21
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 20:50:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120619232310.GA6496@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200284>

Hi,

Jeff King wrote:

> When a C file includes a header file or depends on a
> command-line "-D" macro, we note it in the Makefile like:
>
>   git.o: common-cmds.h
>
> However, other targets built from the C file should also
> know about this dependency (in particular, .sp and .s files
> that are not part of the usual build process). We sometimes
> noted these and sometimes not; let's make sure they are
> always included.

First reactions:

This improves consistency.  Yay!

Making .sp and .s targets depend on generated .h files like
common-cmds.h is very important.  Otherwise, I would not be able to
generate my git.s assembler listing or sparse-check git.c unless
common-cmds.h has already been generated as a side-effect of some
earlier build process.

On the other hand, making .sp and .s targets depend on preexisting .h
files and files like GIT-CFLAGS would not have any effect at all,
because:

 - .sp targets are phony --- there is no stamp file that certifies
   a given file has been checked by a "make sparse" run.  Maybe that
   will change some day.

 - .s targets are rebuilt every time.  Maybe I am just weird, but I
   find myself upgrading my compiler pretty often, so when I manually
   ask for an assembler listing I am happy to see it regenerated
   unconditionally using the new code generation rules.

It turns out that this patch is only about common-cmds.h, which was
the straightforward case.  Why not say so and save the reader from
having to think so hard? ;)

Hope that helps,
Jonathan
