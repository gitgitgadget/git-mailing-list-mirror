Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5272B1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 17:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeIHWQn convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 8 Sep 2018 18:16:43 -0400
Received: from chomsky.autogeree.net ([91.216.110.36]:42992 "EHLO
        chomsky.autogeree.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHWQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 18:16:43 -0400
X-Greylist: delayed 711 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Sep 2018 18:16:42 EDT
Received: by localhost.localdomain (localhost.localdomain, from userid 1000)
        id 367BDE1C3A; Sat,  8 Sep 2018 19:15:32 +0200 (CEST)
Date:   Sat, 8 Sep 2018 19:15:32 +0200
From:   Julien Moutinho <julm+git@autogeree.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: gitweb: HTML output is not always encoded in UTF-8 when using
 --fastcgi.
Message-ID: <20180908171532.uyz7i5oy6w6otp2r@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Description
===========
An old (2011) description of the problem is here:
https://stackoverflow.com/questions/7285215/nginx-fastcgi-utf-8-encoding-output-iso-8859-1-instead-of-utf8#answer-18149487

Basically, gitweb's HTML output is not always encoded in UTF-8
when using --fastcgi.


Reproduction
============
gitweb v2.18.0
perl   v5.28.0

| echo Système >test.git/description

According to the 2011 problem report,
the problem only appears when using gitweb.cgi --fastcgi
not when gitweb.cgi is spawned by fcgiwrap.

And apparently, the text must not contain one character
which cannot be correctly converted to ISO-8859-1,
or an UTF-8 encoding is done (not sure by what);
which made this bug harder to spot.


Explanation
===========
According to Christian Hansen (chansen), the problem is that:
> FCGI streams are implemented using the older stream API,
> TIEHANDLE. Applying PerlIO layers using binmode() has no effect.
https://stackoverflow.com/questions/5005104/how-to-force-fastcgi-to-encode-form-data-as-utf-8-as-cgi-pm-has-option#answer-7097698
https://perldoc.perl.org/perltie.html

Indeed:
> FCGI.pm isn't Unicode aware,
> only characters within the range 0x00-0xFF are supported.
https://metacpan.org/pod/FCGI#LIMITATIONS

But, as stated in gitweb's to_utf8():
> gitweb writes out in utf-8
> thanks to "binmode STDOUT, ':utf8'" at beginning"


Correction
==========
Christian Hansen suggested that:
"The proper solution would be to encode your data before outputting it,
but if thats not an option I can offer this hotpatch:"

| my $enc = Encode::find_encoding('UTF-8');
| my $org = \&FCGI::Stream::PRINT;
| no warnings 'redefine';
| local *FCGI::Stream::PRINT = sub {
|     my @OUTPUT = @_;
|     for (my $i = 1; $i < @_; $i++) {
|         $OUTPUT[$i] = $enc->encode($_[$i], Encode::FB_CROAK|Encode::LEAVE_SRC);
|     }
|     @_ = @OUTPUT;
|     goto $org;
| };

As a quick workaround this hotpatch can even be put in $GITWEB_CONFIG
by removing the `local` before `*FCGI::Stream::PRINT`.
