Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E761F770
	for <e@80x24.org>; Wed,  2 Jan 2019 00:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfABABu (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 19:01:50 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:42637 "EHLO
        3.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfABABu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 19:01:50 -0500
X-Greylist: delayed 4563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jan 2019 19:01:48 EST
Received: from player729.ha.ovh.net (unknown [10.109.146.173])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id DAF4AD76F9
        for <git@vger.kernel.org>; Tue,  1 Jan 2019 23:45:42 +0100 (CET)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player729.ha.ovh.net (Postfix) with ESMTPSA id 690DE167B0BD
        for <git@vger.kernel.org>; Tue,  1 Jan 2019 22:45:42 +0000 (UTC)
To:     git@vger.kernel.org
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: git-send-email warnings & process dying of signal 11
Message-ID: <1e4ac3d5-f6f5-bcce-2f09-0519934289b9@milecki.pl>
Date:   Tue, 1 Jan 2019 23:45:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17119871036016398045
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrudehgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello & Happy New Year!

I've recently switched from openSUSE 42.3 (perl 5.18.2 & git 2.13.7) to
the openSUSE Tumbleweed (perl 5.28.1 & git 2.20.1) and send-email
doesn't work for me anymore.

FWIW it doesn't seem like a git regression. I've manually installed
2.13.7 in my new OS and it also fails.

It basically fails with the:
Warning: unable to close filehandle __ANONIO__ properly: Bad file descriptor at /usr/lib/git/git-send-email line 812.
Warning: unable to close filehandle __ANONIO__ properly: Bad file descriptor at /usr/lib/git/git-send-email line 812.
error: git-send-email died of signal 11

Relevant perl source:
    802  sub ask {
    803          my ($prompt, %arg) = @_;
    804          my $valid_re = $arg{valid_re};
    805          my $default = $arg{default};
    806          my $confirm_only = $arg{confirm_only};
    807          my $resp;
    808          my $i = 0;
    809          return defined $default ? $default : undef
    810                  unless defined $term->IN and defined fileno($term->IN) and
    811                         defined $term->OUT and defined fileno($term->OUT);
    812          while ($i++ < 10) {
    813                  $resp = $term->readline($prompt);
    814                  if (!defined $resp) { # EOF
    815                          print "\n";
    816                          return defined $default ? $default : undef;
    817                  }
    818                  if ($resp eq '' and defined $default) {
    819                          return $default;
    820                  }
    821                  if (!defined $valid_re or $resp =~ /$valid_re/) {
    822                          return $resp;
    823                  }
    824                  if ($confirm_only) {
    825                          my $yesno = $term->readline(
    826                                  # TRANSLATORS: please keep [y/N] as is.
    827                                  sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
    828                          if (defined $yesno && $yesno =~ /y/i) {
    829                                  return $resp;
    830                          }
    831                  }
    832          }
    833          return;
    834  }

It seems that the "return defined" line causes warnings.

I don't know perl but I tried patching /usr/lib/git/git-send-email with
the attached diff and got a following output:

Warning: unable to close filehandle __ANONIO__ properly: Bad file descriptor at /usr/lib/git/git-send-email line 812.
Warning: unable to close filehandle __ANONIO__ properly: Bad file descriptor at /usr/lib/git/git-send-email line 812.
term: Term::ReadLine=HASH(0x56138dd97c50)
*** buffer overflow detected ***: /usr/bin/perl terminated
error: git-send-email died of signal 6

It makes me suspect that maybe readline() call causes a crash.

Does this report make sense? Is there anything else I can provide?

--- /usr/lib/git/git-send-email.orig    2019-01-01 23:38:35.980954492 +0100
+++ /usr/lib/git/git-send-email 2019-01-01 23:37:58.964956240 +0100
@@ -810,7 +810,9 @@
                 unless defined $term->IN and defined fileno($term->IN) and
                        defined $term->OUT and defined fileno($term->OUT);
         while ($i++ < 10) {
+               print STDERR "term: $term\n";
                 $resp = $term->readline($prompt);
+               print STDERR "readline done\n";
                 if (!defined $resp) { # EOF
                         print "\n";
                         return defined $default ? $default : undef;
