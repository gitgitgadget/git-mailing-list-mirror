From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el: does not show one-line summary in echo area
Date: Fri, 04 Feb 2011 13:26:16 +0100
Message-ID: <87oc6sm1ef.fsf@krank.kagedal.org>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <20110204014315.GB28525@elie>
	<87tygkm8h7.fsf@krank.kagedal.org>
	<201102041103.10770.jnareb@gmail.com>
	<87r5bom7g3.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Xavier Maillard <zedek@gnu.org>,
	Alexandre Julliard <julliard@winehq.org>,
	Martin Nordholts <enselic@gmail.com>,
	Kevin Ryde <user42@zip.com.au>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Sergei Organov <osv@javad.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 13:26:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlKkF-0001RQ-18
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 13:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab1BDM00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 07:26:26 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:59384 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab1BDM0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 07:26:22 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E22C14000C;
	Fri,  4 Feb 2011 13:26:20 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id D5BD040014; Fri,  4 Feb 2011 13:26:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E79E74000C;
	Fri,  4 Feb 2011 13:26:18 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id A12E7625A5; Fri,  4 Feb 2011 13:26:16 +0100 (CET)
In-Reply-To: <87r5bom7g3.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of
	"Fri, 04 Feb 2011 11:15:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166039>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Dnia pi=C4=85tek 4. lutego 2011 10:53, David K=C3=A5gedal napisa=C5=82=
:
>>
>>> 3) Showing when you move to a different blame chunk, by showing a
>>>    one-line summary in the echo area.
>>
>> There is even some prior art for this to borrow from, namely cperl-m=
ode
>> shows information about syntax at given point in echo area (minibuff=
er
>> area) after some delay.  Just FYI.
>
> Sure, there are a number of those (eldoc comes to mind). I think the
> hardest part is figuring out what to show. A 40-charater hash is
> probably not very useful. The problem is that the committer informati=
on,
> date, and commit message first line takes up a lot of space. But we c=
an
> of course let the echo area grow to two lines, or even three.
>
> I don't think I'll have time to cook something up right now, though.

