From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Wed, 14 Nov 2007 03:02:24 -0800
Message-ID: <7vir45hyyn.fsf@gitster.siamese.dyndns.org>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Nov 14 12:02:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsG1C-0001PO-7f
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 12:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbXKNLCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 06:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXKNLCd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 06:02:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56946 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbXKNLCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 06:02:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D8B0E2EF;
	Wed, 14 Nov 2007 06:02:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 560BF946FF;
	Wed, 14 Nov 2007 06:02:50 -0500 (EST)
In-Reply-To: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
	(Johannes Sixt's message of "Tue, 13 Nov 2007 21:04:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64980>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> This is a series of smallish, unrelated changes that were necessary
> for the MinGW port.

I was _VERY_ afraid of reviewing this series.

> [PATCH 05/11] Use is_absolute_path() in sha1_file.c.
> [PATCH 06/11] Move #include <sys/select.h> and <sys/ioctl.h> to
> 	git-compat-util.h.
>
> These two are certainly undisputed.

Except on esoteric/broken systems there might be some dependency
on the order the system include files are included, so 06/11
needs some testing.  But it is a change in the right direction.

> [PATCH 07/11] builtin run_command: do not exit with -1.
>
> Replaces exit(-1) by exit(255). I don't know if this has any bad
> consequences on *nix.

Linux manual page says "the value of status & 0377 is returned
to the parent", which agrees with POSIX's "only the least
significant 8 bits(that is, status & 0377) shall be available to
a waiting parent process".  So I think we are safe on conforming
platforms.

> [PATCH 08/11] Close files opened by lock_file() before unlinking.
>
> This one was authored by Dscho. It is a definite MUST on Windows.

This was something we've talked about doing a few times on the
list but did not.  It is good that this saw some testing in the
field, as it is easy to get wrong while moving the call site of
close(2) around.

> [PATCH 09/11] Allow a relative builtin template directory.
> [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
> 	of ETC_GITCONFIG.
> [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
>
> These need probably some discussion. They avoid that $(prefix) is
> hardcoded and so allows that an arbitrary installation directory.

I had to worry a bit about bootstrapping issues in 11/11.  We
need to ensure that anybody who wants to read the configuration
data first does setup_path() because git_exec_path() reads from
argv_exec_path and setup_path() is what assigns to that
variable.

But other than that and 08/11, I found everything is trivially
correct and it was a pleasant read.

Thanks.
