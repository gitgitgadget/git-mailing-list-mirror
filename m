From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Sun, 30 Aug 2015 10:08:10 +0100
Message-ID: <CAE5ih7_yvzEgij9XEvoDnMMvkCeB77SUfnkf7=xr6r8eN6SCog@mail.gmail.com>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
	<1440764691-62254-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, technoweenie@github.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 11:08:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVybH-00022j-Hh
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 11:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbbH3JIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 05:08:13 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34774 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbbH3JIL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 05:08:11 -0400
Received: by oiex83 with SMTP id x83so50661166oie.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E3fd2Hj7lv4F9Jbip6b6WoKJT/pQBAU8EJ/OZWMzJm0=;
        b=WzCNmONrWo8PRzo+EujVAqahjMYkJywnDONsJJeqKBVWzp/UYYhIcHEig8tGm0oCpv
         1NqbVszWgztyUao8lsCzS/xMaaWM1NkCYCLkxKsiLiggIaxdEw6HNIaXLa1q4Ho67atC
         3TrO4BgmOnIsoD55b9eqRH72VJyqEM4UiWlNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=E3fd2Hj7lv4F9Jbip6b6WoKJT/pQBAU8EJ/OZWMzJm0=;
        b=Ayd17yh2RikAH3fFvDYXnO6uq/NQQaaHSh7psbvmrMUGjBRprfb3lYvfetfwTw2kzB
         mV8L0FZV2lU0aUiqWqj6nN+1QUOyO2KMbGk699do6UnKsgrQ7wVxeHxu13x/xq11C/je
         5oIbRIiJpJ4XBdlAryM2NgSAY6qMD9T+jQ1ZjVxEUzJVc1RDYEfso8YtLPQeR3F3Tyx+
         tMzrdCsW5qPdP3KBHuwdG2mfAVMP5BI8uMfN476QED7Yysu55FkmPTFl0RCwmqXOXfzX
         48RCA2fFCKnecz9BKW6FBowH187OUufFiwXwlXtmmq8Mq61Gq5cFSlR7XaAH8teXT7WV
         GTiQ==
X-Gm-Message-State: ALoCoQnU5FbPFVkYixc5LnlZamWV4alFzi58X/gDZ4smK1OQDMlR74xTiMIDN1GfvUDH4QowtHa3
X-Received: by 10.202.229.204 with SMTP id c195mr10055249oih.113.1440925690155;
 Sun, 30 Aug 2015 02:08:10 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Sun, 30 Aug 2015 02:08:10 -0700 (PDT)
In-Reply-To: <1440764691-62254-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276813>

Comments below.

>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..a188840 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -252,6 +252,18 @@ Git repository:
>         Use a client spec to find the list of interesting files in p4.
>         See the "CLIENT SPEC" section below.
>

<snip>

>
> +def mkdir_p(path):
> +    # Copied from http://stackoverflow.com/questions/600268/mkdir-p-functionality-in-python
> +    try:
> +        os.makedirs(path)
> +    except OSError as exc: # Python >2.5
> +        if exc.errno == errno.EEXIST and os.path.isdir(path):
> +            pass
> +        else:
> +            raise

Sigh. We need to upgrade to Python 3....

Coujld also just do:

   if not path.isdir(path) os.makedirs(path)

