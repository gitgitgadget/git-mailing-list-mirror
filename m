From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 18:01:52 -0600
Message-ID: <20110208000151.GA19944@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 01:02:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmb20-00078E-5i
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab1BHACB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:02:01 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55064 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab1BHACA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:02:00 -0500
Received: by qyj19 with SMTP id 19so1947420qyj.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 16:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xOj0m5cSUPTACJxVKL5g8W91jOLOrGmkWYw9qV5Re6o=;
        b=d+qLufioMR8mjjiyVIsnJd2D3BVbvJ7MsHmF421b8b7d/DZzp15F7cg5hNfzs6AUKd
         WZlzJ0QVLjfLfKAuUQnhvx5tsvYRTic6zYRuQqWXSo7ebYu7+NMCxD+Nqj5/BLGheU2c
         g8k55mMtmXAkqqC2S7GsuTvdW8truN/Rh1KaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jlsgQ/nPi8z1cUHSzNIxMRyKB/wkH3Q/XXzKyxRi7gnY3t61Fpcru07CVu7oghs7Wf
         QImwZfgljARUD862AuZki7UWlIK/GEKqmDiadnKQjQCxSyf2rwkrtGd3+K5Gvv4iCmME
         s/wkg3MLs5sX73EoE7kc6V24GZuonPhklMcVg=
Received: by 10.224.20.2 with SMTP id d2mr14562172qab.300.1297123319373;
        Mon, 07 Feb 2011 16:01:59 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id g32sm3128976qck.34.2011.02.07.16.01.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 16:01:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110207234526.GA28336@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166312>

Jeff King wrote:

> Jonathan, do you want to roll all of these up into a single patch?

Sounds good.

> +++ b/t/t2020-checkout-detach.sh
[...]
> +check_detached() {
> +	! git symbolic-ref -q HEAD >/dev/null
> +}
> +
> +check_not_detached() {
> +	! check_detached
> +}

To be pedantic, I'll put

 check_detached () {
	test_must_fail git symbolic-ref -q HEAD >/dev/null
 }

 check_not_detached () {
	git symbolic-ref -q HEAD >/dev/null
 }

and add some more paranoid tests:

 test_expect_success 'checkout --detach without branch name detaches' '
        reset &&
	git checkout --detach &&
	check_detached
 '

 test_expect_success 'checkout --detach catches error in usage' '
	reset &&
	git checkout master &&
	test_must_fail git checkout --detach tag nonsense &&
	check_not_detached
 '

 test_expect_success 'checkout --detach moves HEAD' '
	reset &&
	git checkout one &&
	git checkout --detach two &&
	git diff --exit-code HEAD &&
	git diff --exit-code two
 '
