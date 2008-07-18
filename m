From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Fri, 18 Jul 2008 09:59:02 +0400
Message-ID: <20080718055902.GI2925@dpotapov.dyndns.org>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com> <7vod5mpmp7.fsf@gitster.siamese.dyndns.org> <20080627223107.GH5737@dpotapov.dyndns.org> <20080718002620.GE8421@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 08:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJj0k-0004gI-SN
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 08:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYGRF7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbYGRF7K
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:59:10 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:48789 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbYGRF7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:59:09 -0400
Received: by mu-out-0910.google.com with SMTP id w8so293065mue.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eJ2qzNjhC67KfIQW6NVNQV4t0LC7XQ+gmNjauLUWl18=;
        b=sQAvEL4MYm0dmSNE+6JYsdwg+kWgCzZA5ZY2ONRCymutWTVHwKjJPpiZzr3gkJSntc
         IakSnzBV6IqUlUiP2xgdcHZZhR95BAqrskkrGOk8w/gmnCKQ84J6yAJfNeadQz91Hora
         s25YEUp6XIyEtxuLuSzonxjy/hubHcrcx60eI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z93W9b248GipEmRUwAS/TvGjSdXBf9WepWYZmaiSgKKFNBcKzwGnjnvN0Mx17r8Hqa
         5CX72l2uiB0JXi0GTTlMaRxA5nFY5NmVMpn9rW5T7aPDrP77VKJFLaI+uuDTPE84FHoZ
         QBpz0jgDOVkrrURopp0MUHpNtlDCtfHsxv/qQ=
Received: by 10.103.221.13 with SMTP id y13mr2625400muq.41.1216360746750;
        Thu, 17 Jul 2008 22:59:06 -0700 (PDT)
Received: from localhost ( [85.140.168.212])
        by mx.google.com with ESMTPS id j2sm18301630mue.8.2008.07.17.22.59.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 22:59:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080718002620.GE8421@leksak.fem-net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88991>

On Fri, Jul 18, 2008 at 02:26:20AM +0200, Stephan Beyer wrote:
> 
> Dmitry Potapov wrote:
> > diff --git a/shell.c b/shell.c
> > index b27d01c..91ca7de 100644
> > --- a/shell.c
> > +++ b/shell.c
> > @@ -3,6 +3,14 @@
> >  #include "exec_cmd.h"
> >  #include "strbuf.h"
> >  
> > +/* Stubs for functions that make no sense for git-shell. These stubs
> > + * are provided here to avoid linking in external redundant modules.
> > + */
> > +void release_pack_memory(size_t need, int fd){}
> > +void trace_argv_printf(const char **argv, const char *fmt, ...){}
> > +void trace_printf(const char *fmt, ...){}
> > +
> > +
> 
> I don't really understand why this works.
> You redefine libgit.a functions here
> 
> So the linker should complain like that:
> 	libgit.a(sha1_file.o): In function `release_pack_memory':
> 	/home/sbeyer/src/git/sha1_file.c:624: multiple definition of `release_pack_memory'
> 	shell.o:/home/sbeyer/src/git/shell.c:9: first defined here
> 	collect2: ld returned 1 exit status
> 
> And, in fact, it does when I move a function from a builtin to a lib
> source file, for example launch_editor() from builtin-tag.c to strbuf.c,
> like the following one:

It works because these functions are defined in object files, so the
linker should not search for them in libraries. However, if the linker
is forced to link sha1_file.c for some other reason, you will get the
conflict.

Dmitry