(Although there is a tiny race hazard if something else creates the
same path between isdir and makedir, but the way you're using it,
seems unlikely.

> +
>  def die(msg):
>      if verbose:
>          raise Exception(msg)
> @@ -1994,6 +2005,11 @@ class P4Sync(Command, P4UserMap):
>                  optparse.make_option("-/", dest="cloneExclude",
>                                       action="append", type="string",
>                                       help="exclude depot path"),
> +                optparse.make_option("--use-lfs-if-size-exceeds", dest="lfsMinimumFileSize", type="int",
> +                                     help="Use LFS to store files bigger than the given threshold in bytes."),
> +                optparse.make_option("--use-lfs-for-extension", dest="lfsFileExtensions",
> +                                     action="append", type="string",
> +                                     help="Use LFS to store files with the given file extension(s)."),
>          ]
>          self.description = """Imports from Perforce into a git repository.\n
>      example:
> @@ -2025,6 +2041,9 @@ class P4Sync(Command, P4UserMap):
>          self.clientSpecDirs = None
>          self.tempBranches = []
>          self.tempBranchLocation = "git-p4-tmp"
> +        self.lfsFiles = []
> +        self.lfsMinimumFileSize = None
> +        self.lfsFileExtensions = []
>
>          if gitConfig("git-p4.syncFromOrigin") == "false":
>              self.syncWithOrigin = False
> @@ -2145,6 +2164,63 @@ class P4Sync(Command, P4UserMap):
>
>          return branches
>
> +    def writeToGitStream(self, gitMode, relPath, contents):
> +        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
> +        self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
> +        for d in contents:
> +            self.gitStream.write(d)
> +        self.gitStream.write('\n')
> +
> +    def writeGitAttributesToStream(self):
> +        gitAttributes = [f + ' filter=lfs -text\n' for f in self.lfsFiles if not self.hasFileLFSExtension(f)]
> +        self.writeToGitStream(
> +            '100644',
> +            '.gitattributes',
> +            ['*.' + f + ' filter=lfs -text\n' for f in self.lfsFileExtensions] +
> +            [f + ' filter=lfs -text\n' for f in self.lfsFiles if not self.hasFileLFSExtension(f)]
> +        )
> +
> +    def hasFileLFSExtension(self, relPath):
> +        return reduce(
> +            lambda a, b: a or b,
> +            [relPath.endswith('.' + e) for e in self.lfsFileExtensions],
> +            False
> +        )
> +
> +    def isFileLargerThanLFSTreshold(self, relPath, contents):
> +        return self.lfsMinimumFileSize and sum(len(d) for d in contents) >= self.lfsMinimumFileSize

Could have a command-line option "--try-compress-first" (or some such)
which compresses the file, and it it's very compressible, leaves it
alone. It would trade speed of cloning with not-using-LFS-needlessly.

> +
> +    def generateLFSPointerFile(self, relPath, contents):
> +        # Write P4 content to temp file
> +        p4ContentTempFile = tempfile.NamedTemporaryFile(prefix='git-lfs', delete=False)
> +        for d in contents:
> +            p4ContentTempFile.write(d)
> +        p4ContentTempFile.flush()
> +
> +        # Generate LFS pointer file based on P4 content
> +        lfsProcess = subprocess.Popen(
> +            ['git', 'lfs', 'pointer', '--file=' + p4ContentTempFile.name],
> +            stdout=subprocess.PIPE
> +        )
> +        lfsPointerFile = lfsProcess.stdout.read()
> +        if lfsProcess.wait():
> +            die('git-lfs command failed. Did you install the extension?')

We're going to leave the P4 content file lying around undeleted here;
is there any way to avoid that and cleanup nicely?

> +        contents = [i+'\n' for i in lfsPointerFile.split('\n')[2:][:-1]]
> +
> +        # Write P4 content to LFS
> +        oid = contents[1].split(' ')[1].split(':')[1][:-1]
> +        oidPath = os.path.join(self.cloneDestination, '.git', 'lfs', 'objects', oid[:2], oid[2:4])
> +        mkdir_p(oidPath)
> +        shutil.move(p4ContentTempFile.name, os.path.join(oidPath, oid))
> +
> +        # Update Git attributes
> +        self.lfsFiles.append(relPath)
> +        self.writeGitAttributesToStream()
> +
> +        # LFS Spec states that pointer files should not have the executable bit set.
> +        gitMode = '100644'
> +        return (gitMode, contents)
> +
>      # output one file from the P4 stream
>      # - helper for streamP4Files
>
> @@ -2213,17 +2289,13 @@ class P4Sync(Command, P4UserMap):
>              text = regexp.sub(r'$\1$', text)
>              contents = [ text ]
>
> -        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
> +        if relPath == '.gitattributes':
> +            die('.gitattributes already exists in P4.')
>
> -        # total length...
> -        length = 0
> -        for d in contents:
> -            length = length + len(d)
> +        if self.isFileLargerThanLFSTreshold(relPath, contents) or self.hasFileLFSExtension(relPath):

s/Treshold/Threshold/g


> +            (git_mode, contents) = self.generateLFSPointerFile(relPath, contents)
>
> -        self.gitStream.write("data %d\n" % length)
> -        for d in contents:
> -            self.gitStream.write(d)
> -        self.gitStream.write("\n")
> +        self.writeToGitStream(git_mode, relPath, contents)
>
>      def streamOneP4Deletion(self, file):
>          relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
> @@ -2231,6 +2303,10 @@ class P4Sync(Command, P4UserMap):
>              sys.stderr.write("delete %s\n" % relPath)
>          self.gitStream.write("D %s\n" % relPath)
>
> +        if relPath in self.lfsFiles:
> +            self.lfsFiles.remove(relPath)
> +            self.writeGitAttributesToStream()
> +
>      # handle another chunk of streaming data
>      def streamP4FilesCb(self, marshalled):
>
> diff --git a/t/t9822-git-p4-lfs.sh b/t/t9822-git-p4-lfs.sh
> new file mode 100755
> index 0000000..b27bf29
> --- /dev/null
> +++ b/t/t9822-git-p4-lfs.sh
> @@ -0,0 +1,277 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories and store files in LFS'
> +
> +( git lfs help ) >/dev/null 2>&1 || {

Does this need to be in a subshell?

> +       skip_all='skipping git p4 LFS tests; no git lfs'
> +       test_done
> +}
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'Create repo with binary files' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +               echo "text" >file.txt &&
> +               echo "bin 13 bytes" >file.dat &&
> +               p4 add file.txt &&
> +               p4 add file.dat &&
> +               p4 submit -d "Add text and binary file" &&
> +               echo "bin 13 bytes" >file2.bin &&
> +               p4 add file2.bin &&
> +               p4 submit -d "Add another binary file with same content"
> +               echo "bin 14 bytess" >file3.bin &&
> +               p4 add file3.bin &&
> +               p4 submit -d "Add another binary file with different content"
> +       )
> +'
> +
> +test_expect_success 'Store files in LFS based on size (10 bytes)' '
> +       client_view "//depot/... //client/..." &&
> +       git p4 clone --use-client-spec --use-lfs-if-size-exceeds=10 --destination="$git" //depot@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +
> +               cat >expect <<-\EOF &&
> +               .git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               .git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff

This feels like it could be very fragile. Every time a new file gets
added to the tests we'll end up having to mess around with SHA1
digests. Surely all we care about is that LFS can recreate the files
we gave it originally?

Plus it makes it quite hard to understand what's going on!

> +               EOF
> +               find ".git/lfs/objects" -type f >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               size 13
> +               EOF
> +               cat file.dat >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               size 13
> +               EOF
> +               cat file2.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
> +               size 14
> +               EOF
> +               cat file3.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               file.dat filter=lfs -text
> +               file2.bin filter=lfs -text
> +               file3.bin filter=lfs -text
> +               EOF
> +               cat .gitattributes >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Store files in LFS based on size (14 bytes)' '
> +       client_view "//depot/... //client/..." &&
> +       git p4 clone --use-client-spec --use-lfs-if-size-exceeds=14 --destination="$git" //depot@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +
> +               cat >expect <<-\EOF &&
> +               .git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
> +               EOF
> +               find ".git/lfs/objects" -type f >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               bin 13 bytes
> +               EOF
> +               cat file.dat >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               bin 13 bytes
> +               EOF
> +               cat file2.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
> +               size 14
> +               EOF
> +               cat file3.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               file3.bin filter=lfs -text
> +               EOF
> +               cat .gitattributes >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Store files in LFS based on extension (dat)' '
> +       client_view "//depot/... //client/..." &&
> +       git p4 clone --use-client-spec --use-lfs-for-extension=dat --destination="$git" //depot@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +
> +               cat >expect <<-\EOF &&
> +               .git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               EOF
> +               find ".git/lfs/objects" -type f >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               size 13
> +               EOF
> +               cat file.dat >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               bin 13 bytes
> +               EOF
> +               cat file2.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               bin 14 bytess
> +               EOF
> +               cat file3.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               *.dat filter=lfs -text
> +               EOF
> +               cat .gitattributes >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Store files in LFS based on size (14 bytes) and extension (dat)' '
> +       client_view "//depot/... //client/..." &&
> +       git p4 clone \
> +               --use-client-spec \
> +               --use-lfs-if-size-exceeds=14 \
> +               --use-lfs-for-extension=dat \
> +               --destination="$git" //depot@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +
> +               cat >expect <<-\EOF &&
> +               .git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               .git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
> +               EOF
> +               find ".git/lfs/objects" -type f >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               size 13
> +               EOF
> +               cat file.dat >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               bin 13 bytes
> +               EOF
> +               cat file2.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
> +               size 14
> +               EOF
> +               cat file3.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               *.dat filter=lfs -text
> +               file3.bin filter=lfs -text
> +               EOF
> +               cat .gitattributes >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Remove file from repo and store files in LFS based on size (10 bytes)' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +               p4 delete file3.bin &&
> +               p4 submit -d "Remove file"
> +       ) &&
> +
> +       git p4 clone --use-client-spec --use-lfs-if-size-exceeds=10 --destination="$git" //depot@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +
> +               # Note that file3 remains here as it referenced in the history
> +               cat >expect <<-\EOF &&
> +               .git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               .git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
> +               EOF
> +               find ".git/lfs/objects" -type f >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               size 13
> +               EOF
> +               cat file.dat >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               version https://git-lfs.github.com/spec/v1
> +               oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
> +               size 13
> +               EOF
> +               cat file2.bin >actual &&
> +               test_cmp expect actual &&
> +
> +               cat >expect <<-\EOF &&
> +               file.dat filter=lfs -text
> +               file2.bin filter=lfs -text
> +               EOF
> +               cat .gitattributes >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Clone repo with existing .gitattributes file' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +
> +               echo "*.txt text" >.gitattributes &&
> +               p4 add .gitattributes &&
> +               p4 submit -d "Add .gitattributes"
> +       ) &&
> +
> +       test_must_fail git p4 clone --use-client-spec --destination="$git" //depot 2>errs &&
> +       grep ".gitattributes already exists in P4." errs
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
