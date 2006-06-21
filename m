From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: Use setlocale in addition to $ENV{LC_ALL} to set locale
Date: Wed, 21 Jun 2006 03:49:41 -0700
Message-ID: <20060621104941.GB15748@localdomain>
References: <7v3bdy5178.fsf@assigned-by-dhcp.cox.net> <11508811631669-git-send-email-jnareb@gmail.com> <e7b796$lj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 12:51:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0IL-0006lj-Jv
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 12:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWFUKtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 06:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWFUKtq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 06:49:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:29084 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751478AbWFUKtp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 06:49:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AA1447DC022;
	Wed, 21 Jun 2006 03:49:41 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 21 Jun 2006 03:49:41 -0700
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e7b796$lj$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22256>

Jakub Narebski <jnareb@gmail.com> wrote:
> Jakub Narebski wrote:
> 
> > $ENV{LC_ALL} = 'C'; does not change locale used by strftime.
> > Use setlocale( LC_ALL, 'C' ); instead.
> 
> >  # most mail servers generate the Date: header, but not all...
> >  $ENV{LC_ALL} = 'C';
> > -use POSIX qw/strftime/;
> > +use POSIX qw/strftime setlocale LC_ALL/;
> > +setlocale( &LC_ALL, 'C' );
> 
> Perhaps instead of 
>   setlocale( &LC_ALL, 'C' );
> we should use
>   setlocale( &LC_ALL, '' );
> (i.e. set the LC_ALL behaviour according to the locale environment
> variables). I'm not that versed in locale, POSIX and Perl.

I'm responsible for the $ENV{LC_ALL} = 'C' setting but I never actually
tested how things would work with a non-English locale (not being
well-versed in these things myself, either).

I've always wondered about why /usr/bin/822-date existed without
strftime on my Debian systems but never bothered asking, I guess this
could be a good reason why...

For reference, here's the /usr/bin/822-date script
(trailing whitespace fixed):

------- 8< -------

#!/usr/bin/perl --
# I hereby place this in the public domain - Ian Jackson, 1995.
# Changes by Klee Dienes also placed in public domain (1997).

# time structure:
# [ sec min hour mday mon year wday yday isdst ]

@ARGV && die "usage: 822-date\n";

$curtime = time;
@localtm = localtime ($curtime);
$localtms = localtime ($curtime);
@gmttm = gmtime ($curtime);
$gmttms = gmtime ($curtime);

if ($localtm[0] != $gmttm[0]) {
    die (sprintf ("local timezone differs from GMT by a non-minute interval\n"
		 . "local time: %s\n"
		 . "GMT time: %s\n", $localtms, $gmttms));
}

$localmin = $localtm[1] + $localtm[2] * 60;
$gmtmin = $gmttm[1] + $gmttm[2] * 60;

if ((($gmttm[6] + 1) % 7) == $localtm[6]) {
    $localmin += 1440;
} elsif ((($gmttm[6] - 1) % 7) == $localtm[6]) {
    $localmin -= 1440;
} elsif ($gmttm[6] == $localtm[6]) {
    1;
} else {
    die ("822-date: local time offset greater than or equal to 24 hours\n");
}

$offset = $localmin - $gmtmin;
$offhour = $offset / 60;
$offmin = abs ($offset % 60);

if (abs ($offhour) >= 24) {
    die ("822-date: local time offset greater than or equal to 24 hours\n");
}

printf
    (
     "%s, %2d %s %d %02d:%02d:%02d %s%02d%02d\n",
     (Sun,Mon,Tue,Wed,Thu,Fri,Sat)[$localtm[6]], # day of week
     $localtm[3],		# day of month
     (Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec)[$localtm[4]], # month
     $localtm[5]+1900,		# year
     $localtm[2],		# hour
     $localtm[1],		# minute
     $localtm[0],		# sec
     ($offset >= 0) ? '+' : '-',# TZ offset direction
     abs ($offhour),		# TZ offset hour
     $offmin,			# TZ offset minute
     ) || die "822-date: output error: $!\n";

------- 8< -------

-- 
Eric Wong
