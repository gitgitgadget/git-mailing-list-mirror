Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1B3264FB
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786213431; cv=none; b=YqZb8rMGm9BoySCJ020wS+ylzs4bgv6Vi8nLgKmutMCC6VgZpncgIUv5BxF8TiPRZt4nb9Ppygu4S9KkkKe9fuAmz7Jn80fIrhCyLquu+heoSGOhrLcYtXADGl+Dd5PuyswJdwN2S11hCV0c93DdKyJrt05r8twrE/WNde9yiiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786213431; c=relaxed/simple;
	bh=05wbrlIhNPRrnPoJyChLcXjnbqz1hQ/vIQrQcNixrRA=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type; b=ZSmuQTGMSPGsZ20+4DKNfGyZHTV3auP7JzCCHeU0I8Mv7YultolK3OZn6+qTM41V4kmIhvK82Co8X7oBuquJ0wpaUxFSLmGANfKJ/3tp/EEqRE8c/4ejlmo/bYrCtyUOKwSuQkZ1JyXlAK8dvb1/OqS3shm92uDTVE30E/cCa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=guSWtpbV; arc=none smtp.client-ip=217.74.67.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="guSWtpbV"
Date: Sat, 08 Aug 2026 20:23:38 +0200
From: zrzut01@poczta.fm
Subject: git rebase silently ignores nonexistent -X (--strategy-option) but
 git merge does not
To: git@vger.kernel.org
X-Mailer: interia.pl/pf09
Message-Id: <ytaphxxbfvopjtsyyukv@gflc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1786213418; bh=jm3OEMsmH6E3ZeHyeyMPdPQJonlxkcSjxynPmQh+6Lk=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type;
	b=guSWtpbVSdqxKgku+HZw5B+GKS/IGqqtXQQfKunITvC+sl3PwDYYb5KYUvdNPva4+
	 BvutMA1kc7Lnw0dqrVOM5sskT1ovZa5aivQBfRpzfuNxKWtCeCL3XGtu22OI2xdSAE
	 738xaPhCHDkAlxDld1B3005GTEAm5UAYYYWbGlVg=

Hello,

When provide nonexistent <option> to -X when doing rebase it silently
ignores it. Same scenario when executing merge results in error. Such
situation can lead to false positive for end user who will be confident
that whole operation succeeded.

Fedora Linux 44, 7.1.7-200.fc44.x86_64

$ git --version
git version 2.55.0

Example scenario:

$ git clone https://github.com/schacon/simplegit-progit.git
Cloning into 'simplegit-progit'...
remote: Enumerating objects: 13, done.
remote: Total 13 (delta 0), reused 0 (delta 0), pack-reused 13 (from 1)
Receiving objects: 100% (13/13), done.
Resolving deltas: 100% (3/3), done.

$ cd simplegit-progit

$ git branch -c iss1

$ git checkout iss1

$ vi Rakefile

$ git diff
diff --git a/Rakefile b/Rakefile
index 8f94139..8080252 100644
--- a/Rakefile
+++ b/Rakefile
@@ -5,8 +5,8 @@ require 'rake/gempackagetask'
 spec =3D Gem::Specification.new do |s|
     s.platform  =3D   Gem::Platform::RUBY
     s.name      =3D   "simplegit"
-    s.version   =3D   "0.1.1"
-    s.author    =3D   "Scott Chacon"
+    s.version   =3D   "0.1.1"=E2=96=A0=E2=96=A0=E2=96=A0=E2=96=A0=E2=96=A0
+    s.author    =3D   "Scott Chacon Big"
     s.email     =3D   "schacon@gmail.com"
     s.summary   =3D   "A simple gem for using Git in Ruby code."
     s.files     =3D   FileList['lib/**/*'].to_a

--------------
// =E2=96=A0 - space character
--------------

$ git commit -am 'iss1: author name change'
[iss1 fa40d71] iss1: author name change
 1 file changed, 2 insertions(+), 2 deletions(-)

$ git checkout master
Switched to branch 'master'

$ vi Rakefile

$ git diff
diff --git a/Rakefile b/Rakefile
index 8f94139..e458853 100644
--- a/Rakefile
+++ b/Rakefile
@@ -5,7 +5,7 @@ require 'rake/gempackagetask'
 spec =3D Gem::Specification.new do |s|
     s.platform  =3D   Gem::Platform::RUBY
     s.name      =3D   "simplegit"
-    s.version   =3D   "0.1.1"
+    s.version   =3D   "0.1.2"
     s.author    =3D   "Scott Chacon"
     s.email     =3D   "schacon@gmail.com"
     s.summary   =3D   "A simple gem for using Git in Ruby code."

$ git commit -am 'master: version update'
[master f2b3ef3] master: version update
 1 file changed, 1 insertion(+), 1 deletion(-)

$ git checkout iss1
Switched to branch 'iss1'

$ git rebase master
Auto-merging Rakefile
CONFLICT (content): Merge conflict in Rakefile
error: could not apply fa40d71... iss1: author name change
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm &lt;conflicted_files>", then run "git
rebase --continue".
hint: You can instead skip this commit: run "git rebase --skip".
hint: To abort and get back to the state before "git rebase", run
"git rebase --abort".
hint: Disable this message with "git config set advice.mergeConflict
false"
Could not apply fa40d71... # iss1: author name change

$ git rebase --abort

$ git rebase -X sillyoption master
Auto-merging Rakefile
CONFLICT (content): Merge conflict in Rakefile
error: could not apply fa40d71... iss1: author name change
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm &lt;conflicted_files>", then run "git
rebase --continue".
hint: You can instead skip this commit: run "git rebase --skip".
hint: To abort and get back to the state before "git rebase", run
"git rebase --abort".
hint: Disable this message with "git config set advice.mergeConflict
false"
Could not apply fa40d71... # iss1: author name change

