From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [PATCH/RFC] test-lib: clean up trash* directories on SIGINT
Date: Sun, 11 Jul 2010 09:51:02 +0000
Message-ID: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 11 11:51:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXtBn-0000EC-TQ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 11:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab0GKJvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 05:51:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35098 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab0GKJvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 05:51:03 -0400
Received: by iwn7 with SMTP id 7so3676131iwn.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=eumnIVFZIMMLxQtRaz3z/la09DAWFEhBvmEJt9KLuQU=;
        b=x8iKC1GURvRrV8JtuL2MUl2nnkmaQVHKA+lSARoog8XmlEK4v+lDzM34OtGxU+GSqf
         z/H2shbAdNXG7BKd1dXg9mG6rdFqZPuzl4x7bJy9uoOOZQwfIQPQ7J8nCMmEVpVw97Bb
         FcIQEunsN/DRvPBtLDlEn0qljlN4l3AWWG7PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=AMOqecu5SrtZEh595zux1caTQUBqIsuDMH46scjTFCLTEfhBSuAwDwPQ/FIWdzBDbn
         gcB2by7oeLUYaIK06kMIP+ne/x+40vPb9l6CKgf84mwcwr7vy1Y0kW7xRsZz6u/0osbe
         4UUt40Tmvh8uVr8tmvphNutcb4IEHsuxe6qt4=
Received: by 10.231.184.1 with SMTP id ci1mr12793441ibb.39.1278841862383; Sun, 
	11 Jul 2010 02:51:02 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 11 Jul 2010 02:51:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150771>

Is there any reason not to remove trash directories on SIGINT? It's
annoying that trash directories are left when I cancel a test run.

I can submit an actual patch along these lines once Junio applies some
of my other stuff which will probably conflict with any finalized
patch.

Is "trap 'foo' INT" a bashism? Is "trap 'foo' SIGINT" more portable?
How about the exit code from an INT handler, what should it be?

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac496aa..e4a0fc9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -222,6 +222,17 @@ die () {
 GIT_EXIT_OK=
 trap 'die' EXIT

+git_interrupted () {
+       test -d "$remove_trash" &&
+       cd "$(dirname "$remove_trash")" &&
+       rm -rf "$(basename "$remove_trash")"
+
+       # What my shell normal exits on on sigint
+       exit 130
+}
+
+trap 'git_interrupted' INT
+
 # The semantics of the editor variables are that of invoking
 # sh -c "$EDITOR \"$@\"" files ...
 #
