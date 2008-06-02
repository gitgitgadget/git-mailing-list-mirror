From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Revert "git.el: Set process-environment instead of invoking
	env"
Date: Tue, 03 Jun 2008 00:41:44 +0200
Message-ID: <20080602223907.9612.84564.stgit@yoghurt>
References: <7vod6nk05c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Clifford Caoile <piyo@users.sourceforge.net>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 00:43:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Ik2-0005IX-9J
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 00:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbYFBWmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 18:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYFBWmI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:42:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3674 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYFBWmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 18:42:07 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3Iix-0001PZ-00; Mon, 02 Jun 2008 23:41:55 +0100
In-Reply-To: <7vod6nk05c.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83588>

This reverts commit dbe48256b41c1e94d81f2458d7e84b1fdcb47026, which
caused mis-encoding of non-ASCII author/committer names when the
git-status mode is used to create commits.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

On 2008-05-30 13:27:43 -0700, Junio C Hamano wrote:

> Karl Hasselstr=C3=B6m <kha@treskal.com> writes:
>=20
> > How are things going with this fix? Junio, I expect you're waiting
> > for a properly cleaned-up patch, possibly with acks from relevant
> > people?
>=20
> You expected correctly.

In case no one who understands how, why, and whether the fix works
comes forward, here's a revert of the commit that introduced the
problem.

 contrib/emacs/git.el |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)


diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 2557a76..4fa853f 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -232,8 +232,10 @@ and returns the process output as a string, or nil=
 if the git failed."
=20
 (defun git-run-command-region (buffer start end env &rest args)
   "Run a git command with specified buffer region as input."
-  (unless (eq 0 (let ((process-environment (append (git-get-env-string=
s env)
-                                                   process-environment=
)))
+  (unless (eq 0 (if env
+                    (git-run-process-region
+                     buffer start end "env"
+                     (append (git-get-env-strings env) (list "git") ar=
gs))
                   (git-run-process-region
                    buffer start end "git" args)))
     (error "Failed to run \"git %s\":\n%s" (mapconcat (lambda (x) x) a=
rgs " ") (buffer-string))))
@@ -248,8 +250,9 @@ and returns the process output as a string, or nil =
if the git failed."
             (erase-buffer)
             (cd dir)
             (setq status
-                  (let ((process-environment (append (git-get-env-stri=
ngs env)
-                                                     process-environme=
nt)))
+                  (if env
+                      (apply #'call-process "env" nil (list buffer t) =
nil
+                             (append (git-get-env-strings env) (list h=
ook-name) args))
                     (apply #'call-process hook-name nil (list buffer t=
) nil args))))
           (display-message-or-buffer buffer)
           (eq 0 status)))))
