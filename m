From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] Provide a build time default-editor setting
Date: Sat, 31 Oct 2009 16:21:45 -0500
Message-ID: <20091031212144.GA5022@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091031014441.GH5160@progeny.tock>
 <7vfx90co1e.fsf@alter.siamese.dyndns.org>
 <20091031032647.GA5583@progeny.tock>
 <7vzl775ol5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 22:15:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4LIC-0002uK-N7
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 22:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbZJaVLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 17:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbZJaVLW
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 17:11:22 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:33047 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933275AbZJaVLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 17:11:21 -0400
Received: by ywh40 with SMTP id 40so3581340ywh.33
        for <git@vger.kernel.org>; Sat, 31 Oct 2009 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GtFvUTLfRd1RCT994jSxdK7/uqFk7lLkgPy9yqewadA=;
        b=Y1UWjlkSjwaPeW4UbazTpQWHG5A8o1uvDnd/6qtL4+a3Hex/3LtYSQcFPvN3lQgo6X
         f1W2gSPj2zu94/EEOdk+qZRS4cZJeN5l9WKdXNYurdvuhVkkTld//stvmOMr68FPEdhz
         3IcM32Zf23xhBVQkLLm/7z/Ln6phxD69rFORg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D4PbzXu1FMfXdZmV6+sjU/IweCBSNLHYoycE1Q0J3jiB3Fl0zfDDP4Zhi9Z0Wuv0uT
         Z3r2cvCXa5ARMYCBWyFq0pytaChJ0DkQkIrojfTnwqo43DxLFTdRMsHKY+9UU9BLtQLP
         Zi2m+iHUQRkHoYIKlolDKAHvPDHc3OxMPjiE8=
Received: by 10.91.97.9 with SMTP id z9mr2615335agl.46.1257023486091;
        Sat, 31 Oct 2009 14:11:26 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm514951yxg.24.2009.10.31.14.11.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Oct 2009 14:11:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzl775ol5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131858>

Junio C Hamano wrote:

> Honestly speaking, my preference is to see if the built-in editor is
> exactly spelled as 'v' 'i', and skip this test altogether if it isn't.

That does make sense.  But let me try one last time, before doing
that.  (I should have sat down and thought this through carefully
before sending the first version --- sorry.)

Though the first two iterations of the patch were pretty ugly, the
third was just 's/vi/"$editor"/g' after setting editor and bailing out
if it does not consist of lowercase letters.  As you mentioned, it
makes more sense to skip only the "vi" part of the test.

Tested with DEFAULT_EDITOR=vi, vim, /usr/bin/nonexistent.

 t/t7005-editor.sh |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index a95fe19..5257f4d 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -4,7 +4,21 @@ test_description='GIT_EDITOR, core.editor, and stuff'
 
 . ./test-lib.sh
 
-for i in GIT_EDITOR core_editor EDITOR VISUAL vi
+unset EDITOR VISUAL GIT_EDITOR
+
+test_expect_success 'determine default editor' '
+
+	vi=$(TERM=vt100 git var GIT_EDITOR) &&
+	test -n "$vi"
+
+'
+
+if ! expr "$vi" : '^[a-z]*$' >/dev/null
+then
+	vi=
+fi
+
+for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
 do
 	cat >e-$i.sh <<-EOF
 	#!$SHELL_PATH
@@ -12,19 +26,18 @@ do
 	EOF
 	chmod +x e-$i.sh
 done
-unset vi
-mv e-vi.sh vi
-unset EDITOR VISUAL GIT_EDITOR
+
+if ! test -z "$vi"
+then
+	mv e-$vi.sh $vi
+fi
 
 test_expect_success setup '
 
-	msg="Hand edited" &&
+	msg="Hand-edited" &&
+	test_commit "$msg" &&
 	echo "$msg" >expect &&
-	git add vi &&
-	test_tick &&
-	git commit -m "$msg" &&
-	git show -s --pretty=oneline |
-	sed -e "s/^[0-9a-f]* //" >actual &&
+	git show -s --format=%s > actual &&
 	diff actual expect
 
 '
@@ -54,7 +67,7 @@ test_expect_success 'dumb should prefer EDITOR to VISUAL' '
 
 TERM=vt100
 export TERM
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	unset EDITOR VISUAL GIT_EDITOR
@@ -78,7 +91,7 @@ done
 
 unset EDITOR VISUAL GIT_EDITOR
 git config --unset-all core.editor
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	case "$i" in
