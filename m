From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: t2017 test failure in pu
Date: Mon, 08 Sep 2014 11:56:03 +0100
Message-ID: <540D8B43.9060806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 12:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQwcF-0007yC-SR
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 12:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbaIHK4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 06:56:07 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41683 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753033AbaIHK4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 06:56:06 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 2AD50384089;
	Mon,  8 Sep 2014 11:55:32 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D8035384084;
	Mon,  8 Sep 2014 11:55:31 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Mon,  8 Sep 2014 11:55:31 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256639>

Hi Junio,

The current 'pu' branch has a test failure for me, namely test
t2017-checkout-orphan.sh #9.

I had a quick squint at the conflict resolution in commit acdbdf99 and
the only thing that seemed relevant was the dropping of the
'log_all_ref_updates' dance. So, I quickly put it back, like so:

    diff --git a/builtin/checkout.c b/builtin/checkout.c
    index 18a4519..de27a1b 100644
    --- a/builtin/checkout.c
    +++ b/builtin/checkout.c
    @@ -602,9 +602,15 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
     		if (opts->new_orphan_branch) {
     			if (opts->new_branch_log && !log_all_ref_updates) {
     				const char *ref_name;
    +				int ret, temp;
     
     				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
    -				if (create_reflog(ref_name)) {
    +				temp = log_all_ref_updates;
    +				log_all_ref_updates = 1;
    +				ret = create_reflog(ref_name);
    +				log_all_ref_updates = temp;
    +
    +				if (ret) {
     					fprintf(stderr, _("Can not do reflog for '%s'\n"),
     					    opts->new_orphan_branch);
     					return;

and everything works again. (I've only just noticed that the 'dance'
is now within a conditional such that "!log_all_ref_updates" is true, so
that the above can be simplified!)

I guess 'create_reflog' should be called 'maybe_create_reflog' :-D

HTH

ATB,
Ramsay Jones
