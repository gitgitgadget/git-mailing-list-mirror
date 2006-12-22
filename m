From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] fix vc git
Date: Fri, 22 Dec 2006 14:56:15 +0100
Message-ID: <87ac1guj9c.fsf@wine.dyndns.org>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	<emdr6v$9ma$1@sea.gmane.org>
	<8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
	<7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
	<8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com>
	<87ejqsumu3.fsf@wine.dyndns.org>
	<8e745ecf0612220451v367479dq13af2d829a9547c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 14:56:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxksp-0005N7-Vr
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 14:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbWLVN4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 08:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWLVN4U
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 08:56:20 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:49134 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbWLVN4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 08:56:20 -0500
Received: from adsl-84-226-45-154.adslplus.ch ([84.226.45.154] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Gxksk-0003cW-EP; Fri, 22 Dec 2006 07:56:18 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id E8ED84F672; Fri, 22 Dec 2006 14:56:15 +0100 (CET)
To: "Duncan Mak" <duncan@a-chinaman.com>
In-Reply-To: <8e745ecf0612220451v367479dq13af2d829a9547c2@mail.gmail.com> (Duncan Mak's message of "Fri\, 22 Dec 2006 07\:51\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35174>

"Duncan Mak" <duncan@a-chinaman.com> writes:

> Yeah, but the issue is that, as you know, to create a new file in
> emacs, you give find-file  a non-existent file and emacs will open up
> a buffer for you and let you save it when you're done.

OK, but in that case vc-git-registered needs to return failure, you
cannot call git-ls-files as it may find the file in the wrong
directory. I'd suggest something like this:


>From abf4311add221102957145255d5418a7ec06fe1d Mon Sep 17 00:00:00 2001
From: Alexandre Julliard <julliard@winehq.org>
Date: Fri, 22 Dec 2006 14:51:23 +0100
Subject: [PATCH] vc-git: Ignore errors caused by a non-existent directory in vc-git-registered.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/vc-git.el |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 8b63619..3eb4bd1 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -58,8 +58,9 @@
   (with-temp-buffer
     (let* ((dir (file-name-directory file))
            (name (file-relative-name file dir)))
-      (when dir (cd dir))
-      (and (ignore-errors (eq 0 (call-process "git" nil '(t nil) nil "ls-files" "-c" "-z" "--" name)))
+      (and (ignore-errors
+             (when dir (cd dir))
+             (eq 0 (call-process "git" nil '(t nil) nil "ls-files" "-c" "-z" "--" name)))
            (let ((str (buffer-string)))
              (and (> (length str) (length name))
                   (string= (substring str 0 (1+ (length name))) (concat name "\0"))))))))
-- 
1.4.4.2.g28ce

-- 
Alexandre Julliard
julliard@winehq.org
