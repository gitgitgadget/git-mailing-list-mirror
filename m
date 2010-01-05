From: Tomas Carnecky <tom@dbservice.com>
Subject: checkout -m dumping core
Date: Tue, 05 Jan 2010 19:15:38 +0100
Message-ID: <4B4381CA.1080504@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:16:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSDx7-0005Me-NY
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 19:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab0AESQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 13:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042Ab0AESQP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 13:16:15 -0500
Received: from office.neopsis.com ([78.46.209.98]:33957 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0AESQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 13:16:11 -0500
Received: from [192.168.0.82] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	for git@vger.kernel.org;
	Tue, 5 Jan 2010 19:16:03 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.3a1pre) Gecko/20100105 Lightning/1.1a1pre Shredder/3.2a1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136198>

git version 1.6.6.78.gbd757c

HEAD points to a non-existent branch refs/heads/master. Normal checkout 
origin fails with:
error: Entry '.cvsignore' would be overwritten by merge. Cannot merge.
(the working tree does indeed contain this file). So I tried checkout -m 
and git crashed. Workaround for me was reset --hard origin; checkout 
origin. I have the repository backed up in case someone wants to try 
themselves.

$ gdb `which git`
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i386-pc-solaris2.11"...
(gdb) run checkout -m origin
Starting program: /export/home/tomc/local/git/bin/git checkout -m origin
warning: Lowest section in /lib/libpthread.so.1 is .dynamic at 00000074

Program received signal SIGSEGV, Segmentation fault.
0x080788fa in cmd_checkout (argc=0, argv=0x8047538, prefix=0x0) at 
builtin-checkout.c:450
450                             merge_trees(&o, new->commit->tree, work,
(gdb) list
445                             ret = reset_tree(new->commit->tree, 
opts, 1);
446                             if (ret)
447                                     return ret;
448                             o.branch1 = new->name;
449                             o.branch2 = "local";
450                             merge_trees(&o, new->commit->tree, work,
451                                     old->commit->tree, &result);
452                             ret = reset_tree(new->commit->tree, 
opts, 0);
453                             if (ret)
454                                     return ret;
(gdb) p o
$1 = {branch1 = 0x8047650 "origin", branch2 = 0x0, subtree_merge = 0, 
buffer_output = 1, verbosity = 0, diff_rename_limit = -1, 
merge_rename_limit = -1, call_depth = 0, obuf = {alloc = 0, len = 0, buf 
= 0x81643ac ""}, current_file_set = {
     items = 0x0, nr = 0, alloc = 0, strdup_strings = 1}, 
current_directory_set = {items = 0x0, nr = 0, alloc = 0, strdup_strings 
= 1}}
(gdb) p new
$2 = {name = 0x8047650 "origin", path = 0x8166438 "refs/heads/origin", 
commit = 0x8168f48}
(gdb) p work
$3 = (struct tree *) 0x8174f90
(gdb) p old
No symbol "old" in current context.
(gdb) p result
$4 = (struct tree *) 0xfefc81be
(gdb)
