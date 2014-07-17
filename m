From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9r2 1/2] add `config_set` API for caching config-like files
Date: Thu, 17 Jul 2014 13:34:54 +0200
Message-ID: <vpqiomwmd5t.fsf@anie.imag.fr>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
	<53C665A0.2060705@gmail.com> <vpqvbqxjzfx.fsf@anie.imag.fr>
	<53C66E70.3050507@gmail.com> <vpqha2h9tjw.fsf@anie.imag.fr>
	<53C6ABEB.3060205@gmail.com> <vpqzjg9z115.fsf@anie.imag.fr>
	<53C6C2BD.3030703@gmail.com> <vpqvbqwpalt.fsf@anie.imag.fr>
	<53C7AE43.5080402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 13:35:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7jy0-0007N5-SY
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 13:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbaGQLfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 07:35:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38756 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607AbaGQLfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 07:35:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6HBYrmW019118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jul 2014 13:34:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6HBYsU0006238;
	Thu, 17 Jul 2014 13:34:54 +0200
In-Reply-To: <53C7AE43.5080402@gmail.com> (Tanay Abhra's message of "Thu, 17
	Jul 2014 16:36:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 17 Jul 2014 13:34:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6HBYrmW019118
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406201694.81107@GOyLWw8lb7KmH5lem8CbuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253732>

Tanay Abhra <tanayabh@gmail.com> writes:

> I am searching for a more elegant solution to this problem.

The "efficient" (not sure about elegant) solution would be to keep one
configset per file, and re-parse only the files needed.

I find the solution I posted in the other thread relatively "elegant":
invalidate the config cache when things change.

The last test failure seems more tricky. This (dirty) patch fixes the
failure:

--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -255,6 +255,8 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
        return run_diff_files(revs, options);
 }
 
+int git_config_raw(config_fn_t fn, void *data);
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
        int i;
@@ -317,7 +319,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
        if (!no_index)
                gitmodules_config();
-       git_config(git_diff_ui_config, NULL);
+       git_config_raw(git_diff_ui_config, NULL);
 
        init_revisions(&rev, prefix);
 

But this one does not:

diff --git a/builtin/diff.c b/builtin/diff.c
index 0f247d2..2012e81 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -317,7 +317,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
        if (!no_index)
                gitmodules_config();
+       git_config_clear();
        git_config(git_diff_ui_config, NULL);
+       git_config_clear();
 
        init_revisions(&rev, prefix);
 

So it's not just a matter of invalid cache not cleared, it's a real
difference between git_config() and git_config_raw(). The guilty part is
probably userdiff_config(const char *k, const char *v) in userdiff.c,
that parses the xfuncname config option.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
