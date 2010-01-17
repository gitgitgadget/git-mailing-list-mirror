From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Performance optimization for detection of modified submodules
Date: Sun, 17 Jan 2010 21:33:54 +0100
Message-ID: <4B537432.3020201@web.de>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de> <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de> <7v6375lkpj.fsf@alter.siamese.dyndns.org> <4B4F8EF1.3080709@web.de> <7v3a288em2.fsf@alter.siamese.dyndns.org> <4B535E97.1020809@web.de> <7vska4xzzf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 21:34:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWbov-0004h4-Ks
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 21:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab0AQUd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 15:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428Ab0AQUd4
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 15:33:56 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:47788 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0AQUd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 15:33:56 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id DE82B14C19103;
	Sun, 17 Jan 2010 21:33:54 +0100 (CET)
Received: from [80.128.115.167] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWboo-0002CL-00; Sun, 17 Jan 2010 21:33:54 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vska4xzzf.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/5du2/qFfqBSA2NGprZ23shWedIGIg64JbINus
	uAnrBJ7J32UtCcw2qH6ZxheJfIXl5uxJjc6KpB3rs0wprhDRVd
	JGyhFr04nW7W+yCIdp3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137317>

Am 17.01.2010 21:01, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> So here is my first attempt of implementing your proposal. The test suite
>> runs fine, but a few more eyeballs would really be appreciated as i am not
>> very familiar with the code and its corner cases (See diff_change(), is it
>> sufficient to only set "two->dirty_submodule", even if the REVERSE_DIFF
>> option is set? Apart from that i am not so sure about the four changes to
>> tree-diff.c).
> 
> The effect of REVERSE_DIFF bit is contained in the output layer.  The
> order frontends (e.g. diff-files and diff-lib.c::run_diff_files()) feed
> the entries from two hierarchies is not affected.
> 
> The current callers of addremove() may always give the work tree side as
> the second one, but the API is meant to be usable by any other new callers
> and for some of them feeding the work tree side as the first one _might_
> be more sensible (we are talking about futureproofing, so by definition we
> won't know).  It might even be the case where an unanticipated new caller
> might be comparing two trees both living in the work tree (hence you might
> require two independent dirty_submodule bits to the call to show which
> side is dirty, and such a caller may say "both sides are dirty").
> 
> So it would be most future-proof if you add two independent "dirty" bits
> to the API if you are changing it: "is the left side of the comparision a
> dirty submodule?" and "is the right side ...?".  Especially I don't think
> assuming "setting two->dirty is enough for the current implementation" is
> the right way going forward.

Thanks for your explanation, will provide two independent dirty_submodule
bits there.


>> I think we could skip the call to is_submodule_modified() in
>> run_diff_files() and get_stat_data() when the changed flag is already
>> set and only short output (without calling diff_populate_gitlink(), e.g.
>> "git status -s" or "git diff-files") is requested.
> 
> I am puzzled by your "we could skip"; isn't it what you already have done
> in this patch?  More importantly, I think that is the whole point of the
> change to diff API this patch brings in.

This patch was about calling is_submodule_modified() /only once/, either
in run_diff_files() or in get_stat_data(), and reuse the result. But i
think we don't have to call it /at all/ when for example executing "git
status -s" and the HEAD of the submodule does not match the commit in the
index of the superproject. This information is enough to display an 'M'.
No need to check the submodule work tree for dirtyness, as it won't
change the output of the command anymore.
