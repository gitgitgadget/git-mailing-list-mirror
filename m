From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Sun, 23 Aug 2015 01:11:30 +0100
Message-ID: <CAE5ih7_zTP-5WFtPfEcgVsG-sV6k2BhfYh5Z_ttS0oVvJx4NgA@mail.gmail.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 02:11:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTIsr-0002l3-M6
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 02:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbbHWALd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 20:11:33 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36000 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbHWALb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 20:11:31 -0400
Received: by obkg7 with SMTP id g7so85782751obk.3
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZKjxU9gQt0a36rkg3nBsym/LyVTXdQfJK114WZpsPu0=;
        b=N3oV30K8+988AHdBL7SN/HNENOJhmbWj4MlEeAAKly8BAJ+u3B5zfWRZApq7GNCGLR
         WlHsiWulfVOgaNP/PdLHgOdfE8lEkZzBYLXlcFSMlxZDTlzzXKdk/D5etuGPANZICYLU
         NytIondvWnjg/NotQZt3Yj6WNfQtgtxN+V7zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZKjxU9gQt0a36rkg3nBsym/LyVTXdQfJK114WZpsPu0=;
        b=j8m+HP5d7eOu3P6PEwfXJVz/8Fty2B2S60cZQHT1x2we0VdtI0qBSRDlG0vod0n6Xg
         AxSNG399HyYhys8EZrNzpr07MG3rdf3OCB8p6E81M76D73HTD1pjlnqGLBRQBZngbkIE
         HZNZkr3yhZ1h62GYPjNvyspxqiZw/P9rHw0iUyf9bKEayMjahKJv4EqeIV7ZDNY/NRtz
         Xmdkw8PIz1iJp5r+Err2ZjInfzOK0FDtUhTvFUIZUS/jpLHjX9UQ8xkTKpaz5pynyCMz
         9CLfLxIlWLDiSCk+w//sqxPIVin8iCRHbOA9mowB11X3C3WiW8S8zu7rhUkIHqEjPHeX
         khpw==
X-Gm-Message-State: ALoCoQk/mKx7RCVz3MTuK3u2Xko+1zNaOAqcj3Kfxgj2Q4/5wsVXsDU35lr5sljodMT8vN/OObjt
X-Received: by 10.182.39.194 with SMTP id r2mr15584092obk.20.1440288690609;
 Sat, 22 Aug 2015 17:11:30 -0700 (PDT)
Received: by 10.60.162.5 with HTTP; Sat, 22 Aug 2015 17:11:30 -0700 (PDT)
In-Reply-To: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276399>

Lars - thanks for persisting with this!

I'm still trying to fully understand what's going on here - can you
point out where I've got it wrong below please!

The server is on Linux, and is case-sensitive. For whatever reason
(probably people committing changes on Windows in the first place)
we've ended up with a P4 repo that has differences in path case that
need to be ignored, with all upper-case paths being mapped to
lower-case.

e.g. the *real* depot might be:

//depot/path/File1
//depot/PATH/File2

git-p4 clone should return this case-folded on Windows (and Linux?)

$GIT_DIR/path/File1
$GIT_DIR/path/File2

(Am I right in thinking that this change folds the directory, but not
the filename?)

I don't really understand why a dictionary is required to do this
though - is there a reason we can't just lowercase all incoming paths?
Which is what the existing code in p4StartWith() is trying to do. That
code lowercases the *entire* path including the filename; this change
seems to leave the filename portion unchanged. I guess though that the
answer may be to do with your finding that P4 makes up the case of
directories based on lexicographic ordering - is that the basic
problem?

For a large repo, this approach is surely going to be really slow.

Additionally, could you update your patch to add some words to
Documentation/git-p4.txt please?

A few other comments inline.

Thanks!
Luke



