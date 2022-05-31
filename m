Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC0AC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbiEaOYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345217AbiEaOYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 10:24:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B68020A
        for <git@vger.kernel.org>; Tue, 31 May 2022 07:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwYL9v6gkpBfXNT+4uExh4l4n4PVMjX1/Vyc5GQwHXUf0+4vYtJkw+XxTs3NUCkEPCPH6dZKeAxpWn7hn4V+b1J/90LZege6qLyItjNEN45hsRvvnnEvRG37G9nhB72+KgV3WrpIANYfp7b5H48eS4joGOGPRCjXiRLl8AXzOsjNOIlijGaq/hmuRLrsnv+Wo/RTh7voJ9tTgctvQQYcTPQc76Dbs3PA8j12YRCJOh57M6aG4UdkRENxaiQGemOhyn+BF6+dcdqKPHHc77hcZAjH9EcM9gs+n+xXjqi0d7C+4G0FmjA+fj1NJTLSPF17jG2v9jOlI97hcaYo065Kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWvqf3aWn2RifcKtE3kCBl5RX5+/Xtd8XhJ/gBT7TuM=;
 b=M1HRYkhbi+dwptWIe3zrm7lp6X9R4Dm4V+9rkN86JfVyWzWHRYKXtu8g+GD3QY0jrCF616r9h1HdL0Afy/rtWYXTWzOIZ1WyxphyFwIvapOBHAe9eLz9wqew4CDZm3upmdvf4YzjhGVYE19+iyrIoM0Pyo2xxJS2aJPJtGbeALU3l9q91LE4PWhN8NWeR6ew06dsJWL3BOKcLLfICaJfIebrD5AxGN1bARE1IffEoTm/jxYL6wNqhW6mK0QZ8QFXScywTuHPdFi8jDB4nHqqxfqJ10/cq+Te4x01LJnXXEKZ3w2LBl6bXp0XaE9YDOnobpm6Z4jaaQeOmRQbONRYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softwareag.com; dmarc=pass action=none
 header.from=softwareag.com; dkim=pass header.d=softwareag.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softwareag.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWvqf3aWn2RifcKtE3kCBl5RX5+/Xtd8XhJ/gBT7TuM=;
 b=ks8tMp9FXLsUmIThjmCMCfLijZv7zlaTV1mlphkcCV16VvGya3fcEy878Ybjk3jdOJzGV+64753rYda03sg7uBYDiHKsHNwwQOTo3FWcdSBFnATqmRnOoNr/HaJl0hpqB2F5V95XfpX9bh0nniEKGM4Q8j19kPwwtLBgXIJvZhE=
