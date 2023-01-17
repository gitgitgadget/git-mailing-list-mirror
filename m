Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2691AC54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjAQBiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjAQBho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:37:44 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C02887F
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:37:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfTkztmIjDc6SaAHpkAby5nsQKFU4vHcvERAJBsjYkgbwIQfDXUxUoGm2MiyrmCJmWdvdVI83xXdFNXzG2W2X/7Q98ieNPiESwExn8OVEwZmvsUp5QSN965D5xXuQgFHrnXnkjEDU3WVjGF3ZG2rsOjUmsERYm/sbKDvYj2MU2Q8sA1W5peBhFlant6f/ctfXUL7GJIf3WLA8A1JBFHeW20+/ttjFo88hI+KxI3ChZ0cpDjCf/LsHZTYsq+9PIS59xDgwhKMd+omXN/Jf/A1le76knnkSM+ogt/gEamNo6sMzml4ubRDFsCFznterwBthRJXyRAakK7iFsl7TS8sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9M+LtdeDtARP6sIeVV+OY/iK4R1+9zkz6iAYEq5W3s=;
 b=U7HRfwTcyud1ExgvCHsttd7xyWlGzrhfDyuzFr/PqVITt6c/k30StiRoLQiLtWAgK/AH73PJCD1jQqWmGLguzol9K/uqyeb5GQsoLQBDeeGdLl9JnwoofZlEO9+G4MylLRkXwPMG9sdu4rJkmuRQKKUz/bC9sdUhX3aS2qXiKd/auIxii9Wu8cMWw/UCdOnUijD9Q2UGk+oDxxjqezgiFeg9hu0m4K/DiURkbptGALP8BJL6mHVLRaU2IPcsjMLZ6/1g/GJfu4TyXfXLCWANOVpXYD9MhmYF91RjfjnedbiBJwo3FboBg4y/NOWAiWzM7Hzqi6Kwt3RKPHhJvedwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9M+LtdeDtARP6sIeVV+OY/iK4R1+9zkz6iAYEq5W3s=;
 b=jYM5hksQK44ocSTngQqGPYD+zios+7mzj8d+tazUG3kMvesT+xf8lObJz3qr/jxLGVmJncIB/3kUrndYwRPue5tL7j5p9wOgp4nwV7sp4HstzDV6M507V3rBvsfwEE2v+vNla+vUMCoIKl0lHX5oYwrQyc9L9+GqBl2iPb3DYKE=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 01:37:35 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:37:35 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/2] send-email: refactor header generation functions
