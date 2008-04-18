From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: [PATCH] git.el: Set process-environment instead of invoking env (follow-up 1)
Date: Fri, 18 Apr 2008 22:07:12 +0900
Message-ID: <1f748ec60804180607v474ffc55ta7eeb62dd449344@mail.gmail.com>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Git Maintainer" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 15:02:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmqJu-0002rb-UJ
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 15:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbYDRNHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 09:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbYDRNHQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 09:07:16 -0400
Received: from hs-out-0708.google.com ([64.233.178.241]:26247 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYDRNHO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 09:07:14 -0400
Received: by hs-out-0708.google.com with SMTP id 4so352349hsl.5
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=rW1ByrbPaqdmguY+y9HcUp7UV4owpUEYYPoXNUbKaBU=;
        b=l5DaVmxw0+MixpsG2EldCV+NCAZPNaf6eYBi5AmlHX1432TQtLLmOPWGr6ifn7tLYyJ2DWfG9YrOzQtviJx/7gKTzIb7egTW7VtDx7EoqUBjt0cGFNerqlafSXdb90a44kPb2AgBZBHbjZPoFaqGcOK0MPIFV3kM1hNnUGqBLcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=SB+MCUaB+SmOwhxEMqxq6Ad/lULZfDaCz3b1x2kIizinf40fcnwVEH9PdAGzPAhv0YXbx/96kbYTUHKv+aNRJwBqrjaeTjaBGarn6kljJ5M1HRB4Qw2I9ZUIaoQ9GjZgY9fIoKmXgKSO1LFB+DZ9PryVNF3cG/pSBDsFt9CAIro=
Received: by 10.100.251.18 with SMTP id y18mr5112200anh.120.1208524032792;
        Fri, 18 Apr 2008 06:07:12 -0700 (PDT)
Received: by 10.101.1.16 with HTTP; Fri, 18 Apr 2008 06:07:12 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 2a1b4b04747df6e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79886>

According to the similar patch from David K=E5gedal [1], "this will mak=
e
it a little less posix-dependent and more efficient." However, there
are two other areas that need to replaced, namely
git-run-command-region and git-run-hooks. This patch implements the
changes of [1] onto those Emacs Lisp functions.

If unpatched, using the git port "msysgit" on Windows will require
defadvice changes as shown at [2] (also explained at 4msysgit.git
[3]).

I have tested git-run-command-region on msysgit, because this is
always called by git-commit (via git-commit-tree <- git-do-commit <-
git-commit-file). However, I could not test git-run-hooks because it
currently does not work on the Emacs Windows port. The latter reports
the hooks files as a+rw and a-x, despite msysgit and cygwin chmod
setting on the respective files.

References:
[1] f27e55864317611385be4d33b3c53ca787379df9
[2] http://groups.google.com/group/msysgit/browse_thread/thread/b852fef=
689817707
[3] http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommit;h=3D3c30e5e87=
358eba7b6d7dcd6301ae8438f0c30ea

Signed-off-by: Clifford Caoile <piyo@users.sourceforge.net>
---
 contrib/emacs/git.el |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 4fa853f..2557a76 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -232,10 +232,8 @@ and returns the process output as a string, or
nil if the git failed."

 (defun git-run-command-region (buffer start end env &rest args)
   "Run a git command with specified buffer region as input."
-  (unless (eq 0 (if env
-                    (git-run-process-region
-                     buffer start end "env"
-                     (append (git-get-env-strings env) (list "git") ar=
gs))
+  (unless (eq 0 (let ((process-environment (append (git-get-env-string=
s env)
+                                                   process-environment=
)))
                   (git-run-process-region
                    buffer start end "git" args)))
     (error "Failed to run \"git %s\":\n%s" (mapconcat (lambda (x) x)
args " ") (buffer-string))))
@@ -250,9 +248,8 @@ and returns the process output as a string, or nil
if the git failed."
             (erase-buffer)
             (cd dir)
             (setq status
-                  (if env
-                      (apply #'call-process "env" nil (list buffer t) =
nil
-                             (append (git-get-env-strings env) (list
hook-name) args))
+                  (let ((process-environment (append (git-get-env-stri=
ngs env)
+                                                     process-environme=
nt)))
                     (apply #'call-process hook-name nil (list buffer
t) nil args))))
           (display-message-or-buffer buffer)
           (eq 0 status)))))
--=20
1.5.5.1015.g9d258
