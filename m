From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] clone: do not include authentication data in guessed dir
Date: Wed, 05 Aug 2015 12:41:27 -0700
Message-ID: <xmqqmvy534m0.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438769179-5943-1-git-send-email-ps@pks.im>
	<1438769179-5943-2-git-send-email-ps@pks.im>
	<xmqqzj253a39.fsf@gitster.dls.corp.google.com>
	<xmqqr3nh34tv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sunshine@sunshineco.com, pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:41:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN4ZB-0008Se-Vf
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 21:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbbHETla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 15:41:30 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36231 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbHETl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 15:41:29 -0400
Received: by pdco4 with SMTP id o4so22326705pdc.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wZjJwEN4CsFyJtxiNhLBHLVFc5XUpdQnUO0paWKAgyY=;
        b=ot7II20IgAen0PBNyQJC+tMqBI4KW1PawDxtmbKb0uniFE/JPu79p1lE0C6lBlZ2eh
         tVNyikdvUnXpQeeCQp9tafoZF9w96o1DTdbg6ljUxuqQZ2f21CD2Sr4tsqNyYZj+wXf2
         atNIlq8oDNRZmPJh93fdlnRMDQOsKAnIkCA3Sit5HMBI8f3//YeHrVt3ZRCHLbtobw4H
         e+G3qNvuWOAEo1heZybQG0NwQiIGRIuP6qIeEi/oikdddLw5F4bEj311FSKIOBnPEv3C
         Hcl5ZRg+Dufd3uyIK2QZXClQN53nQ8lBrWdeNXJ6fyLWanBky+ZAGf9u840r5dTqYeka
         f05g==
X-Received: by 10.70.65.5 with SMTP id t5mr23121473pds.16.1438803689133;
        Wed, 05 Aug 2015 12:41:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id nn13sm3790969pdb.93.2015.08.05.12.41.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 12:41:28 -0700 (PDT)
In-Reply-To: <xmqqr3nh34tv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Aug 2015 12:36:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275389>

Junio C Hamano <gitster@pobox.com> writes:

> For completeness, here is what I think the end result (together with
> Peff's series) of the test should look like.
> ...
> Note that ssh://user:passw@rd@host:1234/ and user:passw@rd@host:/
> tests fail for the same reason (finding @ should be greedy, I think).

And I think this should make it pass.  Just remember the last
occurrence of '@' by moving the 'start' every time we see an '@'
sign.

 builtin/clone.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index cae288f..5d86439 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -160,13 +160,12 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 		start += 3;
 
 	/*
-	 * Skip authentication data.
+	 * Skip authentication data, if exists.
 	 */
-	ptr = start;
-	while (ptr < end && !is_dir_sep(*ptr) && *ptr != '@')
-		ptr++;
-	if (*ptr == '@')
-		start = ptr + 1;
+	for (ptr = start; ptr < end && !is_dir_sep(*ptr); ptr++) {
+		if (*ptr == '@')
+			start = ptr + 1;
+	}
 
 	/*
 	 * Strip trailing spaces, slashes and /.git
