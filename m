From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] reset: Libify reset_index_file and print_new_head_line
Date: Fri, 10 Jun 2011 05:35:32 -0500
Message-ID: <20110610103532.GA32119@elie>
References: <1307546728-11202-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 12:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUz49-0005jG-NM
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 12:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab1FJKfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 06:35:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54876 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab1FJKfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 06:35:43 -0400
Received: by iyb14 with SMTP id 14so2054112iyb.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0IRWYXEbPc0w4M/N5SKgH5U1LLNeGZ14IoesWUUyUV0=;
        b=EbVsISfsEHVjMpPCEjk2pf8EFGq1eVtH2ynZqNE/FbzijC1wipVo4hADqEZXy2gyFj
         80f6o47sfJKuHLf90rdnFjCdgNUnOAB+uDCv3t0bxDKXhoU9qpV/IrINk+0+XlJKvmCx
         ngttwGPSXTaNeDKHYZpsacADm0T928YbfQ9mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jhvhh4gtAAebJB+I/a7w+xNMdDTOD8Oct3BBdwTrTxPjb7Ge50eg+JkFVLpbb2cINk
         1wiNfKRh3OKQcjHrlHsdpwuOGdLv1ofg14cjvbY4xATPhgQk/kukSL3lUrrShanzFJu1
         JzBJU2onHBrn0a6zwJNOsjKRPbqsS99LMEmlk=
Received: by 10.42.228.68 with SMTP id jd4mr2325167icb.142.1307702142055;
        Fri, 10 Jun 2011 03:35:42 -0700 (PDT)
Received: from elie (adsl-68-255-107-108.dsl.chcgil.ameritech.net [68.255.107.108])
        by mx.google.com with ESMTPS id vn4sm2132342icb.19.2011.06.10.03.35.38
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 03:35:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307546728-11202-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175602>

Hi Ram,

Ramkumar Ramachandra wrote:

>  This patch lays the foundation for libifying reset by starting with
>  two "easy" methods.  I'll be using print_new_head_line in the
>  sequencer series while implementing --abort.

It should be easier to review this one with a caller in mind to give
an indication about whether the API is right.  More generally, the
excitement of patches exposing new library code comes when you can see
the header with a pleasant API, ideally followed by an example or two
to see how it plays out in practice.  See "git log --grep=API junio/pu"
for a few recent examples of this.

> --- /dev/null
> +++ b/reset.c
> @@ -0,0 +1,81 @@
> +#include "builtin.h"
> +#include "refs.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "tree.h"
> +#include "branch.h"
> +#include "tree.h"
> +#include "unpack-trees.h"
> +#include "reset.h"

Are these all needed?  E.g., where is diffcore used?

> --- /dev/null
> +++ b/reset.h
> @@ -0,0 +1,11 @@
> +#ifndef RESET_H
> +#define RESET_H
> +
> +#include "commit.h"

We can avoid unnecessarily rebuilding (if COMPUTE_HEADER_DEPENDENCIES
is set) for callers that do not use commit.h when commit.h changes by
just declaring

	struct commit;

Leaving out the declaration altogether would _almost_ work but the
declaration is needed for type in the function declaration and a later
definition of "struct commit" to refer to the same type.

Actually more important than the above is avoiding mutual dependencies
between header files, but the above makes for a more entertaining
story about why to avoid unnecessary #includes.

> +
> +enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };

The names of these identifiers (especially KEEP, MERGE, and NONE)
would have a good chance to colliding with other uses after being
exposed into a global namespace like this, no?

Maybe RESET_MIXED, RESET_SOFT, etc could avoid this while still not
being too verbose.

> +
> +int reset_index_file(const unsigned char *sha1, int reset_type, int quiet);
> +void print_new_head_line(struct commit *commit);

Warning: trivia ahead.

For some odd reason I still remember a patch from Stefan Beyer:
http://thread.gmane.org/gmane.comp.version-control.git/92023
which was probably too invasive to apply but made the whole codebase
oddly more pleasant when I tried it.  It simply added "extern" at the
start of function prototypes in header files that lacked it.

Sorry I don't have any more substantial comments on this one at the
moment.  Still, hope that helps.
