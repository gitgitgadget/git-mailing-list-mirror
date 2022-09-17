Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08641ECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 16:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIQQaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIQQaG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 12:30:06 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6618E04
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663432204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fq3mc1AUIrfzEMdxtQlF08hi3BV7TJKBQdkFF7fr5FM=;
        b=B1w/kTIprp+shF4uBB/rz6TxMSgOtvTVhf2/sOye1h34jS9VudQ9Hht+swY0R66Td2ass7
        wFH7mScBlUjrjwf3yx/Q74HdjLGDivWcMe2P3WW9BSfy9zvELyXnrBHasKsY6zGu/dNQ3e
        /2jnbL5xRpBehXpUezn4HHpHn6lITKM=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17011012.outbound.protection.outlook.com [40.93.11.12]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-tdFjxCGdMN6z3dntmoTX7g-1; Sat, 17 Sep 2022 12:30:02 -0400
X-MC-Unique: tdFjxCGdMN6z3dntmoTX7g-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by BYAPR05MB5479.namprd05.prod.outlook.com (2603:10b6:a03:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.7; Sat, 17 Sep
 2022 16:29:59 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5632.011; Sat, 17 Sep 2022
 16:29:59 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v8 2/5] fsmonitor: relocate socket file if .git directory
 is remote
Thread-Topic: [PATCH v8 2/5] fsmonitor: relocate socket file if .git directory
 is remote
Thread-Index: AQHYyjKP7P3pxIII0EuJ0bGZzwua3a3jKVoAgACjR+A=
Date:   Sat, 17 Sep 2022 16:29:58 +0000
Message-ID: <BL0PR05MB55710118DBE7AE6A44795D7ED94B9@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
 <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
 <b535649722826d7317061da7d8b0cf3d6e2a51ff.1663377141.git.gitgitgadget@gmail.com>
 <CAPig+cTRNfewL01GOVTjFLaFq-vGgdeV2OX6Bn+StGrgb1JVMA@mail.gmail.com>
