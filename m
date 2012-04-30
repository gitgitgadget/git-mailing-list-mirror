From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 4/4] git p4: submit files with wildcards
Date: Mon, 30 Apr 2012 19:34:48 +0100
Message-ID: <4F9EDB48.6030301@diamand.org>
References: <1335747437-24034-1-git-send-email-pw@padd.com> <1335747437-24034-5-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 20:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOvR2-00058y-TX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 20:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab2D3Sew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 14:34:52 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53633 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab2D3Sev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 14:34:51 -0400
Received: by wibhq7 with SMTP id hq7so3154419wib.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 11:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=PDo/xfiOjq9R0ETBJJsXMiocSuvladETNvg9VVYLoZY=;
        b=esSo1EvioAe4dp7dWks1s2Bv5esqVgns4eemtnNd8eZIDiLCz51wr3twm+WgFVOiHe
         q7BiH0XfxcaTW/0drEeDDQGBF8JitFd4sDFuYJ4QSfIZtZlhaZM2+gKZkunAR1gmORRi
         00iuW1Se++Ox4hOGt36qTja9Z4rBlmPhy+nVX3XYFDVF7JrieZbJOSFutxsNVcO58sof
         oQCtKaKkg/Pgvp5Y+za1MMBGlYQOkPoM6OOkC9uFCmF7Ln7UBqW3oOoleh4AF9Tx/YUV
         NKkxDLfyCvfGV7Z4k0QA8EcnIHL1oS0HetkdzQ2SkxxkGjjEkaqjJfQC6bdC1+fGHE16
         GijQ==
Received: by 10.180.98.8 with SMTP id ee8mr31455852wib.14.1335810889904;
        Mon, 30 Apr 2012 11:34:49 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ff9sm30088532wib.2.2012.04.30.11.34.48
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 11:34:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <1335747437-24034-5-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQlcKQe6VaFcMnV88SxDnodTIFTloB57eQc/quSZi91SbJVOQzYuuBnaBJLv2btfhIn3mDom
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196590>

On 30/04/12 01:57, Pete Wyckoff wrote:
> There are four wildcard characters in p4.  Files with these
> characters can be added to p4 repos using the "-f" option.  They
> are stored in %xx notation, and when checked out, p4 converts
> them back to normal.
>
> When adding files with wildcards in git, the submit path must
> be careful to use the encoded names in some places, and it
> must use "-f" to add them.  All other p4 commands that operate
> on the client directory expect encoded filenames as arguments.
>
> Support for wildcards in the clone/sync path was added in
> 084f630 (git-p4: decode p4 wildcard characters, 2011-02-19),
> but that change did not handle the submit path.
>
> There was a problem with wildcards in the sync path too.  Commit
> 084f630 (git-p4: decode p4 wildcard characters, 2011-02-19)
> handled files with p4 wildcards that were added or modified in
> p4.  Do this for deleted files, and also in branch detection
> checks, too.

Ack, thanks for fixing this. The other changes look fine as well.

