Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4804D1FCC7
	for <e@80x24.org>; Tue, 27 Dec 2016 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbcL0IeQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 03:34:16 -0500
Received: from dmitry.altsci.com ([216.218.134.11]:48064 "EHLO
        dmitry.altsci.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750697AbcL0IeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 03:34:15 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Dec 2016 03:34:15 EST
Received: from mail.altsci.com (javantea-1-pt.tunnel.tserv3.fmt2.ipv6.he.net [IPv6:2001:470:1f04:d98::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dmitry.altsci.com (Postfix) with ESMTPS id B132A33E630
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 00:27:58 -0800 (PST)
Received: from mail.altsci.com (suzy [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.altsci.com (Postfix) with ESMTPS id 8B7A813893D
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 00:29:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4649446176499848834=="
MIME-Version: 1.0
From:   Javantea <jvoss@altsci.com>
To:     git@vger.kernel.org
Subject: Gitview Shell Injection Vulnerability
Date:   Tue, 27 Dec 2016 08:29:22 -0000
Message-Id: <20161227082922.8B7A813893D@mail.altsci.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--===============4649446176499848834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

I have found a shell injection vulnerability in contrib/gitview/gitview.

Gitview Shell Injection Vulnerability

Versions affected: 8cb711c8a5-1d1bdafd64 (<=2.11.0)

Gitview executes shell commands using string concatenation with user supplied data, filenames and branch names. Running Gitview and interacting with the user interface with a malicious filename or branch name in the current repository results in malicious commands being executed as the current user.

AnnotateWindow.add_file_data(self, filename, commit_sha1, line_num):
    fp = os.popen("git cat-file blob " + commit_sha1 +":"+filename)

AnnotateWindow.annotate(self, filename, commit_sha1, line_num):
    fp = os.popen("git ls-tree "+ commit_sha1 + " -- " + filename)
    fp = os.popen("git blame --incremental -C -C -- " + filename + " " + commit_sha1)

GitView.set_branch(self, args):
    fp = os.popen("git rev-parse --sq --default HEAD " + list_to_string(args, 1))
    fp = os.popen("git rev-list  --header --topo-order --parents " + git_rev_list_cmd)

The program also has other uses of os.popen but none use values that the user can manipulate. However, the fix should definitely replace these instances so that the code might one day pass pylint and manual code review easier.

The function os.popen has been replaced by safer functions in the subprocess module. The code can be improved easily because it requires very little change to convert the code to work with arrays of strings instead of strings.

If you have any questions or would like a patch, please let me know.

Regards,
Javantea

--===============4649446176499848834==--
