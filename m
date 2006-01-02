From: Gerrit Pape <pape@smarden.org>
Subject: cogito: commit message from stdin and -m switch
Date: Mon, 2 Jan 2006 12:13:13 +0000
Message-ID: <20060102120709.13166.qmail@5a5356efda0133.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 02 13:07:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtOT5-0003Gn-1a
	for gcvg-git@gmane.org; Mon, 02 Jan 2006 13:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWABMHC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jan 2006 07:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWABMHA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jan 2006 07:07:00 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:60338 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1750844AbWABMG7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jan 2006 07:06:59 -0500
Received: (qmail 13167 invoked by uid 1000); 2 Jan 2006 12:07:09 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14139>

Hi, cg-commit(1) states

-m MESSAGE
       Specify the commit message, which is used instead of starting up
       an editor (if the input is not  stdin,  the  input  is  appended
       after  all the -m messages). Multiple -m parameters are appended
       to a single commit message, each as separate paragraph.

What happens is that the message on stdin overrides the message given
through the -m switch:

 $ cg-init -m initial
 defaulting to local storage area
 Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
 Committed as 4db6889339c6d6775b18673f12bc91adf86f1c2c.
 $ touch foo
 $ cg-add foo
 Adding file foo
 $ echo 'message1' |cg-commit -m 'message0'
 A foo
 Committed as 99d2bbca8ac65fa0c0af7c7536228f4b9470e70f.
 $ cg-log |head
 commit 99d2bbca8ac65fa0c0af7c7536228f4b9470e70f
 tree 4d5fcadc293a348e88f777dc0920f11e7d71441c
 parent 4db6889339c6d6775b18673f12bc91adf86f1c2c
 author Gerrit Pape <pape@smarden.org> Mon, 02 Jan 2006 12:07:59 +0000
 committer Gerrit Pape <pape@smarden.org> Mon, 02 Jan 2006 12:07:59 +0000
 
     message1
 
 commit 4db6889339c6d6775b18673f12bc91adf86f1c2c
 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
 $ 

This also breaks the selftests with stdin not connected to a terminal
(so in Debian package autobuilder environment):

 $ make
 Generating cg-version...
 $ make test </dev/null 
 make -C t/ all
 make[1]: Entering directory
 `/usr/local/src/Debian/Upstream/GIT/cogito/t'
 *** t9000-init.sh ***
 *   ok 1: initialize w/o the initial commit
 [...]
 * FAIL 16: check if the commit is proper
         [ "$(git-cat-file commit HEAD | sed -n '/^parent/q; /^$/{n; :a p; n; b a}')" = "silly commit message
 
         continued" ]
 *   ok 17: blow away the repository
 [...]
 $ 

Regards, Gerrit.