Thread-Topic: [PATCH v5 1/2] send-email: refactor header generation functions
Thread-Index: AQHZKhRG1MTg60LsoEGJJE1KtiZaJg==
Date:   Tue, 17 Jan 2023 01:37:34 +0000
Message-ID: <20230117013709.47054-2-michael.strawbridge@amd.com>
References: <20230117013709.47054-1-michael.strawbridge@amd.com>
In-Reply-To: <20230117013709.47054-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: a6f8ba53-4442-4f2e-27eb-08daf82b68ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5OoQPUudsO3Dl0HBTzBpCBGkuHbC3Ds61LThYB8rsauEY+JSRr8uIV2MnsQRmwZH+yQOXEdQoe5Cw9o7HRbJ4nfCc99bGb4++4W2fSwECSteVqSjpDe4fHKCQF+GxOUDThGmoaErhazsEa+tP1/lUSk3UZtR84EqBfqKOAVcyAB4CyzOdu+kKl9KANBZyWm1d8thJMZa1Y6lIHMnJ3y0YvhVbpP8+n24rumEQeGIw8WYm6eDdhhM6jDBhkiNeLNAmeCuULbCV+1KEwXx2lz8DwjdmEGRLzUx4rOt64h/HJMymhqelwfzaFnqDqPZSacPd+I4Z2/PhM4gYQi6JPCrQn6iooeNXLoU7WcyPbnuOXndB+5t9jiU2ZxbmUUi6IIBi/dFQpeSdGqkRklJbWXn4E22r9EFKY2teEisGHVZIrSZskabVPeGOvo8YtjTfAgSoBcspOSlBsqK3dGjZqW7yKAFNYu/5Iu/+LPXdIbFJ0w68TxIqcupUKeqE4brKthhIChBvRyh3wDmADr9EfSb32sQMhpTuuVCCMGZbKxbbi9MPH61yNYJTX8i2hZRd4uM+76ZBW09X/dYaP2XHhwVlZFHzl5tniuRRio/dbKt/J8d2stLjfWMTbzrwImmsXNLL82w3Mc9TlX//sHFRV4W/Lcpau6Iru3aQRGbynlpkL/M2dxKZC6BWchQPboE2rb0TfSDx66DcHBjbLZgitW1ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(71200400001)(316002)(478600001)(122000001)(6486002)(5660300002)(1076003)(36756003)(54906003)(6916009)(38100700002)(4326008)(8676002)(6512007)(38070700005)(2906002)(8936002)(83380400001)(2616005)(41300700001)(186003)(26005)(64756008)(86362001)(66556008)(76116006)(66446008)(66476007)(66946007)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?94wQeZO2sriV+WdsnAiaeYqiv9I6VMHLM4Kif4gZUi8tgZnZeKhl8oJJqV?=
 =?iso-8859-1?Q?X+vGZcis9V/uOIpiC6i16abGjf4w9cozwKfaoJIEOpvKmMgwPe6DXkoC29?=
 =?iso-8859-1?Q?wFAaLKTsnkycq0IdDM/1cqRA9egR9pyPEGUKV/21mfj35VAFJyvEH89P6e?=
 =?iso-8859-1?Q?Uq8Zi6UL0UlieBxGR+Tik4/zt5b0lEa+gMFXJpHt5LXEJAbuwjyTiZcAKa?=
 =?iso-8859-1?Q?tdFO1skiF6Pj4rqorJEFyw/b3GYtjJMCub1F6kK2hI00mnp4pPPPAMlXMC?=
 =?iso-8859-1?Q?KRYxkzyURURz3E3hua3XG8O6rPgtg2SrLKsl0gteF5OnQKgTSXRyXaOns8?=
 =?iso-8859-1?Q?ZfGYx+pGSWpi55xC5C/SRY2+HqKqgwclizVB7Mbgb4td/ukgeovGINsWQW?=
 =?iso-8859-1?Q?a0C/XnUssRmllM9kaEJziwDJPGeWC640h7JyG9RXJQkkWarUg3Ac0Iz8fT?=
 =?iso-8859-1?Q?8bLPjg9EjZcfHr/xj88C1zJ33Lv4gSfu3u7+Dp2gUX0AyurQb90t4E0Ypp?=
 =?iso-8859-1?Q?pqLe25S9aTMky4NuvXktnn88LCcUgDJArqr5wu5L5NxTa2ScnUnGPxY33X?=
 =?iso-8859-1?Q?Hec5zGNjMp+x34lPFhIQCrjZSlBfdAqHKm9G9J610QPw0GHBFI+FLzqZJS?=
 =?iso-8859-1?Q?ZOEdoeMwcJl7pFgCVFoCr4IbC0KTdT3X5c6xjjAXHNtCvc+uvFK0LASfeW?=
 =?iso-8859-1?Q?5gOhJgDK/rHXCKXEg129S9SExMvK51kQH4LL5xc+4RBUtQAkg0aZbhR7qj?=
 =?iso-8859-1?Q?vT8IR/cLKXOaU8bX+cg58rQzdGyGefAx5ZzxhaF7hdHBcSutF6KgQawEmC?=
 =?iso-8859-1?Q?jRG2JCv4xtgvrio1xgCfHg+UZzGUPDA2cPrmsQZsETft3V1f3sW6RMDNB6?=
 =?iso-8859-1?Q?tqqYmCPGl7GEaZEzOc7olhapUbIJQbeOrPa4/J8JotzqTE+rCk3B/EZ3LE?=
 =?iso-8859-1?Q?0p9oQZsuQdvynCovA5QWyTaZlGp115tkqGbRxWg5rnHUnf32om1jwy4MKU?=
 =?iso-8859-1?Q?Vwkq3/IOrOtsymBUarZmIwy5cvXrzlTUHA5sM2w6cOY6Xfp2PFmSc5l9Oq?=
 =?iso-8859-1?Q?+6HXXYqADnjqeWm7s8TEmct8i3zZyR8QXCfD/oHuDWDW8P57ilO6SkdxX4?=
 =?iso-8859-1?Q?7dc6zck+CNcOR7uEAabmClezhUM2FPaxrteBbMLadBX2aSKM4+fwNLIMQ9?=
 =?iso-8859-1?Q?PXrR87PKoHbXYK5gUAEpm5RjWO4aX5TkTGlaA3SNcAEGiufTTWvbZ4rlf6?=
 =?iso-8859-1?Q?uaugAFuChHoJtU8cX7PirMcNNK1/unoRyLM5KhRCnwQZt3tbcjdzLzlMK6?=
 =?iso-8859-1?Q?X9gTq0RtaJSumYfUMT07bSbuqKWiSRXWBEPGnhWHyrFp9T4B9x6S24yTT6?=
 =?iso-8859-1?Q?LRDXEN1JAinyryXgd/5KMurqsktlB2GYsLunvu3yFVD+gAvJ+rbV4z97hu?=
 =?iso-8859-1?Q?zt1OsFw8fp5c+MHCj04s82ZlVo1iSxsOcJbP8aq/TZGDBPDIsgdYbUYptL?=
 =?iso-8859-1?Q?REtoB4+xsYwgTQ2gKnd9tQR2JyAfa9rguWRzZhWO3AAblDHrAatlBgTh5O?=
 =?iso-8859-1?Q?BdzLeDMo4LpPTtVJi7ZB68QcKWA+oh2euEI6fo7yjx48Mt7PkMJ+554c/U?=
 =?iso-8859-1?Q?rn2IylB9SsPeZd4JSVj/N7gwEyV7NxofUa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f8ba53-4442-4f2e-27eb-08daf82b68ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:37:35.1238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fc005PIRgpKI5zMQnuLgttxXo0gOFmu7XpwvI/EiRUdpU9jZiC72EmvgHxTBgC7hLSIdRfCgfh07haGfpyMuSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split process_file and send_message into easier to use functions.
