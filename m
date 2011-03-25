From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX)] gitweb: Fix handling of fractional timezones in parse_date
Date: Fri, 25 Mar 2011 16:20:27 +0100
Message-ID: <201103251620.28811.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net> <201103241617.37400.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
	Junio Hamano <gitster@pobox.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 16:20:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q38of-00015Q-Ms
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 16:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab1CYPUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 11:20:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43167 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab1CYPUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 11:20:39 -0400
Received: by fxm17 with SMTP id 17so1232090fxm.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=9JcYls6nuywcA/OgpO7IpbENSr4IXHNUftk1trnf4mU=;
        b=rHY2nAXlzRtJoKzuK2VKV6Ya0mAy4YV8mKr+NpXhYmZ9sv9sbkANFQ7IB8zwqJfdNv
         Cm+aNmTojLsq2OtLgZX1REI+Db3L4Ky22SHbROBj2UNssQvAogXNvpQwy2XG4EJHjsbS
         ysPrPLPrhLYeOSzd5/6MCjprfHwkIeMCo2Y/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=T6iDAQgU+qWznxqMYbWuF+BZwrGNaQPvEh2or9YisOYK7T/JaIO1OSO8jl/xsb7DFJ
         g6EBMeN9DVkJ1nYaDWjpmKIZmh2n1AgL5T0vA2t+Vtvny0WI3WPYrRSODyp7wfoBwYj4
         N0tpGnmHiqmQi+TfUax5ZakoxIKYL+a7Phcn0=
Received: by 10.223.63.212 with SMTP id c20mr1017345fai.37.1301066438591;
        Fri, 25 Mar 2011 08:20:38 -0700 (PDT)
Received: from [192.168.1.13] (abwk172.neoplus.adsl.tpnet.pl [83.8.234.172])
        by mx.google.com with ESMTPS id n9sm469587fax.3.2011.03.25.08.20.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 08:20:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201103241617.37400.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169990>

Fractional timezones, like -0330 (NST used in Canada) or +0430
(Afghanistan, Iran DST), were not handled properly in parse_date; this
means values such as 'minute_local' and 'iso-tz' were not generated
correctly.

This was caused by two mistakes:

* sign of timezone was applied only to hour part of offset, and not
  as it should be also to minutes part (this affected only negative
  fractional timezones).

* 'int $h + $m/60' is 'int($h + $m/60)' and not 'int($h) + $m/60',
  so fractional part was discarded altogether ($h is hours, $m is
  minutes, which is always less than 60).


Note that positive fractional timezones +0430, +0530 and +1030 can be
found as authortime in git.git repository itself.

For example http://repo.or.cz/w/git.git/commit/88d50e7 had authortime
of "Fri, 8 Jan 2010 18:48:07 +0000 (23:48 +0530)", which is not marked
with 'atnight', when "git show 88d50e7" gives correct author date of
"Sat Jan 9 00:18:07 2010 +0530".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, 24 Mar 2011, Jakub Narebski wrote:
> On Thu, 24 Mar 2011, John 'Warthog9' Hawley wrote:

> > With each timezone being +1hr to the previous.  The code is capable of
> > handling fractional timezones, but those have not been added.

No, it isn't (see my other email).
 
> NOTE: I think that current gitweb code (parse_date / format_date) doesn't
> handle negative fractional timezones correctly.  
> 
>         $tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
>         my $local = $epoch + ((int $1 + ($2/60)) * 3600);

This patch fixed this bug (actually two bugs ;-)).

> Though git.git repository doesn't contain negative fractional timezones...
> it does contain positive fractional timezones however.
> 
>   $ git log --pretty='%ai%n%ci' --all | cut -d' ' -f 3 | sort -n | uniq
> 
> Could anyone check it e.g. on Linux kernel repository?

Anyone?

 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0178633..256062e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2921,8 +2921,10 @@ sub parse_date {
 	$date{'iso-8601'}  = sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
 	                     1900+$year, 1+$mon, $mday, $hour ,$min, $sec;
 
-	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
-	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
+	my ($tz_sign, $tz_hour, $tz_min) =
+		($tz =~ m/^([+\-])([0-9][0-9])([0-9][0-9])$/);
+	$tz_sign = ($tz_sign eq '-' ? -1 : +1);
+	my $local = $epoch + $tz_sign*($tz_hour + ($tz_min/60.0))*3600;
 	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
 	$date{'hour_local'} = $hour;
 	$date{'minute_local'} = $min;
-- 
1.7.3
