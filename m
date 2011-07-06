From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: support to globally enable/disable a snapshot format
Date: Wed, 06 Jul 2011 06:59:51 -0700 (PDT)
Message-ID: <m339ij5x3s.fsf@localhost.localdomain>
References: <8E0889CB-8A0A-45A5-AF34-9643D4EEFCEF@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mark A Rada" <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Wed Jul 06 16:00:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeSe3-0006zd-11
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 16:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab1GFN7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 09:59:54 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:62889 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1GFN7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 09:59:53 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so111521fxd.11
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:user-agent:mime-version:content-type;
        bh=kz99ZJfaP2UBpJQ8i9aeHeKRrxKDJslBscsmO9WSS5w=;
        b=Rr4ohbzAUmcYillO8erCfWoM+K8qAdZMJe/IlI3OLJtCgM4PWebiecVk4W5G/d1yFV
         GmEmFl12UuNDA3JFvdE7kE0wle5vKgh3oiy2xRz8tyEsjO0cc6acm99q8qRTQYUKUM6L
         rmvO5EAd3BCcuR9zIbtQrtMFZZcQSi4xO21Fo=
Received: by 10.223.13.10 with SMTP id z10mr13096651faz.69.1309960792990;
        Wed, 06 Jul 2011 06:59:52 -0700 (PDT)
Received: from localhost.localdomain (abvw74.neoplus.adsl.tpnet.pl [83.8.220.74])
        by mx.google.com with ESMTPS id j23sm6039889fai.15.2011.07.06.06.59.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 06:59:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p66DxKYH011607;
	Wed, 6 Jul 2011 15:59:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p66Dx4Db011598;
	Wed, 6 Jul 2011 15:59:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176704>

Mark A Rada <marada@uwaterloo.ca> writes:
> On 1-Aug-09, at 4:14 AM, Jakub Narebski wrote:
>> "J.H." <warthog19@eaglescrag.net> writes:
>>
>>> Well you can always call xz with -[1-9] to change the compression
>>> level (same as gzip and bzip2) though I think a full disabling would
>>> be 'more' preferable, though I'm not sure I like Jakub's suggestion
>>> of just deleting it after the fact, it would work.
>> [...]
>>
>> The problem is that 'keys %known_snapshot_formats' serves also as list
>> of allowed snapshot formats, if project specific override is enabled.
>> We can add another optional flag ('disabled' => 1) if you don't want
>> to delete from %known_snapshot_formats in $GITWEB_CONFIG, though I
>> don't know if it is worth it.  Anyway such mechanism can be added, and
>> IMHO should be added, in a separate commit.
> 
> Is this correct?

Thanks for doing it.

It is correct, although I had in mind slightly different solution

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3398163..0a9cec6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -167,27 +167,31 @@ our %known_snapshot_formats = (
>   	'txz' => {
>   		'display' => 'tar.xz',
>   		'type' => 'application/x-xz',
>   		'suffix' => '.tar.xz',
>   		'format' => 'tar',
> -		'compressor' => ['xz']},
> +		'compressor' => ['xz'],
> +		'enabled' => 1},

I'd rather use here, taking for example 'txz' as "known but disabled"

  +		'compressor' => ['xz'],
  +		'disabled' => 1},


>   	'zip' => {
>   		'display' => 'zip',
>   		'type' => 'application/x-zip',
>   		'suffix' => '.zip',
> 		'format' => 'zip'},
>   );

And then you would not need to modify the rest of snapshot formats,
making use of the fact that $hash{'key'} is false-ish, if 'key' does
not exist in hash.

Also, this should be documented at least in comments.
 
>   # Aliases so we understand old gitweb.snapshot values in repository
> @@ -5171,6 +5175,8 @@ sub git_snapshot {
>   		die_error(400, "Unknown snapshot format");
>   	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
>   		die_error(403, "Unsupported snapshot format");
> +	} elsif (!$known_snapshot_formats{$format}{'enabled'}) {
> +		die_error(403, "Snapshot format not allowed");

This would be modified then to read:

  +	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
  +		die_error(403, "Snapshot format not allowed");

Also, we want not only protect againts *using* known but disabled
format, but also do not display it as one of formats available, even
if project specific override is supprted for snapshot, and projects
list it in gitweb.snapshot:

@@ -509,7 +509,8 @@ sub filter_snapshot_fmts {
 		exists $known_snapshot_format_aliases{$_} ?
 		       $known_snapshot_format_aliases{$_} : $_} @fmts;
 	@fmts = grep {
-		exists $known_snapshot_formats{$_} } @fmts;
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'} } @fmts;
 }
 
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";


-- 
Jakub Narebski
Poland
ShadeHawk on #git
