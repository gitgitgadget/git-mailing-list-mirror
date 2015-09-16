From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 6/7] git-p4: add support for large file systems
Date: Wed, 16 Sep 2015 14:05:40 +0200
Message-ID: <5329966D-1A0C-42A1-9099-AC449D50AA52@gmail.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com> <1442237194-49624-7-git-send-email-larsxschneider@gmail.com> <55F92A1E.1090002@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 14:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcBTC-0007tg-G7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 14:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbbIPMFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2015 08:05:45 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38683 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbIPMFo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2015 08:05:44 -0400
Received: by wiclk2 with SMTP id lk2so67605762wic.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nlMq5nKkQEsS8mHye2qewroRQ9FiAD0TE4V8mOTWefM=;
        b=QXV6R4cN9lk5WBkhzIubxBGch5QRNtLFIJxZk52tLNzTmuWvmTROIeWBWi2f0nqdkX
         QYoL6YpZQN7rBglm1MN0ISmce/u6DDZTU0oqPepEIj3mXSPcfIfffMk6ysEcKYQMplKY
         onw2Ucdu7xoTib4/F51nJN/bFXuiLuoBrETQVRg4cbiqh2CqWAx0G7KDHGA7rr3Y4FY3
         sv876kAREAI9/HGbA5qRpRWv6OkBQPVeQNDYf86VWU39M3f82PN57PO8cb+HGyJUAY7I
         VTjIn6t7aWzh7snaRfOsmg61hVy2AJALLDIcJu3WuruwFtZpj0SAB6mXCFM1AW5xJeuY
         JP/w==
X-Received: by 10.180.109.135 with SMTP id hs7mr18884173wib.12.1442405142642;
        Wed, 16 Sep 2015 05:05:42 -0700 (PDT)
Received: from [10.146.248.71] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id jc9sm4189700wic.6.2015.09.16.05.05.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 05:05:42 -0700 (PDT)
In-Reply-To: <55F92A1E.1090002@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278024>


On 16 Sep 2015, at 10:36, Luke Diamand <luke@diamand.org> wrote:

> On 14/09/15 14:26, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Perforce repositories can contain large (binary) files. Migrating th=
ese
>> repositories to Git generates very large local clones. External stor=
age
>> systems such as Git LFS [1], Git Fat [2], Git Media [3], git-annex [=
4]
>> try to address this problem.
>>=20
>> Add a generic mechanism to detect large files based on extension,
>> uncompressed size, and/or compressed size.
>=20
> Looks excellent! I've got a small few comments (below) and I need to =
come back and have another look through if that's OK.
Sure! Thank you :-)

>=20
> Thanks!
> Luke
>=20
>>=20
>> [1] https://git-lfs.github.com/
>> [2] https://github.com/jedbrown/git-fat
>> [3] https://github.com/alebedev/git-media
>> [4] https://git-annex.branchable.com/
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  Documentation/git-p4.txt   |  32 +++++++++++
>>  git-p4.py                  | 139 ++++++++++++++++++++++++++++++++++=
+++++++----
>>  t/t9823-git-p4-mock-lfs.sh |  96 +++++++++++++++++++++++++++++++
>>  3 files changed, 257 insertions(+), 10 deletions(-)
>>  create mode 100755 t/t9823-git-p4-mock-lfs.sh
>>=20
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index 82aa5d6..3f21e95 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -510,6 +510,38 @@ git-p4.useClientSpec::
>>  	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
>>  	This variable is a boolean, not the name of a p4 client.
>>=20
>> +git-p4.largeFileSystem::
>> +	Specify the system that is used for large (binary) files. Please n=
ote
>> +	that large file systems do not support the 'git p4 submit' command=
=2E
>=20
> Why is that? Is it just that you haven't implemented support, or is i=
t fundamentally impossible?

If we detect LFS files only by file extension then we could make it wor=
k. But then we must not use any git-p4 settings. We would need to rely =
only on the =93.gitattributes=94 file that is stored in the P4 reposito=
ry. My implementation also looks at the file size and decides on a indi=
vidual file basis if a file is stored in LFS. That means all clients ne=
ed the same file size threshold.=20

