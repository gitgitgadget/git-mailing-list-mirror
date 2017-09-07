Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0E220286
	for <e@80x24.org>; Thu,  7 Sep 2017 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbdIGQ0q (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:26:46 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:26976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932083AbdIGQ0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iq/SL8plOHg5xNoka2lFLbG3CUpvtq9GGGvyTGvdIUM=;
 b=VrXnfgzu4InygR2RfQFoewSysVp5En1b6CkeMKlnzgftLh57kaVLkC1z7UJlEfb9Uw16XyVGx44t+as3icaa4DFvePbOjrjv0kPQupkm1nMar+4nBxkXEOO8r1RsvLlc8GN7ABsOrZJfCTbQhUZhrMUCxBv91kmeyzRhJ+hXyR4=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.6; Thu, 7 Sep 2017 16:26:42 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v3 0/3] merge-recursive: replace string_list with hashmap
Date:   Thu,  7 Sep 2017 10:25:53 -0600
Message-Id: <20170907162556.61384-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.329.gcdd497e120.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR08CA0069.namprd08.prod.outlook.com (10.171.251.162) To
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b93c921f-4ec2-4ced-3fa1-08d4f60d39cb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0016;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;3:cllA/qkWEE5jKWpnZtKq2SoX1El27sOv7iq/BniocXEQkrYfsro03J2wF1rD9DwIbh35ViParH3Ha+8MvVwBrkC0bNwlAEyC4N+/XheiFXg69rlOVn6L5y1G1TT4rYFXSdNw8hBjdQo1nec8pfDflZvJ1MKpy4SXP9apl28ypmskunRuXI7ZREYFMeH/p5x/9toonEMZIhYuPjRxyr7Aqk9M14X8xDaSp37/n4wUqj4hVLUmy+foAGukHCCmUys3;25:dKw2PRPA5aNxo867iAvMiO8k+nD0DUm9yhy4OGE0CdQqx5hTRK79n42e8pb/MAsVAhyab4vL4qNaa2EO5aEEr+Jz6jbGFw1Qsd9i8eZrePvFhnsPmwx2F4WIvQB7+tjaeAXQcPA3/uz2fDY76Rdta3r0z54nnbDKp0M7H7tnpFwyI/gD8PXXw0F4ea2pgIxxY5BFOh08AwyRZB/0OfP53WE0XZqhRO0vT86RGsXCq7ZmTqMLWFv7upCsUzy0xcnkqzAl1VB+OsGkdSm71MqZY/Tua6FSNuByzSrkD/SrSsHTFW946HCxIjJaitjCVwbXl3gVpzLj0lG9WoO2/DSJqw==;31:AJMjWz2PYripCmkOM4OSLGEiyphMgNOuqbxpQ2O/ZerR+3lUc6ZtEvrcUATQuQd63AsXDpBq27o/szALIu8fpGZ7fLTd3tb506fx5pKiNCc0B8Yop3VQp8Duvfka4AkhGFBgVaYAASEHHm7nL7wJdquZs52dc5sG/m5ZnfIe04uBx3dUnFZVHsLS1wuVlHYF8eE83q1lEot77lFt0xdpKjJkeioubVahN4UFgpVkR7o=
X-MS-TrafficTypeDiagnostic: SN1PR21MB0016:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;20:HPBS1D/qAdk0xuUA0i4HJMW58dmiaVbtF8AKF6RttRIilOx9OveEv0N4BSuqWtE8aq5SbWPR5ECf/4iVIdd3hd1gDsbd8tnEjBt8sFkLZRTKP9sSdDhUDd7Mk14rnZlrqiQ4MqRNkJ+Xxtgc2I1N9n5W6ZsQwAInVuOR6oJDRWOZJ0DQc6F1OiOf4dd7VN2bq0RlxrCh5NTU4+6335OVb+u5drwrAkX2qP2Rvkt61wWTz7NKJFXkHmPYXYRvqAz9VxD54I6gT1aFYtzgEN3LRUQ6SnfPcg08mePwyMeg+PYNkjS30DAhg1T79eIs9+2M3VN6+zVXz+puO5SXXss0wgfv8jnOyO8vE9XjQ6ViV0+8hiv+Gu+HbGpuNBhTumBTSJPzgh6BCwo0E6AApY6mmMMpvmX/NKZB9JAeY2cbHCubQ0nQfLcUrp2+4IdIOiZ3BikGwaWkMyp+KEyGvd061Nfu/z48PIuqHUCOvJVlhKGGu3vT7uH75liDheu2JscM;4:8FN+8N7c3ONWPXPao5vSqC4IHtCL7nnGeLcw+Hp1cZsKiutWHp2i0ZBndHEdd7k0J026G5qDf095+IH60SJA1e2sFs0H2A2rGN3dqzdd/CCOeQjm7GIMqbpeIZfZMEf7+sN8XPlIYQ5tV4qBh+WH4KwlyjHzFsL0gJTRm7VRVajGB/Hp0MnWi4XZmK6iEv9MaH+o2NlRj3bgGOngy/vc0vY19kEcERQc5D1GBUfrDMOQysRjgxwqe6Xrw1oPFUAilj/i5D3we/WpXEFO+GBMqP5ybqi2tZwArgyiHM/5NBE=
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Microsoft-Antispam-PRVS: <SN1PR21MB0016DBFB25CBC237940B542FB7940@SN1PR21MB0016.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0016;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0016;
X-Forefront-PRVS: 04238CD941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(199003)(189002)(47776003)(305945005)(106356001)(53936002)(68736007)(189998001)(66066001)(2361001)(7736002)(2351001)(33646002)(97736004)(105586002)(5660300001)(42186005)(50466002)(478600001)(10290500003)(48376002)(5003940100001)(6486002)(1076002)(3846002)(25786009)(4326008)(6116002)(8656003)(8936002)(107886003)(5005710100001)(110136004)(50226002)(8676002)(10090500001)(81166006)(2906002)(6666003)(81156014)(6916009)(50986999)(101416001)(86612001)(86362001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0016;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0016;23:zHhwY3SmPgrvhVeimNFdOFKQiiDNB6swIIyXLUhFc?=
 =?us-ascii?Q?rHqi04X7o72QaTMNYwpQPm/GA4KpnbtOePTHyMMEOsxRe60Lespgj38nmFld?=
 =?us-ascii?Q?nZMSA3mKZm0NUQe3WxWygvXTInOh74nkhzMu8tpsL+1vliQkw8qz9Fm9u9D2?=
 =?us-ascii?Q?P8OGU9OYhi2p2anHT3MfzVaIaHqWs/K5eoMC3z26dHGkyPa9h4I57ZmCT85s?=
 =?us-ascii?Q?ccSg7zuDsdqZ+liH9qELiRZ3Pk6Zn2K8qdio60M/NN8Csss8+5z1wHBmQ44L?=
 =?us-ascii?Q?G3ZxjebDnVwBmSEAeCBhPmlI/F06DTHQnduegNUew0fMv0IzIDJDBuNb/g1s?=
 =?us-ascii?Q?E9EZ7OYa8/Plf36LOfIwh6McbqmnLkcioqPN+4KWCeBDT0t3/hB8mdknDmEU?=
 =?us-ascii?Q?um7wrPJsyPpL0F/KlNxX9ylWpZtJuAzhphGCKscHXK41R/GIjeGLm+Tm89pQ?=
 =?us-ascii?Q?9100ATPRsGrz9VPXP2dLHkm7av/HcjVFMHvL5PpJ4wqP7Q4/dba/nCvCFEat?=
 =?us-ascii?Q?6IMFi9D06jib+zceQUkVG67TpEshT5DUXsP9w1Yf6PHgxKQacJD8HHHrv0kf?=
 =?us-ascii?Q?f6pV+MemM0s6tpzXzxVcOED1rvVg+ig4ZcS7ijPUfrpicvHD6XPKKvwCqlPg?=
 =?us-ascii?Q?sTzsTGXN+mHbJwSq7wzUUMS1+FAu+h3bQDc/pBkza6iaourhmHloeJW/k3J9?=
 =?us-ascii?Q?AsPdF2mx49Ts8LiSrxZLdcUJkUGoXywFapebwe+GzXq/1zDY8G6dPeprX1ih?=
 =?us-ascii?Q?+pBU2aDxBHGCNsyJdSlVaFHh0EQlos03R1IFRF7RQOkkaYHLQ6qcHLGf4zHk?=
 =?us-ascii?Q?0Ubv4VQeXRNmnaT7++KF0LSvo3escLzXaagvk3I21HZOSoTmmOAr5bN38Fcr?=
 =?us-ascii?Q?Mf1dgpjwoFQIyCatz/hvY0xnUq69eE2JNAYfoiu/y/lFUFOKvSFpgiiENM9m?=
 =?us-ascii?Q?lwA/6eHdUPeIcJlCN/Kgma+RkB9f1tNGBEvHs76jYN6+tz2godAr5Qpx5BkC?=
 =?us-ascii?Q?R2/BI+v/BOC/kHaLcrCh9Cafok0mBQxS87hrFj6u/Ey8bCs0wBZ0D/UF1FAB?=
 =?us-ascii?Q?vyqjDYAY4x5oKzqEeGbylFaLaVuXDvIWSRMLb8K11ycmnxL2DYAf1n1RPpl1?=
 =?us-ascii?Q?1yIBzamd7dpfS3brWGM5HW7xFhFqEZzzXJVRyN24/pUBK2ClCkOa3R2xe129?=
 =?us-ascii?Q?8gR3sGPpFmEb3g=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;6:8LjMH2Vanv7ATz2wJhFeHXk+J3OOiwN/G3GMT1xsXaT78RvzisD8zzHMUrxO0QVdM3GzwYb7vbneO9tDMz2G9p8uZcNIpXDs4O6nUsu4WcJBY2Gg4/tpnxierLedQwmfZauVD+4TEh63VdAxLtaqDwGaS9s9haZX//lsFFIDaPUG73xkgyBDiZoWwmo0sgarVSgoZ7dWUtEHj/9LUnIxGBr04Pu3jWNiWhjwERowB53PKTpHnGWyWfukjbT8bRUttZtR4/O58p+kHTgjCOxR59+a7gTSwTsWUavOPzyl23ZlRwlr1sklLYL6sbwxrQnmh6c53CtvMYEMrwiL943JVw==;5:JYANPiFiBQ7q5UX/JN4ZOykg3KgtIuQc9J+Ff+0XY3UMyCHNRVc+tELYrjbErb4Ksw+68xPvHVrDqRYn+OsBjaVGDWiiJz/ucmYtCrVkbQfsY14k2yJ+QuHCX/WbRXos+ptjqU6f7jhQSXDEOFNX1A==;24:HFLW56Kd4yPC6RssR9bUmPzoXxCltIdVmdIVtAcazJBd3Rdvxcc+GfRMzX87qinaoHc+1pMztQjxZam+f+Q/1DjGC1nSwylA29qORvksOig=;7:gIyqsFQvu58MzZvocC+eGnF7IsLbTyjodItVN8oxo/eLblep8EG1QWrAQDWlok7NVpzkNVHfXah7JQ5/6UQIVYpqauWCfqwThJPXhVSIcXPimOmmuPD4lcbuLhuHewMWVSI2jQNyCrNjE/IhumFyZd9NYFb6vfNBumxRkZRbJUXYj2hNjn4SbKc2ofxPDDx4P8IE4gyYsDpoHv+DRRWDcZ/Oo9CywWbDDJa3TapTWbQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2017 16:26:42.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0016
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

Changes since last version:
1. Removed the function pointers and just check the ignore_case in the
compare and hash methods.
2. Added a comment about the hashmap and why it is getting initialized
and freed but not a local.
3. Use hashmap_get_from_hash and remove the dummy entry

Kevin Willford (3):
  merge-recursive: fix memory leak
  merge-recursive: remove return value from get_files_dirs
  merge-recursive: change current file dir string_lists to hashmap

 merge-recursive.c | 76 ++++++++++++++++++++++++++++++++++++++++---------------
 merge-recursive.h |  3 +--
 2 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.14.1.329.gcdd497e120.dirty