Making SMTP header information more widely available.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 git-send-email.perl | 49 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..810dd1f1ce 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1495,16 +1495,7 @@ sub file_name_is_absolute {
 	return File::Spec::Functions::file_name_is_absolute($path);
 }
=20
-# Prepares the email, then asks the user what to do.
-#
-# If the user chooses to send the email, it's sent and 1 is returned.
-# If the user chooses not to send the email, 0 is returned.
-# If the user decides they want to make further edits, -1 is returned and =
the
-# caller is expected to call send_message again after the edits are perfor=
med.
-#
-# If an error occurs sending the email, this just dies.
-
-sub send_message {
+sub gen_header {
 	my @recipients =3D unique_email_list(@to);
 	@cc =3D (grep { my $cc =3D extract_valid_address_or_die($_);
 		      not grep { $cc eq $_ || $_ =3D~ /<\Q${cc}\E>$/ } @recipients
@@ -1546,6 +1537,22 @@ sub send_message {
 	if (@xh) {
 		$header .=3D join("\n", @xh) . "\n";
 	}
+	my $recipients_ref =3D \@recipients;
+	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
+}
+
+# Prepares the email, then asks the user what to do.
+#
+# If the user chooses to send the email, it's sent and 1 is returned.
+# If the user chooses not to send the email, 0 is returned.
+# If the user decides they want to make further edits, -1 is returned and =
the
+# caller is expected to call send_message again after the edits are perfor=
med.
+#
+# If an error occurs sending the email, this just dies.
+
+sub send_message {
+	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) =3D =
gen_header();
+	my @recipients =3D @$recipients_ref;
=20
 	my @sendmail_parameters =3D ('-i', @recipients);
 	my $raw_from =3D $sender;
@@ -1735,11 +1742,8 @@ sub send_message {
 $references =3D $initial_in_reply_to || '';
 $message_num =3D 0;
=20
-# Prepares the email, prompts the user, sends it out
-# Returns 0 if an edit was done and the function should be called again, o=
r 1
-# otherwise.
-sub process_file {
-	my ($t) =3D @_;
+sub pre_process_file {
+	my ($t, $quiet) =3D @_;
=20
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
=20
@@ -1893,9 +1897,9 @@ sub process_file {
 	}
 	close $fh;
=20
-	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
+	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t, $quiet)
 		if defined $to_cmd;
-	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
+	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
=20
 	if ($broken_encoding{$t} && !$has_content_type) {
@@ -1954,6 +1958,15 @@ sub process_file {
 			@initial_to =3D @to;
 		}
 	}
+}
+
+# Prepares the email, prompts the user, sends it out
+# Returns 0 if an edit was done and the function should be called again, o=
r 1
+# otherwise.
+sub process_file {
+	my ($t) =3D @_;
+
+        pre_process_file($t, $quiet);
=20
 	my $message_was_sent =3D send_message();
 	if ($message_was_sent =3D=3D -1) {
@@ -2002,7 +2015,7 @@ sub process_file {
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
-	my ($prefix, $what, $cmd, $file) =3D @_;
+	my ($prefix, $what, $cmd, $file, $quiet) =3D @_;
=20
 	my @addresses =3D ();
 	open my $fh, "-|", "$cmd \Q$file\E"
--=20
2.34.1
