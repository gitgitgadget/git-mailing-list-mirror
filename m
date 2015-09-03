From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 4/4] git-p4: add support for large file systems
Date: Thu, 3 Sep 2015 22:49:36 +0200
Message-ID: <6D21B562-6527-480F-9E8B-39F7574C3A2D@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-5-git-send-email-larsxschneider@gmail.com> <55E8A7A7.9010401@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, peff@peff.net
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:49:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXbS4-0001Aw-FZ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbbICUtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 16:49:40 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37275 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbbICUtk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 16:49:40 -0400
Received: by wicfx3 with SMTP id fx3so1539498wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e/oNM/VxJyfaMz4RpgN4QS1vnyyzf78Vt2rue8c1Y40=;
        b=rFlBmyC0cwm2xULRqBAkz2I02yBlf02ofTLWJeBbU59QyeA0Es/QZPii8FjevjMS2R
         +K73xOdiDC2kG3ag0/Anmjt/WbRX05HVwMy9iLCK6QYo3g0YLKp62jHxpV+TihIA8BqK
         vQ6EH905sbYtE9jx7+Dkk/6RUvxLAaLoWCpUCBJbRvk3MGNQ02ZJ4fWrdQJf2WlvcMLk
         nf0zfg8RTnbueDJTDAHI80eIq1fwdNYqJkVf2X4YkF/RnAe5LvkE99pteIgiSfd/aPSN
         LhCOz4nDTEi71tNe3toNPpqKzZtwnkyphV+RWyRd3BpnitVIWR++Uwezb+m1VEZRqAss
         3eiA==
X-Received: by 10.180.107.1 with SMTP id gy1mr82889wib.16.1441313378531;
        Thu, 03 Sep 2015 13:49:38 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-092-078-130-241.092.078.pools.vodafone-ip.de. [92.78.130.241])
        by smtp.gmail.com with ESMTPSA id ik8sm69132wjb.8.2015.09.03.13.49.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:49:38 -0700 (PDT)
In-Reply-To: <55E8A7A7.9010401@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277256>


On 03 Sep 2015, at 22:03, Luke Diamand <luke@diamand.org> wrote:

> On 03/09/15 17:35, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Perforce repositories can contain large (binary) files. Migrating th=
ese
>> repositories to Git generates very large local clones. External stor=
age
>> systems such as LFS [1] or git-annex [2] try to address this problem=
=2E
>>=20
>> Add a generic mechanism to detect large files based on extension,
>> uncompressed size, and/or compressed size. Add LFS as example
>> implementation.
>=20
> Can you split this into "add mechanism for large file support" and th=
en "add LFS implementation".
>=20
> It will make it easier to review if nothing else.
=46un fact: I had it that way first and then decided against it. I spli=
t it this way:

commit 1: generic impl + docs
commits 2: lfs impl + TC

OK?

>=20
> Some other comments inline.
>=20
> Thanks!
> Luke
>=20
>>=20
>> [1] https://git-lfs.github.com/
>> [2] http://www.git-annex.org/
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  Documentation/git-p4.txt |  21 ++++
>>  git-p4.py                | 126 +++++++++++++++++++++--
>>  t/t9823-git-p4-lfs.sh    | 263 ++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  3 files changed, 401 insertions(+), 9 deletions(-)
>>  create mode 100755 t/t9823-git-p4-lfs.sh
>>=20
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index 82aa5d6..eac5bad 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -510,6 +510,27 @@ git-p4.useClientSpec::
>>  	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
>>  	This variable is a boolean, not the name of a p4 client.
>>=20
>> +git-p4.largeFileSystem::
>> +	Specify the system that is used used for large (binary) files. Onl=
y
>> +	"LFS" [1] is supported right now. Download and install the Git LFS
>> +	command line extension to use this option.
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
>> +	All files with an compressed size exceeding the threshold will be
>=20
> s/an compressed/a compressed/
ok

