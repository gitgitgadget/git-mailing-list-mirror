From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] A loose object is not corrupt if it cannot be read
 due to EMFILE
Date: Thu, 18 Nov 2010 17:43:00 +0100
Message-ID: <4CE55794.7050201@viscovery.net>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com> <1288299210-27092-2-git-send-email-gitster@pobox.com> <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 18 17:43:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ7Zo-00065C-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 17:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758891Ab0KRQnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 11:43:06 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19918 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab0KRQnF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 11:43:05 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PJ7Zc-0001dQ-QC; Thu, 18 Nov 2010 17:43:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 857211660F;
	Thu, 18 Nov 2010 17:43:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161684>

Am 11/18/2010 15:19, schrieb Erik Faye-Lund:
> What happens, is that read_object returns NULL, but errno is 0.
> Further, it looks to me like read_object can only return NULL through
> the unpack_sha1_file (problem with the compressed data) or
> read_packed_sha1 (find_pack_entry() failure) code-paths.
> 
> errno is set to ENOENT by open_sha1_file (through map_sha1_file)
> before any possible error-points. I guess this makes the "errno = 0"
> redundant, but I think it improves readability of the code. I'm
> guessing that errno gets overwritten by some other call, losing the
> ENOENT. Perhaps some unintended side-effect of one of the
> compat/mingw.[ch]-wrappers?

The problem is in opendir() called via prepare_packed_git_one() via
prepare_packed_git(). It resets errno to 0 on success.

You can test this easily by inserting test_done after the 3rd test of
t5530 and run it with --debug; in the trash-directory you can run

  ../../git-pack-objects --revs --all --stdout >/dev/null </dev/null

and observe the different failure modes on Windows and Linux.

This makes me question whether the approach of Junio's fix is sane. It
depends on errno being set *way* before it is checked and after *a*lot* of
potentially failing system and library calls have been called. Which
function is it that is expected to fail with ENOENT? git_open_noatime()?

-- Hannes