>
> Reported-by: Luke Diamand<luke@diamand.org>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   git-p4.py                     |   74 +++++++++++++++++-----------
>   t/t9800-git-p4-basic.sh       |  106 +++++++++++++++++++++++++++++++++++++++++
>   t/t9809-git-p4-client-view.sh |   33 +++++++++++++
>   3 files changed, 185 insertions(+), 28 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 888e3e7..5afd501 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -131,25 +131,29 @@ def p4_system(cmd):
>       subprocess.check_call(real_cmd, shell=expand)
>
>   def p4_integrate(src, dest):
> -    p4_system(["integrate", "-Dt", src, dest])
> +    p4_system(["integrate", "-Dt", wildcard_encode(src), wildcard_encode(dest)])
>
>   def p4_sync(f, *options):
> -    p4_system(["sync"] + list(options) + [f])
> +    p4_system(["sync"] + list(options) + [wildcard_encode(f)])
>
>   def p4_add(f):
> -    p4_system(["add", f])
> +    # forcibly add file names with wildcards
> +    if wildcard_present(f):
> +        p4_system(["add", "-f", f])
> +    else:
> +        p4_system(["add", f])
>
>   def p4_delete(f):
> -    p4_system(["delete", f])
> +    p4_system(["delete", wildcard_encode(f)])
>
>   def p4_edit(f):
> -    p4_system(["edit", f])
> +    p4_system(["edit", wildcard_encode(f)])
>
>   def p4_revert(f):
> -    p4_system(["revert", f])
> +    p4_system(["revert", wildcard_encode(f)])
>
> -def p4_reopen(type, file):
> -    p4_system(["reopen", "-t", type, file])
> +def p4_reopen(type, f):
> +    p4_system(["reopen", "-t", type, wildcard_encode(f)])
>
>   #
>   # Canonicalize the p4 type and return a tuple of the
> @@ -246,7 +250,7 @@ def setP4ExecBit(file, mode):
>   def getP4OpenedType(file):
>       # Returns the perforce file type for the given file.
>
> -    result = p4_read_pipe(["opened", file])
> +    result = p4_read_pipe(["opened", wildcard_encode(file)])
>       match = re.match(".*\((.+)\)\r?$", result)
>       if match:
>           return match.group(1)
> @@ -636,6 +640,34 @@ def getClientRoot():
>
>       return entry["Root"]
>
> +#
> +# P4 wildcards are not allowed in filenames.  P4 complains
> +# if you simply add them, but you can force it with "-f", in
> +# which case it translates them into %xx encoding internally.
> +#
> +def wildcard_decode(path):
> +    # Search for and fix just these four characters.  Do % last so
> +    # that fixing it does not inadvertently create new %-escapes.
> +    # Cannot have * in a filename in windows; untested as to
> +    # what p4 would do in such a case.
> +    if not platform.system() == "Windows":
> +        path = path.replace("%2A", "*")
> +    path = path.replace("%23", "#") \
> +               .replace("%40", "@") \
> +               .replace("%25", "%")
> +    return path
> +
> +def wildcard_encode(path):
> +    # do % first to avoid double-encoding the %s introduced here
> +    path = path.replace("%", "%25") \
> +               .replace("*", "%2A") \
> +               .replace("#", "%23") \
> +               .replace("@", "%40")
> +    return path
> +
> +def wildcard_present(path):
> +    return path.translate(None, "*#@%") != path
> +
>   class Command:
>       def __init__(self):
>           self.usage = "usage: %prog [options]"
> @@ -1170,7 +1202,8 @@ class P4Submit(Command, P4UserMap):
>                   del(os.environ["P4DIFF"])
>               diff = ""
>               for editedFile in editedFiles:
> -                diff += p4_read_pipe(['diff', '-du', editedFile])
> +                diff += p4_read_pipe(['diff', '-du',
> +                                      wildcard_encode(editedFile)])
>
>               newdiff = ""
>               for newFile in filesToAdd:
> @@ -1605,23 +1638,6 @@ class P4Sync(Command, P4UserMap):
>           if gitConfig("git-p4.syncFromOrigin") == "false":
>               self.syncWithOrigin = False
>
> -    #
> -    # P4 wildcards are not allowed in filenames.  P4 complains
> -    # if you simply add them, but you can force it with "-f", in
> -    # which case it translates them into %xx encoding internally.
> -    # Search for and fix just these four characters.  Do % last so
> -    # that fixing it does not inadvertently create new %-escapes.
> -    #
> -    def wildcard_decode(self, path):
> -        # Cannot have * in a filename in windows; untested as to
> -        # what p4 would do in such a case.
> -        if not self.isWindows:
> -            path = path.replace("%2A", "*")
> -        path = path.replace("%23", "#") \
> -                   .replace("%40", "@") \
> -                   .replace("%25", "%")
> -        return path
> -
>       # Force a checkpoint in fast-import and wait for it to finish
>       def checkpoint(self):
>           self.gitStream.write("checkpoint\n\n")
> @@ -1689,6 +1705,7 @@ class P4Sync(Command, P4UserMap):
>               fnum = fnum + 1
>
>               relPath = self.stripRepoPath(path, self.depotPaths)
> +            relPath = wildcard_decode(relPath)
>
>               for branch in self.knownBranches.keys():
>
> @@ -1706,7 +1723,7 @@ class P4Sync(Command, P4UserMap):
>
>       def streamOneP4File(self, file, contents):
>           relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
> -        relPath = self.wildcard_decode(relPath)
> +        relPath = wildcard_decode(relPath)
>           if verbose:
>               sys.stderr.write("%s\n" % relPath)
>
> @@ -1775,6 +1792,7 @@ class P4Sync(Command, P4UserMap):
>
>       def streamOneP4Deletion(self, file):
>           relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
> +        relPath = wildcard_decode(relPath)
>           if verbose:
>               sys.stderr.write("delete %s\n" % relPath)
>           self.gitStream.write("D %s\n" % relPath)
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 13be144..0223fcf 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -163,6 +163,112 @@ test_expect_success 'wildcard files git p4 clone' '
>   	)
>   '
>
> +test_expect_success 'wildcard files submit back to p4, add' '
> +	test_when_finished cleanup_git&&
> +	git p4 clone --dest="$git" //depot&&
> +	(
> +		cd "$git"&&
> +		echo git-wild-hash>git-wild#hash&&
> +		echo git-wild-star>git-wild\*star&&
> +		echo git-wild-at>git-wild@at&&
> +		echo git-wild-percent>git-wild%percent&&
> +		git add git-wild*&&
> +		git commit -m "add some wildcard filenames"&&
> +		git config git-p4.skipSubmitEdit true&&
> +		git p4 submit
> +	)&&
> +	(
> +		cd "$cli"&&
> +		test_path_is_file git-wild#hash&&
> +		test_path_is_file git-wild\*star&&
> +		test_path_is_file git-wild@at&&
> +		test_path_is_file git-wild%percent
> +	)
> +'
> +
> +test_expect_success 'wildcard files submit back to p4, modify' '
> +	test_when_finished cleanup_git&&
> +	git p4 clone --dest="$git" //depot&&
> +	(
> +		cd "$git"&&
> +		echo new-line>>git-wild#hash&&
> +		echo new-line>>git-wild\*star&&
> +		echo new-line>>git-wild@at&&
> +		echo new-line>>git-wild%percent&&
> +		git add git-wild*&&
> +		git commit -m "modify the wildcard files"&&
> +		git config git-p4.skipSubmitEdit true&&
> +		git p4 submit
> +	)&&
> +	(
> +		cd "$cli"&&
> +		test_line_count = 2 git-wild#hash&&
> +		test_line_count = 2 git-wild\*star&&
> +		test_line_count = 2 git-wild@at&&
> +		test_line_count = 2 git-wild%percent
> +	)
> +'
> +
> +test_expect_success 'wildcard files submit back to p4, copy' '
> +	test_when_finished cleanup_git&&
> +	git p4 clone --dest="$git" //depot&&
> +	(
> +		cd "$git"&&
> +		cp file2 git-wild-cp#hash&&
> +		git add git-wild-cp#hash&&
> +		cp git-wild\*star file-wild-3&&
> +		git add file-wild-3&&
> +		git commit -m "wildcard copies"&&
> +		git config git-p4.detectCopies true&&
> +		git config git-p4.detectCopiesHarder true&&
> +		git config git-p4.skipSubmitEdit true&&
> +		git p4 submit
> +	)&&
> +	(
> +		cd "$cli"&&
> +		test_path_is_file git-wild-cp#hash&&
> +		test_path_is_file file-wild-3
> +	)
> +'
> +
> +test_expect_success 'wildcard files submit back to p4, rename' '
> +	test_when_finished cleanup_git&&
> +	git p4 clone --dest="$git" //depot&&
> +	(
> +		cd "$git"&&
> +		git mv git-wild@at file-wild-4&&
> +		git mv file-wild-3 git-wild-cp%percent&&
> +		git commit -m "wildcard renames"&&
> +		git config git-p4.detectRenames true&&
> +		git config git-p4.skipSubmitEdit true&&
> +		git p4 submit
> +	)&&
> +	(
> +		cd "$cli"&&
> +		test_path_is_missing git-wild@at&&
> +		test_path_is_file git-wild-cp%percent
> +	)
> +'
> +
> +test_expect_success 'wildcard files submit back to p4, delete' '
> +	test_when_finished cleanup_git&&
> +	git p4 clone --dest="$git" //depot&&
> +	(
> +		cd "$git"&&
> +		git rm git-wild*&&
> +		git commit -m "delete the wildcard files"&&
> +		git config git-p4.skipSubmitEdit true&&
> +		git p4 submit
> +	)&&
> +	(
> +		cd "$cli"&&
> +		test_path_is_missing git-wild#hash&&
> +		test_path_is_missing git-wild\*star&&
> +		test_path_is_missing git-wild@at&&
> +		test_path_is_missing git-wild%percent
> +	)
> +'
> +
>   test_expect_success 'clone bare' '
>   	git p4 clone --dest="$git" --bare //depot&&
>   	test_when_finished cleanup_git&&
> diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
> index 43ed1fe..7d993ef 100755
> --- a/t/t9809-git-p4-client-view.sh
> +++ b/t/t9809-git-p4-client-view.sh
> @@ -374,6 +374,39 @@ test_expect_success 'subdir clone, submit rename' '
>   	)
>   '
>
> +# see t9800 for the non-client-spec case, and the rest of the wildcard tests
> +test_expect_success 'wildcard files submit back to p4, client-spec case' '
> +	client_view "//depot/... //client/..."&&
> +	test_when_finished cleanup_git&&
> +	git p4 clone --use-client-spec --dest="$git" //depot/dir1&&
> +	(
> +		cd "$git"&&
> +		echo git-wild-hash>dir1/git-wild#hash&&
> +		echo git-wild-star>dir1/git-wild\*star&&
> +		echo git-wild-at>dir1/git-wild@at&&
> +		echo git-wild-percent>dir1/git-wild%percent&&
> +		git add dir1/git-wild*&&
> +		git commit -m "add some wildcard filenames"&&
> +		git config git-p4.skipSubmitEditCheck true&&
> +		git p4 submit
> +	)&&
> +	(
> +		cd "$cli"&&
> +		test_path_is_file dir1/git-wild#hash&&
> +		test_path_is_file dir1/git-wild\*star&&
> +		test_path_is_file dir1/git-wild@at&&
> +		test_path_is_file dir1/git-wild%percent
> +	)&&
> +	(
> +		# delete these carefully, cannot just do "p4 delete"
> +		# on files with wildcards; but git-p4 knows how
> +		cd "$git"&&
> +		git rm dir1/git-wild*&&
> +		git commit -m "clean up the wildcards"&&
> +		git p4 submit
> +	)
> +'
> +
>   test_expect_success 'reinit depot' '
>   	(
>   		cd "$cli"&&
