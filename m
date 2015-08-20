From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Thu, 20 Aug 2015 09:16:39 +0200
Message-ID: <917E3751-4BC8-4034-9101-30C77426D81C@gmail.com>
References: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com> <1440014686-63290-2-git-send-email-larsxschneider@gmail.com> <55D55EC9.6050002@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 09:17:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSK62-0002rl-50
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 09:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbHTHQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 03:16:46 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35558 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbHTHQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2015 03:16:44 -0400
Received: by wicne3 with SMTP id ne3so137965732wic.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ur9MZTSs5Ct8wa8QAWwMZmJ8aa2VgdnVsZcajDmstrQ=;
        b=idquW1CjSOIhjkQ03jVYZVnKmMemLD0ENsvnDtLJPvPrXytmjKZK7S16xBOt3D5vs/
         nZqvQRQrx7RgNSZTXiSvWzqcuhgXPpSd47SaMEHX5rPw/y1lmW1UdvW3o4bicsGVh5t3
         FqUqJx5sc2u7fXK2b0JW4B4UlP/5vT1TtKrvQdWOxQOiiWErrRBLkqBPb5SEWjV21zJ1
         dYF0+lSUagfMU6SvZKLDNlXTRBcnqhEC5OCiJr8SjYkzao38Cw3b+btGsGaRa4CtFGEj
         lfNaYChC9CF32HthFRN8tAkmisjmMh8+8N+SwNpH2Zu/CG+zd1C+Ttw1q1aKhgS8ajF2
         aXtQ==
X-Received: by 10.180.211.82 with SMTP id na18mr14590540wic.76.1440055003097;
        Thu, 20 Aug 2015 00:16:43 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-100-064-030.188.100.pools.vodafone-ip.de. [188.100.64.30])
        by smtp.gmail.com with ESMTPSA id a19sm4193486wjr.27.2015.08.20.00.16.41
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 00:16:41 -0700 (PDT)
In-Reply-To: <55D55EC9.6050002@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276231>

Thanks for your feedback! See my answers below.

On 20 Aug 2015, at 06:59, Torsten B=F6gershausen <tboegi@web.de> wrote:

> Some nit-picking below:
> On 08/19/2015 10:04 PM, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> PROBLEM:
>> We run P4 servers on Linux and P4 clients on Windows. For an unknown
>> reason the file path for a number of files in P4 does not match the
>> directory path with respect to case sensitivity.
>>=20
>> E.g. `p4 files` might return
>> //depot/path/to/file1
>> //depot/PATH/to/file2
>>=20
>> If you use P4/P4V then these files end up in the same directory, e.g=
=2E
>> //depot/path/to/file1
>> //depot/path/to/file2
>>=20
>> If you use git-p4 then all files not matching the correct file path
>> (e.g. `file2`) will be ignored.
>>=20
>> SOLUTION:
>> Identify files that are different with respect to case sensitivity.
> This may be confusing:
> It's the "file names" that differ, not the file content.
> And in the rest of the patch the term "path" is used.
> How about this:
>=20
> Identify path names that are different with respect to case sensitivi=
ty.
Agreed!

>=20
>=20
>> If there are any then run `p4 dirs` to build up a dictionary
>> containing the "correct" cases for each path. It looks like P4
>> interprets "correct" here as the existing path of the first file in =
a
>> directory. The path dictionary is used later on to fix all paths.
>>=20
>> This is only applied if the parameter "--fix-paths" is passed to the
>> git-p4 clone command.
> The "fix-path" doesn't tell a user what exactly is fixed.
> Something like "fix-path-case" may be more self-explaining,
> but I would simply use "--ignore-case", which is more in line
> with Git. (But this is debatable)
I agree but =93=97ignore-case=94 seems a bit broad to me. How about =93=
=97ignore-path-case=94? Because it is really only about paths case, not=
 filename case.


