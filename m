From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Reduce parse-options.o dependencies
Date: Wed, 29 Jun 2011 15:29:59 -0500
Message-ID: <20110629202959.GJ22556@elie>
References: <1309000334-31980-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 22:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc1Oo-00056z-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 22:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614Ab1F2UaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 16:30:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35025 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1F2UaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 16:30:08 -0400
Received: by yxi11 with SMTP id 11so621689yxi.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lA1DaTjkFOFhXp0y4VpENRrAACKiR5D7dKaRO6mb2hM=;
        b=gkLtTUMwyfCZrTfK20L4W5jAxDgQimhMf6rFA6YS4e4/lvWSbmFV2jr9Cr9fMnK0+y
         867ulfre2AoSS4eaPZEU5W/uKByto5wE5EfDPfgrQm0Lmb6p2SEyX84/HGHR+8/zXfof
         M3vZPaLRP/di4qRHMrB4zgS2dinkukoWo7cO0=
Received: by 10.236.148.148 with SMTP id v20mr1581229yhj.376.1309379406162;
        Wed, 29 Jun 2011 13:30:06 -0700 (PDT)
Received: from elie ([68.255.110.41])
        by mx.google.com with ESMTPS id v4sm1104404yhm.76.2011.06.29.13.30.01
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Jun 2011 13:30:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309000334-31980-1-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176457>

Hi,

Dmitry Ivankov wrote:

> Currently parse-options.o pulls quite a big bunch
> of dependencies. This complicates it's usage in
> contrib/ because it pulls external dependencies
> and it also increases executables size.

Nitpick: it is easier to read text with a little longer lines;
typical for git.git is 70 columns or so.

> Split off less generic and more internal to git
> part of parse-options.c to parse-options-git.c.

These are just callbacks for special option types, right?  Maybe
something like parse-options-cb.c would make sense.

> Declare optbug and opterror as extern as they are
> shared between these parts and also may be used
> elsewhere.

I'd suggest making this a separate patch.  The idea is that optbug
and opterror might be used by option callbacks whether they are
specific to a particular command or generic, so it is useful to
expose them as a sort of toolkit for use with OPT_CALLBACK, right?

> Move prefix_function from setup.c to abspath.c.

I think you mean "prefix_filename". :)  Makes sense ---
prefix_filename is a generically useful function, not specific to
git's filesystem layout.

> Now parse-options.o pulls just abspath.o, ctype.o,
> strbuf.o, usage.o, wrapper.o, libc directly and
> strlcpy.o indirectly.

One vague dream I've had is to submit strbuf and parse-options as CCAN
modules (http://ccan.ozlabs.org/) in the hope that others will start
to use them.  The above should make that a little easier; thanks.

> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
>  Makefile            |    3 +-
>  abspath.c           |   28 +++++++++++++
>  parse-options-git.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  parse-options.c     |  108 +--------------------------------------------------
>  parse-options.h     |    3 +
>  setup.c             |   28 -------------
>  6 files changed, 143 insertions(+), 135 deletions(-)
>  create mode 100644 parse-options-git.c
[diff snipped, available at
 http://thread.gmane.org/gmane.comp.version-control.git/176318]