I whipped up a patch anyway. This adds an echo area message shown after
0.5 seconds of idleness, using the git-blame-echo-format format string.
Try it and see if makes sense. I can clean it up (and split it up)
later.

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index d351cfb..9f60a6f 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -104,34 +104,53 @@
 (defcustom git-blame-prefix-format
   "%h %20A:"
   "The format of the prefix added to each line in `git-blame'
-mode. The format is passed to `format-spec' with the following format =
keys:
-
-  %h - the abbreviated hash
-  %H - the full hash
-  %a - the author name
-  %A - the author email
-  %c - the committer name
-  %C - the committer email
-  %s - the commit summary
+mode. See `git-blame-format' for more information.
 "
   :group 'git-blame)
=20
 (defcustom git-blame-mouseover-format
   "%h %a %A: %s"
   "The format of the description shown when pointing at a line in
-`git-blame' mode. The format string is passed to `format-spec'
-with the following format keys:
+`git-blame' mode. See `git-blame-format' for more information
+"
+  :group 'git-blame)
+
+(defcustom git-blame-echo-format
+  "%H\n%a %A %t\n%s"
+  "The format of the description shown in the echo area when moving ar=
ound in
+`git-blame' mode. See `git-blame-format' for more information."
+  :group 'git-blame)
+
+(defun git-blame-format (info format)
+  "Use format-spec to format the blame info in INFO with the following=
 keys:
=20
   %h - the abbreviated hash
   %H - the full hash
   %a - the author name
   %A - the author email
+  %t - the author time
   %c - the committer name
   %C - the committer email
+  %T - the commtter time
   %s - the commit summary
 "
-  :group 'git-blame)
-
+  (let ((hash (car info))
+        (author-time (let ((time (string-to-number
+                                  (git-blame-get-info info 'author-tim=
e))))
+                       (list (/ time 65536) (% time 65536) 0)))
+        (committer-time (let ((time (string-to-number
+                                  (git-blame-get-info info 'committer-=
time))))
+                          (list (/ time 65536) (% time 65536) 0))))
+    (format-spec format
+                 `((?h . ,(substring (car info) 0 6))
+                   (?H . ,(car info))
+                   (?a . ,(git-blame-get-info info 'author))
+                   (?A . ,(git-blame-get-info info 'author-mail))
+                   (?t . ,(format-time-string "%c" author-time))
+                   (?c . ,(git-blame-get-info info 'committer))
+                   (?C . ,(git-blame-get-info info 'committer-mail))
+                   (?T . ,(format-time-string "%c" committer-time))
+                   (?s . ,(git-blame-get-info info 'summary))))))
=20
 (defun git-blame-color-scale (&rest elements)
   "Given a list, returns a list of triples formed with each
@@ -198,10 +217,13 @@ minor mode.")
   "A cache of git-blame information for the current buffer")
 (make-variable-buffer-local 'git-blame-cache)
=20
-(defvar git-blame-idle-timer nil
+(defvar git-blame-update-timer nil
   "An idle timer that updates the blame")
 (make-variable-buffer-local 'git-blame-cache)
=20
+(defvar git-blame-show-timer nil
+  "An idle timer that show the current blame info.")
+
 (defvar git-blame-update-queue nil
   "A queue of update requests")
 (make-variable-buffer-local 'git-blame-update-queue)
@@ -246,6 +268,10 @@ See also function `git-blame-mode'."
 	(setq git-blame-colors git-blame-dark-colors)
       (setq git-blame-colors git-blame-light-colors)))
   (setq git-blame-cache (make-hash-table :test 'equal))
+  (unless (and git-blame-show-timer
+               (memq git-blame-show-timer timer-idle-list))
+    (setq git-blame-show-timer
+          (run-with-idle-timer 0.5 t 'git-blame-echo-current)))
   (setq git-blame-mode t)
   (git-blame-run))
=20
@@ -254,7 +280,7 @@ See also function `git-blame-mode'."
=20
 See also function `git-blame-mode'."
   (git-blame-cleanup)
-  (if git-blame-idle-timer (cancel-timer git-blame-idle-timer))
+  (if git-blame-update-timer (cancel-timer git-blame-update-timer))
   (setq git-blame-mode nil))
=20
 ;;;###autoload
@@ -392,34 +418,33 @@ See also function `git-blame-mode'."
       (goto-line start-line)
       (let* ((start (point))
              (end (progn (forward-line num-lines) (point)))
-             (ovl (make-overlay start end))
-             (hash (car info))
-             (spec `((?h . ,(substring hash 0 6))
-                     (?H . ,hash)
-                     (?a . ,(git-blame-get-info info 'author))
-                     (?A . ,(git-blame-get-info info 'author-mail))
-                     (?c . ,(git-blame-get-info info 'committer))
-                     (?C . ,(git-blame-get-info info 'committer-mail))
-                     (?s . ,(git-blame-get-info info 'summary)))))
+             (ovl (make-overlay start end)))
         (push ovl git-blame-overlays)
         (overlay-put ovl 'git-blame info)
         (overlay-put ovl 'help-echo
-                     (format-spec git-blame-mouseover-format spec))
+                     (git-blame-format info git-blame-mouseover-format=
))
         (if git-blame-use-colors
             (overlay-put ovl 'face (list :background
                                          (cdr (assq 'color (cdr info))=
))))
         (overlay-put ovl 'line-prefix
-                     (propertize (format-spec git-blame-prefix-format =
spec)
+                     (propertize (git-blame-format info git-blame-pref=
ix-format)
                                  'face 'git-blame-prefix-face))))))
=20
 (defun git-blame-add-info (info key value)
-  (nconc info (list (cons (intern key) value))))
+  (let* ((keysym (intern key))
+         (a (assq keysym (cdr info))))
+    (if a
+        (setcdr a value)
+      (nconc info (list (cons (intern key) value))))))
=20
 (defun git-blame-get-info (info key)
   (cdr (assq key (cdr info))))
=20
+(defun git-blame-current-info ()
+  (get-char-property (point) 'git-blame))
+
 (defun git-blame-current-commit ()
-  (let ((info (get-char-property (point) 'git-blame)))
+  (let ((info (git-blame-current-info)))
     (if info
         (car info)
       (error "No commit info"))))
@@ -467,17 +492,22 @@ See also function `git-blame-mode'."
          (setq git-blame-last-update (cons start end))
          (setq git-blame-update-queue (nconc git-blame-update-queue
                                              (list git-blame-last-upda=
te)))))
-  (unless (or git-blame-proc git-blame-idle-timer)
-    (setq git-blame-idle-timer
+  (unless (or git-blame-proc git-blame-update-timer)
+    (setq git-blame-update-timer
           (run-with-idle-timer 0.5 nil 'git-blame-delayed-update))))
=20
 (defun git-blame-delayed-update ()
-  (setq git-blame-idle-timer nil)
+  (setq git-blame-update-timer nil)
   (if git-blame-update-queue
       (let ((first (pop git-blame-update-queue))
             (inhibit-point-motion-hooks t))
         (git-blame-update-region (car first) (cdr first)))))
=20
+(defun git-blame-echo-current ()
+  (let ((info (git-blame-current-info)))
+    (when info
+      (message "%s" (git-blame-format info git-blame-echo-format)))))
+
 (provide 'git-blame)
=20
 ;;; git-blame.el ends here


--=20
David K=C3=A5gedal