>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  git-p4.py                         | 83 ++++++++++++++++++++++++++++=
+++++--
>>  t/t9821-git-p4-path-variations.sh | 91 ++++++++++++++++++++++++++++=
+++++++++++
>>  2 files changed, 170 insertions(+), 4 deletions(-)
>>  create mode 100755 t/t9821-git-p4-path-variations.sh
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 073f87b..a21809d 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1931,7 +1931,7 @@ class View(object):
>>                  (self.client_prefix, clientFile))
>>          return clientFile[len(self.client_prefix):]
>>=20
>> -    def update_client_spec_path_cache(self, files):
>> +    def update_client_spec_path_cache(self, files, fixPathCase =3D =
None):
>>          """ Caching file paths by "p4 where" batch query """
>>=20
>>          # List depot file paths exclude that already cached
>> @@ -1950,6 +1950,8 @@ class View(object):
>>              if "unmap" in res:
>>                  # it will list all of them, but only one not unmap-=
ped
>>                  continue
>> +            if fixPathCase:
>> +                res['depotFile'] =3D fixPathCase(res['depotFile'])
>>              self.client_spec_path_cache[res['depotFile']] =3D self.=
convert_client_path(res["clientFile"])
>>=20
>>          # not found files or unmap files set to ""
>> @@ -1987,6 +1989,7 @@ class P4Sync(Command, P4UserMap):
>>                                       help=3D"Maximum number of chan=
ges to import"),
>>                  optparse.make_option("--changes-block-size", dest=3D=
"changes_block_size", type=3D"int",
>>                                       help=3D"Internal block size to=
 use when iteratively calling p4 changes"),
>> +                optparse.make_option("--fix-paths", dest=3D"fixPath=
s", action=3D"store_true"),
>>                  optparse.make_option("--keep-path", dest=3D"keepRep=
oPath", action=3D'store_true',
>>                                       help=3D"Keep entire BRANCH/DIR=
/SUBDIR prefix during import"),
>>                  optparse.make_option("--use-client-spec", dest=3D"u=
seClientSpec", action=3D'store_true',
>> @@ -2017,6 +2020,7 @@ class P4Sync(Command, P4UserMap):
>>          self.maxChanges =3D ""
>>          self.changes_block_size =3D None
>>          self.keepRepoPath =3D False
>> +        self.fixPaths =3D False
>>          self.depotPaths =3D None
>>          self.p4BranchesInGit =3D []
>>          self.cloneExclude =3D []
>> @@ -2049,7 +2053,8 @@ class P4Sync(Command, P4UserMap):
>>          files =3D []
>>          fnum =3D 0
>>          while commit.has_key("depotFile%s" % fnum):
>> -            path =3D  commit["depotFile%s" % fnum]
>> +            path =3D commit["depotFile%s" % fnum]
>> +            path =3D self.fixPathCase(path)
>>=20
>>              if [p for p in self.cloneExclude
>>                  if p4PathStartsWith(path, p)]:
>> @@ -2113,7 +2118,9 @@ class P4Sync(Command, P4UserMap):
>>          branches =3D {}
>>          fnum =3D 0
>>          while commit.has_key("depotFile%s" % fnum):
>> -            path =3D  commit["depotFile%s" % fnum]
>> +            path =3D commit["depotFile%s" % fnum]
>> +            path =3D self.fixPathCase(path)
>> +
>>              found =3D [p for p in self.depotPaths
>>                       if p4PathStartsWith(path, p)]
>>              if not found:
>> @@ -2240,6 +2247,10 @@ class P4Sync(Command, P4UserMap):
>>              if marshalled["code"] =3D=3D "error":
>>                  if "data" in marshalled:
>>                      err =3D marshalled["data"].rstrip()
>> +
>> +        if "depotFile" in marshalled:
>> +            marshalled['depotFile'] =3D self.fixPathCase(marshalled=
['depotFile'])
>> +
>>          if err:
>>              f =3D None
>>              if self.stream_have_file_info:
>> @@ -2314,6 +2325,7 @@ class P4Sync(Command, P4UserMap):
>>=20
>>              # do the last chunk
>>              if self.stream_file.has_key('depotFile'):
>> +                self.stream_file['depotFile'] =3D self.fixPathCase(=
self.stream_file['depotFile'])
>>                  self.streamOneP4File(self.stream_file, self.stream_=
contents)
>>=20
>>      def make_email(self, userid):
>> @@ -2371,7 +2383,8 @@ class P4Sync(Command, P4UserMap):
>>                  sys.stderr.write("Ignoring file outside of prefix: =
%s\n" % f['path'])
>>=20
>>          if self.clientSpecDirs:
>> -            self.clientSpecDirs.update_client_spec_path_cache(files=
)
>> +            self.clientSpecDirs.update_client_spec_path_cache(
>> +                files, lambda x: self.fixPathCase(x))
>>=20
>>          self.gitStream.write("commit %s\n" % branch)
>>  #        gitStream.write("mark :%s\n" % details["change"])
>> @@ -2835,6 +2848,63 @@ class P4Sync(Command, P4UserMap):
>>              print "IO error with git fast-import. Is your git versi=
on recent enough?"
>>              print self.gitError.read()
>>=20
>> +    def fixPathCase(self, path):
>> +        if self.caseCorrectedPaths:
>> +            components =3D path.split('/')
>> +            filename =3D components.pop()
>> +            dirname =3D '/'.join(components).lower() + '/'
>> +            if dirname in self.caseCorrectedPaths:
>> +                path =3D self.caseCorrectedPaths[dirname] + filenam=
e
>> +        return path
>> +
>> +    def generatePathCaseDict(self, depotPaths):
>> +        # Query all files and generate a list of all used paths
>> +        # e.g. this files list:
>> +        # //depot/path/to/file1
>> +        # //depot/PATH/to/file2
>> +        #
>> +        # result in this path list:
>> +        # //depot/
>> +        # //depot/PATH/
>> +        # //depot/path/
>> +        # //depot/PATH/to/
>> +        # //depot/path/to/
>> +        p4_paths =3D set()
>> +        for p in depotPaths:
>> +            for f in p4CmdList(["files", p+"..."]):
>> +                components =3D f["depotFile"].split('/')[0:-1]
>> +                for i in range(3, len(components)+1):
>> +                    p4_paths.add('/'.join(components[0:i]) + '/')
>> +        p4_paths =3D sorted(list(p4_paths), key=3Dlen)
>> +
>> +        if len(p4_paths) > len(set([p.lower() for p in p4_paths])):
>> +            print "ATTENTION: File paths with different case variat=
ions detected. Fixing may take a while..."
>> +            found_variations =3D True
>> +            while found_variations:
>> +                for path in p4_paths:
>> +                    found_variations =3D False
>> +                    path_variations =3D [p for p in p4_paths if p.l=
ower() =3D=3D path.lower()]
>> +
>> +                    if len(path_variations) > 1:
>> +                        print  "%i different case variations for pa=
th '%s' detected." % (len(path_variations), path)
>> +                        # If we detect path variations (e.g. //depo=
t/path and //depot/PATH) then we query P4 to list
>> +                        # the subdirectories of the parent (e.g //d=
epot/*). P4 will return these subdirectories with
>> +                        # the correct case.
>> +                        parent_path =3D '/'.join(path.split('/')[0:=
-2])
>> +                        case_ok_paths =3D [p["dir"] + '/' for p in =
p4CmdList(["dirs", "-D", parent_path + '/*'])]
>> +
>> +                        # Replace all known paths with the case cor=
rected path from P4 dirs command
>> +                        for case_ok_path in case_ok_paths:
>> +                            pattern =3D re.compile("^" + re.escape(=
case_ok_path), re.IGNORECASE)
>> +                            p4_paths =3D sorted(list(set([pattern.s=
ub(case_ok_path, p) for p in p4_paths])), key=3Dlen)
>> +
>> +                        found_variations =3D True
>> +                        break
>> +            return dict((p.lower(), p) for p in p4_paths)
>> +        else:
>> +            if self.verbose:
>> +                print "All file paths have consistent case"
>> +            return None
>>=20
>>      def run(self, args):
>>          self.depotPaths =3D []
>> @@ -3006,6 +3076,11 @@ class P4Sync(Command, P4UserMap):
>>=20
>>          self.depotPaths =3D newPaths
>>=20
>> +        if self.fixPaths:
>> +            self.caseCorrectedPaths =3D self.generatePathCaseDict(s=
elf.depotPaths)
>> +        else:
>> +            self.caseCorrectedPaths =3D None
>> +
>>          # --detect-branches may change this for each branch
>>          self.branchPrefixes =3D self.depotPaths
>>=20
>> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path=
-variations.sh
>> new file mode 100755
>> index 0000000..ede772f
>> --- /dev/null
>> +++ b/t/t9821-git-p4-path-variations.sh
>> @@ -0,0 +1,91 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'Clone repositories with path case variations'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_expect_success 'start p4d with case folding enabled' '
>> +	start_p4d -C1
>> +'
>> +
>> +test_expect_success 'Create a repo with path case variations' '
>> +	client_view "//depot/... //client/..." &&
>> +	cd "$cli" &&
>> +
>> +	mkdir -p One/two &&
>> +	> One/two/File2.txt &&
> Minor remark: To be more Git-style, please no space after '>=92:
OK

>> One/two/File2.txt &&
>=20
>=20
>> +	p4 add One/two/File2.txt &&
>> +	p4 submit -d "Add file2" &&
>> +	rm -rf One &&
>> +
>> +	mkdir -p one/TWO &&
>> +	> one/TWO/file1.txt &&
> Same here
OK

>> +	p4 add one/TWO/file1.txt &&
>> +	p4 submit -d "Add file1" &&
>> +	rm -rf one &&
>> +
>> +	mkdir -p one/two &&
>> +	> one/two/file3.txt &&
> and here
OK

>> +	p4 add one/two/file3.txt &&
>> +	p4 submit -d "Add file3" &&
>> +	rm -rf one
>> +'
>> +
>> +test_expect_success 'Clone the repo and WITHOUT path fixing' '
>> +	client_view "//depot/One/... //client/..." &&
>> +	git p4 clone --use-client-spec --destination=3D"$git" //depot/one =
&&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
> The cd command should be in a subshell:
>=20
>    (
>        cd $git &&
>        test -f xxxx &&
>        test_this_and_that
>    )
>=20
>=20
> Writing shell scripts isn't easy,
> there is some information in
> Documentation/CodingGuidelines
> and
> t/README
Can you try to rephrase your comment? I don=92t get it. My =93cd comman=
d=94 is already in parenthesis (=3D=3D subshell), no?

>=20
>> +		find . | grep two/File2.txt &&
> Should we make sure that two/File2.txt exist?
> Then the "find | grep" feels like overkill.
> The line
> test -f  two/File2.txt &&
> could do the same (or do I miss something ?)
That=92s what I did first. However, I am running OS X with HFS in case-=
insensitive mode (the default). Consequently =93test -f=94 doesn=92t ca=
re about the case. That=92s why I used =93grep=94.

>> +		git ls-files > lines &&
> and here
I really want to make sure only one file ends up in the repo.

>> +		test_line_count =3D 1 lines
>> +	)
>> +'
>> +
>> +test_expect_success 'Clone the repo WITH path fixing' '
>> +	client_view "//depot/One/... //client/..." &&
>> +	git p4 clone --fix-paths --use-client-spec --destination=3D"$git" =
//depot/one &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		find . | grep TWO/file1.txt &&
>> +		find . | grep TWO/File2.txt &&
>> +		find . | grep TWO/file3.txt &&
> Not sure about the find | grep here either.
See answers above.

>> +		git ls-files > lines &&
>> +		test_line_count =3D 3 lines
>> +	)
>> +'
>> +
>> +# It looks like P4 determines the path case based on the first file=
 in
>> +# lexicographical order. Please note the lower case "two" directory=
 for all
>> +# files triggered through the addition of "File0.txt".
>> +test_expect_success 'Add a new file and clone the repo WITH path fi=
xing' '
>> +	client_view "//depot/... //client/..." &&
>> +	cd "$cli" &&
>> +
>> +	mkdir -p One/two &&
>> +	> One/two/File0.txt &&
>> +	p4 add One/two/File0.txt &&
>> +	p4 submit -d "Add file" &&
>> +	rm -rf One &&
>> +
>> +	client_view "//depot/One/... //client/..." &&
>> +	git p4 clone --fix-paths --use-client-spec --destination=3D"$git" =
//depot/one &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		find . | grep two/File0.txt &&
>> +		find . | grep two/file1.txt &&
>> +		find . | grep two/File2.txt &&
>> +		find . | grep two/file3.txt &&
>> +		git ls-files > lines &&
>> +		test_line_count =3D 4 lines
>> +	)
>> +'
>> +
>> +test_expect_success 'kill p4d' '
>> +	kill_p4d
>> +'
>> +
>> +test_done
>> --
