From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git clean -X behaviour when .gitignore has sub-directory
 entries
Date: Mon, 27 Sep 2010 15:36:52 -0500
Message-ID: <20100927203652.GB11957@burratino>
References: <4CA0AB9A.4050002@nuecho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Shawn Bohrer <shawn.bohrer@gmail.com>
To: Jean-Philippe =?utf-8?Q?Gari=C3=A9py?= 
	<jean-philippe.gariepy@nuecho.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 22:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0KUR-0006Md-Qk
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 22:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759374Ab0I0Ujy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 16:39:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48031 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0I0Ujy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 16:39:54 -0400
Received: by wwj40 with SMTP id 40so5700wwj.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oZ7CjlZIiGM+B1KAjWU0CLiZN1pBk5awcEoSy7Bw0gQ=;
        b=EmaWSFBJEofqXyd3KsTkFrN2NSB+XCnVdF+J16S51PNbKwD2r0gO5oyRhmT7sXjAlN
         XN8M/IITIXQIdGqlwFtW7vMtbs0hq4pym0eknjGOz0Ccyde/IQmZFCHqh8a2uFxxoNBj
         PVKlo5afiXJs+vfNndo7M9gF315qqHTaZEhYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=o4OBJqBlk01zqQUuWWFYYDik5RaoYkDBOBLp43lEGTZ0s/qknNNEjIYlvdX/G4UTNd
         bX3VmH6Oc9g+SLbeDuY5+hF+R90A1sJZvrUGtCAI5kctmU8oedCmtPkBYVLyMFe5WuxD
         hl1Hqa0KYpYeQKcg/wG/Qs7IlVRdXPbV2xqB8=
Received: by 10.227.156.196 with SMTP id y4mr6714584wbw.219.1285619992455;
        Mon, 27 Sep 2010 13:39:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g9sm5235657wbh.13.2010.09.27.13.39.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 13:39:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA0AB9A.4050002@nuecho.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157366>

Hi,

Jean-Philippe Gari=C3=A9py wrote:

> When using sub-directory entries in .gitignore, while the entry is
> ignored as expected, "git clean -X" doesn't clean the ignored
> sub-directory.

Thanks for reporting.

 $ cat test.sh
 rm -fr test &&
 git init test &&
 (
	cd test &&
	mkdir -p a/b/c &&
	>a/b/c/f &&
	echo '/a/b/' >.gitignore &&
	git status -s &&
	git clean -X -d -n &&
	git ls-files -o -i --exclude-standard &&
	git ls-files -o --directory -i --exclude-standard &&
	git clean -X -d -f &&
	echo ... drumroll ... &&
	! test -e a/b/c/f
 )
 $ sh test.sh || echo fail
 Initialized empty Git repository in /tmp/test/.git/
 ?? .gitignore
 ... drumroll ...
 fail

Variations:

 1) echo '/a/' >.gitignore
 2) echo '/a/b/c/f' >.gitignore
 3) >a/b/f

(1) does not fail; (2) and (3) still do.

Okay, so why does this happen?  Tracing:

-- 8< --
diff --git a/dir.c b/dir.c
index 133f472..5707ad0 100644
--- a/dir.c
+++ b/dir.c
@@ -693,6 +693,9 @@ static enum path_treatment treat_one_path(struct di=
r_struct *dir,
 					  int dtype, struct dirent *de)
 {
 	int exclude =3D excluded(dir, path, &dtype);
+
+	trace_printf("treat_one_path: path=3D%s exclude=3D%d\n", path, exclud=
e);
+
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path, *len, simplify))
 		dir_add_ignored(dir, path, *len);
-- >8 --

 $ GIT_TRACE=3Dtrue PATH=3D/home/jrn/src/git/bin-wrappers:$PATH sh test=
=2Esh=20
 trace: built-in: git 'init' 'test'
 Initialized empty Git repository in /tmp/test/.git/
 trace: built-in: git 'status' '-s'
 treat_one_path: path=3D.gitignore exclude=3D0
 treat_one_path: path=3Da exclude=3D0
 treat_one_path: path=3Da/b exclude=3D1
 ?? .gitignore
 trace: built-in: git 'clean' '-X' '-d' '-n'
 treat_one_path: path=3D.gitignore exclude=3D0
 treat_one_path: path=3Da exclude=3D0
 trace: built-in: git 'ls-files' '-o' '-i' '--exclude-standard'
 treat_one_path: path=3D.gitignore exclude=3D0
 treat_one_path: path=3Da exclude=3D0
 treat_one_path: path=3Da/b exclude=3D1
 treat_one_path: path=3Da/b/c exclude=3D0
 treat_one_path: path=3Da/b/c/f exclude=3D0
 trace: built-in: git 'ls-files' '-o' '--directory' '-i' '--exclude-sta=
ndard'
 treat_one_path: path=3D.gitignore exclude=3D0
 treat_one_path: path=3Da exclude=3D0
 trace: built-in: git 'clean' '-X' '-d' '-f'
 treat_one_path: path=3D.gitignore exclude=3D0
 treat_one_path: path=3Da exclude=3D0
 ... drumroll ...
 $

 1) a/b/f is not actually considered excluded; only its containing
    directory is.

 2) git clean does not even examine a/b to consider whether to remove
    it: since a/ does not contain any tracked files, it stopped there.

The following would cause "git clean -ndx" to print more than it
should, but hopefully it illustrates the idea.

diff --git a/builtin/clean.c b/builtin/clean.c
index b508d2c..91624c2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -84,8 +84,6 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	if (force > 1)
 		rm_flags =3D 0;
=20
-	dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
-
 	if (read_cache() < 0)
 		die("index file corrupt");
=20
--=20
