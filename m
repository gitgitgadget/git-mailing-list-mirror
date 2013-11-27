From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add an option for adding more branch refs
Date: Wed, 27 Nov 2013 16:56:08 +0100
Message-ID: <52961618.1070603@gmail.com>
References: <1385462243-7898-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 16:56:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlhTM-0001TM-W9
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 16:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab3K0P4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 10:56:13 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:61403 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab3K0P4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 10:56:12 -0500
Received: by mail-ea0-f173.google.com with SMTP id g15so4875969eak.18
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 07:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XlXFglPL3uOKOWXLLM8sR4Xp5qoLcef+qxSJuXECTAM=;
        b=No2pe+cTKlqvA+jcsf6esPkYfdpZ/lXXDavLL2ednb1hwmFfBN/L9bpNP7HYNlfJxF
         Tp9+6ZjlYUr9BV7iv+bW9ZjbvnnC6F+sX/ME1xbdmDEFhnBQ5/tsdP8wUFbPmRN0PcnX
         J/SQxyDd4XrU73HxuLqO5+dCbHQNKOJ3hMiQfFfpK9KYK8c6s2yiLwTt5nrJHgrQDcDW
         jBlCTAYBKyOlPO88QqiIvewsfBn94999C15uhDJ37fWn/81To/p2WNOSfAa//t3QRMqD
         I7YCP0AOnRdOlibH0qLC4df5t1Bd7XpWRfauuW+rzbH58Cglkqm2f7fYRv1L98haqL6+
         /EqQ==
X-Received: by 10.15.45.135 with SMTP id b7mr900722eew.88.1385567770626;
        Wed, 27 Nov 2013 07:56:10 -0800 (PST)
Received: from [158.75.2.83] ([158.75.2.83])
        by mx.google.com with ESMTPSA id 4sm8485577eed.14.2013.11.27.07.56.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 07:56:09 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1385462243-7898-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238446>

Krzesimir Nowak wrote:

> Overriding an @additional_branch_refs configuration variable with
> value ('wip') will make gitweb to show branches that appear in
> refs/heads and refs/wip (refs/heads is hardcoded). Might be useful fo=
r
> gerrit setups where user branches are not stored under refs/heads/.
>

The description of this change starts with technical details,
instead of starting with intent of this change.

Perhaps (this is only a proposal)

   Introduce @additional_branch_refs configuration variable, holding
   names of references to be considered branches; by default empty.
   For example setting it to ('wip') will make gitweb ...


BTW. I have thought at first that is something similar to 'remote_heads=
'
feature, which among others adds 'remotes' section to 'summary' view
displaying refs/remotes/* refs... but no, gitweb still doesn't treat=20
refs/remotes as branches, even with this feature set.

Nb. why new configuration variable, and not new %feature?

> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> ---
>  gitweb/gitweb.perl | 99 ++++++++++++++++++++++++++++++++++++++++----=
----------
>  1 file changed, 74 insertions(+), 25 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 68c77f6..9bfd38b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -17,6 +17,7 @@ use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
> +use List::Util qw(min);
>  use Time::HiRes qw(gettimeofday tv_interval);
>  binmode STDOUT, ':utf8';
>
[...]
 > @@ -3184,24 +3210,43 @@ sub git_get_project_owner {
 >   	return $owner;
 >   }
 >
 > -sub git_get_last_activity {
 > -	my ($path) =3D @_;
 > -	my $fd;
 > +sub git_get_last_activity_age {
 > +	my ($refs) =3D @_;
 > +	my $fd =3D -1;
 >
 > -	$git_dir =3D "$projectroot/$path";
 >   	open($fd, "-|", git_cmd(), 'for-each-ref',
 >   	     '--format=3D%(committer)',
 >   	     '--sort=3D-committerdate',
 >   	     '--count=3D1',
 > -	     'refs/heads') or return;
 > +	     $refs) or return undef;

git-for-each-ref accepts more than one pattern. Why not simply

    	open($fd, "-|", git_cmd(), 'for-each-ref',
    	     '--format=3D%(committer)',
    	     '--sort=3D-committerdate',
    	     '--count=3D1',
   -	     'refs/heads') or return;
   +	     get_branch_refs()) or return;

Then we won't need List::Util::min.

[...]
 > +sub git_get_last_activity {
 > +	my ($path) =3D @_;
 > +	my @ages =3D ();
 > +
 > +	$git_dir =3D "$projectroot/$path";
 > +	for my $ref (get_branch_refs()) {
 > +		my $age =3D git_get_last_activity_age('refs/' . $_);
 > +
 > +		push @ages, $age if defined $age;
 > +	}
 > +	if (@ages) {
 > +		my $min_age =3D min(@ages);
 > +
 > +		return ($min_age, age_string($min_age));
 > +	}
 > +
 >   	return (undef, undef);
 >   }
 >
[...]
--=20
Jakub Nar=C4=99bski
