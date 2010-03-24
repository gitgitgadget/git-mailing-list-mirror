From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] http-backend: Don't infinite loop during die()
Date: Wed, 24 Mar 2010 13:06:58 -0700
Message-ID: <20100324200658.GA22505@spearce.org>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org> <20100322142204.GB8916@spearce.org> <7vvdclk1y9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brady Catherman <brady@catherman.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:07:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuWr7-00008I-OM
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab0CXUHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 16:07:03 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:35325 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545Ab0CXUHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 16:07:01 -0400
Received: by pxi36 with SMTP id 36so2606422pxi.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:07:01 -0700 (PDT)
Received: by 10.141.187.12 with SMTP id o12mr514204rvp.43.1269461220747;
        Wed, 24 Mar 2010 13:07:00 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm299424iwn.5.2010.03.24.13.06.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 13:06:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvdclk1y9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143113>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > If stdout has already been closed by the CGI and die() gets called,
> > the CGI will fail to write the "Status: 500 Internal Server Error" to
> > the pipe, which results in die() being called again (via safe_write).
> > This goes on in an infinite loop until the stack overflows and the
> > process is killed by SIGSEGV.
> >
> > Instead set a flag on the first die() invocation and perform no
> > action during recursive die() calls.  This way failures to write the
> > error messages to the stdout pipe do not result in an infinite loop.
> 
> Hmm.  I would need something like this on top, but there must be a better
> way.  Ideas?

Ick.

Just exit(0) if dead is true.  The *only* reason we would come back
into the die handler at this point is because we failed during the
die handler.  That recursive failure means we can't report the
errors, because that's all that was left once the dead variable
was set.

-- 
Shawn.
