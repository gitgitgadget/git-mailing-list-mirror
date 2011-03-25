From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX) v3] gitweb: Fix handling of fractional timezones in parse_date
Date: Fri, 25 Mar 2011 20:20:49 +0100
Message-ID: <201103252020.51516.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <AANLkTik5bLaR_0uhqGrNWW6U7z82KfmpNTyvRwkKFfj+@mail.gmail.com> <7v8vw36s0r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 20:21:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3CZM-0007Uq-JG
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 20:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab1CYTVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 15:21:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65511 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab1CYTVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 15:21:05 -0400
Received: by bwz15 with SMTP id 15so1141219bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=WTj9KEuCFE3dkPXqUE/q/t8gpVCeAzzdY8D8bWdeaw0=;
        b=rU4ehf/W2+hMb/VyYoXXkD7+Ak3wlGPwAHFy/Vyg1InuM+Kk2AKxouGkZneJIBeBXu
         oWIBG3JULWDnTkbOuiPamYyxMFNJZijsgd0sB+JXbpIkZVjbSGuDifT4h0M0UTqmQfGC
         cchae60D1F07j+r0TecxB4ROmJPOGkjVlZsMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=S+ovKPI6C32a2ODJcdD1XzPKWHJPvzUDBnBrRQ6G86ku2LGGEHPAkLRm1JxrF1IZCh
         7s8+VL6OcXfo7KW76/bUXTXVVTV1kLOcvkb6hQUixkKFuVvl90S6q+GGnTQ9Kj5yxFpT
         HCKQZtKejeClYMHzZ6LTAmzeSYxFG3sZsBFoI=
Received: by 10.204.127.88 with SMTP id f24mr1091421bks.54.1301080862186;
        Fri, 25 Mar 2011 12:21:02 -0700 (PDT)
Received: from [192.168.1.13] (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id c11sm984652bkc.2.2011.03.25.12.20.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 12:21:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8vw36s0r.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170014>

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
Junio C Hamano wrote:
> Kevin Cernekee <cernekee@gmail.com> writes:
> 
> > It's just a matter of personal preference, but I would find this
> > regexp slightly easier to read:
> >
> > +               ($tz =~ m/^([+\-])([0-9]{2})([0-9]{2})$/);
> 
> I'd say "^([-+])(\d\d)(\d\d)$" makes it the most clear.
> 
> > > +       $tz_sign = ($tz_sign eq '-' ? -1 : +1);
> > > +       my $local = $epoch + $tz_sign*($tz_hour + ($tz_min/60.0))*3600;
> >
> > If you wanted to avoid floats, you could do something like:
> >
> > +       my $local = $epoch + $tz_sign * ($tz_hour * 3600 + $tz_min * 60);
> 
> That is not just float-avoidance, but is much more logical.
> 
> 	(($h * 60) + $m) * 60
> 
> may be even more logical and more readable, though.
> 
> Care to re-roll the patch?

Re-rolled.

 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0178633..ee69ea6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2921,8 +2921,10 @@ sub parse_date {
 	$date{'iso-8601'}  = sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
 	                     1900+$year, 1+$mon, $mday, $hour ,$min, $sec;
 
-	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
-	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
+	my ($tz_sign, $tz_hour, $tz_min) =
+		($tz =~ m/^([-+])(\d\d)(\d\d)$/);
+	$tz_sign = ($tz_sign eq '-' ? -1 : +1);
+	my $local = $epoch + $tz_sign*((($tz_hour*60) + $tz_min)*60);
 	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
 	$date{'hour_local'} = $hour;
 	$date{'minute_local'} = $min;
-- 
1.7.3
