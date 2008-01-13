From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Sat, 12 Jan 2008 17:46:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kristian H?gsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 02:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDrx5-0001ku-1J
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 02:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYAMBrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 20:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbYAMBrS
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 20:47:18 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57619 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752229AbYAMBrR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 20:47:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0D1kLx2015883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jan 2008 17:46:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0D1kK84023730;
	Sat, 12 Jan 2008 17:46:21 -0800
In-Reply-To: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.42 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_42
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70365>



On Sat, 12 Jan 2008, Linus Torvalds wrote:
> 
> I thought we had fixed this long long ago, but if we did, it has 
> re-surfaced.

It's new, and yes, it seems to be due to the new builtin-commit.c.

I think I know what is going on.

In the old git-commit.sh, this case used to be handled with

	TMP_INDEX="$GIT_DIR/tmp-index$$"

	GIT_INDEX_FILE="$THIS_INDEX" \
	git read-tree --index-output="$TMP_INDEX" -i -m HEAD

which is a one-way merge of the *old* index and HEAD, taking the index 
information from the old index, but the actual file information from HEAD 
(to then later be updated by the named files).

This logic is implemented by builtin-read-tree.c with

	struct unpack_trees_options opts;
	..
	opts.fn = oneway_merge;
	..
	unpack_trees(nr_trees, t, &opts);

where all the magic is done by that "oneway_merge()" function being called 
for each entry by unpack_trees(). This does everything right, and the 
result is that any index entry that was up-to-date in the old index and 
unchanged in the base tree will be up-to-date in the new index too

HOWEVER. When that logic was converted from that shell-script into a 
builtin-commit.c, that conversion was not done correctly. The old "git 
read-tree -i -m" was not translated as a "unpack_trees()" call, but as 
this in prepare_index():

	discard_cache()
	..
	tree = parse_tree_indirect(head_sha1);
	..
	read_tree(tree, 0, NULL)

which is very wrong, because it replaces the old index entirely, and 
doesn't do that stat information merging.

As a result, the index that is created by read-tree is totally bogus in 
the stat cache, and yes, everything will have to be re-computed.

Kristian?

			Linus
