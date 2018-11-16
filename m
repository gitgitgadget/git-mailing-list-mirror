Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2F81F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbeKPSLi (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:38 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:52922 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727490AbeKPSLb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:31 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7wIJJ032736;
        Fri, 16 Nov 2018 00:00:00 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ns2ddsqtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 15 Nov 2018 23:59:59 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Thu, 15 Nov 2018 23:59:57 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 15 Nov 2018 23:59:57 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 188482212280;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 00/11] fast export and import fixes and features
Date:   Thu, 15 Nov 2018 23:59:45 -0800
Message-ID: <20181116075956.27047-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g1796373474.dirty
In-Reply-To: <20181114002600.29233-1-newren@gmail.com>
References: <20181114002600.29233-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series of small fixes and features for fast-export and
fast-import, mostly on the fast-export side.

Changes since v2 (full range-diff below):
  * Dropped the final patch; going to try to use Peff's suggestion of
    rev-list and diff-tree to get what I need instead
  * Inserted a new patch at the beginning to convert pre-existing sha1
    stuff to oid (rename sha1_to_hex() -> oid_to_hex(), rename
    anonymize_sha1() to anonymize_oid(), etc.)
  * Modified other patches in the series to add calls to oid_to_hex() rather
    than sha1_to_hex()

Elijah Newren (11):
  fast-export: convert sha1 to oid
  git-fast-import.txt: fix documentation for --quiet option
  git-fast-export.txt: clarify misleading documentation about rev-list
    args
  fast-export: use value from correct enum
  fast-export: avoid dying when filtering by paths and old tags exist
  fast-export: move commit rewriting logic into a function for reuse
  fast-export: when using paths, avoid corrupt stream with non-existent
    mark
  fast-export: ensure we export requested refs
  fast-export: add --reference-excluded-parents option
  fast-import: remove unmaintained duplicate documentation
  fast-export: add a --show-original-ids option to show original names

 Documentation/git-fast-export.txt |  23 +++-
 Documentation/git-fast-import.txt |  23 +++-
 builtin/fast-export.c             | 190 +++++++++++++++++++++---------
 fast-import.c                     | 166 ++------------------------
 t/t9350-fast-export.sh            |  80 ++++++++++++-
 5 files changed, 268 insertions(+), 214 deletions(-)

 -:  ---------- >  1:  4c3370c85f fast-export: convert sha1 to oid
 1:  8870fb1340 =  2:  6ffa30e3c7 git-fast-import.txt: fix documentation for --quiet option
 2:  16d1c3e22d =  3:  1e278f009a git-fast-export.txt: clarify misleading documentation about rev-list args
 3:  e19f6b36f9 =  4:  9d7b2aef49 fast-export: use value from correct enum
 4:  2b305561d5 !  5:  b65a591d4d fast-export: avoid dying when filtering by paths and old tags exist
    @@ -29,7 +29,7 @@
     -					     oid_to_hex(&tag->object.oid));
     +				if (!p->parents) {
     +					printf("reset %s\nfrom %s\n\n",
    -+					       name, sha1_to_hex(null_sha1));
    ++					       name, oid_to_hex(&null_oid));
     +					free(buf);
     +					return;
     +				}
 5:  607b1dc2b2 !  6:  dde52c9cb6 fast-export: move commit rewriting logic into a function for reuse
    @@ -47,7 +47,7 @@
     -					break;
     -				if (!p->parents) {
     -					printf("reset %s\nfrom %s\n\n",
    --					       name, sha1_to_hex(null_sha1));
    +-					       name, oid_to_hex(&null_oid));
     -					free(buf);
     -					return;
     -				}
    @@ -55,7 +55,7 @@
     +			p = rewrite_commit((struct commit *)tagged);
     +			if (!p) {
     +				printf("reset %s\nfrom %s\n\n",
    -+				       name, sha1_to_hex(null_sha1));
    ++				       name, oid_to_hex(&null_oid));
     +				free(buf);
     +				return;
      			}
 6:  ec1862e858 !  7:  d9b2e326f0 fast-export: when using paths, avoid corrupt stream with non-existent mark
    @@ -35,7 +35,7 @@
     +				 * it.
     +				 */
     +				printf("reset %s\nfrom %s\n\n",
    -+				       name, sha1_to_hex(null_sha1));
    ++				       name, oid_to_hex(&null_oid));
     +				continue;
     +			}
      			printf("reset %s\nfrom :%d\n\n", name,
 7:  9da26e3ccb !  8:  9ddb155a70 fast-export: ensure we export requested refs
    @@ -97,7 +97,7 @@
      		case OBJ_TAG:
      			handle_tag(name, (struct tag *)object);
     @@
    - 				       name, sha1_to_hex(null_sha1));
    + 				       name, oid_to_hex(&null_oid));
      				continue;
      			}
     -			printf("reset %s\nfrom :%d\n\n", name,
    @@ -114,7 +114,7 @@
     +				 * like a ref deletion to me.
     +				 */
     +				printf("reset %s\nfrom %s\n\n",
    -+				       name, sha1_to_hex(null_sha1));
    ++				       name, oid_to_hex(&null_oid));
     +				continue;
     +			}
     +
 8:  7e5fe2f02e !  9:  595d2e5d30 fast-export: add --reference-excluded-parents option
    @@ -117,9 +117,9 @@
     +			printf(":%d\n", mark);
      		else
     -			printf("merge :%d\n", mark);
    -+			printf("%s\n", sha1_to_hex(anonymize ?
    -+						   anonymize_sha1(&obj->oid) :
    -+						   obj->oid.hash));
    ++			printf("%s\n", oid_to_hex(anonymize ?
    ++						  anonymize_oid(&obj->oid) :
    ++						  &obj->oid));
      		i++;
      	}
      
    @@ -138,16 +138,16 @@
     +				 * just means deletion of the ref.
      				 */
     -				printf("reset %s\nfrom %s\n\n",
    --				       name, sha1_to_hex(null_sha1));
    +-				       name, oid_to_hex(&null_oid));
     +				if (!reference_excluded_commits) {
     +					/* delete the ref */
     +					printf("reset %s\nfrom %s\n\n",
    -+					       name, sha1_to_hex(null_sha1));
    ++					       name, oid_to_hex(&null_oid));
     +					continue;
     +				}
     +				/* set ref to commit using oid, not mark */
     +				printf("reset %s\nfrom %s\n\n", name,
    -+				       sha1_to_hex(commit->object.oid.hash));
    ++				       oid_to_hex(&commit->object.oid));
      				continue;
      			}
      
    @@ -156,7 +156,7 @@
      			     N_("Apply refspec to exported refs")),
      		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
     +		OPT_BOOL(0, "reference-excluded-parents",
    -+			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by sha1sum")),
    ++			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
     +
      		OPT_END()
      	};
 9:  14306a8436 = 10:  2686246a89 fast-import: remove unmaintained duplicate documentation
10:  72487a61e4 ! 11:  b78d548e7d fast-export: add a --show-original-ids option to show original names
    @@ -141,9 +141,9 @@
     @@
      		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
      		OPT_BOOL(0, "reference-excluded-parents",
    - 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by sha1sum")),
    + 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
     +		OPT_BOOL(0, "show-original-ids", &show_original_ids,
    -+			    N_("Show original sha1sums of blobs/commits")),
    ++			    N_("Show original object ids of blobs/commits")),
      
      		OPT_END()
      	};

-- 
2.19.1.1063.g1796373474.dirty