>=20
>> +	processed by the large file system. This option might significantl=
y
>> +	slow down your clone/sync process. By default the threshold is
>> +	defined in bytes. Add the suffix k, m, or g to change the unit.
>> +
>>  Submit variables
>>  ~~~~~~~~~~~~~~~~
>>  git-p4.detectRenames::
>> diff --git a/git-p4.py b/git-p4.py
>> index 4d78e1c..cde75a5 100755
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
>> @@ -922,6 +924,51 @@ def wildcard_present(path):
>>      m =3D re.search("[*#@%]", path)
>>      return m is not None
>>=20
>> +def largeFileSystem():
>> +    try:
>> +        return getattr(sys.modules[__name__], gitConfig('git-p4.lar=
geFileSystem'))
>> +    except AttributeError as e:
>> +        die('Large file system not supported: %s' % gitConfig('git-=
p4.largeFileSystem'))
>> +
>> +class LFS:
>=20
> Docstrings?
OK.

>=20
>=20
>> +    @staticmethod
>> +    def description():
>> +        return 'LFS (see https://git-lfs.github.com/)'
>> +
>> +    @staticmethod
>> +    def attributeFilter():
>> +        return 'lfs'
>> +
>> +    @staticmethod
>> +    def generatePointer(cloneDestination, relPath, contents):
>> +        # Write P4 content to temp file
>> +        p4ContentTempFile =3D tempfile.NamedTemporaryFile(prefix=3D=
'git-p4-large-file', delete=3DFalse)
>=20
> delete=3DFalse, doesn't that mean that if anything goes wrong, we lea=
ve large files lying around? Perhaps that doesn't matter, I don't know.
delete=3DTrue means the file is deleted as soon as it is closed
source: https://docs.python.org/2/library/tempfile.html
I don=92t close the file (sounds like a bug?!) so in theory delete=3DTr=
ue would work. However, I am moving the file a few lines below.

>=20
>> +        for d in contents:
>> +            p4ContentTempFile.write(d)
>> +        p4ContentTempFile.flush()
>=20
> These seems like behaviour that could live in the base class or the m=
ain git-p4 code. It doesn't look LFS-specific.
ok

>=20
>> +
>> +        # Generate LFS pointer file based on P4 content
>> +        lfsProcess =3D subprocess.Popen(
>> +            ['git', 'lfs', 'pointer', '--file=3D' + p4ContentTempFi=
le.name],
>> +            stdout=3Dsubprocess.PIPE
>> +        )
>> +        lfsPointerFile =3D lfsProcess.stdout.read()
>> +        if lfsProcess.wait():
>> +            os.remove(p4ContentTempFile.name)
>> +            die('git-lfs command failed. Did you install the extens=
ion?')
>> +        contents =3D [i+'\n' for i in lfsPointerFile.split('\n')[2:=
][:-1]]
>> +
>> +        # Write P4 content to LFS
>> +        oid =3D contents[1].split(' ')[1].split(':')[1][:-1]
>> +        oidPath =3D os.path.join(cloneDestination, '.git', 'lfs', '=
objects', oid[:2], oid[2:4])
>> +        if not os.path.isdir(oidPath):
>> +            os.makedirs(oidPath)
>> +        shutil.move(p4ContentTempFile.name, os.path.join(oidPath, o=
id))
>=20
> This also does not look LFS-specific.
ok

Thank you! One thing I missed to noticed in the commit message:
Right now the LFS uploads need to be executed manually. I will automate=
 this with git-p4 in v3.

Do you want to test this feature against a real backend? In that case y=
ou would need a LFS enabled GitHub account. If you don=92t have one, ma=
ybe _Jeff King_ can help?

Thanks,
Lars


>=20
>> +
>> +        # LFS Spec states that pointer files should not have the ex=
ecutable bit set.
>> +        gitMode =3D '100644'
>> +        return (gitMode, contents)
>> +
>>  class Command:
>>      def __init__(self):
>>          self.usage =3D "usage: %prog [options]"
>> @@ -2038,6 +2085,7 @@ class P4Sync(Command, P4UserMap):
>>          self.clientSpecDirs =3D None
>>          self.tempBranches =3D []
>>          self.tempBranchLocation =3D "git-p4-tmp"
>> +        self.largeFiles =3D []
>>=20
>>          if gitConfig("git-p4.syncFromOrigin") =3D=3D "false":
>>              self.syncWithOrigin =3D False
>> @@ -2158,6 +2206,59 @@ class P4Sync(Command, P4UserMap):
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
>> +    def writeGitAttributesToStream(self):
>> +        self.writeToGitStream(
>> +            '100644',
>> +            '.gitattributes',
>> +            [
>> +                '\n',
>> +                '#\n',
>> +                '# %s\n' % largeFileSystem().description(),
>> +                '#\n',
>> +            ] +
>> +            ['*.' + f.replace(' ', '[:space:]') + ' filter=3D%s -te=
xt\n' % largeFileSystem().attributeFilter()
>> +                for f in gitConfigList("git-p4.largeFileExtensions"=
)
>> +            ] +
>> +            ['/' + f.replace(' ', '[:space:]') + ' filter=3D%s -tex=
t\n' % largeFileSystem().attributeFilter()
>> +                for f in self.largeFiles if not self.hasLargeFileEx=
tension(f)
>> +            ]
>> +        )
>> +
>> +    def hasLargeFileExtension(self, relPath):
>> +        return reduce(
>> +            lambda a, b: a or b,
>> +            [relPath.endswith('.' + e) for e in gitConfigList('git-=
p4.largeFileExtensions')],
>> +            False
>> +        )
>> +
>> +    def exceedsLargeFileThreshold(self, relPath, contents):
>> +        if gitConfigInt('git-p4.largeFileThreshold'):
>> +            contentsSize =3D sum(len(d) for d in contents)
>> +            if contentsSize > gitConfigInt('git-p4.largeFileThresho=
ld'):
>> +                return True
>> +        if gitConfigInt('git-p4.largeFileCompressedThreshold'):
>> +            contentFile =3D tempfile.NamedTemporaryFile(prefix=3D'g=
it-p4-large-file', delete=3DFalse)
>> +            for d in contents:
>> +                contentFile.write(d)
>> +            contentFile.flush()
>> +            compressedContentFile =3D tempfile.NamedTemporaryFile(p=
refix=3D'git-p4-large-file', delete=3DFalse)
>> +            zf =3D zipfile.ZipFile(compressedContentFile.name, mode=
=3D'w')
>> +            zf.write(contentFile.name, compress_type=3Dzipfile.ZIP_=
DEFLATED)
>> +            zf.close()
>> +            compressedContentsSize =3D zf.infolist()[0].compress_si=
ze
>> +            os.remove(contentFile.name)
>> +            os.remove(compressedContentFile.name)
>> +            if compressedContentsSize > gitConfigInt('git-p4.largeF=
ileCompressedThreshold'):
>> +                return True
>> +        return False
>> +
>>      # output one file from the P4 stream
>>      # - helper for streamP4Files
>>=20
>> @@ -2226,17 +2327,20 @@ class P4Sync(Command, P4UserMap):
>>              text =3D regexp.sub(r'$\1$', text)
>>              contents =3D [ text ]
>>=20
>> -        self.gitStream.write("M %s inline %s\n" % (git_mode, relPat=
h))
>> +        if relPath =3D=3D '.gitattributes':
>> +            die('.gitattributes already exists in P4.')
>>=20
>> -        # total length...
>> -        length =3D 0
>> -        for d in contents:
>> -            length =3D length + len(d)
>> +        if (gitConfig('git-p4.largeFileSystem') and
>> +            (   self.exceedsLargeFileThreshold(relPath, contents) o=
r
>> +                self.hasLargeFileExtension(relPath)
>> +            )):
>> +            (git_mode, contents) =3D largeFileSystem().generatePoin=
ter(self.cloneDestination, relPath, contents)
>> +            self.largeFiles.append(relPath)
>> +            self.writeGitAttributesToStream()
>> +            if verbose:
>> +                sys.stderr.write("%s added to large file system\n" =
% relPath)
>>=20
>> -        self.gitStream.write("data %d\n" % length)
>> -        for d in contents:
>> -            self.gitStream.write(d)
>> -        self.gitStream.write("\n")
>> +        self.writeToGitStream(git_mode, relPath, contents)
>>=20
>>      def streamOneP4Deletion(self, file):
>>          relPath =3D self.stripRepoPath(file['path'], self.branchPre=
fixes)
>> @@ -2244,6 +2348,10 @@ class P4Sync(Command, P4UserMap):
>>              sys.stderr.write("delete %s\n" % relPath)
>>          self.gitStream.write("D %s\n" % relPath)
>>=20
>> +        if relPath in self.largeFiles:
>> +            self.largeFiles.remove(relPath)
>> +            self.writeGitAttributesToStream()
>> +
>>      # handle another chunk of streaming data
>>      def streamP4FilesCb(self, marshalled):
>>=20
>> diff --git a/t/t9823-git-p4-lfs.sh b/t/t9823-git-p4-lfs.sh
>> new file mode 100755
>> index 0000000..a7587bf
>> --- /dev/null
>> +++ b/t/t9823-git-p4-lfs.sh
>> @@ -0,0 +1,263 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'Clone repositories and store files in LFS'
>> +
>> +git lfs help >/dev/null 2>&1 || {
>> +	skip_all=3D'skipping git p4 LFS tests; no git lfs'
>> +	test_done
>> +}
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_file_in_lfs() {
>> +	FILE=3D$1
>> +	SIZE=3D$2
>> +	EXPECTED_CONTENT=3D$3
>> +	test_path_is_file $FILE &&
>> +	test_line_count =3D 3 $FILE &&
>> +	cat $FILE | grep "size $SIZE" &&
>> +	HASH=3D$(cat $FILE | grep "oid sha256:" | sed -e 's/oid sha256://g=
') &&
>> +	LFS_FILE=3D".git/lfs/objects/${HASH:0:2}/${HASH:2:2}/$HASH"
>> +	test_path_is_file $LFS_FILE &&
>> +	echo $EXPECTED_CONTENT >expect
>> +	test_cmp expect $LFS_FILE
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
>> +		echo "txt 7b" >file1.txt &&
>> +		p4 add file1.txt &&
>> +		echo "bin 13 bytes" >file2.dat &&
>> +		p4 add file2.dat &&
>> +		p4 submit -d "Add text and binary file" &&
>> +
>> +		mkdir "path with spaces" &&
>> +		echo "bin 13 bytes" >"path with spaces/file3.bin" &&
>> +		p4 add "path with spaces/file3.bin" &&
>> +		p4 submit -d "Add another binary file with same content and space=
s in path" &&
>> +
>> +		echo "bin 14 bytesx" >file4.bin &&
>> +		p4 add file4.bin &&
>> +		p4 submit -d "Add another binary file with different content"
>> +	)
>> +'
>> +
>> +test_expect_success 'Store files in LFS based on size (>12 bytes)' =
'
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.largeFileSystem LFS &&
>> +		git config git-p4.largeFileThreshold 12 &&
>> +		git p4 clone --use-client-spec --destination=3D"$git" //depot@all=
 &&
>> +
>> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
>> +		test_file_in_lfs "path with spaces/file3.bin" 13 "bin 13 bytes" &=
&
>> +		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
>> +
>> +		find ".git/lfs/objects" -type f >actual &&
>> +		test_line_count =3D 2 actual &&
>> +
>> +		cat >expect <<-\EOF &&
>> +
>> +		#
>> +		# LFS (see https://git-lfs.github.com/)
>> +		#
>> +		/file2.dat filter=3Dlfs -text
>> +		/path[:space:]with[:space:]spaces/file3.bin filter=3Dlfs -text
>> +		/file4.bin filter=3Dlfs -text
>> +		EOF
>> +		test_path_is_file .gitattributes &&
>> +		test_cmp expect .gitattributes
>> +	)
>> +'
>> +
>> +test_expect_success 'Store files in LFS based on size (>13 bytes)' =
'
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.largeFileSystem LFS &&
>> +		git config git-p4.largeFileThreshold 13 &&
>> +		git p4 clone --use-client-spec --destination=3D"$git" //depot@all=
 &&
>> +
>> +		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
>> +
>> +		find ".git/lfs/objects" -type f >actual &&
>> +		test_line_count =3D 1 actual &&
>> +
>> +		cat >expect <<-\EOF &&
>> +
>> +		#
>> +		# LFS (see https://git-lfs.github.com/)
>> +		#
>> +		/file4.bin filter=3Dlfs -text
>> +		EOF
>> +		test_path_is_file .gitattributes &&
>> +		test_cmp expect .gitattributes
>> +	)
>> +'
>> +
>> +test_expect_success 'Store files in LFS based on extension (dat)' '
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.largeFileSystem LFS &&
>> +		git config git-p4.largeFileExtensions dat &&
>> +		git p4 clone --use-client-spec --destination=3D"$git" //depot@all=
 &&
>> +
>> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
>> +
>> +		find ".git/lfs/objects" -type f >actual &&
>> +		test_line_count =3D 1 actual &&
>> +
>> +		cat >expect <<-\EOF &&
>> +
>> +		#
>> +		# LFS (see https://git-lfs.github.com/)
>> +		#
>> +		*.dat filter=3Dlfs -text
>> +		EOF
>> +		test_path_is_file .gitattributes &&
>> +		test_cmp expect .gitattributes
>> +	)
>> +'
>> +
>> +test_expect_success 'Store files in LFS based on size (>13 bytes) a=
nd extension (dat)' '
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.largeFileSystem LFS &&
>> +		git config git-p4.largeFileExtensions dat &&
>> +		git config git-p4.largeFileThreshold 13 &&
>> +		git p4 clone --use-client-spec --destination=3D"$git" //depot@all=
 &&
>> +
>> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
>> +		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
>> +
>> +		find ".git/lfs/objects" -type f >actual &&
>> +		test_line_count =3D 2 actual &&
>> +
>> +		cat >expect <<-\EOF &&
>> +
>> +		#
>> +		# LFS (see https://git-lfs.github.com/)
>> +		#
>> +		*.dat filter=3Dlfs -text
>> +		/file4.bin filter=3Dlfs -text
>> +		EOF
>> +		test_path_is_file .gitattributes &&
>> +		test_cmp expect .gitattributes
>> +	)
>> +'
>> +
>> +test_expect_success 'Remove file from repo and store files in LFS b=
ased on size (>12 bytes)' '
>> +	client_view "//depot/... //client/..." &&
>> +	(
>> +		cd "$cli" &&
>> +		p4 delete file4.bin &&
>> +		p4 submit -d "Remove file"
>> +	) &&
>> +
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.largeFileSystem LFS &&
>> +		git config git-p4.largeFileThreshold 12 &&
>> +		git p4 clone --use-client-spec --destination=3D"$git" //depot@all=
 &&
>> +
>> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
>> +		test_file_in_lfs "path with spaces/file3.bin" 13 "bin 13 bytes" &=
&
>> +		! test_path_is_file file4.bin &&
>> +
>> +		find ".git/lfs/objects" -type f >actual &&
>> +		# 3 is correct here as some commits in the tree still reference t=
he deleted file
>> +		test_line_count =3D 3 actual
>> +
>> +		cat >expect <<-\EOF &&
>> +
>> +		#
>> +		# LFS (see https://git-lfs.github.com/)
>> +		#
>> +		/file2.dat filter=3Dlfs -text
>> +		/path[:space:]with[:space:]spaces/file3.bin filter=3Dlfs -text
>> +		EOF
>> +		test_path_is_file .gitattributes &&
>> +		test_cmp expect .gitattributes
>> +	)
>> +'
>> +
>> +test_expect_success 'Add big files to repo and store files in LFS b=
ased on compressed size (>19 bytes)' '
>> +	client_view "//depot/... //client/..." &&
>> +	(
>> +		cd "$cli" &&
>> +		echo "bin 24 bytesxxxxxxxxxxx" >file5.bin &&
>> +		p4 add file5.bin &&
>> +		p4 submit -d "Add another binary file with different content" &&
>> +
>> +		echo "bin 34 bytesxxxxxxxxxxxzzzzzzzzzz" >file6.bin &&
>> +		p4 add file6.bin &&
>> +		p4 submit -d "Add another binary file with different content"
>> +	) &&
>> +
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.largeFileSystem LFS &&
>> +		git config git-p4.largeFileCompressedThreshold 19 &&
>> +		# We only import HEAD here ("@all" is missing!)
>> +		git p4 clone --use-client-spec --destination=3D"$git" //depot &&
>> +
>> +		test_file_in_lfs file6.bin 13 "bin 34 bytesxxxxxxxxxxxzzzzzzzzzz"=
 &&
>> +
>> +		find ".git/lfs/objects" -type f >actual &&
>> +		test_line_count =3D 1 actual
>> +
>> +		cat >expect <<-\EOF &&
>> +
>> +		#
>> +		# LFS (see https://git-lfs.github.com/)
>> +		#
>> +		/file6.bin filter=3Dlfs -text
>> +		EOF
>> +		test_path_is_file .gitattributes &&
>> +		test_cmp expect .gitattributes
>> +	)
>> +'
>> +
>> +test_expect_success 'Clone repo with existing .gitattributes file' =
'
>> +	client_view "//depot/... //client/..." &&
>> +	(
>> +		cd "$cli" &&
>> +
>> +		echo "*.txt text" >.gitattributes &&
>> +		p4 add .gitattributes &&
>> +		p4 submit -d "Add .gitattributes"
>> +	) &&
>> +
>> +	test_must_fail git p4 clone --use-client-spec --destination=3D"$gi=
t" //depot 2>errs &&
>> +	grep ".gitattributes already exists in P4." errs
>> +'
>> +
>> +test_expect_success 'kill p4d' '
>> +	kill_p4d
>> +'
>> +
>> +test_done
