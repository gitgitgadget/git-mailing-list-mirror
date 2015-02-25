From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: fix localtime=true on non-glibc environments
Date: Wed, 25 Feb 2015 10:38:10 -0800
Message-ID: <xmqqfv9tomzx.fsf@gitster.dls.corp.google.com>
References: <1424880281-570-1-git-send-email-ryu1kkb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ryuichi Kokubo <ryu1kkb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:38:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQgqh-00028K-Np
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 19:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbbBYSiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 13:38:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752711AbbBYSiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 13:38:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C2CE3B4BB;
	Wed, 25 Feb 2015 13:38:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZFpBdkiUxaFugQl9ta+LenvlPtc=; b=Lg8atG
	dg0op8xhYn/Mn4oNDKynmaCtVZbI2qXomPaWo91I+yCx71jz5e5YqwVcaLGZJzje
	GxFdnxiNnCZDvfMKW/EUY3iI4nFpAEgCsMJJn3F3GDzaL0RNGoiEE225CuJJlQXn
	weFjeKd0/nHzc4m75iP1L8Ttv12w6Xa0+pNdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uoYxoHqfLPXDTkRnk5Wa0NDpYPRW08kN
	WG4Q0cz1PCDW7vSaJp4K80qsuRd2ynDJSG6in3x/28V1CIGvdlXwAHDsM3YhX+xc
	OeakuavxUvu3ArrS1b42galRhq1wDiQRSTiH/s1t0U3zg4XM0Ymx37Si1RnU+13D
	829yhyWwuV8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 930183B4BA;
	Wed, 25 Feb 2015 13:38:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A8093B4B9;
	Wed, 25 Feb 2015 13:38:12 -0500 (EST)
In-Reply-To: <1424880281-570-1-git-send-email-ryu1kkb@gmail.com> (Ryuichi
	Kokubo's message of "Thu, 26 Feb 2015 01:04:41 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73B9770E-BD1D-11E4-ACBD-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264401>

Ryuichi Kokubo <ryu1kkb@gmail.com> writes:

> git svn uses POSIX::strftime('%s', $sec, $min, ...) to make unix epoch time.
> But lowercase %s formatting character is a GNU extention. This causes problem
> in git svn fetch --localtime on non-glibc systems, such as msys or cygwin.
> Using Time::Local::timelocal($sec, $min, ...) fixes it.
>
> Signed-off-by: Ryuichi Kokubo <ryu1kkb@gmail.com>

Sounds sensible.

Because we already have "use Time::Local qw(...)" in perl/Git.pm
that is used by git-svn, we know the platforms that are capable
of running the current git-svn do have Time::Local available, so
I do not have worries about new dependency, either.

Eric?

>
> Notes:
>     lowercase %s format character in strftime is a GNU extension and not widely supported.
>     POSIX::strftime affected by underlying crt's strftime because POSIX::strftime just calls crt's one.
>     Time::Local is good function to replace POSIX::strftime because it's a perl core module function.
>     
>     Document about Time::Local.
>      http://perldoc.perl.org/Time/Local.html
>     
>     These are specifications of strftime.
>     
>     The GNU C Library Reference Manual.
>      http://www.gnu.org/software/libc/manual/html_node/Formatting-Calendar-Time.html
>     
>     perl POSIX module's strftime document. It does not have '%s'.
>      http://perldoc.perl.org/POSIX.html
>     
>     strftime document of Microsort Windows C Run-Time library.
>      https://msdn.microsoft.com/en-us/library/fe06s4ak.aspx
>     
>     The Open Group's old specification does not have '%s' too.
>      http://pubs.opengroup.org/onlinepubs/007908799/xsh/strftime.html
>     
>     On my environment, following problems happened.
>     - msys   : git svn fetch does not progress at all with perl.exe consuming CPU.
>     - cygwin : git svn fetch progresses but time stamp information is dropped.
>        Every commits have unix epoch timestamp.
>     
>     I would like to thank git developer and contibutors.
>     git helps me so much everyday.
>     Thank you.
> ---
>  perl/Git/SVN.pm |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 8e4af71..f243726 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -14,6 +14,7 @@ use IPC::Open3;
>  use Memoize;  # core since 5.8.0, Jul 2002
>  use Memoize::Storable;
>  use POSIX qw(:signal_h);
> +use Time::Local;
>  
>  use Git qw(
>      command
> @@ -1332,7 +1333,7 @@ sub parse_svn_date {
>  		$ENV{TZ} = 'UTC';
>  
>  		my $epoch_in_UTC =
> -		    POSIX::strftime('%s', $S, $M, $H, $d, $m - 1, $Y - 1900);
> +		    Time::Local::timelocal($S, $M, $H, $d, $m - 1, $Y - 1900);
>  
>  		# Determine our local timezone (including DST) at the
>  		# time of $epoch_in_UTC.  $Git::SVN::Log::TZ stored the