On 21 August 2015 at 18:19,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> PROBLEM:
> We run P4 servers on Linux and P4 clients on Windows. For an unknown
> reason the file path for a number of files in P4 does not match the
> directory path with respect to case sensitivity.
>
> E.g. `p4 files` might return
> //depot/path/to/file1
> //depot/PATH/to/file2
>
> If you use P4/P4V then these files end up in the same directory, e.g.
> //depot/path/to/file1
> //depot/path/to/file2
>
> If you use git-p4 then all files not matching the correct file path
> (e.g. `file2`) will be ignored.

I'd like to think that the existing code that checks core.ignorecase
should handle this. I haven't tried it myself though.


>
> SOLUTION:
> Identify path names that are different with respect to case sensitivity.
> If there are any then run `p4 dirs` to build up a dictionary
> containing the "correct" cases for each path. It looks like P4
> interprets "correct" here as the existing path of the first file in a
> directory. The path dictionary is used later on to fix all paths.
>
> This is only applied if the parameter "--ignore-path-case" is passed to
> the git-p4 clone command.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  git-p4.py                         |  82 ++++++++++++++++++++++++++--
>  t/t9821-git-p4-path-variations.sh | 109 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 187 insertions(+), 4 deletions(-)
>  create mode 100755 t/t9821-git-p4-path-variations.sh
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..61a587b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1931,7 +1931,7 @@ class View(object):
>                  (self.client_prefix, clientFile))
>          return clientFile[len(self.client_prefix):]
>
> -    def update_client_spec_path_cache(self, files):
> +    def update_client_spec_path_cache(self, files, fixPathCase = None):
>          """ Caching file paths by "p4 where" batch query """
>
>          # List depot file paths exclude that already cached
> @@ -1950,6 +1950,8 @@ class View(object):
>              if "unmap" in res:
>                  # it will list all of them, but only one not unmap-ped
>                  continue
> +            if fixPathCase:
> +                res['depotFile'] = fixPathCase(res['depotFile'])
>              self.client_spec_path_cache[res['depotFile']] = self.convert_client_path(res["clientFile"])
>
>          # not found files or unmap files set to ""
> @@ -1987,6 +1989,7 @@ class P4Sync(Command, P4UserMap):
>                                       help="Maximum number of changes to import"),
>                  optparse.make_option("--changes-block-size", dest="changes_block_size", type="int",
>                                       help="Internal block size to use when iteratively calling p4 changes"),
> +                optparse.make_option("--ignore-path-case", dest="ignorePathCase", action="store_true"),
>                  optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
>                                       help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
>                  optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
> @@ -2017,6 +2020,7 @@ class P4Sync(Command, P4UserMap):
>          self.maxChanges = ""
>          self.changes_block_size = None
>          self.keepRepoPath = False
> +        self.ignorePathCase = False
>          self.depotPaths = None
>          self.p4BranchesInGit = []
>          self.cloneExclude = []
> @@ -2049,7 +2053,8 @@ class P4Sync(Command, P4UserMap):
>          files = []
>          fnum = 0
>          while commit.has_key("depotFile%s" % fnum):
> -            path =  commit["depotFile%s" % fnum]
> +            path = commit["depotFile%s" % fnum]
> +            path = self.fixPathCase(path)
>
>              if [p for p in self.cloneExclude
>                  if p4PathStartsWith(path, p)]:
> @@ -2113,7 +2118,9 @@ class P4Sync(Command, P4UserMap):
>          branches = {}
>          fnum = 0
>          while commit.has_key("depotFile%s" % fnum):
> -            path =  commit["depotFile%s" % fnum]
> +            path = commit["depotFile%s" % fnum]
> +            path = self.fixPathCase(path)
> +
>              found = [p for p in self.depotPaths
>                       if p4PathStartsWith(path, p)]
>              if not found:
> @@ -2240,6 +2247,10 @@ class P4Sync(Command, P4UserMap):
>              if marshalled["code"] == "error":
>                  if "data" in marshalled:
>                      err = marshalled["data"].rstrip()
> +
> +        if "depotFile" in marshalled:
> +            marshalled['depotFile'] = self.fixPathCase(marshalled['depotFile'])
> +
>          if err:
>              f = None
>              if self.stream_have_file_info:
> @@ -2314,6 +2325,7 @@ class P4Sync(Command, P4UserMap):
>
>              # do the last chunk
>              if self.stream_file.has_key('depotFile'):
> +                self.stream_file['depotFile'] = self.fixPathCase(self.stream_file['depotFile'])
>                  self.streamOneP4File(self.stream_file, self.stream_contents)
>
>      def make_email(self, userid):
> @@ -2371,7 +2383,8 @@ class P4Sync(Command, P4UserMap):
>                  sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
>
>          if self.clientSpecDirs:
> -            self.clientSpecDirs.update_client_spec_path_cache(files)
> +            self.clientSpecDirs.update_client_spec_path_cache(
> +                files, lambda x: self.fixPathCase(x))
>
>          self.gitStream.write("commit %s\n" % branch)
>  #        gitStream.write("mark :%s\n" % details["change"])
> @@ -2835,6 +2848,62 @@ class P4Sync(Command, P4UserMap):
>              print "IO error with git fast-import. Is your git version recent enough?"
>              print self.gitError.read()
>
> +    def fixPathCase(self, path):
> +        if self.caseCorrectedPaths:
> +            components = path.split('/')
> +            filename = components.pop()
> +            dirname = '/'.join(components).lower() + '/'
> +            if dirname in self.caseCorrectedPaths:
> +                path = self.caseCorrectedPaths[dirname] + filename
> +        return path
> +
> +    def generatePathCaseDict(self, clientPrefix):
> +        # Query all files and generate a list of all used paths
> +        # e.g. this files list:
> +        # //depot/path/to/file1
> +        # //depot/PATH/to/file2
> +        #
> +        # result in this path list:
> +        # //depot/
> +        # //depot/PATH/
> +        # //depot/path/
> +        # //depot/PATH/to/
> +        # //depot/path/to/
> +        p4_paths = set()
> +        for f in p4CmdList(["files", clientPrefix + "..."]):
> +            components = f["depotFile"].split('/')[0:-1]
> +            for i in range(3, len(components)+1):
> +                p4_paths.add('/'.join(components[0:i]) + '/')
> +        p4_paths = sorted(list(p4_paths), key=len)
> +
> +        if len(p4_paths) > len(set([p.lower() for p in p4_paths])):
> +            print "ATTENTION: File paths with different case variations detected. Fixing may take a while..."

