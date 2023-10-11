Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B03CDB482
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 20:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376315AbjJKUWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjJKUW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 16:22:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB8F90
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 13:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv0SxhlJKVsDo2R294vMnbIri36pWJrR+l1bCBD9ecS76FG1lmaZ883QosEciOw4I+2OgZ36GsLUPIOj/7DZndLjRZTwD1npF3XQTednZ5ll8/lc1w4hRKo4hEfBPYXDZdkd90KeVmX2KOAuabwhgccFBflGZh7vKy2J5aNa8e8iAjGySFzH/+G9G4XSyHz+sS4y6p9ChH657J3zekPdqyO/g6DfySrBoHZXDvwc9mfCZp7+ypJu8E5NmUsrePuWuIJyxmfvNsjWIkmSDT0JWuIM05vYRwd6c1eyrxDrrCRh8aM/a/Jg2XxGrZfjQinsQbujBfNgHTE2KwpHfNz0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ss5YeIQUv043S2phVqXszoOdrEKQmKF7d95G2Qaxaw=;
 b=RntiflJBSk0kC/KqH3cd6sgslytAzbVbifFUZ02AiBpTCyDHVRmRifH1YW/oEHi2hGv3pKU6hbRSk2SCCUU/EjEWR60u4fBO96g2HVejTJnwvLvugVcXK+IWCCkbbKdrAQjs+vVjoTZQYku1m+BEpEp8xIw+mZRtrlKIhuBqVW4VcKk4//6x0J1pVSeKR+VSVQhWf0EHsl5fyOtKsvmxUvzHWFW4+qXTotzgpZE/agrvUD8XG6MSG81GaeyaQnwgQccIHxYGuuhcZ133+ujhW6th0VM//Swt5F73i4iks3Ysq6i+kpEi2axhj1MFjs4FMTJHBvPR6PKUAf7Nncnu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ss5YeIQUv043S2phVqXszoOdrEKQmKF7d95G2Qaxaw=;
 b=3Sry0g1TRBa+fk3jMOxSAKWRjGy2S0MgFaRZkVqmfLJMVlffUW4Y/UkCWvSLFi/YLoICvPscW1+agbedCLPuPxNg9PvV7t1n9qfROhz+YrQ+XsFQkK2qVyq94uCqmUnfyJSAhvRQqGCtlq/MlJ4P3gl2cfnAAr+8czyGgosFN1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 20:22:22 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 20:22:22 +0000
