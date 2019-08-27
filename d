Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3981F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 00:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH0AE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 20:04:58 -0400
Received: from pv50p00im-ztdg10012101.me.com ([17.58.6.49]:56518 "EHLO
        pv50p00im-ztdg10012101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbfH0AE6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 20:04:58 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 20:04:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1566863753;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Content-Type:From:Date:Subject:Message-Id:To;
        b=NQdrDa1GfYxYWmxSljS6hervh8icWvQPJeFSr+IkKRKM2h7jzvdW0PIKGrejQBDE6
         0DO95/hVZjkNLinsGBucn+XCakfrfzWkyWDlfW9+fMWaERdJUVQ9M/kHjq7UEejNMd
         wsakrAbQqQoJovKViaQfpmRx/CsPGM7KxXjx+jNl7eT/l8TEq/QuN0DoFgp55J9qQq
         LaM+eDx+ZNE9q8POgQokvcVL+xVnxFGytNUV9tdkXu/usLdYPwXNwvTlh8Z0yuPSBj
         jx4i8tgbTGtn8u0asu1A4rNJdn6e0vTfAriUuu70PggZhMCMi3TSbSbwLNkdsnhzA/
         eXSGQtm3mfC5A==
Received: from [192.168.100.244] (unknown [77.31.212.46])
        by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id CF0CD8405FE
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 23:55:52 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   ". ." <w_sm2019@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 27 Aug 2019 02:55:48 +0300
Subject: M
Message-Id: <D2ED1EA0-D60F-4342-90C9-E6D993B1A10C@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16F203)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=241 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1908260223
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