In-Reply-To: <CAPig+cTRNfewL01GOVTjFLaFq-vGgdeV2OX6Bn+StGrgb1JVMA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|BYAPR05MB5479:EE_
x-ms-office365-filtering-correlation-id: cde5973b-f621-4179-24e2-08da98c9dcfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: pcuR+PN37TtFFIBrqH8CtB/btjXUEqYRQIDGTfnzIf5g5YxRiT1Ik965V4BI3OwizNUZUrfPHqxE5gHKeHzn5KcrRcz7UfSWzcurM5pApzmzVfFp2X/l1yKV+qiitK5ji4MpTPeQN+KqYkRjQVFAaaB4Q1+woDflsuDDAMAlksbsRJFBe170dPPRLHb4UQJudhTTPs8qgDijdGLu7SgNOloPN0hJl7pTJ0WpQNhgPJC0UhIzzGt7l9DPv9zlR3kuygBtgNFhetqky470kKqd6FERfJ9u9BKEGxudyCFjXI/ce3BZbdsc8e8e8np9cCotHESLpDWpUBsrUPK1b5hCOpA7MRnPzYARE4/6tNe8Bf3e8ksXpR1HXkdS8905ifvHLKBcDl70kFLmWyqliFobjn+OZvLPjFpCfVaJzruHreNFGBSYiJ5rUQiWzP4e9ZQG0ssEGmui43m77a7iurH7PumCmqC+VXt1wfXUmAbbAyvqM3M6DyhZnMoHIlR11bAl+V+7LdOSO/ZcYrySdh+SIe1vtA7a1VFB0Bvwy5Cm34SyBVxKks4MMlFObmo3w2quLkEfUkBRH0/BmMxeEsrworFlk/jDa2UKUXX8hfOSZp+qHuvJgJv7wNIhy+50MMQ77+dAiszvfdTPu8TI1BXKw4mC0sHf+PuY079GZHNGoJrG2VAp3aiSyvmyM1EMFL01YkQ2U9yTDlBi74HwXB5J7iDzgZVlDRLJ3+UupGyvQV77S1MQhxVw4FwQ9i+MIsHh5VOuAzZYbeE5fpohAmbCCHjFLRBsiFdXnZMel5DtooVaqfsTU11e97AmwQXQT5x+QomdY82mKfZCOXaLH9+6ykBIKhV12yhZhCjrgj8d5r57vaxaWReeVpUXszdWG4nLbTFHmHd/vTnQZ7isMgTFUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(366004)(39850400004)(451199015)(122000001)(38100700002)(186003)(66574015)(83380400001)(38070700005)(9686003)(26005)(53546011)(7696005)(6506007)(71200400001)(478600001)(41300700001)(54906003)(110136005)(316002)(8676002)(52536014)(86362001)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(55016003)(8936002)(2906002)(33656002)(142923001)(473944003)(414714003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkZKeitCb0E1VFVUSmZMU2gvQVNCWkJXYzZuSnM3WWE2akl6OEpySkpJK2hp?=
 =?utf-8?B?RHlwRnZlOFB5S2xGM2NnSXNSMmgrQ3dMejJzbkFGeW9IUi91d1k3akw5OTUv?=
 =?utf-8?B?a21hOHpqRzRpOW16RkFxaFBHalN5RTdIUGVObkFJT2RHOWs5QitFc2RmenNS?=
 =?utf-8?B?V0dRNDhGTlA0SmJDbEIzWG51UGh3NVdaUDJSK3VKM1RsdDd0Y1EvSmVvOFNM?=
 =?utf-8?B?Y0Y0V05wVnhHSVN6SnJhTElSMDFTM0dHTjlFclVzbHFoSHNGcyt2Uk5Fc2hr?=
 =?utf-8?B?Nk5ubVNyWmM3Uml0dzEzbUx5TmFxc0ZNQjM2TEFTL3V1L1NvVmlzV01EbW90?=
 =?utf-8?B?R1JxTko1cUV6alExcFZMQkJMM3Fsc2JuUG84MWIrMEFWbWxqL2xmcHo3aGl1?=
 =?utf-8?B?dnFkWWJ4NWVkZGEyVkZGeEF1WVE1bTlIOTQxYjNqYklnM0o5TXBGbjFwd0FZ?=
 =?utf-8?B?aXdZemJHa3lDZWtHSG5iLzNscSthdVEwKys0dUx3RDc0NkVZK3JqdG9YckhK?=
 =?utf-8?B?Q01UQlhWVzJKbW9BS3RDdElWUlVFbFRBOFk4TDdCRGl4cWZiZmV2dGRmbzEv?=
 =?utf-8?B?UVdhcUxYU2RwWG1GV3FNUWpob0cybzN4cmFRWGJOcFlCZENnbzJiZVR3dnFC?=
 =?utf-8?B?SHRJeFpGNms0TERTNjEwWExiMW0yejNSM2JOeVJpRUMwT28raHErUGQzVUJn?=
 =?utf-8?B?Q2JHWWNPa0Fib1lXUmgzYkVwdmJEUDVLbDBaSEIzQ1BGck4vUGZ4aDRzd3Zl?=
 =?utf-8?B?Rm04ZzV5Y1N2V2Vtb0VxZzBEWG5WeDNKY21pK1V5NVRheFVrY0VzTTRJVDFo?=
 =?utf-8?B?VVpOUWxEUENwOWlGSkVITHhWU09QaG9wRHQzNW9QODBJOFBtSFNaUVltQTMz?=
 =?utf-8?B?OVc0QjBQcGh2MTZya3p6ZjRXZVBtTmxDOUxRMjZtbEJxRSs5ZThrZUxuVm5w?=
 =?utf-8?B?VTN5UStiM2ZXVkVLK1JFV3VEakR5OFBZUjdySE5ocnZvblRGbzBTYy9IbnBU?=
 =?utf-8?B?Q2xmM3ZIZFltV3dEa3lncjZvVmNVYU1JZml5ejJQLy81VHdxcGh0WHVPUVdz?=
 =?utf-8?B?VmhXaHFQSEFCbFNzemJTcStETEtkTEtTU2paSmdORUNoQllabFRuN0JkRmJa?=
 =?utf-8?B?M2t6ZnkzS25HOXBFWEFBd3hoSWYwWXlTcU1tV0hoUm92azVsVTgxM2w5WWJC?=
 =?utf-8?B?OXNBdkFrSnVoZzg1bEN0dG5Udk9VNkJlUTNzTmhuc0h4R3d2SjJCSzU4cWNG?=
 =?utf-8?B?MkRpNjFDRUhGNU9BZk5NcC94Wk9zeXNrd2xIS1RZNkd2L2NrU3h2TUhJU2R2?=
 =?utf-8?B?KzByUmozMnN0YWdFajd5d0xSZDNWN1RuTm5VajR5elpVVGdrVGF1akJEK1ZO?=
 =?utf-8?B?TjVyS2pKbjRPeEo3eW5NQ1JEY0ptU3lOZ2VWd2RFVll5cG03LzZoRlM2NXVv?=
 =?utf-8?B?TEhDQm5uTHpRWW5VYjlGMEhkVW5WUW9WaHVoRUlxdGQvTElVaTBDR3RXVGhq?=
 =?utf-8?B?eTIxT0ExazcyWlIyZXN6aEw5MktBYXhJNU1xMzlESjJaSkgva0tYTmV4QTI0?=
 =?utf-8?B?VjVDbU9aS0VjYjVabmUxaHU0QW9zangrMll3NEQvOGd5NGN1WEJwY1k4VDFt?=
 =?utf-8?B?OXJDdWY0cHlYVUQzY0UyUVM0QTNxUndyVUtBa3VvQThsQXRVb0VtSGg4dXNv?=
 =?utf-8?B?NUs4Vy9GYlZRQ0JuQ2ZsUXJwU1p6RVZ1Y0VFYUdwMzV4VlgyMW8rM0RLMkdR?=
 =?utf-8?B?QUR2NXdFTFVPMFI3VEYzd2ppeFEyVEJYaDQ0V3dQUFE2aG5nZkUyb0JtNWt6?=
 =?utf-8?B?RkR1NWJiWGJkNkpkVEJKd1ZnWnBUN2NEVXlQSGdVUGJmZGIzcTQ3d0Q3SlZk?=
 =?utf-8?B?NHRlYVJnTjF2NnVETWxMSDN6cjM3RisyMk1CZzAvdGwzY0JTdXNleHA0bFJB?=
 =?utf-8?B?MWltUFdvRWowV0RWdkNZZWJUbHo5MWVOSVpEZCtQSllvZDBnWVVwY3VpMVBk?=
 =?utf-8?B?Q0xuREdyZmJBN2NENGJHeHVBTHl3bWcrbXpxK29mMWxQeDhUNDc0MFllU2hP?=
 =?utf-8?B?a2hTTmxxeDhKNkZjZ2ZHSnFRc3N4bUpLRkpUeGQyT2cwNm1FVFhhV3ZkUXp6?=
 =?utf-8?Q?5jH4N1xoansq29sML2KgOUHOP?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5479
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBTdW5zaGluZSA8
c3Vuc2hpbmVAc3Vuc2hpbmVjby5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMTcs
IDIwMjIgMjozMCBBTQ0KPiBUbzogRXJpYyBEZUNvc3RhIHZpYSBHaXRHaXRHYWRnZXQgPGdpdGdp
dGdhZGdldEBnbWFpbC5jb20+DQo+IENjOiBHaXQgTGlzdCA8Z2l0QHZnZXIua2VybmVsLm9yZz47
IEplZmYgSG9zdGV0bGVyIDxnaXRAamVmZmhvc3RldGxlci5jb20+Ow0KPiBUb3JzdGVuIELDtmdl
cnNoYXVzZW4gPHRib2VnaUB3ZWIuZGU+OyDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbg0KPiA8
YXZhcmFiQGdtYWlsLmNvbT47IFJhbXNheSBKb25lcyA8cmFtc2F5QHJhbXNheWpvbmVzLnBsdXMu
Y29tPjsNCj4gSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+
OyBFcmljIERlQ29zdGENCj4gPGVkZWNvc3RhQG1hdGh3b3Jrcy5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjggMi81XSBmc21vbml0b3I6IHJlbG9jYXRlIHNvY2tldCBmaWxlIGlmIC5naXQg
ZGlyZWN0b3J5IGlzDQo+IHJlbW90ZQ0KPiANCj4gT24gRnJpLCBTZXAgMTYsIDIwMjIgYXQgOTox
MiBQTSBFcmljIERlQ29zdGEgdmlhIEdpdEdpdEdhZGdldA0KPiA8Z2l0Z2l0Z2FkZ2V0QGdtYWls
LmNvbT4gd3JvdGU6DQo+ID4gSWYgdGhlIC5naXQgZGlyZWN0b3J5IGlzIG9uIGEgcmVtb3RlIGZp
bGUgc3lzdGVtLCBjcmVhdGUgdGhlIHNvY2tldA0KPiA+IGZpbGUgaW4gJ2ZzbW9uaXRvci5zb2Nr
ZXREaXInIGlmIGl0IGlzIGRlZmluZWQsIGVsc2UgY3JlYXRlIGl0IGluICRIT01FLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogRXJpYyBEZUNvc3RhIDxlZGVjb3N0YUBtYXRod29ya3MuY29tPg0K
PiA+IC0tLQ0KPiA+IGRpZmYgLS1naXQgYS9jb21wYXQvZnNtb25pdG9yL2ZzbS1pcGMtZGFyd2lu
LmMNCj4gPiBiL2NvbXBhdC9mc21vbml0b3IvZnNtLWlwYy1kYXJ3aW4uYw0KPiA+IEBAIC0wLDAg
KzEsNDYgQEANCj4gPiArc3RhdGljIEdJVF9QQVRIX0ZVTkMoZnNtb25pdG9yX2lwY19fZ2V0X2Rl
ZmF1bHRfcGF0aCwNCj4gPiArImZzbW9uaXRvci0tZGFlbW9uLmlwYyIpDQo+ID4gKw0KPiA+ICtj
b25zdCBjaGFyICpmc21vbml0b3JfaXBjX19nZXRfcGF0aChzdHJ1Y3QgcmVwb3NpdG9yeSAqcikg
ew0KPiA+ICsgICAgICAgc3RhdGljIGNvbnN0IGNoYXIgKmlwY19wYXRoOw0KPiA+ICsgICAgICAg
U0hBX0NUWCBzaGExY3R4Ow0KPiA+ICsgICAgICAgY2hhciAqc29ja19kaXI7DQo+ID4gKyAgICAg
ICBzdHJ1Y3Qgc3RyYnVmIGlwY19maWxlID0gU1RSQlVGX0lOSVQ7DQo+ID4gKyAgICAgICB1bnNp
Z25lZCBjaGFyIGhhc2hbU0hBX0RJR0VTVF9MRU5HVEhdOw0KPiA+ICsNCj4gPiArICAgICAgIGlm
IChpcGNfcGF0aCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGlwY19wYXRoOw0KPiA+ICsN
Cj4gPiArICAgICAgIGlwY19wYXRoID0gZnNtb25pdG9yX2lwY19fZ2V0X2RlZmF1bHRfcGF0aCgp
Ow0KPiA+ICsNCj4gPiArICAgICAgIC8qIEJ5IGRlZmF1bHQgdGhlIHNvY2tldCBmaWxlIGlzIGNy
ZWF0ZWQgaW4gdGhlIC5naXQgZGlyZWN0b3J5ICovDQo+ID4gKyAgICAgICBpZiAoZnNtb25pdG9y
X19pc19mc19yZW1vdGUoaXBjX3BhdGgpIDwgMSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJu
IGlwY19wYXRoOw0KPiA+ICsNCj4gPiArICAgICAgIFNIQTFfSW5pdCgmc2hhMWN0eCk7DQo+ID4g
KyAgICAgICBTSEExX1VwZGF0ZSgmc2hhMWN0eCwgci0+d29ya3RyZWUsIHN0cmxlbihyLT53b3Jr
dHJlZSkpOw0KPiA+ICsgICAgICAgU0hBMV9GaW5hbChoYXNoLCAmc2hhMWN0eCk7DQo+ID4gKw0K
PiA+ICsgICAgICAgcmVwb19jb25maWdfZ2V0X3N0cmluZyhyLCAiZnNtb25pdG9yLnNvY2tldGRp
ciIsICZzb2NrX2Rpcik7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogQ3JlYXRlIHRoZSBzb2NrZXQg
ZmlsZSBpbiBlaXRoZXIgc29ja2V0RGlyIG9yICRIT01FICovDQo+ID4gKyAgICAgICBpZiAoc29j
a19kaXIgJiYgKnNvY2tfZGlyKQ0KPiA+ICsgICAgICAgICAgICAgICBzdHJidWZfYWRkZigmaXBj
X2ZpbGUsICIlcy8uZ2l0LWZzbW9uaXRvci0lcyIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNvY2tfZGlyLCBoYXNoX3RvX2hleChoYXNoKSk7DQo+ID4gKyAg
ICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIHN0cmJ1Zl9hZGRmKCZpcGNfZmlsZSwgIn4v
LmdpdC1mc21vbml0b3ItJXMiLA0KPiA+ICsgaGFzaF90b19oZXgoaGFzaCkpOw0KPiANCj4gQSBj
b3VwbGUgY29tbWVudHMuLi4NCj4gDQo+IEluIG15IG1pbmQsIHRoZSBkaXJlY3Rvcnkgc3BlY2lm
aWVkIGJ5IGBmc21vbml0b3Iuc29ja2V0ZGlyYCBpcyBsaWtlbHkgdG8gYmUNCj4gZGVkaWNhdGVk
IHRvIHRoaXMgcHVycG9zZSAoaS5lLiBob3VzaW5nIEdpdCBhZG1pbmlzdHJhdGl2ZSBqdW5rKS4g
QXMgc3VjaCwgaXQNCj4gZmVlbHMgc29tZXdoYXQgb2RkIGZvciB0aGUgc29ja2V0IGZpbGUgdG8g
YmUgaGlkZGVuOyBJIHdvdWxkIGluc3RlYWQgZXhwZWN0DQo+IHRoZSBzb2NrZXQgbmFtZSB0byBi
ZSBub24taGlkZGVuIChzYXksDQo+ICJnaXQtZnNtb25pdG9yLWRhZW1vbi17aGFzaH0uaXBjIikg
cmF0aGVyIHRoYW4gaGlkZGVuICgiLmdpdC1mc21vbml0b3ItKiIpLg0KPiBUaGUgZGlyZWN0b3J5
IHNwZWNpZmllZCBieSBgZnNtb25pdG9yLnNvY2tldGRpcmAgbWF5IG9yIG1heSBub3QgYmUgaGlk
ZGVuDQo+IChpLmUuIHN0YXJ0IHdpdGggYSBkb3QpLCBidXQgdGhhdCdzIHRoZSB1c2VyJ3MgZGVj
aXNpb24uIEZvciB0aGUgJEhPTUUgY2FzZSwgaXQNCj4gYWxtb3N0IGZlZWxzIGNsZWFuZXIgdG8g
Y3JlYXRlIGEgaGlkZGVuIGRpcmVjdG9yeSAoc2F5LCAiJEhPTUUvLmdpdC0NCj4gZnNtb25pdG9y
IikgaW4gd2hpY2ggdG8gaG91c2UgdGhlIHNvY2tldCBmaWxlcyAoImdpdC1mc21vbml0b3ItZGFl
bW9uLQ0KPiB7aGFzaH0uaXBjIikuIEFueWhvdywgdGhpcyBjb21tZW50IGlzIHF1aXRlIHN1Ympl
Y3RpdmU7IHBlcmhhcHMgbm90DQo+IGFjdGlvbmFibGUuDQoNCj4gV2hhdCBoYXBwZW5zIGlmIGVp
dGhlciAkSE9NRSBvciBgZnNtb25pdG9yLnNvY2tldGRpcmAgYXJlIG5ldHdvcmstDQo+IG1vdW50
ZWQ/IFNob3VsZCB0aGlzIGNvZGUgYmUgY2hlY2tpbmcgZm9yIHRoYXQgY2FzZT8gSWYgdGhleSBh
cmUgbmV0d29yay0NCj4gbW91bnRlZCwgc2hvdWxkIGl0IGVycm9yIG91dD8gQXQgbWluaW11bSwg
SSB3b3VsZCB0aGluayBhIHdhcm5pbmcgaXMNCj4gd2FycmFudGVkIGluIG9yZGVyIHRvIHNhdmUg
dXNlcnMgdGhlIGhlYWRhY2hlIG9mIHdvbmRlcmluZyB3aHkgZnNtb25pdG9yDQo+IGlzbid0IHdv
cmtpbmcgY29ycmVjdGx5Lg0KPiANClVsdGltYXRlbHksIHRoZSBVRFMgZmlsZSBsb2NhdGlvbiBp
cyBjaGVja2VkIGJ5IGNoZWNrX3Vkc192b2x1bWUgaW4gZnNtLXNldHRpbmdzLWRhcndpbiBhcyBw
YXJ0IG9mIHRoZSBvdmVyYWxsIHNldHRpbmdzIGNoZWNrczsgaXQgd2lsbCBlcnJvci1vdXQgdGhl
cmUgaWYgdGhlIHBhdGggaXMgb24gdGhlIG5ldHdvcmsuDQoNCj4gPiArICAgICAgIGlwY19wYXRo
ID0gaW50ZXJwb2xhdGVfcGF0aChpcGNfZmlsZS5idWYsIDEpOw0KPiA+ICsgICAgICAgaWYgKCFp
cGNfcGF0aCkNCj4gPiArICAgICAgICAgICAgICAgZGllKF8oIkludmFsaWQgcGF0aDogJXMiKSwg
aXBjX2ZpbGUuYnVmKTsNCj4gPiArDQo+ID4gKyAgICAgICBzdHJidWZfcmVsZWFzZSgmaXBjX2Zp
bGUpOw0KPiANCj4gYHNvY2tfZGlyYCBpcyBiZWluZyBsZWFrZWQsIGlzbid0IGl0Pw0KPg0KDQpT
dXJlIGlzLCB0aGFua3MuDQoNCg0KPiA+ICsgICAgICAgcmV0dXJuIGlwY19wYXRoOw0KPiA+ICt9
DQo+ID4gZGlmZiAtLWdpdCBhL2NvbXBhdC9mc21vbml0b3IvZnNtLWlwYy13aW4zMi5jDQo+ID4g
Yi9jb21wYXQvZnNtb25pdG9yL2ZzbS1pcGMtd2luMzIuYw0KPiA+IEBAIC0wLDAgKzEsOSBAQA0K
PiA+ICtjb25zdCBjaGFyICpmc21vbml0b3JfaXBjX19nZXRfcGF0aChzdHJ1Y3QgcmVwb3NpdG9y
eSAqcikgew0KPiA+ICsgICAgICAgc3RhdGljIGNoYXIgKnJldDsNCj4gPiArICAgICAgIGlmICgh
cmV0KQ0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBnaXRfcGF0aGR1cCgiZnNtb25pdG9yLS1k
YWVtb24uaXBjIik7DQo+ID4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gXCBObyBu
ZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQo+IA0KPiBNZW50aW9uZWQgYWxyZWFkeS4NCg0K

