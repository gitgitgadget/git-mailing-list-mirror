From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/8] revert: Improve error handling by cascading errors upwards
Date: Fri, 20 May 2011 12:09:55 +0530
Message-ID: <BANLkTimJ-BSBiyKd1dAcUEUmfLGVjdioNQ@mail.gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-2-git-send-email-artagnon@gmail.com> <20110511095949.GA2676@elie>
 <20110519091831.GA28723@ramkum.desktop.amazon.com> <20110519180314.GA26248@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 08:40:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNJOJ-0003rc-05
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 08:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933433Ab1ETGkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 02:40:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39168 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933375Ab1ETGkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 02:40:18 -0400
Received: by wwa36 with SMTP id 36so3655449wwa.1
        for <git@vger.kernel.org>; Thu, 19 May 2011 23:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=w2cIhNYYpUWpNer+v5pDd4eqmZh842HmVk0xHwArXp4=;
        b=JsmKrHJUiRUyMS35h4Egb+eezOKZYWB3V0R7/D0D9Ufb29Wfg0FelVPiK+OxivTnDf
         eZTI7hO9bgAQ8Z0efCCww7E9UtzL/RVh0Ca+8jCNBcvRFySsr7U7mpYg85OioTT5ahR6
         6AD+T6AqtwM90aErc60Tg9uVwNsoMSXleUCpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dej+UfkFE8pG5d4a47/Bgri0GFwDAnM6vUjUC3G1hJLihALV054cepfGXkuqdQfyqb
         zq2EFFCtGUtOns1RZM3GZN8KpUf7TBFnS+53NTGzxTCjt5sheskqA5gQ0mwTym9sb0sT
         2UvrQM70hDtFGGwNJ8YWeDk9f7cxGbg9qh52s=
Received: by 10.216.235.196 with SMTP id u46mr3802374weq.25.1305873616924;
 Thu, 19 May 2011 23:40:16 -0700 (PDT)
Received: by 10.216.20.65 with HTTP; Thu, 19 May 2011 23:39:55 -0700 (PDT)
In-Reply-To: <20110519180314.GA26248@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174042>

Hi Jonathan,

I'm a little confused, so I'm also including a commit message
justifying the change.
Have I understood the issue correctly? Does this diff look alright?

Note: I've removed the die from get_message in another unrelated
patch; essentially, do_pick_commit never calls die.

    Since do_pick_commit is only delegated the job of picking a single
    commit in an entire cherry-pick or revert operation, don't die in this
    function.  Instead, return an error to be handled by the caller
    appropriately.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/builtin/revert.c b/builtin/revert.c
index 0cc3b6b..138485f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -415,20 +415,20 @@ static int do_pick_commit(void)
 		struct commit_list *p;

 		if (!mainline)
-			die(_("Commit %s is a merge but no -m option was given."),
-			    sha1_to_hex(commit->object.sha1));
+			return error(_("%s: Commit %s is a merge but no -m option was given."),
+				me, sha1_to_hex(commit->object.sha1));

 		for (cnt = 1, p = commit->parents;
 		     cnt != mainline && p;
 		     cnt++)
 			p = p->next;
 		if (cnt != mainline || !p)
-			die(_("Commit %s does not have parent %d"),
-			    sha1_to_hex(commit->object.sha1), mainline);
+			return error(_("%s: Commit %s does not have parent %d"),
+				me, sha1_to_hex(commit->object.sha1), mainline);
 		parent = p->item;
 	} else if (0 < mainline)
-		die(_("Mainline was specified but commit %s is not a merge."),
-		    sha1_to_hex(commit->object.sha1));
+		return error(_("%s: Mainline was specified but commit %s is not a merge."),
+			me, sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;

@@ -438,8 +438,8 @@ static int do_pick_commit(void)
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
-		die(_("%s: cannot parse parent commit %s"),
-		    me, sha1_to_hex(parent->object.sha1));
+		return error(_("%s: cannot parse parent commit %s"),
+			me, sha1_to_hex(parent->object.sha1));

 	/*
 	 * "commit" is an existing commit.  We would want to apply
@@ -578,8 +578,8 @@ static int revert_or_cherry_pick(int argc, const
char **argv)

 	while ((commit = get_revision(&revs))) {
 		int res = do_pick_commit();
-		if (res)
-			return res;
+		if (res < 0)
+			exit(128);
 	}

 	return 0;
