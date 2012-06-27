From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-import: allow "merge $null_sha1" command
Date: Wed, 27 Jun 2012 18:39:31 -0500
Message-ID: <20120627233931.GA3014@burratino>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-3-git-send-email-divanorama@gmail.com>
 <7v395g75gg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 01:39:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk1pq-0006XA-V6
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 01:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab2F0Xjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 19:39:41 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47392 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab2F0Xjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 19:39:40 -0400
Received: by yenl2 with SMTP id l2so1414301yen.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8nN5Px/oQVgPV88rput7bsu+MMUuT7kZWodHdudfjKk=;
        b=DuRLwO2gVhNP5hmI3jFVW3GVsUTONo17qyrWq/VV1Np2/8ixKjuu3nAZAKhuXPrBUM
         ju512nEWJnlyVt2+UXi8Uk+h3BOG8eOUJm5zaadJuzzF373VPzYw/9etcblXMgE0A2wx
         I69HRPaS4r2C1e71+IUlakbyJtKOzm2sWAQTb6LPiIqvGSDg3hDXHGrEM3MD/QhXIjIR
         LbX5wr/xVQWnQ5MK76lpSmz/+osU/Cmn4FG5xkN87YGK4Bq49grcNhbQr0zDdmVwCDqA
         q7Id92MsWBZ5LKdzouAafR/ArCxFGbyxvd/hfVTGaAHemarCx8XvwP83d5bSHcQmw+VS
         eNRA==
Received: by 10.236.200.199 with SMTP id z47mr25826519yhn.82.1340840379912;
        Wed, 27 Jun 2012 16:39:39 -0700 (PDT)
Received: from burratino (adsl-99-41-41-208.dsl.chcgil.sbcglobal.net. [99.41.41.208])
        by mx.google.com with ESMTPS id v61sm150530170yhi.17.2012.06.27.16.39.38
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 16:39:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v395g75gg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200771>

Junio C Hamano wrote:
> Dmitry Ivankov <divanorama@gmail.com> writes:

>> "from $null_sha1" and "merge $empty_branch" are already allowed so
>> allow "merge $null_sha1" command too.
>
> Would accepting such a "merge oops-do-not-do-anything" allow
> exporters' job to be simpler?

Good question.

I was uncomfortable with the patch and couldn't pin down why and I
think you've hit it.

I can imagine an importer that does

	cat <<EOF
	commit refs/heads/master
	from $parent
	merge $second_parent
[etc]
	EOF

and uses parent=0000000000000000000000000000000000000000 in the
degenerate case, but it is not hard to use

	cat <<EOF
	commit refs/heads/master
	$optional_from_line$optional_second_parent
[etc]
	EOF

so this is not a very strong justification.  Mostly it felt like a
step in the right direction because once you can do it for "from",
someone might try it with "merge" and it's simplest to explain the
syntax if we're consistent.

On the other side to be weighed against that is the danger that
someone might actually start using "merge" this way.  They would be
making their frontend break compatibility with old versions of git
fast-import for no good reason.

So on second thought, it does not seem like a good direction at all.
[Though the cleanup I mentioned might be nice in any case. ;-)]

I wonder if anyone using "from" with a branch name that resolves in
the internal branch table to $null_sha1 was actually intending that.
Would any importers break if we started to forbid it?  Would it make
sense to add that check in "next" for a release or two and see if
anyone complains?

Looking at the patch for 00e2b884 (Remove branch creation command from
fast-import, 2006-08-24), it looks like support for "from $null_sha1"
was intentional.  Maybe mailing list discussions from around then have
insight.

Thanks for some food for thought,
Jonathan
