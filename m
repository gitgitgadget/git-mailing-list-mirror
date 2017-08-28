Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F110D208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdH1U3j (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:29:39 -0400
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:56768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbdH1U3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JYkwhcc5CId03NciUwzjafxwh/pnbBZqRSvwSZF6K1k=;
 b=OMdNbNa6f85f/F88jtcry4+Q+aaGXqk6zRZlaG7rQz6B5IUI1+DRx2ZcBJ7SYLBeH5YW2Lnpr6xAezHCxXSKRp7NbS13k3IyshiaOWLplPolA+KI2f6bIU/MGawGy6K50bj0ldHzf7YNLegmnDKI6q/hXHB7qzlpCHrnfojnPvo=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 DM2PR21MB0043.namprd21.prod.outlook.com (2a01:111:e400:50c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.13.0; Mon, 28 Aug
 2017 20:29:35 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 0/3] merge-recursive: replace string_list with hashmap
Date:   Mon, 28 Aug 2017 14:28:26 -0600
Message-Id: <20170828202829.3056-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:910:14::24) To DM2PR21MB0043.namprd21.prod.outlook.com
 (2a01:111:e400:50c4::21)
X-MS-Office365-Filtering-Correlation-Id: 78ddda4b-9bae-4011-b609-08d4ee537f9a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR21MB0043;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;3:QkeCHwmjF+K4A39PxP4WPOLqooBBlUv6qLjftEqI+o+73VVjmqaY9MnI2YcL2f8Y4KyBHHyJ4XeKSWw22EEbZ8XwWGLdSoq1dW+iwFyIVfDS3XxesKykFMxDwzhIzB8lXq77wdCeOZX9VoTz51cq3aq6c2yESaAGodWgkUPsnvpL4cbjRxmGEo7ESeupgS3vKJ3XFe4bFcM/+nfsQ8WBBkXzVlKfgd8Me161ipTu6V+b7noWvgZvc+Xltt0TprSN;25:Ga10FSzT/nwINmWv0BDGPzAVqjueRaGaT1MWwmknvoMXGFyNvnwM4Cq3IFtV5N9cpZInbUbA1njbA6Q3f6Zr97J+f9/7HopEqWqDyuyOBxIBWE131i13AuMy5iaq0D5p2D1uVSVUD0fcRHps8njzl2PYb816wBwZhnAp9M0YecElmJH7211Ys/g/aB2beLwN6U/UvftZ37/zhKgDpOvCLEqnjc5v0uS2NTv16LyePQucDSHc57Imq465AMtnXhqHSYPAj11i1S9RNhVztBuVAlW5HRnwlIE6nxr8JTvlRcoNYo1ChahSKDD5dvDyI2RKrAISl2QXtTO0MwZ2M98Zpg==;31:9FwmXiCNppsq9FGPL5rhfzLQGPadpv27aaM1VkDbP2F6/7uwjh4LiD5MLwR6ahQGXOR7fJ8e+DJj7c2VD6nxwe+KtP73NfnA0TTstih38J/fAhHEgNH0f0/vjEJrqH+UPhojWoOC/w4V79/35Dbpv/fxh9o5wLUetPUjSCg9W10w3f0OnENnI+eUev+pV8EHTt/gR6v1223LyulILhoVWrpoYVfN+ALvxvLcL0Uj4p8=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0043:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;20:JXqNk6tTOKws8hP8nV3rBmN8M1dGCBrrDk51fUZZC/yvKcl7NzhZnj4UYyVob1V27xl/IOqFEmumLYG9+8/iRh4hblqYUiSzLfhcyaYqiafku+utRaltOPL2YANRXDkKuE4y1lxZWkE8Xsb6UrU0vStBina9iR3DlHe4ufGHtEAa9qQbop8NwgNxPOReCqpSLCKx+Tf/Vhm69jIwb5fpy17UAdcgYJ5183udajIRDPA/ez7w+CgxE2NwbM9lIOS/DqvZD7P0QUAaqqYKO+VgZnj6h5qrne9xkUrZUX+83Y0XFdsk1UBxxjE3uu61Uv0Z5qpeJIHDqfhGIrWBkFmLAzDUjUvmHAnmNTuW9WdzamYrdbVZpzUwbraNLe4alNyyP7JWeMtvVdCrBUTYGbiWpmARMN0iWhCo543TWNB+AvB16Fqku745wQbzLVlXmsjnWQ/qjtkuJwZIgJvSw8FPcQfWTsxss64eOQJcSJDCYvY8SPbEOCSi8j4fRgsPg5HJ;4:IYrtM0FGdm9WzFll1Y7/6kgunIs1F23249XD1wQ5Q3LXNIyawBN+T+60F1lCbg85blhXkWQw/zwvFMlCOe/cAkEKA50nugj/E5YIfSctwaKalgzWXGQR7VsP14mfWTCmMMUEKHiRzcwyzNnyknLOZjBEOvDhik1Dc8osGGV7EKrsqpalP0AY5Rvf3uvrUg4PjX5KVJhbef52yQD96v4RCx8So/JhsHBHPpO4+gX7Yv/DYKc/uv/Ezgdy5kLGDG3dFBrgwBb5ICc2KORo0l19Sj/J5sdk1Lu6TFPCbDD1tak=
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0043C4DD50A207BFB54F16FAB79E0@DM2PR21MB0043.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6055026)(6041248)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0043;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0043;
X-Forefront-PRVS: 0413C9F1ED
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7370300001)(4630300001)(6009001)(39860400002)(47760400005)(189002)(199003)(36756003)(10090500001)(8656003)(68736007)(53936002)(101416001)(48376002)(50466002)(6486002)(5003940100001)(106356001)(33646002)(2351001)(5660300001)(10290500003)(42186005)(189998001)(105586002)(2906002)(2361001)(478600001)(5005710100001)(7350300001)(4326008)(47776003)(6666003)(66066001)(1076002)(110136004)(6916009)(107886003)(3846002)(6116002)(305945005)(25786009)(575784001)(50986999)(8676002)(50226002)(86362001)(97736004)(7736002)(81156014)(81166006)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0043;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0043;23:rME8Dtw5k/a0G9CpSeTL1XoMfJk8ZGZ21iVHs/eWK?=
 =?us-ascii?Q?cjvkdXwVuGsFj+YqQx1ff5yboVkhMQeSBYaZq2V8bShAI/mcQKvhwyyURrwr?=
 =?us-ascii?Q?ZlaPnOiitOq2XXEaa2vqDj+AFqApoTafNI1YC9N7m3xKeIWO2uPuaErzw8QK?=
 =?us-ascii?Q?CdpAjYFJVauo1aYZJjWVcUrrZvrWaRSwI/byQHllz9JnnTXTCCMtLpx2Q9BL?=
 =?us-ascii?Q?c5psY6FpOuP7VVXwOQgbkC0D/zl2FjyGHBGV2OgW3WbzfzDo2vv4qOFKveg0?=
 =?us-ascii?Q?87nVZE1w72nkGmqmW6sSJWMBIduUhzjjcGBfuKTHxu4qE9REeq4NmXJfFK1f?=
 =?us-ascii?Q?7rd4U5ANQrQFOpwnbqkXAr1MOQNSw0sioZKiTNjZXeg518V+YBJr4/tvdbsj?=
 =?us-ascii?Q?1oCDaJ4tXOz6Cy/BxUxFYS/gjVegoIC24jYD1CnwV1gJvEmWTYGwNye8W0IK?=
 =?us-ascii?Q?RSjC3HlAtmSfwgW0jaI2AloE09dKgqaeP45ckoRrf7dnTc53CTZMkhhSyc6M?=
 =?us-ascii?Q?b8+mH6vPz+BN4EYtWd3l7Ph5UZboiSJxXjmQzlJV8i5SdiiRIe41CpdshC21?=
 =?us-ascii?Q?3MwvOsAXK6ssWB0lK4UJNa4+w4AI2DwtCfsRM6wEQ0FwBGJ46f4v49umowyl?=
 =?us-ascii?Q?DYjsbg2eqFp/d36d6B4uGz7SUtNVL4UgKcSuJTRQJ289bb7bCMgf2omaG/yC?=
 =?us-ascii?Q?aEUgrgXQZuhP5D9NGCpsIDpl8gCP5ht96NvrzKHhZYNXcunMJ5TDfs10N3qw?=
 =?us-ascii?Q?eRqV3gNBAsdaZ/YbpdY8z4mOuM+1yCUV8wuqfxVDMiuZSM1dsdc68Lf08AJ1?=
 =?us-ascii?Q?lpArx3tB6DiR9pG2qpJEephkhDMLTHNnTPoVaIAgdJl96gusHyrYOHdv910E?=
 =?us-ascii?Q?UHFmVaj7R2LqFtHsQBV7SSSQZU6TLguwXIX3l985YFhNjwVUkDKZt2T/SNY1?=
 =?us-ascii?Q?vy+zOZuyzrUAJ8P64sT3uwLPiERQ0PwDqF0xEXrFOX381HZYAIba7b04c7km?=
 =?us-ascii?Q?YnrV2x63fmXeuHpFgowiJbX2JwQTiWiL+UhPAGNPHufylKMUkK2a1Th76VEl?=
 =?us-ascii?Q?dQpnk4Ex7xQenOGh4F7dJZ8DixZN+eUwIW+KYVl42SFdSZulxPlY9VOgpr+Q?=
 =?us-ascii?Q?X8MAPPapRQ0spiS84OodBpxDP6ygV/k/KgXGhfpTAXpQYm4wZrgetY5Agvof?=
 =?us-ascii?Q?5s2OeIjlJ8aQef2H0k41dRueivs6zWVyyNzgiS4xChsP2c753mDfYieVrfwZ?=
 =?us-ascii?Q?PSL14zibdU/2gbCBmOnhmW1OYkPLNVBoFXskAJV?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;6:dfGANdA0vWNZQAItihax5b+x9WELoIO942VN3aaebOe7bOKOmL6UgZndUuSMaKJvP1VvvGyaZcTa6461u1WFKeU6E6eusAg1PuXw9tlr6wMkyk0u16cMAUQG9A/5H/6astlKIUYS5b8/RDvfH/HVlOTOyixYGNtGYlB5fW3zlSWnrVRtsS4RxRUrEEJ0sX6bkwHN9b/hEdxW0OMlKELU6tg1lP+yPCpAeiw4VliQgHxVxSUjG1+rIbOsVXPFE0D/Px68oMU0QTKN4CCtNBtXZSnOUzz1RRHbyuECMqaUmIWFd6ivsUa30FTOb7Tk75V/eLMsJcheugeSCrTaDiCAuw==;5:Ep7jeIQG8zKFaIf/9DgLKq8B9etY92Rs6xETK9RCfhR2o2FCpa1X46bUukJk/48oHoHDXbWzuD+MxMo2rTDe5aiQpkl8+dkrg6oUpJ3gJdFlpVVjWhv4VzplfEVKxL6f8BwQOsOfWlDsnsdHI4hitQ==;24:p1/vhF3kpvXySdCQ7ECwFcgqFffTHzxLm18qIPKEvt8jLzCvnF74GqRKukMCZcVmigjh14od3tjVKCz0G1KzLBIY5nEXqHO7P4HfEsYE0pQ=;7:U/SJ9HoeNx/9nwB93GXr3LHfuO4IkTGl9IPI5wU6FFn86OBhHqJnIKpCtFYBRYZNl3G9kvUB2rD6+RTMHk+k4hC/8BDgvVUfBLWcwdSRhvW0vkl/3exy0OXDjmS85OJMBAt+BjA8D5KrwlS2U7b9bMpCgE5FOHQbkL+SwZ1D0ZAvo39hNOFhb6OMBX2X0nrwL0mPsW7jPQlpHP72i6g1RJkHVG2l1Ijn6G5aSlJOLFo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2017 20:29:35.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0043
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Code was using two string_lists, one for the directories and
one for the files.  The code never checks the lists independently
so we should be able to only use one list.  The string_list also
is a O(log n) for lookup and insertion.  Switching this to use a
hashmap will give O(1) which will save some time when there are
millions of paths that will be checked.

Also cleaned up a memory leak and method where the return was not
being used.

Kevin Willford (3):
  merge-recursive: fix memory leak
  merge-recursive: remove return value from get_files_dirs
  merge-recursive: change current file dir string_lists to hashmap

 merge-recursive.c | 68 +++++++++++++++++++++++++++++++++++++++----------------
 merge-recursive.h |  3 +--
 2 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.14.1.329.g6edf0add19

