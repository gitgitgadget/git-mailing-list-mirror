From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Pull gitweb If-Modified-Since handling out into its own function and use for snapshots.
Date: Tue, 20 Mar 2012 04:55:45 -0700 (PDT)
Message-ID: <m37gyf4hc3.fsf@localhost.localdomain>
References: <20120315075407.GA18246@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Tue Mar 20 12:56:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9xfV-0007bQ-O9
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 12:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759295Ab2CTLzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 07:55:49 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39367 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab2CTLzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 07:55:48 -0400
Received: by wibhq7 with SMTP id hq7so5107644wib.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=QSMlHx3iz9HFSPyfvfMakAPnu1Cr79mo1SCG6uwRl5Y=;
        b=w2r9KoOZg0AvqGD/k27Ip+KiJNO+LC+8vGOR00Np7k4OBch7dE4Umek6u0USpmFUki
         xkoEnL0/hWLvTeyFzrrniXuo5blbiw+jzzcuS22s5W1sMZ6PKpXZIMLAGNomZaIeSUIw
         2QYJhqSd1+esNJcf73uoEe6mJitU/qMwyFFEZpcvjISJmfvuCBTNnNdaVyjmcCXrTF13
         wyLxWo7jumE0Miw2kea6YJ3vEnvmMeZJsYd8dO9fV+3coO8s+P4wRFO/Tpgyq8O7JmXk
         sLVaOleceZhl3PVwVZ50FETF0SZwE0XrckQV9Wde0QTsZyWVvuOM3YrW5gE0p1rhgTAD
         3ikQ==
Received: by 10.216.135.102 with SMTP id t80mr9211662wei.59.1332244546707;
        Tue, 20 Mar 2012 04:55:46 -0700 (PDT)
Received: from localhost.localdomain (abvw11.neoplus.adsl.tpnet.pl. [83.8.220.11])
        by mx.google.com with ESMTPS id e6sm33472677wix.8.2012.03.20.04.55.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 04:55:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2KBtgXs019287;
	Tue, 20 Mar 2012 12:55:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2KBteBc019284;
	Tue, 20 Mar 2012 12:55:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120315075407.GA18246@odin.tremily.us>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193495>

I'm sorry I am only now answering, but unfortunately this patch has
fallen thought crack.

"W. Trevor King" <wking@drexel.edu> writes:

> The current gitweb only generates Last-Modified and handles
> If-Modified-Since headers for the git_feed action.  This patch breaks
> the Last-Modified and If-Modified-Since handling code out from
> git_feed into a new function modified_since.  This makes the code easy
> to reuse for other actions where it is appropriate,

That is a very good idea.

Of course adding support for If-Modified-Since has sense only if we
can calculate modification time without doing all the work (and
calculating modification time separately doesn;t add to work to be
done), or at least we are to send large amount of data so even if we
cannot save CPU time and I/O hit we can save network bandwidth.

> and I've added the code to do that in git_snapshot.

Nitpick about grammar: here you change from impersonal to personal
form in commit message, unnecessarily I think.

