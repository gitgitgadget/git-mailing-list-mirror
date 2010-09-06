From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Better way to find commit from tarball?
Date: Mon, 6 Sep 2010 15:05:08 -0500
Message-ID: <20100906200508.GA26371@burratino>
References: <AANLkTi=ZnZppPu8tT3-sUG6zZM8YnonPwMG_XZhO03up@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <tjacobs@si2services.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OshyJ-0006EI-Cs
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab0IFUHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 16:07:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43652 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0IFUHN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 16:07:13 -0400
Received: by qyk36 with SMTP id 36so2714172qyk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/+lxG93G1yVcvTjCuryCuF86sm1Ty6BcySOF1q98tKI=;
        b=La/jCS7RiTReOjOaGp3FA/nqmwkgRmdJ4FWRjwbaJG2v5l6sPsmIBubakdviE52p/H
         t0KpA4l7R4WYIZIrp2SGxb+U03HOJc25PxEhHWU/UIcqF1Fp4cX+mwL+vFJm+Jq6Lw5p
         A8CMi9mz2C+4NknXTqGfw03m6ebPmeVkGv/RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QZ19yRfdPBNQ7sRQWEjRF/CikFXhnV/kJtKZt4dA9bOve/00Nj+RUNpvxuGkB3+5rP
         SFzJxZuOf5eVeLbB2U1HUUg6zRaUgyVqIGk6p0NPHJecAQNJFK9z7Y/5vOnRo4bqC9ab
         Yew7I/F5p3TjFxHnFTXJ0+ovoba8kJ4Lc4g+U=
Received: by 10.224.20.13 with SMTP id d13mr145016qab.258.1283803632451;
        Mon, 06 Sep 2010 13:07:12 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id l13sm6004175qck.43.2010.09.06.13.07.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 13:07:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ZnZppPu8tT3-sUG6zZM8YnonPwMG_XZhO03up@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155607>

Todd A. Jacobs wrote:

>     cd $SOME_WORK_DIR
>     find . -path ./.git -prune -o -print0 | xargs -0 rm
>     tar xvfz $TARBALL
>     for commit in {0..100}; do
>         id="master~${commit}"
>         if git diff --quiet --exit-code "$id"
>         then
>             echo "Matched on commit $id"
>             break
>         fi
>     done
> 
> Someone please tell me there's an easier way to find a matching tree
> when handed a tarball. This works, but seems cumbersome.

If you are lucky and they used "git archive":

	gunzip <$TARBALL | git get-tar-commit-id

Otherwise: maybe something like this[1] will work.

	tar_id=$(
		git init tarball &&
		cd tarball &&
		perl /usr/share/doc/git/contrib/fast-import/import-tars.perl $TARBALL &&
		git rev-parse --verify HEAD:
	) &&
	rm -fr tarball &&
	git rev-list --full-history --format='%h %T' HEAD |
	grep " $tar_id\$"

[1] http://thread.gmane.org/gmane.comp.version-control.git/44750/focus=44849
