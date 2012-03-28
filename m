From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v7 3/3] gitweb: add If-Modified-Since handling to git_snapshot().
Date: Wed, 28 Mar 2012 19:11:31 +0100
Message-ID: <201203282011.32148.jnareb@gmail.com>
References: <20120328164513.GA4389@odin.tremily.us>  <81004880a876bb9b9f607129956363d3167bff72.1332956550.git.wking@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:11:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxLh-0002iz-HM
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758508Ab2C1SLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:11:34 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37200 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757381Ab2C1SLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:11:33 -0400
Received: by wgbdr13 with SMTP id dr13so1231996wgb.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Ak4cjUoMRu8zRlA/tWHef57UQQ0LtmjEdT5guL2fKZc=;
        b=JkRXUDfrdL0udCaF6iYa6qzcG/Oh3QtpHZohyvasHuCiymm9OIFZVOUCa6DA3Uxf1Q
         UAoqBV8cvaPa+/boRnA7k+7oWBwU+9BWV2KFYvUVBM9tWnoZsLSXBBNdugdH5baK7wi9
         X0nIwgi/3dc7KjNmyKjObvnIrA9mmEihKnzSFEQIZrjqj+efb0uKzd4/FmL6n7s+HBM2
         iULNBIeV284H/CHxEkhr59QM8dv6pkKlomSmzDxxyOMYRXs1ZU/hUdvwGZPC/T/aAhoI
         4rb3oMQw+AjyO5ut4UxVRsrEUTjrFM4XFcoV+7TyUv0ckCOp4nGBcWItM8PjXMCeI21J
         TXVA==
Received: by 10.216.134.136 with SMTP id s8mr18119844wei.6.1332958292060;
        Wed, 28 Mar 2012 11:11:32 -0700 (PDT)
Received: from [192.168.1.13] (euy254.neoplus.adsl.tpnet.pl. [83.20.196.254])
        by mx.google.com with ESMTPS id ff2sm16178233wib.9.2012.03.28.11.11.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 11:11:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <81004880a876bb9b9f607129956363d3167bff72.1332956550.git.wking@drexel.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194155>

W. Trevor King wrote:

> @@ -7060,9 +7064,15 @@ sub git_snapshot {
>  	}
>  
>  	$filename =~ s/(["\\])/\\$1/g;
> +	my %latest_date;
> +	if (%co) {
> +		%latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
> +	}
> +
>  	print $cgi->header(
>  		-type => $known_snapshot_formats{$format}{'type'},
>  		-content_disposition => 'inline; filename="' . $filename . '"',
> +		-last_modified => (%co ? $latest_date{'rfc2822'} : ()),
>  		-status => '200 OK');

I'm sorry to be bearer of bad news, but this is still incorrect.
It should be:

   	print $cgi->header(
   		-type => $known_snapshot_formats{$format}{'type'},
   		-content_disposition => 'inline; filename="' . $filename . '"',
  +		%co ? (-last_modified => $latest_date{'rfc2822'}) : (),
   		-status => '200 OK');

(The "fat comma" => operator has relatively low priority, lower than
ternary conditional operator ?:)
  
> +test_expect_success 'modification: tree snapshot' '
> +	ID=`git rev-parse --verify HEAD^{tree}` &&
> +	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output &&
> +	! grep "Last-Modified" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'

And it was not caught by test because CGI.pm can output the last modified
header as "Last-modified" (RFC 2616, sec 4.2 states "Field names are
case-insensitive"), so the last check should be

  +	! grep -i "Last-Modified" gitweb.output

Hmmm... why we use gitweb.output and not gitweb.headers?  Is it consistency
with earlier tests?

-- 
Jakub Narebski
Poland
