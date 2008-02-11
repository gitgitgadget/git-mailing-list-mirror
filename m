From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 2/2] Emacs mode: delete patches
Date: Mon, 11 Feb 2008 10:42:22 +0100
Message-ID: <87wspbsubl.fsf@lysator.liu.se>
References: <20080210204628.17886.27365.stgit@yoghurt>
	<20080210204851.17886.69638.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:42:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVBg-00039V-9Z
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbYBKJmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 04:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYBKJmV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:42:21 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:47352 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbYBKJmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 04:42:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 1CD52200A1F4;
	Mon, 11 Feb 2008 10:42:19 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26383-01-9; Mon, 11 Feb 2008 10:42:18 +0100 (CET)
Received: from krank (78.156.200.233.bredband.tre.se [78.156.200.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4A0FC200A1F9;
	Mon, 11 Feb 2008 10:42:18 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 743587B4077; Mon, 11 Feb 2008 10:42:22 +0100 (CET)
In-Reply-To: <20080210204851.17886.69638.stgit@yoghurt> ("Karl =?utf-8?Q?H?=
 =?utf-8?Q?asselstr=C3=B6m=22's?= message of "Sun\, 10 Feb 2008 21\:54\:08
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73493>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> Teach the emacs mode to delete patches.
>
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>
> ---
>
> David, could you have a look at this as well? In addition to me being
> elisp challenged, there are the following issues:
>
>   * Is "d" a reasonable binding? Any better suggestion?

We could reserve "d" for moving a patch "down", maybe.  The more
destructive commands could be on less accessible keys. Maybe "D" or
"C-d".

>   * Currently, this command requires you to mark one or more patches
>     before deleting. This is convenient when deleting more than one
>     patch, but one could argue that it should be possible to delete
>     the patch at point without having to select it.

You need something like this:

--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -187,6 +187,15 @@ Commands:
         (match-string-no-properties 1)
       nil)))
=20
+(defun stgit-selected-patches ()
+  "Return the names of the marked patches, or the patch on the current=
 line."
+  (if stgit-marked-patches
+      (stgit-marked-patches)
+    (let ((patch (stgit-patch-at-point)))
+      (if patch
+          (list patch)
+        '()))))
+
 (defun stgit-goto-patch (patch)
   "Move point to the line containing PATCH"
   (let ((p (point)))

>   * We should probably ask for confirmation before deleting.

Absolutely. Something like this (untested):

(defun stgit-delete (patch-names)
  "Delete the named patches"
  (interactive (list (stgit-selected-patches)))
  (if (zerop (length patch-names))
      (error "No patches to delete")
    (when (yes-or-no-p (format "Really delete %d patches? "
                               (length patch-names)))
      (stgit-capture-output nil
        (apply 'stgit-run "delete" patch-names))
      (stgit-refresh))


--=20
David K=C3=A5gedal
