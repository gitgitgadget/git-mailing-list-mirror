From: "Nazri Ramliy" <ayiehere@gmail.com>
Subject: [PATCH (Eek!)] git diff does not honor --no-ext-diff
Date: Wed, 26 Nov 2008 15:12:25 +0800
Message-ID: <544dda350811252312u7ef5533bwb20b37640d861487@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 08:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Eb4-00070F-5C
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 08:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbYKZHM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 02:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbYKZHM1
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 02:12:27 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:59933 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbYKZHM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 02:12:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so336466rvb.1
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 23:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qyq/m9IGabtNQ7WdmWo95UAMT7o7x8nto4RfwtR+SQo=;
        b=CNCcvwq2JRT2hvYaiBHqo4+4zo/uWDtR/1cWNHXjVQK+niD0nh+C7fzYxk37lWIhZl
         YqVIL2SJl1OOD+ZZAvct0m5dqnozkcTedoOek95j7pnWXYnfy5TYdZpMgiw9dPilqCHp
         WwXQN3iyE2wFI2sAi2Mxc7ArEkoRQVwVRRhN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=CBimV/32x+27Cz0rycRfRTbrZHOSj8DEbJhklWie9Iv7r93hu+tPPxcu8jOFsznoTg
         vHn5u8mq4FelTKW5WbeeRmVSzKlH0SDmITYMhMK7I62uz8Txc9kd+hADSfEwzXJfXIuh
         qvylcD5tr0wP+TlGlZKKml9dPzptSQ1EUxM5M=
Received: by 10.142.134.20 with SMTP id h20mr2485186wfd.178.1227683545447;
        Tue, 25 Nov 2008 23:12:25 -0800 (PST)
Received: by 10.143.107.3 with HTTP; Tue, 25 Nov 2008 23:12:25 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101706>

Hello list,

git-diff does not honor the --no-ext-diff option in both cases when the external
diff program is set via diff.external and gitattributes.

Is this intentional? If not the following patch seems to fix it.

I think there must be a cleaner way of fixing this than doing it by
`hand' hence the Eek!

Nazri.

 builtin-diff.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 7ceceeb..4ac7e15 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -290,6 +290,19 @@ int cmd_diff(int argc, const char **argv, const
char *prefix)
        /* Otherwise, we are doing the usual "git" diff */
        rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;

+       DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
+       /*
+        * Do we have --no-ext-diff and have external diff setup via either
+        * gitconfig or gitattributes, then clear ALLOW_EXTERNAL by hand.  Eek.
+        */
+       for (i = 1; i < argc; i++) {
+               const char *arg = argv[i];
+               if (!strcmp(arg, "--"))
+                       break;
+               else if (!strcmp(arg, "--no-ext-diff"))
+                       DIFF_OPT_CLR(&rev.diffopt, ALLOW_EXTERNAL);
+       }
+
        if (nongit)
                die("Not a git repository");
        argc = setup_revisions(argc, argv, &rev, NULL);
@@ -298,7 +311,6 @@ int cmd_diff(int argc, const char **argv, const
char *prefix)
                if (diff_setup_done(&rev.diffopt) < 0)
                        die("diff_setup_done failed");
        }
-       DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
        DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
        DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
