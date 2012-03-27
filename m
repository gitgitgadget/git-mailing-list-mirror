From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/3] gitweb: refactor If-Modified-Since handling
Date: Tue, 27 Mar 2012 23:24:20 +0100
Message-ID: <201203280024.20805.jnareb@gmail.com>
References: <20120326173646.GA6524@odin.tremily.us> <7vsjgvnr4x.fsf@alter.siamese.dyndns.org> <20120326191242.GA9041@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 00:24:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCeoV-0006Mj-49
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 00:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225Ab2C0WYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 18:24:22 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64088 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab2C0WYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 18:24:21 -0400
Received: by wibhj6 with SMTP id hj6so5859208wib.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=2x6W+u10C8rDhvc1UyUeo5cZOf0xEqMctTA/WH0Y1RY=;
        b=RKyaXGDl4gcpDh6x6V1+IiSptSikwNuw890g69ZDYg3dTiLpvr1oQfYnhdZRC57m89
         HL9s4RuJMKtJiqvMGP5OpWB46iLIk9CcRLMQVRxEVCbuyxkE4DswF7TvvVtDygFvwTWp
         plXI0fT2Dnlpn+bnnIulrGrqBacx7wKnaRU7ec+eIsRZ7ubkk6KnTTlE9kOUw+NT1zTY
         uUxKDj/OFYw7UI5wefSDw7XgnBbsQWD2u+nijnsFxO5O8ZT0BpkinKycOFcu1nIBllif
         xkaJk3Mavo52dobcbVIeCLgPyWkDPKymjWBtYON8I9XZDKcLTkyAaNXAYus1GVOSdjvP
         qd7Q==
Received: by 10.180.80.104 with SMTP id q8mr1481089wix.14.1332887060211;
        Tue, 27 Mar 2012 15:24:20 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id b3sm52892018wib.4.2012.03.27.15.24.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 15:24:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120326191242.GA9041@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194090>

On Mon, 26 Mar 2012, W. Trevor King wrote:

> The current gitweb only generates Last-Modified and handles
> If-Modified-Since headers for the git_feed action.  This patch breaks
> the Last-Modified and If-Modified-Since handling code out from
> git_feed into a new function exit_if_unmodified_since.  This makes the
> code easy to reuse for other actions.

Nice description, and I think quite good name for a subroutine.  Well,
good enough; any more we would drown in bikeshed-ding.
> 
> Only gitweb actions which can easily calculate a modification time
> should use exit_if_unmodified_since, as the goal is to balance local
> processing time vs. upload bandwidth.

Good.
>
> Signed-off-by: W Trevor King <wking@drexel.edu>
> ---
> Patch v4 1/3 is unchanged.  Should I mail it back in with a
> [PATCH v5 1/3] tag?
> 
> Changes since v4:
> * die_if_unmodified() -> exit_if_unmodified_since()
> * Added missing `&&` to tests for feed-last-modified (patch 2/3) and
>   snapshot-last-modified (patch 3/3).
> 
>  gitweb/gitweb.perl                       |   40 +++++++++++++++++------------
>  t/t9501-gitweb-standalone-http-status.sh |   27 +++++++++++++++++++-
>  2 files changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 041da17..229f3da 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7003,6 +7003,28 @@ sub snapshot_name {
>  	return wantarray ? ($name, $name) : $name;
>  }
>  
> +sub exit_if_unmodified_since {
> +	my ($latest_epoch) = @_;

We could have made \%latest_date an optional parameter...

  +	my ($latest_epoch, $latest_date) = @_;

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
> +			my %latest_date = parse_date($latest_epoch);

...and use it if provided

  +			my %latest_date = ref($latest_date) eq 'HASH' 
  +				? %$latest_date : parse_date($latest_epoch);

but something is to be said for simplicity.  We need epoch for comparison
anyway.

> +			print $cgi->header(
> +				-last_modified => $latest_date{'rfc2822'},
> +				-status => '304 Not Modified');

O.K. we lose some unnecessary headers; never mind that.  What is
important is here.

> +			goto DONE_GITWEB;
> +		}
> +	}
> +}
> +
>  sub git_snapshot {
>  	my $format = $input_params{'snapshot_format'};
>  	if (!@snapshot_fmts) {
> @@ -7820,24 +7842,8 @@ sub git_feed {
>  	if (defined($commitlist[0])) {
>  		%latest_commit = %{$commitlist[0]};
>  		my $latest_epoch = $latest_commit{'committer_epoch'};
> +		exit_if_unmodified_since($latest_epoch);
>  		%latest_date   = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
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
> -		}
>  		print $cgi->header(
>  			-type => $content_type,
>  			-charset => 'utf-8',
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 31076ed..0e49f29 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -92,7 +92,7 @@ test_debug 'cat gitweb.output'
>  test_expect_success 'snapshots: bad tree-ish id (tagged object)' '
>  	echo object > tag-object &&
>  	git add tag-object &&
> -	git commit -m "Object to be tagged" &&
> +	test_tick && git commit -m "Object to be tagged" &&
>  	git tag tagged-object `git hash-object tag-object` &&
>  	gitweb_run "p=.git;a=snapshot;h=tagged-object;sf=tgz" &&
>  	grep "400 - Object is not a tree-ish" gitweb.output
> @@ -112,6 +112,31 @@ test_expect_success 'snapshots: bad object id' '
>  '
>  test_debug 'cat gitweb.output'
>  
> +# ----------------------------------------------------------------------
> +# modification times (Last-Modified and If-Modified-Since)
> +
> +test_expect_success 'modification: feed last-modified' '
> +	gitweb_run "p=.git;a=atom;h=master" &&
> +	grep "Status: 200 OK" gitweb.output &&
> +	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
> +'

All right.

What's that date from?  Wouldn't it be better to read it from commit
object with `git show -s --pretty=%cD HEAD` or postprocessed from
'%ct' timestamp?

> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'modification: feed if-modified-since (modified)' '
> +	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	gitweb_run "p=.git;a=atom;h=master" &&
> +	unset HTTP_IF_MODIFIED_SINCE &&
> +	grep "Status: 200 OK" gitweb.output
> +'

I think it *might* be better solution to use test_when_finished:

  +test_expect_success 'modification: feed if-modified-since (modified)' '
  +	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
  +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
  +	gitweb_run "p=.git;a=atom;h=master" &&
  +	grep "Status: 200 OK" gitweb.output
  +'

I don't think we need sane_unset here.

> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'modification: feed if-modified-since (unmodified)' '
> +	export HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
> +	gitweb_run "p=.git;a=atom;h=master" &&
> +	unset HTTP_IF_MODIFIED_SINCE &&
> +	grep "Status: 304 Not Modified" gitweb.output
> +'

Same here.

> +test_debug 'cat gitweb.headers'
>  
>  # ----------------------------------------------------------------------
>  # load checking
> -- 
> 1.7.3.4
> 

-- 
Jakub Narebski
Poland
