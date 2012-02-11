From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Sat, 11 Feb 2012 07:20:35 -0800 (PST)
Message-ID: <m3obt5tn0g.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-2-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 16:20:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwEkl-0002PR-BR
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 16:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab2BKPUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 10:20:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62811 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab2BKPUi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 10:20:38 -0500
Received: by eaah12 with SMTP id h12so1226929eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=CBpopl81AB4a453UlUM5FBm2qBVn//jtE1IyNez9ZAo=;
        b=PfqK9aWk8gegd2wE89UEHY6g9WqJwkkEIWTMuIGAxPqPXQlv58I0i6TBONT+3El2tX
         tkGmwdIMwaqZBmz6rD6vay5q87Cdz3R1nguyS1CBo15fvnVU7uD2Z8D0z7DJlNdAPnNI
         FwdU5karSf7gHVvfz10K7Ri6iew919Tn3vYVc=
Received: by 10.213.3.5 with SMTP id 5mr1000455ebl.91.1328973636239;
        Sat, 11 Feb 2012 07:20:36 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id o49sm36486643eei.0.2012.02.11.07.20.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 07:20:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BFKW8R015531;
	Sat, 11 Feb 2012 16:20:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BFKVTH015528;
	Sat, 11 Feb 2012 16:20:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-2-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190515>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Currently, print_sidebyside_diff_chunk() does two things: it
> accumulates diff lines and prints them. Accumulation may be used to
> perform additional operations on diff lines, so it makes sense to spl=
it
> these two things. Thus, the code that prints diff lines in a side-by-=
side
> manner is moved out of print_sidebyside_diff_chunk() to a separate
> subroutine.
>=20
> The outcome of this patch is that print_sidebyside_diff_chunk() is no=
w
> much shorter and easier to read.
>=20
> This change is meant to be a simple code movement. No behavior change=
 is
> intended.
>=20
> Signed-off-by: Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com>

As it is pure refactoring, and improves readibility of code quite a
bit, I am all for it, but...

You replace the following set of conditions

> -		## print from accumulator when type of class of lines change
> -		# empty contents block on start rem/add block, or end of chunk
> -		if (@ctx && (!$class || $class eq 'rem' || $class eq 'add')) {

and

> -		# empty add/rem block on start context block, or end of chunk
> -		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
> -			if (!@add) {
[...]
> -			} elsif (!@rem) {
[...]
> -			} else {


with these (I have reindented the code to match)

> +		## print from accumulator when have some add/rem lines or end
> +		# of chunk (flush context lines)
> +		if (((@rem || @add) && $class eq 'ctx') || !$class) {

> +                     if (@$ctx) {
[...]
> +                     }
> +                     if (!@$add) {
[...]
> +                     } elsif (!@$rem) {
[...]
> +                     } else {

It is not obvious that the final result is the same.

BTW doesn't new code print context when printing added and removed
lines, and not as soon as class changes?  This doesn't change the
output, but it slightly changes behavior.

--=20
Jakub Nar=EAbski