Does this really need "ATTENTION" in the output?

> +            found_variations = True
> +            while found_variations:
> +                for path in p4_paths:
> +                    found_variations = False
> +                    path_variations = [p for p in p4_paths if p.lower() == path.lower()]
> +
> +                    if len(path_variations) > 1:
> +                        print  "%i different case variations for path '%s' detected." % (len(path_variations), path)
> +                        # If we detect path variations (e.g. //depot/path and //depot/PATH) then we query P4 to list
> +                        # the subdirectories of the parent (e.g //depot/*). P4 will return these subdirectories with
> +                        # the correct case.
> +                        parent_path = '/'.join(path.split('/')[0:-2])
> +                        case_ok_paths = [p["dir"] + '/' for p in p4CmdList(["dirs", "-D", parent_path + '/*'])]
> +
> +                        # Replace all known paths with the case corrected path from P4 dirs command
> +                        for case_ok_path in case_ok_paths:
> +                            pattern = re.compile("^" + re.escape(case_ok_path), re.IGNORECASE)
> +                            p4_paths = sorted(list(set([pattern.sub(case_ok_path, p) for p in p4_paths])), key=len)

Sorry, I don't quite get what this is doing.

We're generating a list of all of the files in the depot being cloned.
From that we get a set of all of the paths, sorted by length.
And then we seem to repeatedly rewrite that set with a new set where
each element has been replaced using a regular expression in a way
that I don't quite understand....

