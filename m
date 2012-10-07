From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 3/5] diff: acknowledge --submodule=short command-line
 option
Date: Sun, 07 Oct 2012 21:49:28 +0200
Message-ID: <5071DCC8.50004@web.de>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com> <1349196670-2844-4-git-send-email-artagnon@gmail.com> <506B3F74.3020208@web.de> <CALkWK0mbQZjYUR73rdFP2BtOzdL9gQqxnC5fjtsCYq2F29=8qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 21:49:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKwrB-0002zb-3K
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 21:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab2JGTte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 15:49:34 -0400
Received: from mout.web.de ([212.227.15.3]:53647 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab2JGTtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 15:49:33 -0400
Received: from [192.168.178.41] ([91.3.178.130]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0M8zOD-1TFCEQ1OzF-00D9Iw; Sun, 07 Oct 2012 21:49:31
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CALkWK0mbQZjYUR73rdFP2BtOzdL9gQqxnC5fjtsCYq2F29=8qg@mail.gmail.com>
X-Provags-ID: V02:K0:1kdxjbfrXorHeFO/z+AgFmzxuXCf3rulj/kpKMIQfSU
 afkFiHtyd/mXmRmo7THwHHPqyArhMU1ejui4QSbTWOTBEL9wRJ
 xxsAbSVIiNN9aWJ9PDmT2bdV3hxaUbkf8VCnjjD6GV2LTacf/1
 eEsy/1P/buLkNxdw4alXhmMvKr0j72VaiRsOBBy8l3ecYP/QzJ
 DwKbIF6MCAatLBjcY2PIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207188>

Am 07.10.2012 17:22, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> Am 02.10.2012 18:51, schrieb Ramkumar Ramachandra:
>>> Currently, the diff code does not differentiate between an explicit
>>> '--submodule=short' being passed, and no submodule option being passed
>>> on the command line.  Making this differentiation will be important
>>> when the command-line option can be used to override a
>>> "diff.submoduleFormat" configuration variable introduced in the next
>>> patch.
>>
>> Wouldn't it be sufficient here to simply reset the log flag by using
>> "DIFF_OPT_CLR(options, SUBMODULE_LOG)"? This would avoid having to
>> use the last bit of the diffopt flags. And if I read the code correctly,
>> diff_opt_parse() is called by setup_revisions() which is called after
>> git_config(), so that should be safe. (And "textconv" uses the same
>> approach)
> 
> How is it sufficient?  In git_diff_ui_config(), I set
> submodule_format_cfg, which has nothing to do with SUBMODULE_LOG.  In
> builtin_diff(), I'll have to check SUBMODULE_LOG and
> submodule_format_cfg.  The tricky bit is that I should check
> submodule_format_cfg if and only if "--submodule=short" was NOT passed
> on the command line-  now, that's not the same thing is checking if
> SUBMODULE_LOG is unset, because SUBMODULE_LOG is unset (or cleared) if
> no argument was passed or if "--submodule=short" is passed.
> Therefore, I need a SUBMODULE_SHORT to differentiate between the two
> cases.
> 
> What am I missing?

I forgot to mention that testing submodule_format_cfg would have to
happen in cmd_diff() (between reading the config and parsing the
command line options) instead of builtin_diff(). Something like this
should do the trick (untested):

diff --git a/builtin/diff.c b/builtin/diff.c
index 9650be2..180bf44 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -297,6 +297,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix
        DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
        DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);

+       if (submodule_format_cfg && !strcmp(submodule_format_cfg, "log"))
+               DIFF_OPT_SET(options, SUBMODULE_LOG);
+
        if (nongit)
                die(_("Not a git repository"));
        argc = setup_revisions(argc, argv, &rev, NULL);
