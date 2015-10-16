From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] stripspace: Use parse-options for command-line parsing
Date: Fri, 16 Oct 2015 10:29:35 -0700
Message-ID: <xmqqd1weg1s0.fsf@gitster.mtv.corp.google.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-3-git-send-email-tklauser@distanz.ch>
	<xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn8p3-0003mP-TY
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbbJPR3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:29:38 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35089 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbbJPR3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:29:37 -0400
Received: by padcn9 with SMTP id cn9so11269536pad.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=h1eFEBUVS5UH8wWpvAgW5O4Zku5nGGr0ll2aAqV6v5Y=;
        b=B5DxTym23wD4IpMxsh4sNAoRKph4A2M+y/xCVKRsD5bVoyxPMDQC72XOD9grsxDbTp
         LsCz/MUPxLmelGrGSAi3GIxwZpRBrZHohs5QFm9uGmcvuM0dm6EbXPO9B3pNzzGb66/h
         FlyeWoHZhA313WfMwzY6NiLNobQv02QjtHIHzNvFteRSpNGFrts9l3KAJJ1+WPrSsfOx
         haTxNh6dAB4ryWA0Nh0fgrzbiJK7QKTR4L2BzYqIK23xltLXr05YnMuzBg6FBrxZ8FCh
         m7EGhUVAZTuMfkKTqKpQdaZAvrk9IKl2BxEouGZ8SwEQXecUgFZ7lcWIDINVn+AzVU7R
         Wofw==
X-Received: by 10.66.253.99 with SMTP id zz3mr17660332pac.38.1445016577023;
        Fri, 16 Oct 2015 10:29:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id uc1sm22414922pab.20.2015.10.16.10.29.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 10:29:36 -0700 (PDT)
In-Reply-To: <xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 16 Oct 2015 10:07:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279757>

Junio C Hamano <gitster@pobox.com> writes:

>> -	if (mode == INVAL)
>> -		usage(usage_msg);
>
> When given "git stripspace -s blorg", we used to set mode to INVAL
> and then showed the correct usage.  But we no longer have a check
> that corresponds to the old INVAL thing, do we?  Perhaps check argc
> to detect presence of an otherwise ignored non-option argument
> immediately after parse_options() returns?

Perhaps like this.

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index ac1ab3d..a8b7a93 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -40,8 +40,9 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, stripspace_usage,
-			     PARSE_OPT_KEEP_DASHDASH);
+	argc = parse_options(argc, argv, prefix, options, stripspace_usage, 0);
+	if (argc)
+		usage_with_options(stripspace_usage, options);
 
 	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
 		git_config(git_default_config, NULL);