Received: from AM0PR02MB5635.eurprd02.prod.outlook.com (2603:10a6:208:15d::11)
 by VI1PR02MB5792.eurprd02.prod.outlook.com (2603:10a6:803:12d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 14:24:42 +0000
Received: from AM0PR02MB5635.eurprd02.prod.outlook.com
 ([fe80::f021:da15:ae53:34fd]) by AM0PR02MB5635.eurprd02.prod.outlook.com
 ([fe80::f021:da15:ae53:34fd%4]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 14:24:42 +0000
From:   "Philip, Bevan" <Bevan.Philip@softwareag.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Files with \r\n\n line endings can result in needing to renormalize
 twice, after deleting checked out file and restoring from repo
Thread-Topic: Files with \r\n\n line endings can result in needing to
 renormalize twice, after deleting checked out file and restoring from repo
Thread-Index: Adh0+ba2lvEh2aeaSzKNKrxP3MqN7A==
Date:   Tue, 31 May 2022 14:24:42 +0000
Message-ID: <AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_ActionId=777a93fd-a82b-4c59-90b1-d6ab9b21a950;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_ContentBits=0;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_Enabled=true;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_Method=Standard;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_Name=Public;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_SetDate=2022-05-31T13:21:32Z;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_SiteId=d9662eb9-ad98-4e74-a8a2-04ed5d544db6;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softwareag.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f867307-8940-45b4-9e40-08da43114d91
x-ms-traffictypediagnostic: VI1PR02MB5792:EE_
x-microsoft-antispam-prvs: <VI1PR02MB57923D1580E83698E1A91922E8DC9@VI1PR02MB5792.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2dFsHRwqZ0BruLzfs4vY05HIWSE9tsZJkCLT98mhRV59rahZr0PHT1Ri4nDn2wLupl/q0Eu90cXictGW7pwPutF9WD+rM1AME4uShdTOh4TXgkVXxRWDgdLx9xDbnBkzBLyW3RASeGC5ksPKqYFi20gA8DwW2eYd77XXeXcSci1D+7LZcRwLUa6iOX6gFZjJli2hUNhJvNn6GCmXPwgu4hOQzjA9YNn3G9+CHWw6FqA8EqX8ECqA8aCo26Z21SL0kXiADLFQGo4b7/TxSjy7F/M4hPyITNJOUSa1M650CPBwKx90nuYu7gtjHjLVxFlKn+5wfH4xhzpMxIWuDt1qC8QeaOUSzxSvTFKuYyJWZ+WMuYhn7Ey+ZMA/5oz7aFMbs3MBTKygdwIKA0/HF/lAht0R3tsVqbvbMqhMWskuE1J2XRz+44N1KsE88gK2huEvrlK8n4EA3WKYNjOq8pFu9P6CTjjM7Ha8wItJO5ZRJ/vnvF9aMz+F0IDbDMtDya6AFEptV3XLyLlGFNPxItz7gXUSgNuMwSCLIbMM48Xc5Ob7k66F+o3o+/uNZq7ejOrjMV72T8WVUwsP6KZQmYH9M62liPYHlzKA+zCxVW25dg/W+6ZthcgUrAoqDsA4ttWpMohnubxTOwheh+hy9flIXByLdAk2vpoSKiSmK6WnlvnZzwoUVgg0mU1s9RDtf6MfM3sLK0oWrrNobh6FYWhnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5635.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(2906002)(316002)(26005)(6506007)(7696005)(6916009)(122000001)(8936002)(38070700005)(83380400001)(55016003)(86362001)(52536014)(66946007)(38100700002)(5660300002)(66476007)(76116006)(66446008)(8676002)(64756008)(66556008)(508600001)(966005)(71200400001)(33656002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5hrUEMXtLSVbhHS/2Ry1yn/Hev3dVcl+5OUGQrRpIeNBoQE1C04zndahHvMT?=
 =?us-ascii?Q?H+cSCl9HOW9RtSgYbcEEZaPzvLzFfbtkaeEbtUu5k2iSgVnWny+rj8UoLLTe?=
 =?us-ascii?Q?onKoQENXw+wBf0U4AfNMBli9YqDNShOZwLbfHvfz7Eh115dR0nqbNIHJMQG7?=
 =?us-ascii?Q?0REPCnWNVXVWhV8FiXtEykoVB+v/omIur3DqtUH9PBEJvlgtYh7IXgeEGrMu?=
 =?us-ascii?Q?T/k8XIDgC9Qp+Wwi208WJ7WyVIYjEjZsd84YajRiakaIMR+60oIEu0fuzcPn?=
 =?us-ascii?Q?d8OiI1GcN7Wh/tXe66SXKATBWyZTkwgK9RmtTIp4mA2TpbIZai8nmEERG9yy?=
 =?us-ascii?Q?b/tUkbBzf5YNEqbKo0vJo/br856mk3z0ctc+Z6tWmYWKCVe2m8G8R14ES1Qs?=
 =?us-ascii?Q?H35NR0A+ebC2sZ4saSSYd7lAn8SOZYh9RIl3/UyVX4ZTIJe1njycH4XOSbYe?=
 =?us-ascii?Q?jll2i7nVfqRcYpbDPCr05ZNIi5SY+cL+USYLIPUMfSG3EHAHBSvS2Dn7WUwz?=
 =?us-ascii?Q?B07Xi2t+C67OrP6nhBkNfexi1rWfUTkRiY8m9TIT86Kx0Dr6ZrIvpNFoH5RF?=
 =?us-ascii?Q?wkclLkx2K/grRmKG/XmDEzDZO6X9ehxaliOqAIy2c7vReooelq3VnwCqtEuh?=
 =?us-ascii?Q?J+qaImzCbjE8GviJi4BF/1fzDQ+F3FAkC3OAzj4WEdiYAxUOMsgaMCppg5g1?=
 =?us-ascii?Q?U9YQoU78rc1RFZYAeWcggydKTEZVdRQPPzBY7JDmgT4OTCu4eMZ4+KPf/qni?=
 =?us-ascii?Q?N7xBbxYtBLosRgFA0a2w9BRPZQ+rgdMAMF3SGDZfPVC/ytlYiJS4cnYB1oLO?=
 =?us-ascii?Q?rkcBURKfiD9f6kWBg7tM/bbl/pN6re4rZGi8nnzZd/TiN0iHou4DOnmko3w6?=
 =?us-ascii?Q?uRgJxwAekHgqYplPyhAITLN0FW1j/GqKVy2gegCoPiib4sti/WqpCsyYkilx?=
 =?us-ascii?Q?X4JgQs6I3WQxfCpLGyS+tx7GYB08P5wkK3pLkQsFBVtf0rFn4WHJhYuyTXv1?=
 =?us-ascii?Q?M6Ks4gJadbmxovJBNoBQIfJcOyQ2jH44NBMuA3qhh111uw3oSjyQZGpkhq3w?=
 =?us-ascii?Q?bL1YjOvpUlUqxnPnNOkL65AGOOFwuzNuoWxNDM2W+5A240JAh/hT97uXNktV?=
 =?us-ascii?Q?8IDfg9H4w1nNw5CjDxmDYGUe+74Bh2t5vHJAMIzcyKe4+EUhiIWdUhK4UmR5?=
 =?us-ascii?Q?xmDPHa6G/40yjxxQN5eyuHTZ21FElsbzeARsJ2B7kKsVa3Nr+UYlRcw6NpCg?=
 =?us-ascii?Q?hdYJO4ZONKuLjiVcp4qqN/uMSgcurbIyy6iBRWdFNDWzLujmlxVy9tjlvxX2?=
 =?us-ascii?Q?v3xK/Cpmm507csEHo2wQV1ldYPJWcRO8N1UU+FVoJ+/BL4Q6ndeYLflXHBAM?=
 =?us-ascii?Q?E82+wCyYOuNAlJamGJzier34cwbi6WRJIRpT63K99/T79I0R5Gv5eCibE3tC?=
 =?us-ascii?Q?P4dYbBCfxSrJM9PlcoKSDbPFYe5XTa/dQTVKUjH16XOY7oHwJOXG6+GwEWs7?=
 =?us-ascii?Q?Y6C/EdsE3/hdZKDr5g27hbhCVRkiO2hnT+QArHx0hK14100gMjqW4gX7ld8C?=
 =?us-ascii?Q?GBBNt5vYvHuptnWeruQFLIpG6bKxjvs85VGfsPa0AbjhJjduJSIZhckZqmqN?=
 =?us-ascii?Q?AVcfV5IeVDzg2Y6/J7XDONBho41uSGqzqcvb9SFZ8USZWGnZ8lcMNZTdyYgW?=
 =?us-ascii?Q?tASKQ5xyPkxxcvLYWH7C5AysxaRS/61I+WniEV8TNObaiWI315bSCQM+O3Bf?=
 =?us-ascii?Q?ihZD9eC/tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: softwareag.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5635.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f867307-8940-45b4-9e40-08da43114d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 14:24:42.1084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9662eb9-ad98-4e74-a8a2-04ed5d544db6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dQFAKkPQRTtRNKz/VXa8no8L1/XycSFwTPWIguZKV9N3fgTtKOhY25WKZI6PD1lOTljPRiRZwyNB32HIF/Pig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5792
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I've experienced an odd bug/limitation with `git add --renormalize`, requir=
ing me to run the command twice on a specific file. Here is a bug report.

What did you do before the bug happened? (Steps to reproduce your issue)

#!/bin/bash -x
printf "Test\\r\\r\\nTest Another Line\\r\\r\\nFinal Line\\r\\r\\n\\r\\r\\n=
" > git.bdf
printf "* text=3Dauto\\n*.bdf text" > .gitattributes
mkdir test1
cd test1
git init
cp ../git.bdf .
git add .
git status
git commit -m "Add file git.bdf"
cp ../.gitattributes .
git add .gitattributes
git add --renormalize .
git status
git commit -m "Renormalize git.bdf"
git add --renormalize .
git status
rm git.bdf
git restore .
git add --renormalize .
git status

What did you expect to happen? (Expected behavior)
Only needing to renormalize the file once.

What happened instead? (Actual behavior)
Renormalize the file once, then renormalize again after deleting the file t=
hat is checked out on disk and restoring it from the object stored within t=
he Git repo.

What's different between what you expected and what actually happened?
Needed to run the renormalize step again, after deleting the file checked o=
ut on disk and restoring the file from the object stored within the Git rep=
o.

Anything else you want to add:
This only occurs for files with \r\r\n line endings (and possibly also endi=
ng the file with \r\r\n\r\n)

The file is in three states:
- Initial state: \r\r\n line endings within Git object
- Initial renormalization state: \r\n line endings within Git object
- Second renormalization state: \n line endings within Git object

Happens on both Windows and Linux (replicated on a fresh install of Git for=
 Windows within Windows Sandbox). Additionally, tested with `next` trunk on=
 Linux.
System info is for a Windows build where it does happen.

Directory, and file names should be irrelevant.

We encountered this naturally, with some files within a SVN repo we're migr=
ating.

[System Info]
git version:
git version 2.36.1.windows.1
cpu: x86_64
built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19043
compiler info: gnuc: 11.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>

Thanks,
Bevan
This communication contains information which is confidential and may also =
be privileged. It is for the exclusive use of the intended recipient(s). If=
 you are not the intended recipient(s), please note that any distribution, =
copying, or use of this communication or the information in it, is strictly=
 prohibited. If you have received this communication in error please notify=
 us by e-mail and then delete the e-mail and any copies of it.
Software AG (UK) Limited Registered in England & Wales 1310740 - http://www=
.softwareag.com/uk
