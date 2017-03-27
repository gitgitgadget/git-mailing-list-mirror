Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51CD1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 23:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbdC0Xyr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 19:54:47 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:15338
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752780AbdC0Xyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 19:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PR1nS/6VHll1XPY/TBENapnUABokzoGcS9fHeIqnKEE=;
 b=dHpq8mn6LdA/eFrf2ETkGqDjyLfweJdafcXCZ1DxT85zqZiNb4j+3z5dv8+u44y5P2m+RhBuS1sgzJmZTRJjOfNAkK1UQGbZheKuHGUhuX9NCkKfPkXNr751RtzzWKcRaqNhT6y15VpCDBOQjqOGUU4Vt4wpz5i1OokQue4e8qk=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB324.namprd03.prod.outlook.com (10.141.68.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Mon, 27 Mar 2017 23:54:36 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.020; Mon, 27 Mar 2017 23:54:37 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] sub-process: refactor the filter process code into
 a reusable module
Thread-Topic: [PATCH v2 2/2] sub-process: refactor the filter process code
 into a reusable module
Thread-Index: AQHSpLMw60zJ+eylxEGVOM4/5wrlLaGpDyaAgABBFpA=
Date:   Mon, 27 Mar 2017 23:54:36 +0000
Message-ID: <BL2PR03MB3232F7FE70707532B5FB178F4330@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-4-benpeart@microsoft.com>
 <c8f85b4a-e69e-76ab-9a8d-66857968fb4d@google.com>
