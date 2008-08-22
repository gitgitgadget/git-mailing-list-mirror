From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 15:01:54 +0200
Message-ID: <200808221501.54908.jnareb@gmail.com>
References: <200808221256.21805.jnareb@gmail.com> <1219408777-13513-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWWIH-0007Ka-NT
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbYHVNCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbYHVNCD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:02:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:21174 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYHVNCB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:02:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so208409nfc.21
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VTEGs5m35PoevLFLb57EeeZVmy5rEe9vCbQswEWz9yM=;
        b=UfaWId+c4aoWcY8nrnO/3iqEDdFvw5bCf4FpPvRjb2d89Tsh5LRbBNYLQUDzamXVgT
         KF1C/f8n+kj8AR2sAuli8JZSkEtqBg1NOOqD7EcxdGSPfv7ANyj65FMldnAP6ceg3vyQ
         la36M98CTG8vN+y71PwHRYm8TmXtagNch61c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aXEK//ZQEBAJJxPUYOtk5b56WkaZrkI/un0uUBa1dMEMyJvl0xEI12qlFb1Ujo8BUa
         9SPK/bUf62vTg6b/oQ0T3nbgaxtnYk2J7FoHeHpYspR7i3kWpdjr5zSfI65hYTYW5G3V
         Qld4jjAjUpsAo4M2DfVA47BpD3Vrzirqfugmg=
Received: by 10.210.18.8 with SMTP id 8mr1439718ebr.147.1219410119654;
        Fri, 22 Aug 2008 06:01:59 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.249.91])
        by mx.google.com with ESMTPS id 20sm1375500eyc.9.2008.08.22.06.01.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 06:01:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1219408777-13513-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93291>

On Fri, 22 August 2008, Giuseppe Bilotta wrote:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a0d9272..5cb332f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1201,7 +1201,12 @@ sub format_ref_marker {
>  	my $markers = '';
>  
>  	if (defined $refs->{$id}) {
> -		foreach my $ref (@{$refs->{$id}}) {
> +		foreach my $aref (@{$refs->{$id}}) {
> +			# this code exploits the fact that non-lightweight tags are the
> +			# only indirect objects, and that they are the only objects for which
> +			# we want to use tag instead of shortlog as action
> +			my $ref = $aref->[0];
> +			my $indirect = $aref->[1];
>  			my ($type, $name) = qw();
>  			# e.g. tags/v2.6.11 or heads/next
>  			if ($ref =~ m!^(.*?)s?/(.*)$!) {
> @@ -1212,8 +1217,14 @@ sub format_ref_marker {
>  				$name = $ref;
>  			}
>  
> -			$markers .= " <span class=\"$type\" title=\"$ref\">" .
> -			            esc_html($name) . "</span>";
> +			my $class = $type;
> +			if ($indirect) {
> +				$class .= " indirect";
> +			}
> +
> +			$markers .= " <span class=\"$class\" title=\"$ref\">" .
> +				$cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"), hash=>$ref)}, $name) .
> +				"</span>";
>  		}
>  	}
>  
> @@ -2035,11 +2046,11 @@ sub git_get_references {
>  
>  	while (my $line = <$fd>) {
>  		chomp $line;
> -		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
> +		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)(\^\{\})?$!) {
>  			if (defined $refs{$1}) {
> -				push @{$refs{$1}}, $2;
> +				push @{$refs{$1}}, [$2, $3];
>  			} else {
> -				$refs{$1} = [ $2 ];
> +				$refs{$1} = [ [$2, $3] ];
>  			}
>  		}
>  	}

Seems overly complicated.  How about something like this, instead?
It simply moves stripping ^{} from refs to format_ref_marker(),
and uses "tags/v1.5.0^{}" instead of [ "tags/v1.5.0", 1 ].

NOT TESTED!

 gitweb/gitweb.perl |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4c104d2..261307f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1096,18 +1096,24 @@ sub format_ref_marker {
 
 	if (defined $refs->{$id}) {
 		foreach my $ref (@{$refs->{$id}}) {
-			my ($type, $name) = qw();
+			my ($class, $name, $indirect) = qw();
+			# strip ^{} suffix from indirect refs, like tags/v2.6.11^{}
+			$indirect = ($ref =~ s/\^{}$//);
 			# e.g. tags/v2.6.11 or heads/next
 			if ($ref =~ m!^(.*?)s?/(.*)$!) {
-				$type = $1;
-				$name = $2;
+				$class = $1;
+				$name  = $2;
 			} else {
-				$type = "ref";
-				$name = $ref;
+				$class = "ref";
+				$name  = $ref;
 			}
+			$class .= " indirect" if $indirect;
 
-			$markers .= " <span class=\"$type\" title=\"$ref\">" .
-			            esc_html($name) . "</span>";
+			$markers .= " <span class=\"$class\" title=\"$ref\">" .
+			            esc_html($name) .
+			            $cgi->a({-href => href(action=>($indirect ? "tag" : "shortlog"),
+			                                   hash=>$ref)}, $name) .
+			            "</span>";
 		}
 	}
 
@@ -1959,7 +1965,7 @@ sub git_get_references {
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?.+)$!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {


-- 
Jakub Narebski
Poland
