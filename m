From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] t5300-pack-object.sh: portability issue using  /usr/bin/stat
Date: Fri, 06 Apr 2007 19:45:06 -0700
Message-ID: <86odm0sy19.fsf@blue.stonehenge.com>
References: <20070406234903.GJ3854@regex.yaph.org>
	<7vfy7dgcn1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: arjen@yaph.org (Arjen Laarhoven),
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 04:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha0vl-0000at-In
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 04:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbXDGCpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 22:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbXDGCpI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 22:45:08 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:28633 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965116AbXDGCpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 22:45:07 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id AA7291DEF8E; Fri,  6 Apr 2007 19:45:06 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.14; tzolkin = 11 Ix; haab = 2 Pop
In-Reply-To: <7vfy7dgcn1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 06 Apr 2007 19:08:02 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43957>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> arjen@yaph.org (Arjen Laarhoven) writes:
>> In the test 'compare delta flavors', /usr/bin/stat is used to get file size.
>> This isn't portable.  There already is a dependency on Perl, use its '-s'
>> operator to get the file size.

Junio> If you do use Perl, then you do not want to do it as two
Junio> separate invocations with their result compared with test.

Junio> How about this on top of your patch?

Junio> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
Junio> index a400e7a..5710a23 100755
Junio> --- a/t/t5300-pack-object.sh
Junio> +++ b/t/t5300-pack-object.sh
Junio> @@ -123,11 +123,13 @@ test_expect_success \
Junio>       done'
Junio>  cd "$TRASH"
 
Junio> -test_expect_success \
Junio> -    'compare delta flavors' \
Junio> -    'size_2=`perl -e "print -s q[test-2-${packname_2}.pack]"` &&
Junio> -     size_3=`perl -e "print -s q[test-3-${packname_3}.pack]"` &&
Junio> -     test $size_2 -gt $size_3'
Junio> +test_expect_success 'compare delta flavors' '
Junio> +	perl -e "
Junio> +		exit ( ((-s q[test-2-${packname_2}.pack]) >
Junio> +			(-s q[test-3-${packname_3}.pack]))
Junio> +			? 0 : 1);
Junio> +	"
Junio> +'

I'd go with:

    perl -e '
      defined($_ = -s $_) or die for @ARGV;
      exit 1 if $ARGV[0] <= $ARGV[1];
    ' test-2-$packname_2.pack test-3.$packname_3.pack

which also tests to make sure the -s returned something, and works a lot less
hard to quote the filenames coming in (they come in via @ARGV instead of
triple interpolation).  I'm not sure how to shoehorn that into
test_expect_success, but this is better Perl at least. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
