From: Tomas Carnecky <tom@dbservice.com>
Subject: clang static analyzer
Date: Sun, 6 Dec 2009 07:11:24 +0100
Message-ID: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 07:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHALn-0005Op-AQ
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 07:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZLFGLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 01:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZLFGLp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 01:11:45 -0500
Received: from office.neopsis.com ([78.46.209.98]:47162 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbZLFGLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 01:11:44 -0500
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	for git@vger.kernel.org;
	Sun, 6 Dec 2009 07:11:49 +0100
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134646>

There have been several attempts at running the clang static analyzer on the git source code, some even resulted in patches. I tried it, too, and among the many false positives I think clang found a few real issues. The results can be seen at [1].

Clang again found many dead assignments/increments, but in the earlier discussions you concluded that you want to keep those around. So I focussed on another class of potential bugs: Argument with 'nonnull' attribute passed null. There were a total of seven such issues. I then tried to look through the code and see if they are valid or false positives:

xdiff-interface.c:xdiff_set_find_func() - When 'value' is a string with no newline character in it, the loop at line 291 sets 'value' to NULL on its first iteration and then passes 'value' to strchr() in the second iteration.

utf8.c:utf8_strwidth() - 'string' may be set to NULL in utf8_width() which makes this one a false positive.

pretty.c:get_header() - if 'line' doesn't contain a newline character, line is set to NULL on first iteration and then passed to strchr() in the second itration.

attr.c:prepare_attr_stack() - bootstrap_attr_stack() sets attr_stack so this one is a false positive as well.

test-parse-options.c:length_callback() - if arg == NULL and unset == 0 then the function passes NULL to strlen().

builtin-pack-objects.c:check_pbase_path() - false positive, if done_pbase_paths == NULL then also done_pbase_paths_alloc == 0 and so step 4 can't take the false branch.

builtin-ls-files.c:verify_pathspec() - false positive, pathspec is not NULL when the function is called.


- Some of the issues might be purely hypothetical, for example I don't know if it's possible that get_header() can be passed a string with no newlines, maybe this is prevented earlier in the code path.
- Some of the false positives (such as the last one) could be avoided by giving clang a hint that a certain variable can't be NULL (by using assert() or if (!foo) return).


tom


[1] http://78.46.209.101/stuff/clang-static-analyzer/git/v1.6.6-rc1-32-g97f3d79/