Message-ID: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
Date:   Wed, 11 Oct 2023 16:22:18 -0400
User-Agent: Mozilla Thunderbird
Subject: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
Content-Language: en-US
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me> <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
In-Reply-To: <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:806:f2::34) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df648b6-e637-4bf8-89dd-08dbca97c68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHA9/cj6gjSgzdKBGkD26fB/Ag4KctiHWbDCrR8Nisya1pD6YIiQuHg+ZkXymIj+QXqeoXubrG9xHprs1T9Sdnk04RKFg+7jzw9vxckPaZn5yQI/ilhJ0I4YY2ix79sNZm6wQepHh9ERSz0qO/+TGB2t24K9EqfHRX+ze/u9IrKesmrlswwsBLz8yf2KM7PuYFeNUQCkKYMlhJpPE9Ao74v/sQqx+1CS2PYyK6mrD8QrKmy3d6PjiY98JbpbMmJnMWr2lpX2OjSH7DuiVV0cWqTAsr3xS7gkT6wJq1xco3LypwS5+rT2ChP7MqtMw5WAHxjKrwInSX1idEcQG83blVeTS3GAhph0sV1tJD6hwD4XCFOB63c0LiEntnPjZdjL8vD9YakEU22w8uMW5rl7fQGZmCXECanT9dQkv+u7vjR3FvWaG5GMkpjzztKRDKVRjwUmJ4/nU/Q0AwNHsUO8u+rE87p76EdiKaZZcesYfzmmpfzuTjd6rXCFTS8irdOovpt5B91WXIqbvM4rthIubcoWxwRp/EEsMC0hqV2yyQ+C/uyQs3UF4vMZ0FtVAwLePcC55RHrdL9uMB+zDT33izHML6txCkZKBKjK+LG/pJNFHCv67CyNb77Qu+lC/i4w8Mk9796cZ2+XDm9NAp79sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(6512007)(86362001)(36756003)(31696002)(38100700002)(66556008)(44832011)(83380400001)(6666004)(6486002)(478600001)(8936002)(6506007)(8676002)(316002)(4326008)(41300700001)(26005)(2906002)(66946007)(2616005)(66476007)(110136005)(5660300002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0R0bHN5VEszT3ZRZTErcmZtaEhUNEF4MU9zNjVHL2thMEovNWdiY0IvTWp1?=
 =?utf-8?B?U0V0R1JjdGs5UVArUnpVUmM5WVRrUWdLOCtDSUQ2M1NiWk5MbSsvdXFMZHNw?=
 =?utf-8?B?NEI3d2tyeW5NVzFZTGdoZVJtdDQ3d0pHS2JCR0w4MkcvSHBvYVVqd0xnVk0z?=
 =?utf-8?B?S1NnYlBhWk1qZ21BQlNxeVFORHNmdW9HMG50amZCUk5PTUJaWjFYczduY1VS?=
 =?utf-8?B?MDVyKzlKRGovRDNPSzJmbzU5TjhYbEVwdXdzbWxmbzlQQks1MTlqVUhwd2g5?=
 =?utf-8?B?VDQ5dzc1di9QL2RyNXVNYzlINGRCMTY3K0UrazVDTUw0OGE3SjRJOWhKbzhT?=
 =?utf-8?B?bCtYdjJoNVR4cEU4YmdOd0ZVekdnb0lDTlk4UU1SS09nTFdlUWZ2WExRU241?=
 =?utf-8?B?MTIwQWhyUWxOdDc0K1NmaXVKUHE0NllIWW5yazR0RWM4L09hcmNrUUhQZkN0?=
 =?utf-8?B?OFhtUDBTRlRJSjhKdXYvcHhuYU0rbHhWOEVLVE4zbmdUT2ZVb2l3MGI0WUh4?=
 =?utf-8?B?V1hkZmJSY2luQVlLRnpOWWFRS2RadVl2UjVoVFVqNE9yYkhFZkJtcWppTFJP?=
 =?utf-8?B?MklyV3hyTytoNStuK01yVFBRWkJUWlJ5VG9iQk02V0pzVmZ4SXNxN2dkN3ZX?=
 =?utf-8?B?S29CUVl5dTRyWFMvT0tXcGhzUWZPMlFrZStjVkpQdGljOXZrZVdMblZnMW1r?=
 =?utf-8?B?eGV4WXVpbGdBYUROQjIwWkRlR1VsdHdROHh6eDBKbEZZKzJmQjI5WXJFQlB5?=
 =?utf-8?B?bCtHakh1bDFZeVBjTkgza2pxci9OZEdlM2pFakllbkxaOUZDajFCZDZVbXZl?=
 =?utf-8?B?R3JPekRjaU9nT1oycWhVa2ZqY3JuaGpibzR2VHFHOVlZS2hySjd3WDN2MXVm?=
 =?utf-8?B?bE4wN0tXWU8vUElqZFZ0NmdjTHdyTjNMb3ZEb3V1ZTAvWGNRTTJvK2N3NWZ4?=
 =?utf-8?B?anJWZ2lBUzJZMTE4dFRnVGdpMVVYbGJLWlEzN08xODRaWkhjTm1rNWF4anla?=
 =?utf-8?B?QXlHaFVncVRnUmNhUE9oSkx0a05iSnY5dE0rZk5DeWlyOHlYU3QzSlkwRTRY?=
 =?utf-8?B?Z21mUXBUYU04cDVaeDM4SDRDTXZCZFB5d0l2Mmw5dEROUDlEVUhwTVVLSTBs?=
 =?utf-8?B?VzZWbS9meFlUMU1rRE5KbDNTRHBZNFp1ZVZINHVISkExRXl6V3JkR08vbUsx?=
 =?utf-8?B?aXFjb1oyWnlBUTMrNG9PbVNpZjdFbC85Z1Z6RDRyUk1kcVlKZTFkcUwrRjZ1?=
 =?utf-8?B?OFNkUnZPRjdzU284WnNycjJacUhmMWF4dTJ3L3Urb3F2Y0w4K0RWQm45ZlJC?=
 =?utf-8?B?QXNiWVYzU2hWOG1ZVFIvUDNiaVMzM1hQVGVyYnZsMUNnTHF5STVxU0tRbUlK?=
 =?utf-8?B?UUhHWWkwZzQvWnk3eEYyUFhVOTN0c1B4U01XL3hTNjRNcTZLYm1yLy9ZKzFJ?=
 =?utf-8?B?S2lQMkhwdkR0bEVIamRpRk1PTThQSWZVNFN1V0VTME9UbnREd2lCUXh0ZFQ0?=
 =?utf-8?B?eVRpbGFTMGdMcWxZOHlSeUJnWmY0dGNwbnY4MTA2SUdlOWlWZXdsVGQ2TVZj?=
 =?utf-8?B?a2N5Y09rQnBMYTNDYzZxVjZVYnRUVXhLN0dZekgzYkJvbUZ0V1dpTG5JWG5X?=
 =?utf-8?B?NTVLT3ZZYStqSWNzODNFcVZ1TU1rUEg2UDdQVzlubUZ2a0pKRVkwVFpER2Er?=
 =?utf-8?B?cjdMYzRLS1dIYXRGeVRVN1lqZVNMRVpkZTVyRG45YnBHSzRYMng4aDRGNU5x?=
 =?utf-8?B?YjZDMUdEN20zbkQ0b080TjlBdy9BejVXcnhwemtVV1RvTmlQZ3NYR0U1V3VG?=
 =?utf-8?B?eS8vM3JzbkRhbENjSU45Z3Q5dVo1NTJueDNzczQ2TjRONjc2dk5OWEdpZi9q?=
 =?utf-8?B?TWRCOWg0dXFiaEM2dEI1WjdIaXUwSTljM2FDUFVFQnJadzdjZ0N1dVJwYTRw?=
 =?utf-8?B?UzEvYVFNTVhobWNSaVAxdEZ1OGZqenh5eTkwY3djdjRBbC9XL095VnExOHUr?=
 =?utf-8?B?KzNnK0xqRi83cTM1TnErWStTNjBvWGN4N3hsVlFpM0Z0L3VkTjB0VCtIM1Nq?=
 =?utf-8?B?NkF1RGxRMk40dFdGWXR4a1NzS20zem5QaDNaRTB4a0JpeUk2ZWxpd0s1OVR6?=
 =?utf-8?Q?MhUMVzWBmOIW7cdsQoCjVtJYn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df648b6-e637-4bf8-89dd-08dbca97c68d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:22:22.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IowyLx8wT2HJe9s/kN4y1ZiLd9MQhEmohIDuom1wqztWP3RSTTqi30Z3ze0HndtpqhySqI2PYLJOLTO+boGhBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move processing of email address lists before the sendemail-validate
hook code.  This fixes email address validation errors when the optional
perl module Email::Valid is installed and multiple addresses are passed
in on a single to/cc argument like --to=foo@example.com,bar@example.com.
---
 git-send-email.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 288ea1ae80..cfd80c9d8b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -799,6 +799,10 @@ sub is_format_patch_arg {
 
 $time = time - scalar $#files;
 
+@initial_to = process_address_list(@initial_to);
+@initial_cc = process_address_list(@initial_cc);
+@initial_bcc = process_address_list(@initial_bcc);
+
 if ($validate) {
        # FIFOs can only be read once, exclude them from validation.
        my @real_files = ();
@@ -1099,10 +1103,6 @@ sub expand_one_alias {
        return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
 }
 
-@initial_to = process_address_list(@initial_to);
-@initial_cc = process_address_list(@initial_cc);
-@initial_bcc = process_address_list(@initial_bcc);
-
 if ($thread && !defined $initial_in_reply_to && $prompting) {
        $initial_in_reply_to = ask(
                __("Message-ID to be used as In-Reply-To for the first email (if any)? "),
-- 
2.34.1
