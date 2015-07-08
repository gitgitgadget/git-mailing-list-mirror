From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: add log.follow config option
Date: Wed, 08 Jul 2015 09:49:06 -0700
Message-ID: <xmqqzj36y4ql.fsf@gitster.dls.corp.google.com>
References: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
	<xmqqsi8z1urz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:20:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCsX6-0003fS-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 18:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933982AbbGHQtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 12:49:12 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33964 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbbGHQtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 12:49:09 -0400
Received: by igoe12 with SMTP id e12so5189329igo.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UAjwsrX8dxMP2tmZZnmyiTXXZdpR/99fL1c3V9J6Tcg=;
        b=nFMA6kd84STavQejrg2Yp5DnVkp6OAD1HDgkQI1qitUv4gz1ia2R249m16WxtlOSiI
         iUu80CstJhX+9WmKYUe6s91euM5Lk5DYBhh7kG78yPKKFEriHbo+6Iix0XsnKSj4kK1f
         Nk18uae3eUQqih/UaixMA6PeLw5tCSvR21OKBdZOusyJegYKaQJDGDHDwnOvCEvuDOwL
         zgakpzuKD4faJB9ky/N4o87xcKJOXhSo/KRVmJakw5qkM455x0/DS5Wo3I2vgkHLUPL/
         gDv67WIY22xo3DNSb47sxCKWcjxsRktJXSrGi+J5r0QVB/wrjauH7NLz1Dc+qoxfwkGV
         /lHA==
X-Received: by 10.50.164.199 with SMTP id ys7mr36627555igb.6.1436374148726;
        Wed, 08 Jul 2015 09:49:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id o2sm2264752igr.9.2015.07.08.09.49.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 09:49:07 -0700 (PDT)
In-Reply-To: <xmqqsi8z1urz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Jul 2015 15:13:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273691>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> diff --git a/revision.c b/revision.c
>> index 3ff8723..ae6d4c3 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2322,12 +2322,21 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>  
>>  	if (revs->prune_data.nr) {
>>  		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
>> -		/* Can't prune commits with rename following: the paths change.. */
>> -		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
>> -			revs->prune = 1;
>> +
>>  		if (!revs->full_diff)
>>  			copy_pathspec(&revs->diffopt.pathspec,
>>  				      &revs->prune_data);
>> +
>> +		if (DIFF_OPT_TST(&revs->diffopt, DEFAULT_FOLLOW_RENAMES) &&
>> +		    revs->diffopt.pathspec.nr == 1)
>> +			DIFF_OPT_SET(&revs->diffopt, FOLLOW_RENAMES);
>> +
>> +		/* Can't prune commits with rename following: the paths change.. */
>> +		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES)) {
>> +			revs->prune = 1;
>> +		} else {
>> +			revs->diff = 1;
>> +		}
>>  	}
>>  	if (revs->combine_merges)
>>  		revs->ignore_merges = 0;
>
> It is unfortunate that we have to waste one DIFF_OPT bit and touch
> revision.c for something that is "just a convenience".  Because
> setup_revisions() does not have a way to let you flip the settings
> depending on the number of pathspecs specified, I do not think of a
> solution that does not have to touch a low level foundation part of
> the codebase, which I'd really want to avoid.

Whoa, wait.

What is this opt->tweak thing doing here?

    int setup_revisions(int argc, const char **argv, ...
    {
    ...
            /* Second, deal with arguments and options */
    ...
            if (prune_data.nr) {
    ...
                    parse_pathspec(&revs->prune_data, 0, 0,
                                   revs->prefix, prune_data.path);
            }

            if (revs->def == NULL)
                    revs->def = opt ? opt->def : NULL;
            if (opt && opt->tweak)
                    opt->tweak(revs, opt);
    ...
            if (revs->prune_data.nr) {
                    copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
                    /* Can't prune commits with rename following...
                    if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
                            revs->prune = 1;
                    if (!revs->full_diff)
                            copy_pathspec(&revs->diffopt.pathspec,
                                          &revs->prune_data);
            }
    ...
    }


It seems that my earlier "setup_revisions() does not have a way to
let you flip the settings depending on the number of pathspecs
specified" is false.  We had to solve a similar issue when we did
b4490059 (show -c: show patch text, 2010-03-08), and the mechanism
for doing such tweaking of the effect by command line options is
already there.

Now I am wondering if the following suffices---instead of adding
another special case to setup_revisions(), we can tweak with an
existing mechanism.

You may want to rename show_rev_tweak_rev() and call the new
default_follow_tweak() function at the end of that existing tweak
function, if you want "git show" to also pay attention to the
log.follow configuration.  I don't think it is necessary.

diff --git a/builtin/log.c b/builtin/log.c
index 6a068f7..d06248a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -625,6 +625,14 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
+static void default_follow_tweak(struct rev_info *rev,
+				 struct setup_revision_opt *opt)
+{
+	if (DIFF_OPT_TST(&rev->diffopt, DEFAULT_FOLLOW_RENAMES) &&
+	    rev->prune_data.nr == 1)
+		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
+}
+
 int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -638,6 +646,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
+	opt.tweak = default_follow_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	return cmd_log_walk(&rev);
 }
