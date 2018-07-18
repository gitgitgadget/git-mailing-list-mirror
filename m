Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730011F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeGRVY4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:24:56 -0400
Received: from mail-sn1nam01on0112.outbound.protection.outlook.com ([104.47.32.112]:23886
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730096AbeGRVY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IVZ/RjedFPtCVTRyBfyfkxyl4AentR7A8GR7smy7gE=;
 b=TN4XEnsdc6bBi26jlg4RfTDMcyWB8WtcNlyIZc30jZoGU6i4O59tl3FLkKTtxnUvgu3053DlIKLqifOWCeLSec+uj/c8F/y3Jfyx/swS+32tBhQJnEXL/DrVv49DvXXIA+FHwb8hZgLIBJWsDKwIE3u96xTP3hKHHgbv6woH+XM=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0966.namprd21.prod.outlook.com (52.132.133.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Wed, 18 Jul 2018 20:45:15 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::65fa:bfcd:22b6:7861]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::65fa:bfcd:22b6:7861%4]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 20:45:15 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 1/3] add unbounded Multi-Producer-Multi-Consumer queue
Thread-Topic: [PATCH v1 1/3] add unbounded Multi-Producer-Multi-Consumer queue
Thread-Index: AQHUHtg78yHvKfLviEe5EFh6eAGjDg==
Date:   Wed, 18 Jul 2018 20:45:15 +0000
Message-ID: <20180718204458.20936-2-benpeart@microsoft.com>
References: <20180718204458.20936-1-benpeart@microsoft.com>
In-Reply-To: <20180718204458.20936-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: DM5PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:3:12b::18) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;6:Dj0DKCMHOVIu605TZOgkc6zCTpUJNs/gs/UfSFOUHVKGHxCeOCe98jaRLQ7vPwSEXhK5CKAg0Ti3gNyRBFVaFH9IEY8GoKi9BpDRZ7pH//gdKzx7DnJGOca0mEy4xit3hRTjuwpOvm6m30iNFSoxUoVKT3+Usgb5/QU0ywJUCLaUI46/FJX7sI2QFI60uDDEXA3U/ibiatJ2GG91IHfRcOLZItsd5uQgN7kVhrcBIbvjdJvltcRAgTxwTHA2LeoqT1TPvPX1oBPeUj6Tkh7lvJtQD9Vo7/CmUgumqDOejdUXNmZB6+zsPQzaQ2Q0oJHlxCqFM8ndorxgDVa1pt/1npjyyxmpax3YWWhawo1qTqxnUI5F+7Hsjl+3pJlCCTfd21JRiYSL6ssrlPqO9QNB3tVDBPOaKAqiFUhFyFASem9QPJyfbk3PJE552cJfAfzHZiSPXgFtowgdk1nXCdxONQ==;5:L5s4IhcbEs5aRBV11L6YXIeneUR/a4S3oKefjAAD5w31lO7RUTogIwyVNQj3GTKkBsFSJLxD5ZJz/8pZFLIaS+mjwsfNeGm+wTeEoKfiRTDh8BYKmYw/RiIj9O3NO4sL73YvMhYqwkh2f2PmCRU2EwMFtef2c7LSaHRKHrVgZh4=;7:xEd7An1Lu8EOFjpyh3yb1Hl49qnOCs3KETmONteMwnrL+cX8Xui+EPtKy2PyJMg64AY1Uqm8i0PMLJhtv40dgoFmy8Gz254Drl67zlZsp/aqfHAaS4KHVpw7s22wg5wbXqaJgMeXoExYN5t0zFunpp9fDfCWxJIMefT5kbPT20/oP588isgDy2ITbpF+ZrtfDb3S53975/BiP/HtKoTsBuO49twwL8nnPiAVh7UK8D9fuHd3M3HafDiDXuk+RBrZ
x-ms-office365-filtering-correlation-id: 310b5df0-7c1e-4143-53f2-08d5ecef5d6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0966CCD3B032663551A89138F4530@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(2351001)(5640700003)(105586002)(4326008)(6436002)(22452003)(106356001)(52116002)(5250100002)(76176011)(8936002)(1730700003)(8676002)(81166006)(81156014)(6486002)(478600001)(10290500003)(2616005)(72206003)(73180200002)(476003)(446003)(11346002)(486006)(66066001)(256004)(107886003)(14444005)(6512007)(53936002)(86612001)(99286004)(305945005)(186003)(36756003)(2900100001)(14454004)(25786009)(7736002)(10090500001)(50226002)(1076002)(2501003)(2906002)(68736007)(97736004)(316002)(3846002)(6116002)(54906003)(5660300001)(6916009)(102836004)(26005)(386003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gnAxWamgW+7hPS9GfRXSRd9dzNYh1BlOy0EFtFGEH3j3pJAThEgAmlcnUohv2cw7UMH/x4WXRBRzdHD01eUmzYoobg+0IhgkcX9+ya+JDMT/F6iV/LQAnmFM2WbeVG0CS+rcCxZ8C7800qvt3Bh6wy0er2H9ChQpZZPVomvqpmRv2halyU/QjQShwApt/+3o0/vnpz7RRtywqAoO/PYvV1v1hdIPi6p+SgVY9GxBqiArHMU8XaUhI70L3mPJvatitd81gmCWKsEzTjwQXr5JxR9ao3kYGbGWov+SqQ3T7+U99BwSFLo9Y9W7I5Ur4ZpgaSGAQ8MZb5RZh3YYyXncol1GfKHjiT6iPHYNYp+sR/0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b5df0-7c1e-4143-53f2-08d5ecef5d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 20:45:15.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Makefile    |  1 +
 mpmcqueue.c | 49 ++++++++++++++++++++++++++++++++
 mpmcqueue.h | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 mpmcqueue.c
 create mode 100644 mpmcqueue.h

diff --git a/Makefile b/Makefile
index 0cb6590f24..fdaabf0252 100644
--- a/Makefile
+++ b/Makefile
@@ -890,6 +890,7 @@ LIB_OBJS +=3D merge.o
 LIB_OBJS +=3D merge-blobs.o
 LIB_OBJS +=3D merge-recursive.o
 LIB_OBJS +=3D mergesort.o
+LIB_OBJS +=3D mpmcqueue.o
 LIB_OBJS +=3D name-hash.o
 LIB_OBJS +=3D notes.o
 LIB_OBJS +=3D notes-cache.o
diff --git a/mpmcqueue.c b/mpmcqueue.c
new file mode 100644
index 0000000000..22411af1b0
--- /dev/null
+++ b/mpmcqueue.c
@@ -0,0 +1,49 @@
+#include "mpmcqueue.h"
+
+void mpmcq_init(struct mpmcq *queue)
+{
+	queue->head =3D NULL;
+	queue->cancel =3D 0;
+	pthread_mutex_init(&queue->mutex, NULL);
+	pthread_cond_init(&queue->condition, NULL);
+}
+
+void mpmcq_destroy(struct mpmcq *queue)
+{
+	pthread_mutex_destroy(&queue->mutex);
+	pthread_cond_destroy(&queue->condition);
+}
+
+void mpmcq_push(struct mpmcq *queue, struct mpmcq_entry *entry)
+{
+	pthread_mutex_lock(&queue->mutex);
+	entry->next =3D queue->head;
+	queue->head =3D entry;
+	pthread_cond_signal(&queue->condition);
+	pthread_mutex_unlock(&queue->mutex);
+}
+
+struct mpmcq_entry *mpmcq_pop(struct mpmcq *queue)
+{
+	struct mpmcq_entry *entry =3D NULL;
+
+	pthread_mutex_lock(&queue->mutex);
+	while (!queue->head && !queue->cancel)
+		pthread_cond_wait(&queue->condition, &queue->mutex);
+	if (!queue->cancel) {
+		entry =3D queue->head;
+		queue->head =3D entry->next;
+	}
+	pthread_mutex_unlock(&queue->mutex);
+	return entry;
+}
+
+void mpmcq_cancel(struct mpmcq *queue)
+{
+	struct mpmcq_entry *entry;
+
+	pthread_mutex_lock(&queue->mutex);
+	queue->cancel =3D 1;
+	pthread_cond_broadcast(&queue->condition);
+	pthread_mutex_unlock(&queue->mutex);
+}
diff --git a/mpmcqueue.h b/mpmcqueue.h
new file mode 100644
index 0000000000..7421e06aad
--- /dev/null
+++ b/mpmcqueue.h
@@ -0,0 +1,80 @@
+#ifndef MPMCQUEUE_H
+#define MPMCQUEUE_H
+
+#include "git-compat-util.h"
+#include <pthread.h>
+
+/*
+ * Generic implementation of an unbounded Multi-Producer-Multi-Consumer
+ * queue.
+ */
+
+/*
+ * struct mpmcq_entry is an opaque structure representing an entry in the
+ * queue.
+ */
+struct mpmcq_entry {
+	struct mpmcq_entry *next;
+};
+
+/*
+ * struct mpmcq is the concurrent queue structure. Members should not be
+ * modified directly.
+ */
+struct mpmcq {
+	struct mpmcq_entry *head;
+	pthread_mutex_t mutex;
+	pthread_cond_t condition;
+	int cancel;
+};
+
+/*
+ * Initializes a mpmcq_entry structure.
+ *
+ * `entry` points to the entry to initialize.
+ *
+ * The mpmcq_entry structure does not hold references to external resource=
s,
+ * and it is safe to just discard it once you are done with it (i.e. if
+ * your structure was allocated with xmalloc(), you can just free() it,
+ * and if it is on stack, you can just let it go out of scope).
+ */
+static inline void mpmcq_entry_init(struct mpmcq_entry *entry)
+{
+	entry->next =3D NULL;
+}
+
+/*
+ * Initializes a mpmcq structure.
+ */
+extern void mpmcq_init(struct mpmcq *queue);
+
+/*
+ * Destroys a mpmcq structure.
+ */
+extern void mpmcq_destroy(struct mpmcq *queue);
+
+/*
+ * Pushes an entry on to the queue.
+ *
+ * `queue` is the mpmcq structure.
+ * `entry` is the entry to push.
+ */
+extern void mpmcq_push(struct mpmcq *queue, struct mpmcq_entry *entry);
+
+/*
+ * Pops an entry off the queue.
+ *
+ * `queue` is the mpmcq structure.
+ *
+ * Returns mpmcq_entry on success, NULL on cancel;
+ */
+extern struct mpmcq_entry *mpmcq_pop(struct mpmcq *queue);
+
+/*
+ * Cancels any pending pop requests.
+ *
+ * `queue` is the mpmcq structure.
+ */
+extern void mpmcq_cancel(struct mpmcq *queue);
+
+#endif
--=20
2.17.0.gvfs.1.123.g449c066

