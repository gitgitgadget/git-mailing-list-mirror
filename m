From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v6 3/3] gitweb: add If-Modified-Since handling to git_snapshot().
Date: Wed, 28 Mar 2012 17:08:55 +0100
Message-ID: <201203281808.56432.jnareb@gmail.com>
References: <201203281613.52624.jnareb@gmail.com>  <8129a671c793613ad2a0b00e1239e6a7ded7491a.1332949186.git.wking@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 18:09:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCvQm-0004Ar-8d
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 18:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302Ab2C1QI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 12:08:58 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56166 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258Ab2C1QI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 12:08:57 -0400
Received: by wejx9 with SMTP id x9so740427wej.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=i9sWX5DM+QoszBkUv4bXi0umN8OJu4MhQ7HvfIcR+qI=;
        b=SqWK/+LKbrFOzwG6ZjkuKy7mfSY4GksvDTi8eVhO9MYNR73TeRU3BbCAcPVlBWq7UN
         r48wCrWCDfN5lgxnF5LQhkSLXzcy92+yssog1tI6BejIApwZZqZosCmp4zFGLNANmtC6
         MQn38heGyhLw2l4pbyF26ARBhD38rQ2xw2fYt5+QKDa6c42aRFfmDe7A7VecDCBqlhi5
         Hezh5Ytuitcyjt44zB1OhvzGwbCv75J/PyeD4By+8KnOrUKVmMPzTSpiNveMVR/oTxzz
         T2vlr/qEhbXqCWUz6ILG0f45m+29AL+CCDL+drBbHay87H5Zndr8OAVXw2eqalYeLRK+
         6fqw==
Received: by 10.216.136.157 with SMTP id w29mr17884142wei.23.1332950936428;
        Wed, 28 Mar 2012 09:08:56 -0700 (PDT)
Received: from [192.168.1.13] (euy254.neoplus.adsl.tpnet.pl. [83.20.196.254])
        by mx.google.com with ESMTPS id o2sm14932116wiv.11.2012.03.28.09.08.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 09:08:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8129a671c793613ad2a0b00e1239e6a7ded7491a.1332949186.git.wking@drexel.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194142>

On Wed, 28 Mar 2012, wking@tremily.us wrote:

> Because snapshots can be large, you can save some bandwidth by
> supporting caching via If-Modified-Since.  This patch adds support for
> the i-m-s request to git_snapshot() if the request is a commit.
> Requests for snapshots of trees, which lack well defined timestamps,
> are still handled as they were before.
> 
> Signed-off-by: W Trevor King <wking@drexel.edu>
> ---
>  gitweb/gitweb.perl                       |   10 +++++++++
>  t/t9501-gitweb-standalone-http-status.sh |   33 ++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ba106c1..591c793 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7051,6 +7051,10 @@ sub git_snapshot {
>  
>  	my ($name, $prefix) = snapshot_name($project, $hash);
>  	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
> +
> +	my %co = parse_commit($hash);
> +	exit_if_unmodified_since($co{'committer_epoch'}) if %co;
> +

Nice.

>  	my $cmd = quote_command(
>  		git_cmd(), 'archive',
>  		"--format=$known_snapshot_formats{$format}{'format'}",
> @@ -7060,9 +7064,15 @@ sub git_snapshot {
>  	}
>  
>  	$filename =~ s/(["\\])/\\$1/g;
> +	my %latest_date;
> +	if (%co) {
> +		%latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
> +	}
> +

That is probably more readable than

  +	%latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'})
  +		if %co;

>  	print $cgi->header(
>  		-type => $known_snapshot_formats{$format}{'type'},
>  		-content_disposition => 'inline; filename="' . $filename . '"',
> +		-last_modified => (%co ? $latest_date{'rfc2822'} : undef),
>  		-status => '200 OK');
>  

Same issue as with previous patch:

   	print $cgi->header(
   		-type => $known_snapshot_formats{$format}{'type'},
   		-content_disposition => 'inline; filename="' . $filename . '"',
  +		%co ? (-last_modified => $latest_date{'rfc2822'}) : (),
   		-status => '200 OK');


>  	open my $fd, "-|", $cmd
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index afa6bd4..1487820 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -138,6 +138,39 @@ test_expect_success 'modification: feed if-modified-since (unmodified)' '
>  '
>  test_debug 'cat gitweb.headers'
>  
> +test_expect_success 'modification: snapshot last-modified' '
> +	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output &&
> +	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'modification: snapshot if-modified-since (modified)' '
> +	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
> +	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'modification: snapshot if-modified-since (unmodified)' '
> +	export HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
> +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
> +	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
> +	grep "Status: 304 Not Modified" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'modification: tree snapshot' '
> +	ID=`git rev-parse --verify HEAD^{tree}` &&
> +	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output &&
> +	! grep "Last-Modified" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'

Good!

-- 
Jakub Narebski
Poland
