From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cherry-pick: add failing test for out-of-order pick
Date: Thu, 12 Jan 2012 12:32:46 -0600
Message-ID: <20120112183246.GB6038@burratino>
References: <CALkWK0nJM2wUE9qzp38qjFFqCdwX9w0Jckxi1G=1=7adMxg2rw@mail.gmail.com>
 <1326390647-21446-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPSh-0005MI-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 19:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab2ALScx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 13:32:53 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54730 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab2ALScw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 13:32:52 -0500
Received: by ghbg16 with SMTP id g16so455335ghb.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 10:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QZTvNG3K8gZclWKnSCiTSj/2Ak9Sc0XWJm5qfCWaqZc=;
        b=kxJqvizop2vLTzezRdRNPptjS1zKY+PU7bLuMA9QItBkih784hRrwcNdHUfEJluVBu
         mzHTrWkVuiHdbzdmMS9rP9ZmTDBevT4rdabvdSyfUHd/B+viSaflPNZ478i7U2bZu4JZ
         /h1GstdnxqwH6DPAqvhRv/kffd+Sk99sEjXO8=
Received: by 10.101.186.1 with SMTP id n1mr608532anp.18.1326393171951;
        Thu, 12 Jan 2012 10:32:51 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j16sm15683430anm.9.2012.01.12.10.32.50
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 10:32:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326390647-21446-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188467>

Ramkumar Ramachandra wrote:

>   $ git cherry-pick master..topic
>   $ git cherry-pick topic ^master
>   $ git cherry-pick ^master topic
>
> So the order of the arguments specified on the command-line is
> irrelevant in these cases.  However, there are cases where it is wort=
h
> paying attention to the order.  For instance:
>

This segue feels a bit unnatural.  I think the relevant point was that
early output from revision traversal (and perhaps some other things
--- I haven't checked) relies on commits having been inserted in a
topologically sorted order.

Anyway, I don't think the background is necessary --- the
one-paragraph description below stands well enough alone.

>   $ git cherry-pick commit3 commit1 commit2
>=20
> picks commits after sorting by date order, which is counter-intuitive=
=2E
> Add a failing test to t3508 (cherry-pick-many-commits) documenting
> this behavior.
>=20
> Reported-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
[...]
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -59,6 +59,31 @@ test_expect_success 'cherry-pick first..fourth wor=
ks' '
>  	check_head_differs_from fourth
>  '
> =20
> +test_expect_failure 'cherry-pick picks commits in the right order' '

I would say "in the order requested" instead of the right order, since
it is not completely obvious to me what the right order is.

> +	cat <<-\EOF >expected &&
> +	[master OBJID] fourth
> +	 Author: A U Thor <author@example.com>
> +	 1 files changed, 1 insertions(+), 0 deletions(-)
> +	[master OBJID] second
> +	 Author: A U Thor <author@example.com>
> +	 1 files changed, 1 insertions(+), 0 deletions(-)
> +	[master OBJID] third
> +	 Author: A U Thor <author@example.com>
> +	 1 files changed, 1 insertions(+), 0 deletions(-)
> +	EOF

Why check all these details of formatting, instead of e.g. using "git
rev-list | git diff-tree -s --format=3D%s"?

[...]
> +	test_cmp expected actual.fuzzy &&
> +	check_head_differs_from second

Why make the same check twice?

Hope that helps,
Jonathan
