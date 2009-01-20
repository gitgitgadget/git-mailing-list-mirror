From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Provide pessimistic defaults for cross compilation
 tests.
Date: Mon, 19 Jan 2009 22:50:52 -0800
Message-ID: <7v63kampwz.fsf@gitster.siamese.dyndns.org>
References: <loom.20090115T123123-915@post.gmane.org>
 <20090116094110.GD25275@ins.uni-bonn.de>
 <20090119203400.GA3539@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 07:52:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPATN-0005GR-0x
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 07:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZATGvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 01:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbZATGvE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 01:51:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbZATGvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 01:51:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 75AB31CD12;
	Tue, 20 Jan 2009 01:51:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE8011CD0D; Tue,
 20 Jan 2009 01:50:53 -0500 (EST)
In-Reply-To: <20090119203400.GA3539@ins.uni-bonn.de> (Ralf Wildenhues's
 message of "Mon, 19 Jan 2009 21:34:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B28C54F6-E6BE-11DD-8924-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106444>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> In a cross compile setup, configure tests that run programs
> cannot be executed; in that case, provide pessimistic default
> values.
>
> Bug reported by Julius Naperkowski.
> ---
>
>> I can post a patch to add sane default settings for AC_RUN_IFELSE in
>> cross compile setups, this weekend.
>
>  configure.ac |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 363547c..4a208d4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -360,6 +360,7 @@ AC_RUN_IFELSE(
>  		else if (strcmp(buf, "12345"))
>  		  return 2;]])],
>  	[ac_cv_c_c99_format=yes],
> +	[ac_cv_c_c99_format=no],
>  	[ac_cv_c_c99_format=no])
>  ])
>  if test $ac_cv_c_c99_format = no; then

This one probably is Ok, but...

> @@ -380,6 +381,7 @@ AC_RUN_IFELSE(
>  		FILE *f = fopen(".", "r");
>  		return f && fread(&c, 1, 1, f)]])],
>  	[ac_cv_fread_reads_directories=no],
> +	[ac_cv_fread_reads_directories=yes],
>  	[ac_cv_fread_reads_directories=yes])
>  ])
>  if test $ac_cv_fread_reads_directories = yes; then

I am not quite sure if this is an improvement ...

> @@ -414,6 +416,7 @@ AC_RUN_IFELSE(
>  		  if (snprintf(buf, 3, "%s", "12345") != 5
>  		      || strcmp(buf, "12")) return 1]])],
>  	[ac_cv_snprintf_returns_bogus=no],
> +	[ac_cv_snprintf_returns_bogus=yes],
>  	[ac_cv_snprintf_returns_bogus=yes])
>  ])
>  if test $ac_cv_snprintf_returns_bogus = yes; then

... nor this one.

Is there a way to say something like "I'll autodetect as much as I can
without running tests, but please tell me these characteristics of the
target system manually" and leave the resulting config.mak.autogen in a
shape that will guarantee compilation failure until the missing ones are
supplied by config.mak?

The thing is, I am not convinced that it is desirable to be able to build
a possibly suboptimal binary in a cross compilation environment, without
being told in what aspect of the resulting binary is suboptimal.  I'd
rather see a build system that honestly tells me what information it needs
but couldn't find, so that I would know I have a chance to help it.

Of course, suggesting a pessimistic default that can result in suboptimal
but correct result would be a good thing to help the user help the build.
I just think it is a good idea to tell the user we are giving such hint a
bit more loudly to draw attention.
