From: David Reiss <dreiss@facebook.com>
Subject: Re: [PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Thu, 15 May 2008 14:09:39 -0700
Message-ID: <482CA693.3060602@facebook.com>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 23:11:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwkig-00061o-UK
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 23:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbYEOVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 17:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYEOVJo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 17:09:44 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:59018 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbYEOVJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 17:09:43 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4FL9e34026124;
	Thu, 15 May 2008 14:09:40 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 May 2008 14:06:48 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.DEB.1.00.0805152055280.30431@racer>
X-OriginalArrivalTime: 15 May 2008 21:06:48.0296 (UTC) FILETIME=[96B48E80:01C8B6CF]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-15_04:2008-05-14,2008-05-15,2008-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805150182
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82233>

longest_prefix is just a textual check.  It doesn't verify that the prefix
is actually a full directory component of the cwd.  For example...

dreiss@dreiss-vmware:/tmp$ mkdir test
dreiss@dreiss-vmware:/tmp$ cd test
dreiss@dreiss-vmware:/tmp/test$ git init
Initialized empty Git repository in .git/
dreiss@dreiss-vmware:master:test$ mkdir abcd
dreiss@dreiss-vmware:master:test$ cd abcd
dreiss@dreiss-vmware:master:test/abcd$ git rev-parse --show-prefix
abcd/
dreiss@dreiss-vmware:master:test/abcd$ ~/git-ceil/git rev-parse --show-prefix
abcd/
dreiss@dreiss-vmware:master:test/abcd$ GIT_CEILING_DIRECTORIES=/tmp/test/ab ~/git-ceil/git rev-parse --show-prefix
fatal: Not a git repository
dreiss@dreiss-vmware:master:test/abcd:128$ 

"/tmp/test/ab" is a textual prefix of the cwd, but it should not prevent
"/tmp/test/.git" from being discovered.  For what it's worth, my test cases
check this behavior.  Ironically, I think this could be fixed by requiring
the ceiling directories to have trailing slashes.

Also, I think it is better to move the 'chdir("..")' after the do loop,
so that git won't even chdir up into the ceiling directory.  This actually
doesn't matter to me, but I figured that it might be nice for someone.

Finally, just a small thing.  The documentation still says "GIT_CEILING_DIRS".

--David

Johannes Schindelin wrote:
> 
> In certain setups, trying to access a non-existing .git/ can take quite
> some time, for example when the directory is an automount directory.
> 
> Allow the user to specify directories where Git should stop looking for
> a .git/ directory: GIT_CEILING_DIRECTORIES, if set, is expected to be
> a colon delimited list of such barrier directories.
> 
> Note: if GIT_CEILING_DIRECTORIES=/a/b and your current working directory
> is /a, Git will _not_ stop looking.
> 
> Note2: you must not specify the directories with trailing slashes.
> 
> Initial implementation by David Reiss.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
>         Show me the bugs!
> 
>         I just checked: the "/" issue you were referring to is most likely
>         the fact that "git rev-parse --git-dir" would return "//.git"
>         instead of "/.git" (if that is the appropriate GIT_DIR).
> 
>         This is the original behavior (without this patch), and IMO a
>         separate issue, which might not even need fixing.
> 
>  Documentation/git.txt          |    6 +++++
>  cache.h                        |    2 +
>  path.c                         |   19 ++++++++++++++++
>  setup.c                        |   11 +++++++-
>  t/t1504-ceiling-directories.sh |   46
> ++++++++++++++++++++++++++++++++++++++++
>  t/test-lib.sh                  |    1 +
>  6 files changed, 83 insertions(+), 2 deletions(-)
>  create mode 100644 t/t1504-ceiling-directories.sh
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index adcd3e0..a12d1f8 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -415,6 +415,12 @@ git so take care if using Cogito etc.
>         This can also be controlled by the '--work-tree' command line
>         option and the core.worktree configuration variable.
> 
> +'GIT_CEILING_DIRS'::
> +       If set (to a colon delimited list of absolute directories), Git
> +       will refuse to look for the .git/ directory further when hitting
> +       one of those directories (otherwise it would traverse the parent
> +       directories until hitting the root directory).
> +
>  git Commits
>  ~~~~~~~~~~~
>  'GIT_AUTHOR_NAME'::
> diff --git a/cache.h b/cache.h
> index a8638b1..c31b4c7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -300,6 +300,7 @@ static inline enum object_type object_type(unsigned
> int mode)
>  #define CONFIG_ENVIRONMENT "GIT_CONFIG"
>  #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
>  #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
> +#define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
>  #define GITATTRIBUTES_FILE ".gitattributes"
>  #define INFOATTRIBUTES_FILE "info/attributes"
>  #define ATTRIBUTE_MACRO_PREFIX "[attr]"
> @@ -522,6 +523,7 @@ static inline int is_absolute_path(const char *path)
>         return path[0] == '/';
>  }
>  const char *make_absolute_path(const char *path);
> +int longest_prefix(const char *path, const char *prefix_list);
> 
>  /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
>  extern int sha1_object_info(const unsigned char *, unsigned long *);
> diff --git a/path.c b/path.c
> index b7c24a2..c0d7364 100644
> --- a/path.c
> +++ b/path.c
> @@ -357,3 +357,22 @@ const char *make_absolute_path(const char *path)
> 
>         return buf;
>  }
> +
> +int longest_prefix(const char *path, const char *prefix_list)
> +{
> +       int max_length = 0, length = 0, i;
> +
> +       for (i = 0; prefix_list[i]; i++)
> +               if (prefix_list[i] == ':') {
> +                       if (length > max_length)
> +                               max_length = length;
> +                       length = 0;
> +               }
> +               else if (length >= 0) {
> +                       if (prefix_list[i] == path[length])
> +                               length++;
> +                       else
> +                               length = -1;
> +               }
> +       return max_length > length ? max_length : length;
> +}
> diff --git a/setup.c b/setup.c
> index 9e9a2b1..cece3e4 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -365,10 +365,13 @@ const char *read_gitfile_gently(const char *path)
>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
>         const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
> +       const char *ceiling_directories =
> +               getenv(CEILING_DIRECTORIES_ENVIRONMENT);
>         static char cwd[PATH_MAX+1];
>         const char *gitdirenv;
>         const char *gitfile_dir;
>         int len, offset;
> +       int min_offset = 0;
> 
>         /*
>          * Let's assume that we are in a git repository.
> @@ -422,6 +425,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
>         if (!getcwd(cwd, sizeof(cwd)-1))
>                 die("Unable to read current working directory");
> 
> +       if (ceiling_directories)
> +               min_offset = longest_prefix(cwd, ceiling_directories);
> +
>         /*
>          * Test in the following order (relative to the cwd):
>          * - .git (file containing "gitdir: <path>")
> @@ -453,7 +459,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                 }
>                 chdir("..");
>                 do {
> -                       if (!offset) {
> +                       if (offset <= min_offset) {
>                                 if (nongit_ok) {
>                                         if (chdir(cwd))
>                                                 die("Cannot come back to
> cwd");
> @@ -462,7 +468,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                                 }
>                                 die("Not a git repository");
>                         }
> -               } while (cwd[--offset] != '/');
> +               } while (offset > min_offset &&
> +                               --offset >=0 && cwd[offset] != '/');
>         }
> 
>         inside_git_dir = 0;
> diff --git a/t/t1504-ceiling-directories.sh b/t/t1504-ceiling-directories.sh
> new file mode 100644
> index 0000000..1d8ef0b
> --- /dev/null
> +++ b/t/t1504-ceiling-directories.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Johannes E. Schindelin
> +#
> +
> +test_description='test limiting with GIT_CEILING_DIRECTORIES'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +
> +       CWD="$(pwd -P)" &&
> +       mkdir subdir
> +
> +'
> +
> +test_expect_success 'without GIT_CEILING_DIRECTORIES' '
> +
> +       test .git = "$(git rev-parse --git-dir)" &&
> +       (cd subdir && git rev-parse --git-dir) &&
> +       echo "$CWD" &&
> +       test "$CWD/.git" = "$(cd subdir && git rev-parse --git-dir)"
> +
> +'
> +
> +test_expect_success 'with non-matching ceiling directory' '
> +
> +       test "$(GIT_CEILING_DIRECTORIES="$CWD/X" \
> +               git rev-parse --git-dir)" = .git
> +
> +'
> +
> +test_expect_success 'with matching ceiling directories' '
> +
> +       GIT_CEILING_DIRECTORIES="$CWD/X:$CWD/subdir" &&
> +       export GIT_CEILING_DIRECTORIES &&
> +       (cd subdir && test_must_fail git rev-parse --git-dir) &&
> +       git rev-parse --git-dir &&
> +       GIT_CEILING_DIRECTORIES="$CWD/subdir:$CWD/X" &&
> +       export GIT_CEILING_DIRECTORIES &&
> +       (cd subdir && test_must_fail git rev-parse --git-dir) &&
> +       git rev-parse --git-dir
> +
> +'
> +
> +test_done
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 5002fb0..c3a3167 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -35,6 +35,7 @@ unset GIT_WORK_TREE
>  unset GIT_EXTERNAL_DIFF
>  unset GIT_INDEX_FILE
>  unset GIT_OBJECT_DIRECTORY
> +unset GIT_CEILING_DIRECTORIES
>  unset SHA1_FILE_DIRECTORIES
>  unset SHA1_FILE_DIRECTORY
>  GIT_MERGE_VERBOSITY=5
> --
> 1.5.5.1.425.g5f464
> 
