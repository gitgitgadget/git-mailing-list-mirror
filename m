From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry-pick / pre-commit hook?
Date: Wed, 8 Dec 2010 11:53:24 -0600
Message-ID: <20101208175324.GB5687@burratino>
References: <m2wrnktcl2.wl%dave@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 18:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQODC-0007yf-ED
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 18:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab0LHRxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 12:53:37 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36274 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab0LHRxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 12:53:36 -0500
Received: by qwa26 with SMTP id 26so1571569qwa.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 09:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lBzZXYNEMHOvRs9O1UWYA7+WomEZUtYYpdXIehK2zPQ=;
        b=Hemrfk97PpfR9jndnsk7gUoxl/NPyP19XG5OUkg+xYGuxtd7sxpgRCXxSAPISrVmpZ
         PaaTkFHay3aYuHNwl9yQaAANINqF+uAbWBKctFTkioQlXtmxznRcu37/AfpgvvMgZZGV
         ZwIbhjuyS4i8ztIYSfrjGnVxrOgQcUop1Id2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pH8kqcX5+gjdEAsujZ6kxKo1U+CviyOFrCjA8+hFk2leUp/MQ5vHDuJcIYn3e37COr
         yxoNxQVCBRFloNPRzUoj1WWstRJ6WcryuWqXga0BlET1A/tzeMSHP0tyfoa/sdgyE4td
         eF1nm/FDcpz4zzterKhfBWCmybGU1rdHza5n0=
Received: by 10.229.192.144 with SMTP id dq16mr7287519qcb.51.1291830815814;
        Wed, 08 Dec 2010 09:53:35 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id nb14sm513665qcb.0.2010.12.08.09.53.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 09:53:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2wrnktcl2.wl%dave@boostpro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163208>

Dave Abrahams wrote:

> Is there a good reason that git cherry-pick (without --no-commit)
> doesn't run my pre-commit hook?

Interesting question.

 $ git grep -F -e '"cherry-pick"'
 [...]
 git.c:          { "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 $ git grep -F -e cmd_cherry_pick
 builtin.h:extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
 builtin/revert.c:int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 git.c:          { "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },

cherry-pick is implemented in builtin/revert.c.  How does it invoke
the "git commit" machinery?  Explicitly, as luck would have it.

 $ git grep --show-function -F -h -C5 -e '"commit"' -- builtin/revert.c
 static int run_git_commit(const char *defmsg)
 {
         /* 6 is max possible length of our args array including NULL */
         const char *args[6];
         int i = 0;
 
         args[i++] = "commit";
         args[i++] = "-n";
         if (signoff)
                 args[i++] = "-s";
 [...]

So cherry-pick deliberately uses -n (= --no-verify) when it calls "git commit".
Why, though?

 $ git log --oneline --follow -S'"-n"' -- builtin/revert.c
 cfd9c27 Allow cherry-pick (and revert) to add signoff line
 f810379 Make builtin-revert.c use parse_options.
 9509af6 Make git-revert & git-cherry-pick a builtin

The '-n' was copied from the old git-revert.sh script when cherry-pick
was made builtin.  Not to let the trail grow cold:

 $ git log --oneline --follow -S-n -- git-revert.sh
 9509af6 Make git-revert & git-cherry-pick a builtin
 abd6970 cherry-pick: make -r the default
 674b280 Add documentation for git-revert and git-cherry-pick.
 8bf14d6 Document the --(no-)edit switch of git-revert and git-cherry-pick
 b788498 git-revert: make --edit default.
 e2f5f6e Do not require clean tree when reverting and cherry-picking.
 9fa4db5 Do not verify reverted/cherry-picked/rebased patches.
 [...]
 $ git show -s 9fa4db5
 commit 9fa4db544e2e4d6c931f6adabc5270daec041536
 Author: Junio C Hamano <junkio@cox.net>
 Date:   Mon Aug 29 21:19:04 2005 -0700

     Do not verify reverted/cherry-picked/rebased patches.
    
     The original committer may have used validation criteria that is less
     stricter than yours.  You do not want to lose the changes even if they
     are done in substandard way from your 'commit -v' verifier's point of
     view.
    
     Signed-off-by: Junio C Hamano <junkio@cox.net>
 $

At last, an answer.  The main purpose of the pre-commit hook (and
builtin checks that preceded it) is to avoid introducing regressions
in whitespace style, encoding, and so forth; but it would make
cherry-picking unnecessarily difficult, without preventing
regressions, to apply the same standards to existing code.

> Is there a hook that cherry-pick
> /will/ run instead?

"git log --grep=pre-commit" seems to suggest that the commit-msg and
post-commit hooks will be run.  But first, what are you trying to
accomplish?  Maybe there is a simpler way, or maybe with that use
case in mind we can make changes to support it better.

Hope that helps,
Jonathan
