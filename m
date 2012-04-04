From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 4/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Thu, 5 Apr 2012 00:47:09 +0200
Message-ID: <201204050047.10357.jnareb@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com> <1333569433-3245-5-git-send-email-michal.kiedrowicz@gmail.com> <7vsjgj6ufi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:47:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFYz0-0005bo-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 00:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab2DDWrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 18:47:13 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52038 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab2DDWrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 18:47:11 -0400
Received: by wejx9 with SMTP id x9so487190wej.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Shoe/FlPrpkVn1ErzeHWjRUIgM1QNgLRzYQLSdWQtSU=;
        b=xvHOnzspZHf5o7G4ZE5/q4NVFcz0BO+fzDGTcxLsCEon0PY4L0C9JXPvX9b6NVzQVa
         MX48VxeJMWik/j90VjlwmwRBwuL847UWSEF4851/+G5PhJN7rYFy7LsSOPc7bumlqohe
         cPWn/25Vrj0QaDkSy8H407AJzWxdbyZXKsJBuMhc6Cf6X0OJ+X/yUb2yh+Ob9dUxnuHq
         a50GfE5EBW+dgAJx4pd27JLw1pQ4rlPm5ICyrYx5XT7NtSRX5JljFoOzCsGYlITg5QV5
         VNrl2P+9/fSLFTdVkxqxrwqH+WE/qio+4GNtFa4Okvm4EGmBY8l1wHsql6fOBYGYjdrb
         CXaA==
Received: by 10.216.134.233 with SMTP id s83mr127044wei.104.1333579630336;
        Wed, 04 Apr 2012 15:47:10 -0700 (PDT)
Received: from [192.168.1.13] (adgy104.neoplus.adsl.tpnet.pl. [79.184.154.104])
        by mx.google.com with ESMTPS id u9sm8523843wix.0.2012.04.04.15.47.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 15:47:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjgj6ufi.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194750>

Junio C Hamano wrote:
> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > +	if (!@$add) {
> > +		# pure removal
> > +...
> > +	} elsif (!@$rem) {
> > +		# pure addition
> > +...
> > +	} else {
> > +		# assume that it is change
> > +		print join '',
>=20
> I know this is not a new problem, but if your patch hunk has both '-'=
 and
> '+' lines, what's there to "assume" that it is a change?  Isn't it al=
ways?

What I meant here when I was writing it that they are lines that change=
d
between two versions, like '!' in original (not unified) context format=
=2E

We can omit this comment.

> > -		# empty add/rem block on start context block, or end of chunk
> > -		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
> > -...
> > +		## print from accumulator when have some add/rem lines or end
> > +		# of chunk (flush context lines)
> > +		if (((@rem || @add) && $class eq 'ctx') || !$class) {
>=20
> This seems to change the condition.  Earlier, it held true if (there =
is
> anything to show), and (class is unset or equal to ctx).  The new cod=
e
> says something different.

Yes it does, as described in the commit message:

                                                    [...] It should
  not change the gitweb output, but it **slightly changes its behavior*=
*.
  Before this commit, context is printed on the class change. Now,  it'=
s
  printed just before printing added and removed lines, and at the end =
of
  chunk.

The difference is that context lines are also printed accumulated now.
Though why this change is required for refactoring could have been
described in more detail...

>                             Also can $class be undef, and if so, does=
n't=20
> it trigger comparison between undef and 'ctx' by having !$class check=
 at
> the end of || chain?

Thanks for noticing this (I wonder why testsuite didn't caught it).
It should be

 +		## print from accumulator when have some add/rem lines or end
 +		# of chunk (flush context lines)
 +		if (!$class || ((@rem || @add) && $class eq 'ctx')) {

--=20
Jakub Narebski
Poland