> +
> +                        found_variations = True
> +                        break
> +            return dict((p.lower(), p) for p in p4_paths)

... and then we just return a dictionary that maps every path to a
lowercase version of itself? So couldn't we have just blindly
lowercased all the paths in the first place?


> +        else:
> +            if self.verbose:
> +                print "All file paths have consistent case"
> +            return None
>
>      def run(self, args):
>          self.depotPaths = []
> @@ -3006,6 +3075,11 @@ class P4Sync(Command, P4UserMap):
>
>          self.depotPaths = newPaths
>
> +        if self.ignorePathCase and self.clientSpecDirs:
> +            self.caseCorrectedPaths = self.generatePathCaseDict(self.clientSpecDirs.client_prefix)
> +        else:
> +            self.caseCorrectedPaths = None
> +
>          # --detect-branches may change this for each branch
>          self.branchPrefixes = self.depotPaths
>
> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
> new file mode 100755
> index 0000000..90515a1
> --- /dev/null
> +++ b/t/t9821-git-p4-path-variations.sh
> @@ -0,0 +1,109 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories with path case variations'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d with case folding enabled' '
> +       start_p4d -C1
> +'
> +
> +test_expect_success 'Create a repo with path case variations' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +
> +               mkdir -p One/two &&
> +               >One/two/File2.txt &&
> +               p4 add One/two/File2.txt &&
> +               p4 submit -d "Add file2" &&
> +               rm -rf One &&
> +
> +               mkdir -p one/TWO &&
> +               >one/TWO/file1.txt &&
> +               p4 add one/TWO/file1.txt &&
> +               p4 submit -d "Add file1" &&
> +               rm -rf one &&
> +
> +               mkdir -p one/two &&
> +               >one/two/file3.txt &&
> +               p4 add one/two/file3.txt &&
> +               p4 submit -d "Add file3" &&
> +               rm -rf one &&
> +
> +               mkdir -p outside-spec &&
> +               >outside-spec/file4.txt &&
> +               p4 add outside-spec/file4.txt &&
> +               p4 submit -d "Add file4" &&
> +               rm -rf outside-spec
> +       )
> +'
> +
> +test_expect_success 'Clone the repo and WITHOUT path fixing' '

s/Clone the repo and/Clone the repo WITHOUT/



> +       client_view "//depot/One/... //client/..." &&
> +       git p4 clone --use-client-spec --destination="$git" //depot &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               # This method is used instead of "test -f" to ensure the case is
> +               # checked even if the test is executed on case-insensitive file systems.
> +               cat >expect <<-\EOF &&
> +                       two/File2.txt
> +               EOF
> +               git ls-files >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Clone the repo WITH path fixing' '
> +       client_view "//depot/One/... //client/..." &&
> +       git p4 clone --ignore-path-case --use-client-spec --destination="$git" //depot &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               cat >expect <<-\EOF &&
> +                       TWO/File2.txt
> +                       TWO/file1.txt
> +                       TWO/file3.txt
> +               EOF
> +               git ls-files >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +# It looks like P4 determines the path case based on the first file in
> +# lexicographical order. Please note the lower case "two" directory for all
> +# files triggered through the addition of "File0.txt".

If that's what P4 is doing, then it's *really* nasty!


> +test_expect_success 'Add a new file and clone the repo WITH path fixing' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +
> +               mkdir -p One/two &&
> +               >One/two/File0.txt &&
> +               p4 add One/two/File0.txt &&
> +               p4 submit -d "Add file" &&
> +               rm -rf One
> +       ) &&
> +
> +       client_view "//depot/One/... //client/..." &&
> +       git p4 clone --ignore-path-case --use-client-spec --destination="$git" //depot &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               cat >expect <<-\EOF &&
> +                       two/File0.txt
> +                       two/File2.txt
> +                       two/file1.txt
> +                       two/file3.txt
> +               EOF
> +               git ls-files >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 1.9.5 (Apple Git-50.3)
>
