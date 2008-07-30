From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: [PATCH] 64bit issue in test-parse-options.c
Date: Wed, 30 Jul 2008 14:16:56 +0200
Message-ID: <20080730141656.41ce02ec@pc09.procura.nl>
Reply-To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 14:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAd0-0008Dx-F9
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbYG3MQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYG3MQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:16:58 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:2170 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbYG3MQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:16:58 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UCGur2027080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 14:16:56 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90772>

git-1.5.6.4 - HP-UX 11.23 64bit compile

* expecting success:
        test-parse-options -s123 -b -i 1729 -b -vv -n > output 2> output.err &&
        test_cmp expect output &&
        test ! -s output.err

--- expect      2008-07-30 11:52:05 +0000
+++ output      2008-07-30 11:52:05 +0000
@@ -1,5 +1,5 @@
 boolean: 2
-integer: 1729
+integer: 7425998454784
 string: 123
 abbrev: 7
 verbose: 2
* FAIL 2: short options

I'm sure you can come up with a more sensible change, but the current
code is definitely wrong


--8<---
--- test-parse-options.c.org    2008-07-30 11:57:16 +0000
+++ test-parse-options.c        2008-07-30 12:08:56 +0000
@@ -2,6 +2,7 @@
 #include "parse-options.h"

 static int boolean = 0;
+static unsigned int int_integer = 0;
 static unsigned long integer = 0;
 static int abbrev = 7;
 static int verbose = 0, dry_run = 0, quiet = 0;
@@ -29,9 +30,9 @@ int main(int argc, const char **argv)
                OPT_BIT('4', "or4", &boolean,
                        "bitwise-or boolean with ...0100", 4),
                OPT_GROUP(""),
-               OPT_INTEGER('i', "integer", &integer, "get a integer"),
-               OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
-               OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
+               OPT_INTEGER('i', "integer", &int_integer, "get a integer"),
+               OPT_INTEGER('j', NULL, &int_integer, "get a integer, too"),
+               OPT_SET_INT(0, "set23", &int_integer, "set integer to 23", 23),
                OPT_DATE('t', NULL, &integer, "get timestamp of <time>"),
                OPT_CALLBACK('L', "length", &integer, "str",
                        "get length of <str>", length_callback),
@@ -53,7 +54,9 @@ int main(int argc, const char **argv)
        };
        int i;

+       integer = 0x12345678;
        argc = parse_options(argc, argv, options, usage, 0);
+       if (integer == 0x12345678) integer = int_integer;

        printf("boolean: %d\n", boolean);
        printf("integer: %lu\n", integer);
-->8---

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