In-Reply-To: <c8f85b4a-e69e-76ab-9a8d-66857968fb4d@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB324;7:xa7peDgA7+TCdlTUj1vLWuG272v6Rj86/+vhnsOqzWqCYfL/CFRTlRIUoPN55Y35aaTI51If58dharKo8wyr3HbLf+iDQwqp08KvNV7P48sZuF7KWdFho9q0dqrd889yYDuZlBez6bXIndIUFnldHW7SPeY/cq0i5IaqdxDpknfS8Y62OlW2YhF8n4DIfeC//cOeiiVNWgpapLe+52xcgvgxOJJvmQBNwc7z1TM/dx1evHbqCT6fGFfY7/E6NbAqNW2k57g+Tc8ZntAnVpa5zL+hC4pd+gPxJp19Jj1aaGlM8MFB6z1xE7O5SgQ/3zUD3SG4OT7ys+LEnTkyjTmeQO1XwMaSvoXU7g0dZXAPu6Y=
x-ms-office365-filtering-correlation-id: 4ba8a9c3-9e03-4af0-f965-08d4756ca02d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423052)(201703031133058)(201702281549052);SRVR:BL2PR03MB324;
x-microsoft-antispam-prvs: <BL2PR03MB324D761842E16E95808137CF4330@BL2PR03MB324.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040427)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(201703131423052)(201703011903052)(201702281528052)(201703061421052)(20161123558025)(20161123564025)(20161123560025)(20161123555025)(20161123562025)(6072148);SRVR:BL2PR03MB324;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB324;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39400400002)(39450400003)(39410400002)(39840400002)(39860400002)(39850400002)(51914003)(24454002)(13464003)(377454003)(66066001)(229853002)(33656002)(8990500004)(10290500002)(7696004)(5005710100001)(2501003)(2950100002)(6246003)(102836003)(189998001)(5660300001)(81156014)(38730400002)(8936002)(3846002)(81166006)(10090500001)(6116002)(39060400002)(53936002)(305945005)(7736002)(77096006)(6506006)(8676002)(76176999)(86612001)(25786009)(50986999)(54356999)(6436002)(53546009)(86362001)(2906002)(3660700001)(9686003)(2900100001)(55016002)(74316002)(122556002)(3280700002)(99286003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB324;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2017 23:54:36.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB324
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Jonathan Tan [mailto:jonathantanmy@google.com]
> Sent: Monday, March 27, 2017 3:00 PM
> To: Ben Peart <peartben@gmail.com>; git@vger.kernel.org
> Cc: Ben Peart <Ben.Peart@microsoft.com>
> Subject: Re: [PATCH v2 2/2] sub-process: refactor the filter process code=
 into
> a reusable module
>=20
> On 03/24/2017 08:27 AM, Ben Peart wrote:
> > Refactor the filter.<driver>.process code into a separate sub-process
> > module that can be used to reduce the cost of starting up a
> > sub-process for multiple commands.  It does this by keeping the
> > external process running and processing all commands by communicating
> > over standard input and standard output using the packet format (pkt-li=
ne)
> based protocol.
> > Full documentation is in Documentation/technical/api-sub-process.txt.
>=20
> Thanks - this looks like something useful to have.

Thanks for the review and feedback.

>=20
> When you create a "struct subprocess_entry" to be entered into the system=
,
> it is not a true "struct subprocess_entry" - it is a "struct subprocess_e=
ntry"
> plus some extra variables at the end. Since the sub-process hashmap is
> keyed solely on the command, what happens if another component uses the
> same trick (but with different extra
> variables) when using a sub-process with the same command?

Having the command be the unique key is sufficient because it gets executed=
 as a process by run_command and there can't be multiple different processe=
s by the same name.=20

>=20
> I can think of at least two ways to solve this: (i) each component can ha=
ve its
> own sub-process hashmap, or (ii) add a component key to the hashmap. (i)
> seems more elegant to me, but I'm not sure what the code will look like.
>=20
> Also, I saw some minor code improvements possible (e.g. using "starts_wit=
h"
> when you're checking for the "status=3D<foo>" line) but I'll comment on t=
hose
> and look into the code more thoroughly once the questions in this e-mail =
are
> resolved.
>=20
> > diff --git a/sub-process.h b/sub-process.h new file mode 100644 index
> > 0000000000..d1492f476d
> > --- /dev/null
> > +++ b/sub-process.h
> > @@ -0,0 +1,46 @@
> > +#ifndef SUBPROCESS_H
> > +#define SUBPROCESS_H
> > +
> > +#include "git-compat-util.h"
> > +#include "hashmap.h"
> > +#include "run-command.h"
> > +
> > +/*
> > + * Generic implementation of background process infrastructure.
> > + * See Documentation/technical/api-background-process.txt.
> > + */
> > +
> > + /* data structures */
> > +
> > +struct subprocess_entry {
> > +	struct hashmap_entry ent; /* must be the first member! */
> > +	struct child_process process;
> > +	const char *cmd;
> > +};
>=20
> I notice from the documentation (and from "subprocess_get_child_process"
> below) that this is meant to be opaque, but I think this can be non-opaqu=
e
> (like "run-command").
>=20
> Also, I would prefer adding a "util" pointer here instead of using it as =
an
> embedded struct. There is no clue here that it is embeddable or meant to =
be
> embedded.
>=20

The structure is intentionally opaque to provide the benefits of encapsulat=
ion.  Obviously, the "C" language doesn't provide any enforcement of that d=
esign principal but we do what we can. =20

The embedded struct is following the same design pattern as elsewhere in gi=
t (hashmap for example) simply for consistency.

> > +
> > +/* subprocess functions */
> > +
> > +typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
> > +int subprocess_start(struct subprocess_entry *entry, const char *cmd,
> > +		subprocess_start_fn startfn);
>=20
> I'm not sure if it is useful to take a callback here - I think the caller=
 of this
> function can just run whatever it wants after a successful subprocess_sta=
rt.

The purpose of doing the subprocess specific initialization via a callback =
is so that if it encounters an error (for example, it can't negotiate a com=
mon interface version) the subprocess_start function can detect that and en=
sure the hashmap does not contain the invalid/unusable subprocess.=20

>=20
> Alternatively, if you add the "util" pointer (as I described above), then=
 it
> makes sense to add a subprocess_get_or_start() function (and now it makes
> sense to take the callback). This way, the data structure will own, creat=
e, and
> destroy all the "struct subprocess_entry" that it needs, creating a nice
> separation of concerns.
>=20
> > +
> > +void subprocess_stop(struct subprocess_entry *entry);
>=20
> (continued from above) And it would be clear that this would free
> "entry", for example.
>=20
> > +
> > +struct subprocess_entry *subprocess_find_entry(const char *cmd);
> > +
> > +/* subprocess helper functions */
> > +
> > +static inline struct child_process *subprocess_get_child_process(
> > +		struct subprocess_entry *entry)
> > +{
> > +	return &entry->process;
> > +}
> > +
> > +/*
> > + * Helper function that will read packets looking for "status=3D<foo>"
> > + * key/value pairs and return the value from the last "status" packet
> > + */
> > +
> > +int subprocess_read_status(int fd, struct strbuf *status);
> > +
> > +#endif
> >
