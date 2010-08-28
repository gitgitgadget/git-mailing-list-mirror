From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t6200-fmt-merge-msg: Exercise 'merge.log' to
 configure shortlog length
Date: Fri, 27 Aug 2010 21:00:18 -0500
Message-ID: <20100828020018.GD2004@burratino>
References: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
 <1282918490-5190-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 04:02:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpAkF-0006fe-DO
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 04:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab0H1CCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 22:02:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54236 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0H1CCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 22:02:04 -0400
Received: by iwn5 with SMTP id 5so3116565iwn.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 19:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Orrm+1ENqfP53BbdKNe7KFmiUp2q23BBn+GDXIabgq8=;
        b=Tcyq7aNNdw4KNJsjztDWoyeFAtHmE3B7N//xKdhjBp9FAT8sxHOVF8x7ifQT0JCajK
         C6iFs43T5ZR4RgkeT98k6wZhjBVmPeUXHAT/7j2SazP0El0XLOZ6hIZ4Tg7RXEzGcghg
         /SnUvy2Xhrd/qnPXEnGDTLEByDfhzxX5EGC+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oZaVqnBO0RD8gcSowEtk8h8xNYKMZMH78Rw2TXx2GxAQJmXx5X59KasVkV2SbYhamn
         LhEu5yCJsE+TUbH0X14c9L9kZ3mGT3l31EcIKpEoCwZzXrtKnEi0cs2FAd/pM8E84G96
         nqZxd/046ei4tlApZ4VIllJN5bgFRq8qcgQRI=
Received: by 10.231.166.210 with SMTP id n18mr1990035iby.167.1282960922524;
        Fri, 27 Aug 2010 19:02:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm4246934ibh.16.2010.08.27.19.02.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 19:02:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282918490-5190-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154627>

Hi,

Ramkumar Ramachandra wrote:

> Add a test to exercise the 'merge.log' configuration option

Thanks!

> +test_expect_success 'configurable shortlog length: merge.log' '

I suspect this test would be easier to understand if split up (yes, I
know I'm guilty of the same in other tests from this file).

Maybe something like this?

	test_expect_success 'setup: clear [merge] configuration' '
		test_might_fail git config --unset-all merge.log &&
		test_might_fail git config --unset-all merge.summary
	'

	test_expect_success 'set up FETCH_HEAD' '
		git checkout master &&
		git fetch . left
	'

	test_expect_success 'merge.log=3 limits shortlog length' '
		test_might_fail git config --unset merge.log &&
		test_might_fail git config --unset merge.summary &&

		cat >expected <<-\EOF &&
		  Left #3
		  ...
		EOF
		git -c merge.log=3 fmt-merge-msg <.git/FETCH_HEAD >msg &&

		tail -n 2 msg >actual &&
		test_cmp expected actual
	'

	test_expect_success 'shortlog length defaults to 20' '
		[...]
	'

	test_expect_success 'merge.log=5 does not limit shortlog length' '
		[...]
	'

	test_expect_success 'merge.log=6 does not limit shortlog length' '
		[...]
	'

	test_expect_success 'merge.log=0 disables shortlog' '
		[...]
	'

	test_expect_success 'merge.log=-1 does something sane' '
		[...]
	'

I can clean up the earlier tests afterwards. :)
Jonathan
