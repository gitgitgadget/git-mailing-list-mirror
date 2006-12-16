X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 13:58:12 -0800
Message-ID: <7vodq3cxl7.fsf@assigned-by-dhcp.cox.net>
References: <458437E0.1050501@midwinter.com> <45843C5A.8020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 21:58:34 +0000 (UTC)
Cc: Steven Grimm <koreth@midwinter.com>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45843C5A.8020501@gmail.com> (A. Large Angry's message of "Sat,
	16 Dec 2006 10:35:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34646>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvhXz-0001Tt-Eh for gcvg-git@gmane.org; Sat, 16 Dec
 2006 22:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161545AbWLPV6O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 16:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161547AbWLPV6O
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 16:58:14 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53783 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161545AbWLPV6N (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 16:58:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216215813.HMIB22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 16:58:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zZyQ1V0121kojtg0000000; Sat, 16 Dec 2006
 16:58:25 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

A Large Angry SCM <gitzilla@gmail.com> writes:

> Steven Grimm wrote:
>> In the course of experimenting with using git for my snapshot
>> backups, I ran into what looks like a bug in git-add: it croaks when
>> it tries to add a file whose type has changed, specifically when a
>> directory gets moved and a symbolic link is put in the old location
>> pointing to the new one. Here's a simple test case:
>>
>> $ git init-db
>> defaulting to local storage area
>> $ mkdir dir
>> $ echo foo > dir/file
>> $ git add .
>> $ git commit -m "initial commit" -a
>> Committing initial tree f4bc9c50d08b041f5e096fa68e243c34170f1cd8
>> create mode 100644 dir/file
>> $ mv dir dir.real
>> $ ln -s dir.real dir
>> $ git add .
>> fatal: unable to add dir to index
>>
>> Is "git add ." the wrong thing to do here? I have been using it as a
>> generic "pick up all the files I haven't added yet" command. Or is
>> this a bug?
>>
>> For what it's worth, "git update-index dir" and "git update-index
>> --add dir" both fail too.
>
> Did you try "git-update-index --replace dir"?

Good point.  I've forgotten about "--replace" codepath, although
that is all my code (May 7, 2005).

Maybe "git add" should internally use ADD_CACHE_OK_TO_REPLACE
(or error out and have an option to enable it)?

In any case, the error message could be made a bit more helpful,
like this.

---

diff --git a/read-cache.c b/read-cache.c
index eae4745..a602010 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -609,7 +609,7 @@ int add_cache_entry(struct cache_entry *ce, int option)
 	if (!skip_df_check &&
 	    check_file_directory_conflict(ce, pos, ok_to_replace)) {
 		if (!ok_to_replace)
-			return -1;
+			return error("'%s' appears as both a file and as a directory", ce->name);
 		pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 		pos = -pos-1;
 	}