> Signed-off-by: W Trevor King <wking@drexel.edu>
> 
> ---
>  gitweb/gitweb.perl |   54 ++++++++++++++++++++++++++++++++++++---------------
>  1 files changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a8b5fad..96a13e7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7003,6 +7003,31 @@ sub snapshot_name {
>  	return wantarray ? ($name, $name) : $name;
>  }
>  
> +sub modified_since {
> +	my ($content_type, $latest_epoch, $timezone) = @_;

Passing $content_type to function named modified_since() looks quite
strange to me.

> +	our $cgi;
> +
> +	my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
> +	if (defined $if_modified) {
> +		my $since;
> +		if (eval { require HTTP::Date; 1; }) {
> +			$since = HTTP::Date::str2time($if_modified);
> +		} elsif (eval { require Time::ParseDate; 1; }) {
> +			$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
> +		}
> +		if (defined $since && $latest_epoch <= $since) {
> +			my %latest_date = parse_date($latest_epoch, $timezone);

Shouldn't we pass \%latest_date (or rather \%modification_date to be
more generic)?  Ah, I see that parse_date() subroutine does not store
original epoch not original timezone.

By the way, for $latest_date{'rfc2822'} we don't need $timezone
argument, and I think we should not pass it to generic
modified_since() function (or whatever it will be called).

> +			print $cgi->header(
> +				-type => $content_type,
> +				-charset => 'utf-8',

Do we need -charset here?  There is no HTTP body, and -charset => 'utf-8'
is incorrect for snapshots (with e.g. 'application/x-zip' $content_type)

> +				-last_modified => $latest_date{'rfc2822'},
> +				-status => '304 Not Modified');
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
>  sub git_snapshot {
>  	my $format = $input_params{'snapshot_format'};
>  	if (!@snapshot_fmts) {
> @@ -7029,6 +7054,14 @@ sub git_snapshot {
>  
>  	my ($name, $prefix) = snapshot_name($project, $hash);
>  	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
> +
> +	my %co = parse_commit($hash) or die_error(404, "Unknown commit object");
> +	if (! modified_since($known_snapshot_formats{$format}{'type'},
> +	                     $co{'committer_epoch'},
> +	                     $co{'committer_tz'})) {
> +		return;
> +	}

For a function named modified_since(), it does too many things.

I think a better idea would be to make this function/subroutine (named
e.g. if_modified_since() or something like that) to work more like
die_error() -- it should simply end request instead of having caller
to use complcated calling convention, and care about eraly termination
by itself.

This means turning modified_since() into subroutine (and renaming it),
and ending it with

  goto DONE_GITWEB;

or

  goto DONE_REQUEST;

depending on the code base you are applying to.

> +
>  	my $cmd = quote_command(
>  		git_cmd(), 'archive',
>  		"--format=$known_snapshot_formats{$format}{'format'}",
> @@ -7038,9 +7071,11 @@ sub git_snapshot {
>  	}
>  
>  	$filename =~ s/(["\\])/\\$1/g;
> +	my %latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
>  	print $cgi->header(
>  		-type => $known_snapshot_formats{$format}{'type'},
>  		-content_disposition => 'inline; filename="' . $filename . '"',
> +		-last_modified => $latest_date{'rfc2822'},
>  		-status => '200 OK');
>  

Have you run gitweb tests?  This simply has no way of working, as %co
variable you use here is not defined anywhere in git_snapshot()
subroutine.

What if there is no commit, for example if we are rewuesting snapshot
of a tree by its SHA-1?  We need to be able to deal with sich
situation, if only by not handling Last-Modified / If-Modified-Since.

>  	open my $fd, "-|", $cmd
> @@ -7821,22 +7856,9 @@ sub git_feed {
>  		%latest_commit = %{$commitlist[0]};
>  		my $latest_epoch = $latest_commit{'committer_epoch'};
>  		%latest_date   = parse_date($latest_epoch, $latest_commit{'comitter_tz'});

Do we use %latest_date beside handling If-Modified-Since?  Is there a
need for separate $latest_epoch and %;atest_date variables?

> -		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
> -		if (defined $if_modified) {
> -			my $since;
> -			if (eval { require HTTP::Date; 1; }) {
> -				$since = HTTP::Date::str2time($if_modified);
> -			} elsif (eval { require Time::ParseDate; 1; }) {
> -				$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
> -			}
> -			if (defined $since && $latest_epoch <= $since) {
> -				print $cgi->header(
> -					-type => $content_type,
> -					-charset => 'utf-8',
> -					-last_modified => $latest_date{'rfc2822'},
> -					-status => '304 Not Modified');
> -				return;
> -			}
> +		if (! modified_since($content_type, $latest_epoch,
> +		                     $latest_commit{'comitter_tz'})) {
> +			return;
>  		}
>  		print $cgi->header(
>  			-type => $content_type,
> -- 
> 1.7.3.4

-- 
Jakub Narebski
