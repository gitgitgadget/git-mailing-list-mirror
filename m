From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 3/3] gitweb: add If-Modified-Since handling to git_snapshot().
Date: Tue, 27 Mar 2012 23:31:37 +0100
Message-ID: <201203280031.38011.jnareb@gmail.com>
References: <20120326191418.GB9041@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 00:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCevb-0002zj-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 00:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910Ab2C0Wbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 18:31:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37657 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026Ab2C0Wbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 18:31:38 -0400
Received: by wgbdr13 with SMTP id dr13so352132wgb.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=/xTnjGcsX+iv54kbsfEy1fCslvglzzXBf2Dl7nC/+lA=;
        b=tNH3rX0T7UhBq4tjrAxRetlFsYuJbEAkDAet8RFAJ2dcd/tqXSRp05FjSzib03XZKT
         KuO1ZGy6YW508L6TFjLAmKupdTm6Q4iwXyoT4sXukXrAtaQ+57CEyyLPwnsGoM1JtV38
         qWByIXJYtw1txDNP97tGDD1ttz8L1ZuXOLLAouDFrtmy9C94D1QI52LcljUqwVHXHRgy
         vPttvsOF3vB4Obx3Fsk6hzMSGbm7/1bw56/k0RXk53jtIncM68SFkW9tbLl++Oq9G9VJ
         eLNNRc09TlleNDnN9N+ygtEQyECI3PDJc73X71DqGoYI5CZi9zOw2X/wy7XFoEPA/m7f
         swAg==
Received: by 10.180.80.40 with SMTP id o8mr1536265wix.10.1332887497071;
        Tue, 27 Mar 2012 15:31:37 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id e6sm52918808wix.8.2012.03.27.15.31.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 15:31:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120326191418.GB9041@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194091>

On Mon, 26 Mar 2012, W. Trevor King wrote:

> Because snapshots can be large, you can save some bandwidth by
> supporting caching via If-Modified-Since.  This patch adds support for
> the i-m-s request to git_snapshot() if the requested hash is a commit.

"if the requested hash is a commit" means here "if we request snapshot
of a commit", isn't it?

> Requests for snapshots of tree-ishes, which lack well defined
> timestamps, are still handled as they were before.

s/tree-ishes/trees/.  Commit is tree-ish but not a tree; it is tree
that lacks timestamp that commit has.

> 
> Signed-off-by: W Trevor King <wking@drexel.edu>
> ---
>  gitweb/gitweb.perl                       |   21 +++++++++++++++---
>  t/t9501-gitweb-standalone-http-status.sh |   33 ++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 229f3da..be9ad5d 100755
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

O.K.  Nice.

>  	my $cmd = quote_command(
>  		git_cmd(), 'archive',
>  		"--format=$known_snapshot_formats{$format}{'format'}",
> @@ -7060,10 +7064,19 @@ sub git_snapshot {
>  	}
>  
>  	$filename =~ s/(["\\])/\\$1/g;
> -	print $cgi->header(
> -		-type => $known_snapshot_formats{$format}{'type'},
> -		-content_disposition => 'inline; filename="' . $filename . '"',
> -		-status => '200 OK');
> +	if (%co) {
> +		my %latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
> +		print $cgi->header(
> +			-type => $known_snapshot_formats{$format}{'type'},
> +			-content_disposition => 'inline; filename="' . $filename . '"',
> +			-last_modified => $latest_date{'rfc2822'},
> +			-status => '200 OK');
> +	} else {
> +		print $cgi->header(
> +			-type => $known_snapshot_formats{$format}{'type'},
> +			-content_disposition => 'inline; filename="' . $filename . '"',
> +			-status => '200 OK');
> +	}

This can be written shorter, and with less code repetition using ?: 
conditional operator:

> +	print $cgi->header(
> +		-type => $known_snapshot_formats{$format}{'type'},
> +		-content_disposition => 'inline; filename="' . $filename . '"',
> +		 (%co ? -last_modified => $latest_date{'rfc2822'} : ()),
> +		-status => '200 OK');

...or something like that.

>  
>  	open my $fd, "-|", $cmd
>  		or die_error(500, "Execute git-archive failed");
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 0e49f29..38e90bd 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh

Same comments as for 2/3.

-- 
Jakub Narebski
Poland
