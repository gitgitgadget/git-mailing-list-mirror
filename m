From: Peter Wu <lekensteyn@gmail.com>
Subject: [PATCH] git-svn: do not escape certain characters in paths
Date: Thu, 17 Jan 2013 23:07:31 +0100
Message-ID: <1472347.NT5gjdj3yd@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 23:08:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvxcw-0004De-9r
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab3AQWHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:07:38 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:59383 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab3AQWHg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:07:36 -0500
Received: by mail-ee0-f49.google.com with SMTP id d4so1432511eek.36
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=Ov+pAqxMlhHkJVzfj5wlOiJevyu6Af/CWTDOS3HnyeQ=;
        b=rZ+J5njGTFolZKmk2oP+9WVhUAP7DN5a7GpCCOW4IZLErTnUoqAisOGvOBPr1tHws4
         9Kevi2iyepowuf44o4dI3LL2aSjW/zNzH97Im4DADfUKevxwPlBSshWpqrTj8dReb4or
         b3Xtr7OKi19A6SbrljxSQ7GunuSGnkdZe5vTgQr3xjyCaB33s1onzgvyI07U4e4qjk1z
         eUfzbwoCwBuufDHnIONrogfVrBxn019iVIePlPJUoovOc4zQUnKUwWSDPD1H5k4KqzxL
         luikkI4CccvUX7x4PJdqrS3EtrvMtXUfJgSs5soesmk3GqY2fCTJnW0E72xkocMMW4cl
         nhVQ==
X-Received: by 10.14.209.193 with SMTP id s41mr18615472eeo.9.1358460455188;
        Thu, 17 Jan 2013 14:07:35 -0800 (PST)
Received: from al.localnet (ip4da018ae.direct-adsl.nl. [77.160.24.174])
        by mx.google.com with ESMTPS id l3sm4527557een.14.2013.01.17.14.07.33
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jan 2013 14:07:34 -0800 (PST)
User-Agent: KMail/4.9.5 (Linux/3.7.1-2-custom; KDE/4.9.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213881>

Subversion 1.7 and newer implement HTTPv2, an extension that should make HTTP
more efficient. Servers with support for this protocol will make the subversion
client library take an alternative code path that checks (with assertions)
whether the URL is "canonical" or not.

This patch fixes an issue I encountered while trying to `git svn dcommit` a
rename action for a file containing a single quote character ("User's Manual"
to "UserMan.tex"). It does not happen for older subversion 1.6 servers nor
non-HTTP(S) protocols such as the native svn protocol, only on an Apache server
shipping SVN 1.7. Trying to `git svn dcommit` under the aforementioned
conditions yields the following error which aborts the commit process:

    Committing to http://example.com/svn ...
    perl: subversion/libsvn_subr/dirent_uri.c:1520: uri_skip_ancestor:
Assertion `svn_uri_is_canonical(child_uri, ((void *)0))' failed.
    error: git-svn died of signal 6

An analysis of the subversion source for the cause:

- The assertion originates from uri_skip_ancestor which calls
  svn_uri_is_canonical, which fails when the URL contains percent-encoded values
  that do not necessarily have to be encoded (not "canonical" enough). This is
  done by a table lookup in libsvn_subr/path.c. Putting some debugging prints
  revealed that the character ' is indeed encoded to %27 which is not
  considered canonical.
- url_skip_ancestor is called by svn_ra_neon__get_baseline_info with the root
  repository URL and path as parameters;
- which is called by copy_resource (libsvn_ra_neon/commit.c) for a copy action
  (or in my case, renaming which is actually copy + delete old);
- which is called by commit_add_dir;
- which is assigned as a structure method "add_file" in
  svn_ra_neon__get_commit_editor.

In the whole path, the path argument is not modified.

Through some more uninteresting wrapper functions, the Perl bindings gives you
access to the add_file method which will pass the path argument without
modifications to svn.

git-svn calls the "R"(ename) subroutine in Git::SVN::Editor which contains:
326         my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
327                                 $self->url_path($m->{file_a}), $self->{r});
"repo_path" basically returns the path as-is, unless the "svn.pathnameencoding"
configuration property is set. "url_path" tries to escape some special
characters, but does not take all special characters into account, thereby
causing the path to contain some escaped characters which do not have to be
escaped.

The list of characters not to be escaped are taken from the
subversion/libsvn_subr/path.c file to fully account for all characters. Tested
with a filename containing all characters in the range 0x20 to 0x78 (inclusive).

Signed-off-by: Peter Wu <lekensteyn@gmail.com>
---
 perl/Git/SVN/Editor.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 3bbc20a..30f92cb 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -145,7 +145,8 @@ sub repo_path {
 sub url_path {
 	my ($self, $path) = @_;
 	if ($self->{url} =~ m#^https?://#) {
-		$path =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
+		# characters are taken from subversion/libsvn_subr/path.c
+		$path =~ s#([^~a-zA-Z0-9_./!$&'()*+,-])#uc sprintf("%%%02x",ord($1))#eg;
 	}
 	$self->{url} . '/' . $self->repo_path($path);
 }
-- 
1.8.1.1
