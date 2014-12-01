From: Aarni Koskela <aarni.koskela@andersinnovations.com>
Subject: [PATCH] git add -i: allow list (un)selection by regexp
Date: Mon, 1 Dec 2014 09:31:22 +0000
Message-ID: <DB3PR04MB25020F247555E521936E676EB7D0@DB3PR04MB250.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "akx@iki.fi" <akx@iki.fi>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvNZH-0007MG-Qr
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 10:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbaLAJqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 04:46:52 -0500
Received: from mail-am1on0062.outbound.protection.outlook.com ([157.56.112.62]:64544
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752741AbaLAJqv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 04:46:51 -0500
X-Greylist: delayed 925 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Dec 2014 04:46:50 EST
Received: from DB3PR04MB250.eurprd04.prod.outlook.com (10.242.130.14) by
 DB3PR04MB250.eurprd04.prod.outlook.com (10.242.130.14) with Microsoft SMTP
 Server (TLS) id 15.1.26.15; Mon, 1 Dec 2014 09:31:23 +0000
Received: from DB3PR04MB250.eurprd04.prod.outlook.com ([169.254.2.138]) by
 DB3PR04MB250.eurprd04.prod.outlook.com ([169.254.2.138]) with mapi id
 15.01.0026.003; Mon, 1 Dec 2014 09:31:22 +0000
Thread-Topic: [PATCH] git add -i: allow list (un)selection by regexp
Thread-Index: AdANSY4HwbHWiaTnRVO1IoZWMHUGow==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.157.91.17]
x-microsoft-antispam: BCL:0;PCL:0;RULEID:;SRVR:DB3PR04MB250;
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:;SRVR:DB3PR04MB250;
x-forefront-prvs: 0412A98A59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(189002)(52044002)(110136001)(101416001)(99396003)(64706001)(87936001)(76576001)(4396001)(2656002)(74316001)(19580395003)(120916001)(19580405001)(20776003)(77096004)(46102003)(97736003)(66066001)(229853001)(92726001)(92566001)(105586002)(77156002)(62966003)(2351001)(107046002)(575784001)(86362001)(95666004)(106356001)(50986999)(21056001)(33656002)(31966008)(40100003)(54356999);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR04MB250;H:DB3PR04MB250.eurprd04.prod.outlook.com;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-OriginatorOrg: andersinnovations.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260476>

Hello!

This patch makes it possible to select or unselect files in `git add -i`
by regular expression instead of unique prefix only.

The command syntax is `/foo` for selection and `-/foo` for unselection.
I don't think the syntax will conflict with any existing use cases, but feel
free to prove me wrong.

I'm not a Perl programmer, but I've tried to follow the style of the
existing code as much as possible. :)

Note I'm currently not on the mailing list, so please cc.

Best regards,

Aarni Koskela

>From 53c12d9c9928dc93a57595e92d785ecc0b245390 Mon Sep 17 00:00:00 2001
From: Aarni Koskela <akx@iki.fi>
Date: Mon, 1 Dec 2014 11:06:10 +0200
Subject: [PATCH] git-add--interactive: allow list (un)selection by regular
 expression

Teach `list_and_choose` to allow `/regexp` and `-/regexp` syntax to
select items based on regular expression match.

For instance, `/jpg$` will select all options whose display name ends with
`jpg`.

Signed-off-by: Aarni Koskela <akx@iki.fi>
---
 git-add--interactive.perl | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 1fadd69..34cc603 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -483,6 +483,8 @@ sub is_valid_prefix {
 	    !($prefix =~ /[\s,]/) && # separators
 	    !($prefix =~ /^-/) &&    # deselection
 	    !($prefix =~ /^\d+/) &&  # selection
+	    !($prefix =~ /^\//) &&   # regexp selection
+	    !($prefix =~ /^-\//) &&  # regexp unselection
 	    ($prefix ne '*') &&      # "all" wildcard
 	    ($prefix ne '?');        # prompt help
 }
@@ -585,6 +587,28 @@ sub list_and_choose {
 			    prompt_help_cmd();
 			next TOPLOOP;
 		}
+		if ($line =~ /^(-)*\/(.+)$/) {
+			my $choose = !($1 && $1 eq '-');
+			my $re = $2;
+			my $found = 0;
+			for ($i = 0; $i < @stuff; $i++) {
+				my $val = $stuff[$i];
+				my $ref = ref $val;
+				if ($ref eq 'ARRAY') {
+					$val = $val->[0];
+				}
+				elsif ($ref eq 'HASH') {
+					$val = $val->{VALUE};
+				}
+				if ($val =~ /$re/) {
+					$chosen[$i] = $choose;
+					$found = 1;
+					last if $opts->{SINGLETON};
+				}
+			}
+			last if $found && ($opts->{IMMEDIATE});
+			next TOPLOOP;
+		}
 		for my $choice (split(/[\s,]+/, $line)) {
 			my $choose = 1;
 			my ($bottom, $top);
@@ -635,6 +659,7 @@ sub singleton_prompt_help_cmd {
 Prompt help:
 1          - select a numbered item
 foo        - select item based on unique prefix
+/regexp    - select item based on regular expression
            - (empty) select nothing
 EOF
 }
@@ -648,6 +673,8 @@ Prompt help:
 foo        - select item based on unique prefix
 -...       - unselect specified items
 *          - choose all items
+/regexp    - select items based on regular expression
+-/regexp   - unselect items based on regular expression
            - (empty) finish selecting
 EOF
 }
-- 
1.9.2.msysgit.0
