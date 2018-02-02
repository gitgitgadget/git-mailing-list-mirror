Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8C41F404
	for <e@80x24.org>; Fri,  2 Feb 2018 17:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeBBRkH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 12:40:07 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:61638 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753076AbeBBRif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 12:38:35 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zY42w2L6Hz5tl9;
        Fri,  2 Feb 2018 18:38:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CEBB91D0F;
        Fri,  2 Feb 2018 18:38:31 +0100 (CET)
Subject: Re: Git on Windows maps creation time onto changed time
To:     Keith Goldfarb <keith@blackthorn-media.com>
References: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <c1e419ae-feae-5a31-ead6-20b25fa92f85@kdbg.org>
Date:   Fri, 2 Feb 2018 18:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.2018 um 00:10 schrieb Keith Goldfarb:
> Dear git,
> 
> While tracking down a problem with a filesystem shared by Windows and Ubuntu, I came across the following code in compat/mingw.c (ming_fstat(), also in do_lstat()):
> 
> 	if (GetFileInformationByHandle(fh, &fdata)) {
> 		buf->st_ino = 0;
> 		buf->st_gid = 0;
> 		buf->st_uid = 0;
> 		buf->st_nlink = 1;
> 		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
> 		buf->st_size = fdata.nFileSizeLow |
> 			(((off_t)fdata.nFileSizeHigh)<<32);
> 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
> 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
> 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
> 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
> 		return 0;
> 	}
> 
> The assignment of buf->st_ctime doesn’t seem right to me. I
> understand there’s no good choice here, but I think a better choice
> would be to  duplicate the definition used for st_mtime.

The purpose of these values is to allow to notice a change on the file 
system without going through the actual file data. Duplicating st_mtime 
would be pointless.

> Background: When I do a git status on Windows and then later on
> Ubuntu (or the other order), it is extremely slow, as the entire tree
> is being traversed. I tracked it down to this difference in
> definition of c_time. Yes, I know about the core.trustctime variable,
> but my problem aside  this seems like an unwise choice.

Don't do that then. Use core.trustctime.

-- Hannes
