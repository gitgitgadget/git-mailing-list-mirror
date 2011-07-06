From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/14] revert: Propogate errors upwards from
 do_pick_commit
Date: Wed, 6 Jul 2011 03:50:08 -0500
Message-ID: <20110706085007.GB15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 10:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeNoL-00041n-C8
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 10:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771Ab1GFIuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 04:50:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49725 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1GFIuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 04:50:13 -0400
Received: by iyb12 with SMTP id 12so5911165iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NHQA6d9IecG5VF6er1eyzCcxL0E8sxgP8xXpjyObmtM=;
        b=SmLmq5cWVdz75v/clqKOSogALa8IDa/f7Vk3Of+DmvE38O5JCoO/XCUHk0bKDGPCn+
         VGcCeOBywyDOUk/zy1RzSqdQ1IglvSq829UZnoYdmOSrKbgGhULcB+M08s/vFHctLXNl
         qcuFbbFzo68l+HTui+NKFq7Kwf9+4sPIcBrLQ=
Received: by 10.42.8.10 with SMTP id g10mr10090829icg.137.1309942212454;
        Wed, 06 Jul 2011 01:50:12 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id v16sm4745818ibe.51.2011.07.06.01.50.10
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 01:50:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176664>

Hi,

Ramkumar Ramachandra wrote:

> Currently, the return value from revert_or_cherry_pick is a
> non-negative number representing the intended exit status from `git
> revert` or `git cherry-pick`.  Change this by replacing some of the
> calls to "die" with calls to "error", so that it can return negative
> values too.  Postive return values indicate conflicts, while negative

The above seems to be suggesting that the current return value is a
_problem_, and that this change _fixes_ it.

But I had thought that the bulk of this patch's changes (die-to-error
conversions) were not meant as a means to that end but an end in
themselves.  Wouldn't a clearer problem statement be "Currently,
revert_or_cherry_pick can fail in two ways.  If it encounters
conflicts, it returns a positive number indicating the intended exit
status for the git wrapper to pass on; for all other errors, it
die()s.  Some callers may not like the latter behavior because of
<reasons here>"?

Only after the reader understands that, she will be ready to
appreciate the value of the proposed alternate return value
convention.  Similar comments apply to the commit messages of the few
patches before --- they are not terribly confusing, but they could
still easily be improved by mentioning what problem the patches are
supposed to solve.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -250,25 +250,20 @@ static struct tree *empty_tree(void)
[...]
> +	if (action == CHERRY_PICK)
> +		error(_("Your local changes would be overwritten by %s."), me);
> +	else
> +		error(_("Your local changes would be overwritten by %s."), me);

gettext creates one msgid for these two strings, so translators have
no choice but to give them the same translation.  Is that the intent?

[...]
> +	if (res < 0)
> +		die(_("%s failed"), me);
> +	return res;
>  }

Likewise.

I haven't looked carefully again at the unwinding-after-error, but
aside from that and except as noted above this looks good.
