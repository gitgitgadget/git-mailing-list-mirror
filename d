Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,TVD_SPACE_RATIO shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D93B1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 20:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbcICUdd (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 16:33:33 -0400
Received: from nm37-vm9.bullet.mail.gq1.yahoo.com ([98.136.217.45]:60457 "EHLO
        nm37-vm9.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753791AbcICUdb (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Sep 2016 16:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=s2048; t=1472934007; bh=lv1iBStmNGICaf+PSQlTyVDY16s+t/TW1/iYUYUvBnU=; h=Date:From:To:Subject:References:From:Subject; b=BJpulm+5PMG1uF2jHQYv1pfrNktwLOO2Eu+gNzrALSAamcIq3zdLJcZOIRQ2Gr/+5mYjWnzKmuO5BadJiDjS45p3W8b5NRm+wGwTHAcnrlIlEQ/HLYMCosjWLRvCaS3/KSBHI92NqtAMdKSR3nnPVTxW6EkJ5t336OB7f5XiMX9eQiK+y6Pkh8UR762XeavuLeyr5OhoF8/fMYsjQIIYnlcKhvFgkVrTu1rgd13IRWW8PUAspYSCorRtQKB7COwfYByb0lozvQ4b2C0cwz9gO+XFjPrjV7n/IgwG16KdbXlm21vMGXpcoYMwk4SLTYauu5SLtc0V+fqg6Dvt/vKpYA==
Received: from [127.0.0.1] by nm37.bullet.mail.gq1.yahoo.com with NNFMP; 03 Sep 2016 20:20:07 -0000
Received: from [98.137.12.60] by nm37.bullet.mail.gq1.yahoo.com with NNFMP; 03 Sep 2016 20:17:08 -0000
Received: from [212.82.98.57] by tm5.bullet.mail.gq1.yahoo.com with NNFMP; 03 Sep 2016 20:17:08 -0000
Received: from [212.82.98.106] by tm10.bullet.mail.ir2.yahoo.com with NNFMP; 03 Sep 2016 20:17:07 -0000
Received: from [127.0.0.1] by omp1043.mail.ir2.yahoo.com with NNFMP; 03 Sep 2016 20:17:07 -0000
X-Yahoo-Newman-Property: ymail-4
X-Yahoo-Newman-Id: 782808.38164.bm@omp1043.mail.ir2.yahoo.com
X-YMail-OSG: v6X4cMkVM1l2_8VxfynEcvxlLSN1q3MY_m2abnYVt5LIa5oQopzr5aqlqFPtVZe
 CDt6KaAI4rbpojibyzwYZh7bbFhwrUuGecdwUc5N5_p0Ziix2vz1xjyaxeIPSaWa920W_jWcgD0x
 UV6hguF7.0Ko.n._kgjeSL7ncRo4KRgGjdoLp1oa4Doq_ugC1ywHVgaD7SsQafBHeeQac.J042Ao
 5xeKpWGDpYzmqwO5jC4de.nEhVyJLO2_4F36ll_xtXHwgJMAvB7KX.tMIcMa2EdAhGSzhqQN0fsw
 YMyLxJ1Lj.ULeDscQ0cg7VAPxWR_nyN9OqY4VVog0WpeBbf4RKGxwycAzXD_JSz4sJ0FQPPMraeD
 SH73dyL6d5UAixn58bUS3CGe.2FZLvChjChJ2F3ERaaK61z2o57lQZ0Sh4qAuhkJ0IsfqhUif3Zn
 W.5r7sxoJl7Wl0sxmWlHYtA5wQPG.tXUX0A9kGBU3iP_S7qbtX0q2ygNJLVv1b0dzb3luzspDfcO
 uo4B7p53_IyMD2mlC_P_3173YQ9Ql6LCiri_F_OJVrhqbV7ZdoPASm.eYBHdL52OFs_3xgtQlPml
 8FbGWH3dB77P.GVjLsI7VkPlQTwaCvtWQumbk_oS.
Received: from jws11166.mail.ir2.yahoo.com by sendmailws108.mail.ir2.yahoo.com; Sat, 03 Sep 2016 20:17:07 +0000; 1472933827.351
Date:   Sat, 3 Sep 2016 20:17:05 +0000 (UTC)
From:   <admoss1980@btinternet.com>
To:     <git@vger.kernel.org>
Message-ID: <213477534.1556627.1472933825496@mail.yahoo.com>
Subject: !!!
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <213477534.1556627.1472933825496.ref@mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

http://www.baidu.com/link?url=DsqnrRyBjH64xj2HvdqZKR4I8iRgR7o9Is6IOc8EiYC#680=ivevjp&4049&hezjgjp==97698091
