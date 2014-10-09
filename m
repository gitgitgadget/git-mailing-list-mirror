From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Thu, 09 Oct 2014 22:06:13 +0200
Message-ID: <5436EAB5.2070809@web.de>
References: <5430427A.5080800@web.de> <xmqqd2a3g2mf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcK0K-0007xx-8H
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 22:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619AbaJIUHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 16:07:50 -0400
Received: from mout.web.de ([212.227.17.12]:62714 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbaJIUHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 16:07:48 -0400
Received: from [192.168.178.27] ([79.253.137.147]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LuLt5-1YIhmi3exL-011gB8; Thu, 09 Oct 2014 22:07:44
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqd2a3g2mf.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:+48n0565bGzmeNgZ+h4tHs6wfOCAk24ww/+XWHLhgMJFMEgNen6
 a3bTxZHrdXb2FjwKy+lEHm+EW32xk7D6zGmD640qyaXz1bBulpK+Gbc6Mavjz3cS68HWIiE
 yziiLRJ9B25qYXzd1kIoJM9DIUOA0KEYZHl0kQBQyG7JfHN9Ng489FeF2h/RAGn4BTPmZKc
 O/HGKfgGwd+XsrkBXsthg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.2014 um 20:23 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> @@ -335,20 +337,18 @@ static int append_ref(const char *refname, con=
st unsigned char *sha1, int flags,
>>   	static struct {
>>   		int kind;
>>   		const char *prefix;
>> -		int pfxlen;
>>   	} ref_kind[] =3D {
>> -		{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
>> -		{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
>> +		{ REF_LOCAL_BRANCH, "refs/heads/" },
>> +		{ REF_REMOTE_BRANCH, "refs/remotes/" },
>>   	};
>>  =20
>>   	/* Detect kind */
>>   	for (i =3D 0; i < ARRAY_SIZE(ref_kind); i++) {
>>   		prefix =3D ref_kind[i].prefix;
>> -		if (strncmp(refname, prefix, ref_kind[i].pfxlen))
>> -			continue;
>> -		kind =3D ref_kind[i].kind;
>> -		refname +=3D ref_kind[i].pfxlen;
>> -		break;
>> +		if (skip_prefix(refname, prefix, &refname)) {
>> +			kind =3D ref_kind[i].kind;
>> +			break;
>> +		}
>=20
> This certainly makes it easier to read.
>=20
> I suspect that the original was done as a (possibly premature)
> optimization to avoid having to do strlen(3) on a variable that
> points at constant strings for each and every ref we iterate with
> for_each_rawref(), and it is somewhat sad to see it lost because
> skip_prefix() assumes that the caller never knows the length of the
> prefix, though.

I didn't think much about the performance implications.  skip_prefix()
doesn't call strlen(3), though.  Your reply made me curious.  The
synthetic test program below can be used to call the old and the new
code numerous times.  I called it like this:

    for a in strncmp skip_prefix
    do
        for b in refs/heads/x refs/remotes/y refs/of/the/third/kind
        do
            time ./test-prefix $a $b
        done
    done

And got the following results:

100000000x strncmp for refs/heads/x, which is a local branch

real    0m2.423s
user    0m2.420s
sys     0m0.000s
100000000x strncmp for refs/remotes/y, which is a remote branch

real    0m4.331s
user    0m4.328s
sys     0m0.000s
100000000x strncmp for refs/of/the/third/kind, which is no branch

real    0m3.878s
user    0m3.872s
sys     0m0.000s
100000000x skip_prefix for refs/heads/x, which is a local branch

real    0m0.891s
user    0m0.888s
sys     0m0.000s
100000000x skip_prefix for refs/remotes/y, which is a remote branch

real    0m1.345s
user    0m1.340s
sys     0m0.000s
100000000x skip_prefix for refs/of/the/third/kind, which is no branch

real    0m1.080s
user    0m1.076s
sys     0m0.000s


The code handles millions of ref strings per second before and after
the change, and with the change it's faster.  I hope the results are
reproducible and make it easier to say goodbye to pfxlen. :)

Ren=C3=A9

---
 .gitignore    |  1 +
 Makefile      |  1 +
 test-prefix.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 test-prefix.c

diff --git a/.gitignore b/.gitignore
index 5bfb234..8416c5e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -193,6 +193,7 @@
 /test-mktemp
 /test-parse-options
 /test-path-utils
+/test-prefix
 /test-prio-queue
 /test-read-cache
 /test-regex
diff --git a/Makefile b/Makefile
index f34a2d4..c09b59e 100644
--- a/Makefile
+++ b/Makefile
@@ -561,6 +561,7 @@ TEST_PROGRAMS_NEED_X +=3D test-mergesort
 TEST_PROGRAMS_NEED_X +=3D test-mktemp
 TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
+TEST_PROGRAMS_NEED_X +=3D test-prefix
 TEST_PROGRAMS_NEED_X +=3D test-prio-queue
 TEST_PROGRAMS_NEED_X +=3D test-read-cache
 TEST_PROGRAMS_NEED_X +=3D test-regex
diff --git a/test-prefix.c b/test-prefix.c
new file mode 100644
index 0000000..ddc63af
--- /dev/null
+++ b/test-prefix.c
@@ -0,0 +1,87 @@
+#include "cache.h"
+
+#define ROUNDS 100000000
+
+#define REF_LOCAL_BRANCH    0x01
+#define REF_REMOTE_BRANCH   0x02
+
+static int test_skip_prefix(const char *refname)
+{
+	int kind, i;
+	const char *prefix;
+	static struct {
+		int kind;
+		const char *prefix;
+	} ref_kind[] =3D {
+		{ REF_LOCAL_BRANCH, "refs/heads/" },
+		{ REF_REMOTE_BRANCH, "refs/remotes/" },
+	};
+
+	for (i =3D 0; i < ARRAY_SIZE(ref_kind); i++) {
+		prefix =3D ref_kind[i].prefix;
+		if (skip_prefix(refname, prefix, &refname)) {
+			kind =3D ref_kind[i].kind;
+			break;
+		}
+	}
+	if (ARRAY_SIZE(ref_kind) <=3D i)
+		return 0;
+	return kind;
+}
+
+static int test_strncmp(const char *refname)
+{
+	int kind, i;
+	const char *prefix;
+	static struct {
+		int kind;
+		const char *prefix;
+		int pfxlen;
+	} ref_kind[] =3D {
+		{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
+		{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
+	};
+
+	for (i =3D 0; i < ARRAY_SIZE(ref_kind); i++) {
+		prefix =3D ref_kind[i].prefix;
+		if (strncmp(refname, prefix, ref_kind[i].pfxlen))
+			continue;
+		kind =3D ref_kind[i].kind;
+		refname +=3D ref_kind[i].pfxlen;
+		break;
+	}
+	if (ARRAY_SIZE(ref_kind) <=3D i)
+		return 0;
+	return kind;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc =3D=3D 3) {
+		int (*fn)(const char *) =3D NULL;
+		printf("%dx %s for %s, which is ", ROUNDS, argv[1], argv[2]);
+		if (!strcmp(argv[1], "skip_prefix"))
+			fn =3D test_skip_prefix;
+		if (!strcmp(argv[1], "strncmp"))
+			fn =3D test_strncmp;
+		if (fn) {
+			int i, kind =3D 0;
+			for (i =3D 0; i < ROUNDS; i++)
+				kind |=3D fn(argv[2]);
+			switch (kind) {
+			case 0:
+				puts("no branch");
+				break;
+			case REF_LOCAL_BRANCH:
+				puts("a local branch");
+				break;
+			case REF_REMOTE_BRANCH:
+				puts("a remote branch");
+				break;
+			default:
+				puts("invalid");
+			}
+		}
+	}
+	return 0;
+}
--=20
2.1.2
