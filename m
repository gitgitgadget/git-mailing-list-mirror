From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/16] nd/list-files redesign
Date: Mon,  9 Mar 2015 17:18:18 +0700
Message-ID: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:18:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUum0-0001F7-Tx
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbbCIKSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 06:18:52 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:39164 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbbCIKSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:18:51 -0400
Received: by pabrd3 with SMTP id rd3so38079254pab.6
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=K/o6KKEziSGnleHWnzmvkY1A6hAa8/lZ1CQIEkvZLfE=;
        b=ROoPLDV1r0xpYEefyb76H4gKtViBc/Hg7Jv+rJ63yHDmZmrDzUmDfzOkgZ6BlKcZFy
         +L7LZrjvC5qXD6lSTm5WHt0hbIvueRMGV8LaTcPYFCvD38AjhI02iOI50T24340xg3QD
         +1VuJHbglpf5g2wCO0RnRBkEogcII8qAcB9ICx13zPplju4WYBfV16JygWw761K+fwJa
         dbpJXSFkPw/f7DofBmEV25Sbm4wlQdCB0iTbRFO2SutAQLUBbb0+b3KqXOHawWBRvS7u
         nc+9ye/Lr9ShY3pcq0RrpTrE4fPyq8oT0Sp0kGuWDHo9mp1Ce5Y1vkSh+v8UQANiBszL
         K/gA==
X-Received: by 10.70.61.161 with SMTP id q1mr16079114pdr.33.1425896330598;
        Mon, 09 Mar 2015 03:18:50 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id qp3sm18490603pdb.11.2015.03.09.03.18.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:18:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:18:46 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265142>

On Tue, Feb 24, 2015 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> status, status -s and the like are in an ordinary user's tool box.
>> ls-files isn't, at least not with "-t", which we even mark as deprecated.
>>
>> That makes me wonder, though, how difficult it would be to
>> wt_status_collect_unchanged() and to leverage the status machinery
>> rather than ls-files.
>
> Good point.  wt-status feels like a much better infrastructure to
> build on than "ls-files -t", which should die ;-).  Especially if
> the command is interested in showing the state of the working tree
> files relative to the tree of HEAD, as "ls-files" is purely between
> the index and the working tree.

So here it is. Except the first 4 patches identical with
'nd/list-files' in 'pu' and not reposted here, the rest is rewritten
using wt-status.c as the base.  Documentation and tests are missing.
Probably bugs lurking too. I just want to check if the UI makes sense.
Full series is available at

    https://github.com/pclouds/git/commits/ls

if you want to pull and try out quickly. With this we got:

usage: git list-files [options] [<pathspec>...]

Filter options
    -c, --cached          show cached files (default)
    -o, --others          show untracked files
    -i, --ignored         show ignored files
    -u, --unmerged        show unmerged files
    -a, --added           show added files compared to HEAD
    -d, --deleted         show deleted files compared to HEAD
    -m, --modified        show modified files compared to HEAD
    -A, --wt-added        show added files in worktree
    -D, --wt-deleted      show deleted files in worktree
    -M, --wt-modified     show modified files on worktree

Other
    -C, --column[=<style>]
                          show files in columns
    -1                    shortcut for --no-column
    --max-depth <depth>   descend at most <depth> levels
    -R, --recursive       shortcut for --max-depth=-1
    --color[=<when>]      show color
    -F, --classify        append indicator (one of */=>@|) to entries

Any filter option can be combined with others. Status code is the same
with 'git status --porcelain'. In fact options -[iouadmADM] are
basically the 'git status --porcelain' with bells and whistles.
-- 
2.3.0.rc1.137.g477eb31
