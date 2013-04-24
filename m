From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Wed, 24 Apr 2013 19:52:01 +0200
Message-ID: <vpq8v47q0ji.fsf@grenoble-inp.fr>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-8-git-send-email-artagnon@gmail.com>
	<CABURp0onypkDFiovYP4s0UuBV+oFp3rPv1Jq8dGbxZhKU_sgsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3rY-0003eq-JY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131Ab3DXRwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:52:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46810 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757045Ab3DXRwG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:52:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3OHpxYA016043
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Apr 2013 19:51:59 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UV3rO-00058c-39; Wed, 24 Apr 2013 19:52:02 +0200
In-Reply-To: <CABURp0onypkDFiovYP4s0UuBV+oFp3rPv1Jq8dGbxZhKU_sgsQ@mail.gmail.com>
	(Phil Hord's message of "Tue, 23 Apr 2013 18:45:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 24 Apr 2013 19:51:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3OHpxYA016043
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367430720.68275@Cclw4IxRmsjJBWp/CLggFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222280>

Phil Hord <phil.hord@gmail.com> writes:

> Because I am in a git-rebase which has apparently failed, I would
> expect 'git rebase --abort' would save me here.  

More generally, if I "git rebase --abort" in the middle of a rebase (not
necessarily at the end), I'd expect the stash to be restored. Right now,
if I read correctly, "git rebase --abort" would discard the stashed
changes without giving me the sha1 I'd need to use to recover it :-(.

Recovering the stash should be doable with stg like

--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -341,6 +341,11 @@ abort)
                ;;
        esac
        output git reset --hard $orig_head
+       if test -f "$state_dir/autostash"
+       then
+           stash_sha1=$(cat "$state_dir/autostash")
+           git stash apply $stash_sha1
+       fi
        rm -r "$state_dir"
        exit
        ;;

the "stash apply" should succeed without conflict by construction
because the stash is applied on the commit it was created.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
