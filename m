From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/14] revert: Introduce struct to keep command-line
 options
Date: Wed, 6 Jul 2011 04:09:15 -0500
Message-ID: <20110706090915.GD15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:09:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeO6o-0003RO-0B
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab1GFJJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 05:09:21 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48799 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1GFJJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 05:09:20 -0400
Received: by iyb12 with SMTP id 12so5922382iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2t561te+O2VYftIgMSm5BZCluBrGPrWJmJVQxUJHyE4=;
        b=uhhTVPEIvEkA3mQ293xwOxjrqNoQW0S4V+4FPsKVFDTdf1iKo7dUphNgVuhgPp+xUY
         zCZxUmJoLyzTMy9HztH2RF9+irN4IIMYsU+shk4Zugv0nBEX4qw7oxgERiSCF8tULJQr
         Z4jBo1l+m2wMwQyfbi7fuNLthxDNX+dUdPjXs=
Received: by 10.42.222.3 with SMTP id ie3mr10098198icb.109.1309943359800;
        Wed, 06 Jul 2011 02:09:19 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id f19sm4755065ibl.49.2011.07.06.02.09.18
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 02:09:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176667>

Ramkumar Ramachandra wrote:

> In later
> steps in this series, we would like to introduce an API function that
> calls into this machinery directly and have a way to tell it what to
> do.  Hence, introduce a structure to group these variables, so that
> the API can take them as a single replay_options parameter.
>
> The variable "me" is left as a file-scope static variable because it
> is not an independent option.  "me" is simply a string that needs to
> be inferred from the "action" option, and is kept global to save each
> function the trouble of determining it independently.

Hm, would it make sense for there to be a "private" section at the
end of the replay_opts struct for variables like this?

> Unfortunately, this patch introduces a minor regression.  Parsing
> strategy-option violates a C89 rule: Initializers cannot refer to
> variables whose address is not known at compile time.  Currently, this
> rule is violated by some other parts of Git as well, and it is
> possible to get GCC to report these instances using the "-std=c89
> -pedantic" option.

I would be interested in fixing that (as a patch on top, maybe).
What do you suggest:

 A. Apply patch 8 and make cmd_revert, cmd_cherry_pick, and parse_args
    manipulate a static "struct replay_opts" while pick_commits et al
    pass around a pointer to it

 B. Make parse_args work like this:

	copy from argument to private static struct replay_opts
	call parse_options()
	copy private static struct replay_opts to argument

 C. Use new option types:

	OPT_BOOL_MEMBER('n', "no-commit",
		offsetof(struct replay_opts, no_commit),
		"don't automatically commit"),

    and teach parse_options to take an additional parameter like it
    takes "prefix" now, to be used as a base address for options that
    write to an offset instead of a pointer

I'm leaning towards A but not sure if that would be wasted work in
light of your plans for these APIs in the long run (i.e., is
parse_args() going to be exposed and want to act on a caller-supplied
struct)?