Junio explained the problem in the v4 thread:
> How is collaboration between those who talk to the same p4 depot
> backed by GitHub LFS expected to work?  You use config to set size
> limits and list of file extensions in your repository, and grab new
> changes from p4 and turn them into Git commits (with pointers to LFS
> and the .gitattributes file that records your choice of the config).
> I as a new member to the same project come, clone the resulting Git
> repository from you and then what do I do before talking to the same
> p4 depot to further update the Git history?  Are the values recorded
> in .gitattributes (which essentially were derived from your
> configuration) somehow reflected back automatically to my config so
> that our world view would become consistent?  Perhaps you added
> 'iso' to largeFileExtensions before I cloned from you, and that
> would be present in the copy of .gitattributes I obtained from you.
> I may be trying to add a new ".iso" file, and I presume that an
> existing .gitattributes entry you created based on the file
> extension automatically covers it from the LFS side, but does my
> "git p4 submit" also know what to do, or would it be broken until I
> add a set of configrations that matches yours?
=20


>=20
>> +	Only Git LFS [1] is implemented right now. Download
>> +	and install the Git LFS command line extension to use this option
>> +	and configure it like this:
>> ++
>> +-------------
>> +git config       git-p4.largeFileSystem GitLFS
>> +-------------
>> ++
>> +	[1] https://git-lfs.github.com/
>> +
>> +git-p4.largeFileExtensions::
>> +	All files matching a file extension in the list will be processed
>> +	by the large file system. Do not prefix the extensions with '.'.
>> +
>> +git-p4.largeFileThreshold::
>> +	All files with an uncompressed size exceeding the threshold will b=
e
>> +	processed by the large file system. By default the threshold is
>> +	defined in bytes. Add the suffix k, m, or g to change the unit.
>> +
>> +git-p4.largeFileCompressedThreshold::
>> +	All files with a compressed size exceeding the threshold will be
>> +	processed by the large file system. This option might slow down
>> +	your clone/sync process. By default the threshold is defined in
>> +	bytes. Add the suffix k, m, or g to change the unit.
>> +
>> +git-p4.pushLargeFiles::
>> +	Boolean variable which defines if large files are automatically
>> +	pushed to a server.
>> +
>>  Submit variables
>>  ~~~~~~~~~~~~~~~~
>>  git-p4.detectRenames::
>> diff --git a/git-p4.py b/git-p4.py
>> index b465356..bfe71b5 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -22,6 +22,8 @@ import platform
>>  import re
>>  import shutil
>>  import stat
>> +import zipfile
>> +import zlib
>>=20
>>  try:
>>      from subprocess import CalledProcessError
>> @@ -932,6 +934,111 @@ def wildcard_present(path):
>>      m =3D re.search("[*#@%]", path)
>>      return m is not None
>>=20
>> +class LargeFileSystem(object):
>> +    """Base class for large file system support."""
>> +
>> +    def __init__(self, writeToGitStream):
>> +        self.largeFiles =3D set()
>> +        self.writeToGitStream =3D writeToGitStream
>> +
>> +    def generatePointer(self, cloneDestination, contentFile):
>> +        """Return the content of a pointer file that is stored in G=
it instead of
>> +           the actual content."""
>> +        assert False, "Method 'generatePointer' required in " + sel=
f.__class__.__name__
>> +
>> +    def pushFile(self, localLargeFile):
>> +        """Push the actual content which is not stored in the Git r=
epository to
>> +           a server."""
>> +        assert False, "Method 'pushFile' required in " + self.__cla=
ss__.__name__
>> +
>> +    def hasLargeFileExtension(self, relPath):
>> +        return reduce(
>> +            lambda a, b: a or b,
>> +            [relPath.endswith('.' + e) for e in gitConfigList('git-=
p4.largeFileExtensions')],
>> +            False
>> +        )
>> +
>> +    def generateTempFile(self, contents):
>> +        contentFile =3D tempfile.NamedTemporaryFile(prefix=3D'git-p=
4-large-file', delete=3DFalse)
>> +        for d in contents:
>> +            contentFile.write(d)
>> +        contentFile.flush()
>> +        contentFile.close()
>=20
> close() should flush() automatically I would have thought.
Correct. SO thinks so, too https://stackoverflow.com/questions/2447143/=
does-close-imply-flush-in-python

>=20
>> +        return contentFile.name
>> +
>> +    def exceedsLargeFileThreshold(self, relPath, contents):
>> +        if gitConfigInt('git-p4.largeFileThreshold'):
>> +            contentsSize =3D sum(len(d) for d in contents)
>> +            if contentsSize > gitConfigInt('git-p4.largeFileThresho=
ld'):
>> +                return True
>> +        if gitConfigInt('git-p4.largeFileCompressedThreshold'):
>> +            contentsSize =3D sum(len(d) for d in contents)
>> +            if contentsSize <=3D gitConfigInt('git-p4.largeFileComp=
ressedThreshold'):
>> +                return False
>> +            contentTempFile =3D self.generateTempFile(contents)
>> +            compressedContentFile =3D tempfile.NamedTemporaryFile(p=
refix=3D'git-p4-large-file', delete=3DFalse)
>> +            zf =3D zipfile.ZipFile(compressedContentFile.name, mode=
=3D'w')
>> +            zf.write(contentTempFile, compress_type=3Dzipfile.ZIP_D=
EFLATED)
>> +            zf.close()
>> +            compressedContentsSize =3D zf.infolist()[0].compress_si=
ze
>> +            os.remove(contentTempFile)
>> +            os.remove(compressedContentFile.name)
>> +            if compressedContentsSize > gitConfigInt('git-p4.largeF=
ileCompressedThreshold'):
>> +                return True
>> +        return False
>> +
>> +    def addLargeFile(self, relPath):
>> +        self.largeFiles.add(relPath)
>> +
>> +    def removeLargeFile(self, relPath):
>> +        self.largeFiles.remove(relPath)
>> +
>> +    def isLargeFile(self, relPath):
>> +        return relPath in self.largeFiles
>> +
>> +    def processContent(self, cloneDestination, git_mode, relPath, c=
ontents):
>> +        """Processes the content of git fast import. This method de=
cides if a
>> +           file is stored in the large file system and handles all =
necessary
>> +           steps."""
>> +        if self.exceedsLargeFileThreshold(relPath, contents) or sel=
f.hasLargeFileExtension(relPath):
>> +            contentTempFile =3D self.generateTempFile(contents)
>> +            (git_mode, contents, localLargeFile) =3D self.generateP=
ointer(cloneDestination, contentTempFile)
>> +
>> +            # Move temp file to final location in large file system
>> +            largeFileDir =3D os.path.dirname(localLargeFile)
>> +            if not os.path.isdir(largeFileDir):
>> +                os.makedirs(largeFileDir)
>> +            shutil.move(contentTempFile, localLargeFile)
>> +            self.addLargeFile(relPath)
>> +            if gitConfigBool('git-p4.pushLargeFiles'):
>> +                self.pushFile(localLargeFile)
>> +            if verbose:
>> +                sys.stderr.write("%s moved to large file system (%s=
)\n" % (relPath, localLargeFile))
>> +        return (git_mode, contents)
>> +
>> +class MockLFS(LargeFileSystem):
>> +    """Mock large file system for testing."""
>> +
>> +    def generatePointer(self, cloneDestination, contentFile):
>> +        """The pointer content is the original content prefixed wit=
h "pointer-".
>> +           The local filename of the large file storage is derived =
from the file content.
>> +           """
>> +        with open(contentFile, 'r') as f:
>> +            content =3D next(f)
>> +            gitMode =3D '100644'
>> +            pointerContents =3D 'pointer-' + content
>> +            localLargeFile =3D os.path.join(cloneDestination, '.git=
', 'mock-storage', 'local', content[:-1])
>> +            return (gitMode, pointerContents, localLargeFile)
>> +
>> +    def pushFile(self, localLargeFile):
>> +        """The remote filename of the large file storage is the sam=
e as the local
>> +           one but in a different directory.
>> +           """
>> +        remotePath =3D os.path.join(os.path.dirname(localLargeFile)=
, '..', 'remote')
>> +        if not os.path.exists(remotePath):
>> +            os.makedirs(remotePath)
>> +        shutil.copyfile(localLargeFile, os.path.join(remotePath, os=
=2Epath.basename(localLargeFile)))
>> +
>>  class Command:
>>      def __init__(self):
>>          self.usage =3D "usage: %prog [options]"
>> @@ -1105,6 +1212,9 @@ class P4Submit(Command, P4UserMap):
>>          self.p4HasMoveCommand =3D p4_has_move_command()
>>          self.branch =3D None
>>=20
>> +        if gitConfig('git-p4.largeFileSystem'):
>> +            die("Large file system not supported for git-p4 submit =
command. Please remove it from config.")
>> +
>>      def check(self):
>>          if len(p4CmdList("opened ...")) > 0:
>>              die("You have files opened with perforce! Close them be=
fore starting the sync.")
>> @@ -2057,6 +2167,12 @@ class P4Sync(Command, P4UserMap):
>>                  lambda git_mode, relPath, contents: self.writeToGit=
Stream(git_mode, relPath, contents)
>>              )
>>=20
>> +        if gitConfig('git-p4.largeFileSystem'):
>> +            largeFileSystemConstructor =3D globals()[gitConfig('git=
-p4.largeFileSystem')]
>> +            self.largeFileSystem =3D largeFileSystemConstructor(
>> +                lambda git_mode, relPath, contents: self.writeToGit=
Stream(git_mode, relPath, contents)
>> +            )
>> +
>>          if gitConfig("git-p4.syncFromOrigin") =3D=3D "false":
>>              self.syncWithOrigin =3D False
>>=20
>> @@ -2176,6 +2292,13 @@ class P4Sync(Command, P4UserMap):
>>=20
>>          return branches
>>=20
>> +    def writeToGitStream(self, gitMode, relPath, contents):
>> +        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath=
))
>> +        self.gitStream.write('data %d\n' % sum(len(d) for d in cont=
ents))
>> +        for d in contents:
>> +            self.gitStream.write(d)
>> +        self.gitStream.write('\n')
>> +
>>      # output one file from the P4 stream
>>      # - helper for streamP4Files
>>=20
>> @@ -2246,17 +2369,10 @@ class P4Sync(Command, P4UserMap):
>>              text =3D regexp.sub(r'$\1$', text)
>>              contents =3D [ text ]
>>=20
>> -        self.gitStream.write("M %s inline %s\n" % (git_mode, relPat=
h))
>> +        if self.largeFileSystem:
>> +            (git_mode, contents) =3D self.largeFileSystem.processCo=
ntent(self.cloneDestination, git_mode, relPath, contents)
>>=20
>> -        # total length...
>> -        length =3D 0
>> -        for d in contents:
>> -            length =3D length + len(d)
>> -
>> -        self.gitStream.write("data %d\n" % length)
>> -        for d in contents:
>> -            self.gitStream.write(d)
>> -        self.gitStream.write("\n")
>> +        self.writeToGitStream(git_mode, relPath, contents)
>>=20
>>      def streamOneP4Deletion(self, file):
>>          relPath =3D self.stripRepoPath(file['path'], self.branchPre=
fixes)
>> @@ -2265,6 +2381,9 @@ class P4Sync(Command, P4UserMap):
>>              sys.stdout.flush()
>>          self.gitStream.write("D %s\n" % relPath)
>>=20
>> +        if self.largeFileSystem and self.largeFileSystem.isLargeFil=
e(relPath):
>> +            self.largeFileSystem.removeLargeFile(relPath)
>> +
>>      # handle another chunk of streaming data
>>      def streamP4FilesCb(self, marshalled):
>>=20
>> diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
>> new file mode 100755
>> index 0000000..8582857
>> --- /dev/null
>> +++ b/t/t9823-git-p4-mock-lfs.sh
>> @@ -0,0 +1,96 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'Clone repositories and store files in Mock LFS'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_file_in_mock () {
>> +	FILE=3D"$1"
> Missing &&
> Plus the next few lines
Are they strictly necessary? I believe you can define variables all in =
=93one line=94. I found it like that in existing tests:
https://github.com/git/git/blob/f4d9753a89bf04011c00e943d85211906e86a0f=
6/t/t9402-git-cvsserver-refs.sh#L18-L20

Nevertheless I will add them in the next role!

>=20
>> +	CONTENT=3D"$2"
>> +	LOCAL_STORAGE=3D".git/mock-storage/local/$CONTENT"
>> +	SERVER_STORAGE=3D".git/mock-storage/remote/$CONTENT"
>> +	echo "pointer-$CONTENT" >expect_pointer
>> +	echo "$CONTENT" >expect_content
>> +	test_path_is_file "$FILE" &&
>> +	test_path_is_file "$LOCAL_STORAGE" &&
>> +	test_path_is_file "$SERVER_STORAGE" &&
>> +	test_cmp expect_pointer "$FILE" &&
>> +	test_cmp expect_content "$LOCAL_STORAGE" &&
>> +	test_cmp expect_content "$SERVER_STORAGE"
>> +}
>> +
>> +test_file_count_in_dir () {
>> +	DIR=3D"$1"
>> +	EXPECTED_COUNT=3D"$2"
>> +	find "$DIR" -type f >actual
>> +	test_line_count =3D $EXPECTED_COUNT actual
>> +}
>> +
>> +test_expect_success 'start p4d' '
>> +	start_p4d
>> +'
>> +
>> +test_expect_success 'Create repo with binary files' '
>> +	client_view "//depot/... //client/..." &&
>> +	(
>> +		cd "$cli" &&
>> +
>> +		echo "content 1 txt 23 bytes" >file1.txt &&
>> +		p4 add file1.txt &&
>> +		echo "content 2-3 bin 25 bytes" >file2.dat &&
>> +		p4 add file2.dat &&
>> +		p4 submit -d "Add text and binary file" &&
>> +
>> +		mkdir "path with spaces" &&
>> +		echo "content 2-3 bin 25 bytes" >"path with spaces/file3.bin" &&
>=20
> Nice putting spaces in the path!
I stumbled across this case in a production migration :-)

>=20
>> +		p4 add "path with spaces/file3.bin" &&
>> +		p4 submit -d "Add another binary file with same content and space=
s in path" &&
>> +
>> +		echo "content 4 bin 26 bytes XX" >file4.bin &&
>> +		p4 add file4.bin &&
>> +		p4 submit -d "Add another binary file with different content"
>> +	)
>> +'
>> +
>> +test_expect_success 'Store files in Mock based on size (>24 bytes)'=
 '
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.useClientSpec true &&
>> +		git config git-p4.largeFileSystem MockLFS &&
>> +		git config git-p4.largeFileThreshold 24 &&
>> +		git config git-p4.pushLargeFiles True &&
>> +		git p4 clone --destination=3D"$git" //depot@all &&
>> +
>> +		test_file_in_mock file2.dat "content 2-3 bin 25 bytes" &&
>> +		test_file_in_mock "path with spaces/file3.bin" "content 2-3 bin 2=
5 bytes" &&
>> +		test_file_in_mock file4.bin "content 4 bin 26 bytes XX" &&
>> +
>> +		test_file_count_in_dir ".git/mock-storage/local" 2 &&
>> +		test_file_count_in_dir ".git/mock-storage/remote" 2
>> +	)
>> +'
>> +
>> +test_expect_success 'Run git p4 submit in repo configured with larg=
e file system' '
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.useClientSpec true &&
>> +		git config git-p4.largeFileSystem MockLFS &&
>> +		git config git-p4.largeFileThreshold 24 &&
>> +		git config git-p4.pushLargeFiles True &&
>> +		git p4 clone --destination=3D"$git" //depot@all &&
>> +
>> +		test_must_fail git p4 submit
>=20
> No test for deletion, does that matter?
OK, I will add one in the mock, too. I have a test for that in the =93t=
9828-git-p4-lfs.sh=94 named =93Remove file from repo and store files in=
 LFS based on size (>24 bytes)=94.

Thanks,
Lars