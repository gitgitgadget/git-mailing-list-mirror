Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C981F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGMQGg (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 12:06:36 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35342 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729681AbeGMQGg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 12:06:36 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DFn4lD029375;
        Fri, 13 Jul 2018 08:51:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2k2uchjy19-1;
        Fri, 13 Jul 2018 08:51:12 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B512122E02C9;
        Fri, 13 Jul 2018 08:51:12 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id A7D1E2CDE6A;
        Fri, 13 Jul 2018 08:51:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/2] Fix use of strategy options with interactive rebases
Date:   Fri, 13 Jul 2018 08:51:10 -0700
Message-Id: <20180713155110.21627-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.645.g72fe132ec2
In-Reply-To: <nycvar.QRO.7.76.6.1807121740270.75@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1807121740270.75@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130136
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jul 12, 2018 at 8:41 AM, Johannes Schindelin <Johannes.Schindelin=
@gmx.de> wrote:
> Hi Elijah,
>
> On Wed, 27 Jun 2018, Elijah Newren wrote:
>
...
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 19bdebb480..f3b10c7f62 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -328,7 +328,7 @@ do
>>               do_merge=3Dt
>>               ;;
>>       --strategy-option=3D*)
>> -             strategy_opts=3D"$strategy_opts $(git rev-parse --sq-quo=
te "--${1#--strategy-option=3D}")"
>> +             strategy_opts=3D"$strategy_opts $(git rev-parse --sq-quo=
te "--${1#--strategy-option=3D}" | sed -e s/^.//)"
>
> Didn't you mean to use "s/^ *//" instead?
>
>>               do_merge=3Dt
>>               test -z "$strategy" && strategy=3Drecursive
>>               ;;
>> diff --git a/sequencer.c b/sequencer.c
>> index 5354d4d51e..ef9237c814 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2206,6 +2206,7 @@ static int populate_opts_cb(const char *key, con=
st char *value, void *data)
>>  static void read_strategy_opts(struct replay_opts *opts, struct strbu=
f *buf)
>>  {
>>       int i;
>> +     char *strategy_opts_string;
>>
>>       strbuf_reset(buf);
>>       if (!read_oneliner(buf, rebase_path_strategy(), 0))
>> @@ -2214,7 +2215,11 @@ static void read_strategy_opts(struct replay_op=
ts *opts, struct strbuf *buf)
>>       if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
>>               return;
>>
>> -     opts->xopts_nr =3D split_cmdline(buf->buf, (const char ***)&opts=
->xopts);
>> +     strategy_opts_string =3D buf->buf;
>> +     if (*strategy_opts_string =3D=3D ' ')
>
> I think that this would ideally even be a `while` instead of an `if`.

Thanks for taking a look; both sound like good suggestions.  Since the
patch in question has already reached next, here's a patch on top of
en/rebase-i-microfixes to make these two changes:

-- 8< --
Subject: [PATCH] Whitespace handling improvements with interactive rebase
 strategy options

In commit 0060041df ("Fix use of strategy options with interactive
rebases", 2018-06-27), extra whitespace was removed from a generated
string to fix up parsing.  Instead of assuming one extra space, though, w=
e
can just remove all leading whitespace and make the code slightly more
robust.

Suggested-by: Johanness Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase.sh | 2 +-
 sequencer.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index f3b10c7f62..e572980bbc 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -328,7 +328,7 @@ do
 		do_merge=3Dt
 		;;
 	--strategy-option=3D*)
-		strategy_opts=3D"$strategy_opts $(git rev-parse --sq-quote "--${1#--st=
rategy-option=3D}" | sed -e s/^.//)"
+		strategy_opts=3D"$strategy_opts $(git rev-parse --sq-quote "--${1#--st=
rategy-option=3D}" | sed -e "s/ *//")"
 		do_merge=3Dt
 		test -z "$strategy" && strategy=3Drecursive
 		;;
diff --git a/sequencer.c b/sequencer.c
index ef9237c814..3f780f8f50 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2216,7 +2216,7 @@ static void read_strategy_opts(struct replay_opts *=
opts, struct strbuf *buf)
 		return;
=20
 	strategy_opts_string =3D buf->buf;
-	if (*strategy_opts_string =3D=3D ' ')
+	while (*strategy_opts_string =3D=3D ' ')
 		strategy_opts_string++;
 	opts->xopts_nr =3D split_cmdline(strategy_opts_string,
 				       (const char ***)&opts->xopts);
--=20
2.18.0.645.g72fe132ec2

