X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Some tips for doing a CVS importer
Date: Mon, 20 Nov 2006 16:49:17 -0500
Message-ID: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 21:50:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kSgC0erWfqGUC7UQrVv2qIbloGZuy2cXniNMd9RoykdV1g35+6IO4Y91e04zqBB1sQBymH8AaNJkcI0WswPLsJSuUc53fOesXgQK3VyyllFOQ8W/hZoc2KERt7f9h7Nadybhu1X+9tenBkvKbk2+G5gGbf6R9I0eRTYlkDCXzws=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31940>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmH1M-0003A3-PG for gcvg-git@gmane.org; Mon, 20 Nov
 2006 22:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966698AbWKTVtl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 16:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966710AbWKTVtl
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 16:49:41 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:58866 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S966698AbWKTVtk
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 16:49:40 -0500
Received: by py-out-1112.google.com with SMTP id a29so1028486pyi for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 13:49:39 -0800 (PST)
Received: by 10.35.125.16 with SMTP id c16mr245716pyn.1164059357676; Mon, 20
 Nov 2006 13:49:17 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 20 Nov 2006 13:49:17 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I have tried all of the available CVS importers. None of them are
without problems. If anyone is interested in writing one for git here
are some ideas on how to structure it.

1) there is a working lex/yacc for CVS in the parsecvs source code
2) The first time you parse a CVS file record everything and don't
parse it again.
3) When the file is first parsed use the deltas to generate the
revisions and feed them to git-fastimport, just remember the SHA1 or
an id in the import code. This is a critical step to getting decent
performance.
4) If you do #1 and #2 you don't need to store CVS revision numbers
and file names in memory. Because of that you can can easily do a
Mozilla import in 2GB, probably 1GB.
5) When comparing CVS revisions only use the CVS timestamps as a last
resort, instead use the dependency information in the CVS file
6) Match up commits by using an sha1 of the author and commit message
7) After all files are loaded, match up the symbols and insert them
into the dependency chains, if any of the symbols depend on a branch
commit the symbol lies on the branch, otherwise the symbol is on the
trunk,
8) Do a topological sort to build the change set commit tree
9) when you hit a loop in the tree break up delta change sets until
the loop can be removed, don't break up symbol change sets.
10) Mozilla has some large commits that were made over dial up. Commit
change sets can span hours. All of these commits need to be merged
into a single change set.
11) An algorithm needs to be developed for detecting branches merging
back into the trunk
12) cvs2svn has excellent test cases, use them to test the new
importer. The cvs2svn code is quite nice but it doesn't handle #7

-- 
Jon Smirl
