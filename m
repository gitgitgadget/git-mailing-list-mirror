From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: More precise tag following
Date: Wed, 31 Jan 2007 09:39:49 +0100
Message-ID: <87bqkf1tey.fsf@morpheus.local>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 09:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCB0l-00045U-Jz
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 09:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXAaIkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 03:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbXAaIkF
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 03:40:05 -0500
Received: from main.gmane.org ([80.91.229.2]:60999 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbXAaIkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 03:40:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCB0Y-00053F-V2
	for git@vger.kernel.org; Wed, 31 Jan 2007 09:39:59 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 09:39:58 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 09:39:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:9veAnfC3Im3VOPc8jFeB7/o/NOE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38235>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>    Now, in a plain-text pager thign (aka the traditional "git blame")=
, you=20
>    don't have much choice. The blame data needs to be there, and you =
can't=20
>    hide it, because if you do, there's no way to get at it. But thing=
s are=20
>    different with an interactive graphical environment (or a textual =
one,=20
>    for that matter: using some curses interface wouldn't change this=20
>    argument).
>
>    You _could_ just make the primary thing be the actual file data, a=
nd=20
>    the blame be "incidental". Which it really is.

Here is an emacs implementation of incremental git-blame.  When you
turn it on while viewing a file, the editor buffer will be updated by
setting the background of individual lines to a color that reflects
which commit it comes from.  And when you move around the buffer, a
one-line summary will be shown in the echo area.

To fix:  The colors are horrible, and work best if you normally
use a dark background.  You can see the list of colors near the top if
you want to change them.

If the file is changed from what is in HEAD, things will obviously be
screwed up.

Usage instructions:  Open a file and type M-x git-blame-mode

;;; git-blame.el

(defvar git-blame-colors
  '("black" "midnight blue" "medium blue" "steel blue"
    "gray2" "gray4" "gray6" "gray8" "gray10" "gray12" "gray14"
    "gray16" "gray18" "gray20" "gray22" "gray24" "gray26" "gray28" "gra=
y30"
    "gray32" "gray34" "gray36" "gray38" "gray40" "gray42" "gray44" "gra=
y46"
    "gray48" "gray56" "gray64" "gray72" "gray80" "gray88" "gray96"))
(defvar git-blame-ancient-color "dark green")

(defvar git-blame-overlays nil)
(defvar git-blame-cache nil)

(defvar git-blame-mode nil)
(make-variable-buffer-local 'git-blame-mode)
(push (list 'git-blame-mode " blame") minor-mode-alist)

(defun git-blame-mode (&optional arg)
  (interactive "P")
  (if arg
      (setq git-blame-mode (eq arg 1))
    (setq git-blame-mode (not git-blame-mode)))
  (make-local-variable 'git-blame-overlays)
  (make-local-variable 'git-blame-colors)
  (make-local-variable 'git-blame-cache)
  (setq git-blame-colors (default-value 'git-blame-colors))
  (if git-blame-mode
      (git-blame-run)
    (git-blame-cleanup)))

(defun git-blame-run ()
  (interactive)
  (let* ((display-buf (current-buffer))
         (blame-buf (get-buffer-create
                     (concat " git blame for " (buffer-name))))
         (proc (start-process "git-blame" blame-buf
                             "git" "blame" "--incremental"
                             (file-name-nondirectory buffer-file-name))=
))
    (mapcar 'delete-overlay git-blame-overlays)
    (setq git-blame-overlays nil)
    (setq git-blame-cache (make-hash-table))
    (with-current-buffer blame-buf
      (erase-buffer)
      (make-local-variable 'git-blame-file)
      (make-local-variable 'git-blame-current)
      (setq git-blame-file display-buf)
      (setq git-blame-current nil))
    (set-process-filter proc 'git-blame-filter)
    (set-process-sentinel proc 'git-blame-sentinel)))

(defun git-blame-cleanup ()
  "Remove all blame properties"
    (mapcar 'delete-overlay git-blame-overlays)
    (setq git-blame-overlays nil)
    (let ((modified (buffer-modified-p)))
      (remove-text-properties (point-min) (point-max) '(point-entered n=
il))
      (set-buffer-modified-p modified)))
   =20

(defun git-blame-sentinel (proc status)
  ;;(kill-buffer (process-buffer proc))
  )

(defvar in-blame-filter nil)

(defun git-blame-filter (proc str)
  (save-excursion
    (set-buffer (process-buffer proc))
    (goto-char (process-mark proc))
    (insert-before-markers str)
    (goto-char 0)
    (unless in-blame-filter
      (let ((more t)
            (in-blame-filter t))
        (while more
          (setq more (git-blame-parse)))))))

(defun git-blame-parse ()
  (cond ((looking-at "\\([0-9a-f]\\{40\\}\\) \\([0-9]+\\) \\([0-9]+\\) =
\\([0-9]+\\)\n")
         (let ((hash (match-string 1))
               (src-line (string-to-number (match-string 2)))
               (res-line (string-to-number (match-string 3)))
               (num-lines (string-to-number (match-string 4))))
           (setq git-blame-current
                 (git-blame-new-commit
                  hash src-line res-line num-lines)))
         (delete-region (point) (match-end 0))
         t)
        ((looking-at "filename \\(.+\\)\n")
         (let ((filename (match-string 1)))
           (git-blame-add-info "filename" filename))
         (delete-region (point) (match-end 0))
         t)
        ((looking-at "\\([a-z-]+\\) \\(.+\\)\n")
         (let ((key (match-string 1))
               (value (match-string 2)))
           (git-blame-add-info key value))
         (delete-region (point) (match-end 0))
         t)
        (t
         nil)))


(defun git-blame-new-commit (hash src-line res-line num-lines)
  (save-excursion
    (set-buffer git-blame-file)
    (let ((info (gethash hash git-blame-cache)))
      (when (not info)
        (let ((color (pop git-blame-colors)))
          (unless color
            (setq color git-blame-ancient-color))
          (setq info (list hash src-line res-line num-lines
                           (cons 'color color))))
        (puthash hash info git-blame-cache))
      (goto-line res-line)
      (while (> num-lines 0)
        (if (get-text-property (point) 'git-blame)
            (forward-line)
          (let* ((start (point))
                 (end (progn (forward-line 1) (point)))
                 (ovl (make-overlay start end)))
            (push ovl git-blame-overlays)
            (overlay-put ovl 'git-blame info)
            (overlay-put ovl 'help-echo hash)
            (overlay-put ovl 'face (list :background
                                         (cdr (assq 'color (cddddr info=
)))))
            ;;(overlay-put ovl 'point-entered
            ;;             `(lambda (x y) (git-blame-identify ,hash)))
            (let ((modified (buffer-modified-p)))
              (put-text-property (if (=3D start 1) start (1- start)) (1=
- end)
                                 'point-entered
                                 `(lambda (x y) (git-blame-identify ,ha=
sh)))
              (set-buffer-modified-p modified))))
        (setq num-lines (1- num-lines))))))

(defun git-blame-add-info (key value)
  (nconc git-blame-current (list (cons (intern key) value))))

(defun git-blame-current-commit ()
  (let ((info (get-char-property (point) 'git-blame)))
    (if info
        (car info)
      (error "No commit info"))))

(defun git-blame-identify (&optional hash)
  (interactive)
  (shell-command
   (format "git log -1 --pretty=3Doneline %s" (or hash
                                                (git-blame-current-comm=
it)))))


--=20
David K=C3=A5gedal
