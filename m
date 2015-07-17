From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Fri, 17 Jul 2015 12:30:21 -0700
Message-ID: <xmqqoaja1t0y.fsf@gitster.dls.corp.google.com>
References: <1437159533304-7635764.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Garbageyard <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 21:30:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGBL4-0000uY-ED
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 21:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbbGQTaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 15:30:25 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36795 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbbGQTaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 15:30:24 -0400
Received: by pachj5 with SMTP id hj5so65605289pac.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8mhyc1KvHZ9l+5IvwLfrjIc5GkmXjeJZVz7hNJKXK90=;
        b=SfcSNJrWnIh3GBUtskWXfughuwWQdWmA6eljfntDIcwqkzRcWL9I8lYuhPEFVXdeaz
         RV/eQZv3PuMm3e6h/uWR8zKQyUPhZuQVGsDjVnw3atWYOjOp5baNOtZ5FLeIzefbiMiE
         jTwQ6VLpfo8MYw/dnTjHVDFkOgnzEjbL2sNs1JqBIyHXhzAGZtUuN+G/OSyUc3E9k0iZ
         iOwecAieRjdnfq7dZfxnqGJMPNkEMYlxXXWaIc/pvUwGTWJ30gknf3f7+/NvKjND7QSX
         ajQEgKpUApwIy4xEhPWsjSlj2hSHQ5+pML/EG/lSflHA9ELPZgJGWoz1u79qBnGa8l/n
         o/mQ==
X-Received: by 10.70.89.170 with SMTP id bp10mr32533138pdb.30.1437161423956;
        Fri, 17 Jul 2015 12:30:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id qo6sm12124159pab.23.2015.07.17.12.30.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 12:30:22 -0700 (PDT)
In-Reply-To: <1437159533304-7635764.post@n2.nabble.com> (Garbageyard's message
	of "Fri, 17 Jul 2015 11:58:53 -0700 (MST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274097>

Garbageyard <varuag.chhabra@gmail.com> writes:

> We have a pre-receive hook that checks for JIRA ID whenever someone pushes
> code to Git server. I'm trying to avoid this check when someone is applying
> a tag. Here's the link for the script: http://pastebin.com/VnMQp5ar
>
> This is the link for output: http://pastebin.com/tBGmYaZF
>
> Problem is that if i run the following command, the output that i get on
> command line is 0
>
> git describe --exact-match ac28ca721e67adc04078786164939989a5112d98 2>&1 |
> grep -o fatal | wc -w

I am not sure what you are trying to do in the first place.

  : gitster x; git init garbage
  Initialized empty Git repository in /var/tmp/x/garbage/.git/
  : gitster x; cd garbage
  : gitster garbage/master; git commit --allow-empty -m initial
  [master (root-commit) b18cac2] initial
  : gitster garbage/master; git tag v0.0 ;# lightweight
  : gitster garbage/master; git commit --allow-empty -m second
  [master d1de78e] second
  : gitster garbage/master; git tag -a 'v0.1' v0.1
  fatal: Failed to resolve 'v0.1' as a valid ref.
  : gitster garbage/master; git tag -a -m 'v0.1' v0.1
  : gitster garbage/master; git commit --allow-empty -m third
  [master d1f1360] third
  : gitster garbage/master; git describe --exact-match HEAD ;# third
  fatal: no tag exactly matches 'd1f1360b46dfde8c6f341e48ce45d761ed37e357'
  : gitster garbage/master; git describe --exact-match HEAD^ ;# second
  v0.1
  : gitster garbage/master; git describe --exact-match HEAD^^ ;# first
  fatal: no tag exactly matches 'b18cac237055d9518f9f92bb4c0a4dac825dce17'
  : gitster garbage/master; exit

I am feeding three _commits_, not tags.  But one of them (i.e. the
one that happens to have an annotated tag) yields the "exact match"
tagname, as designed and expected.

But is it really what you want to do to skip such a commit?  Why?

I also see a questionable thing in the earlier part of your script:

   while read old_sha1 new_sha1 refname ; do
           echo "stdin: [$old_sha1] [$new_sha1] [$refname]"
           if [ "$old_sha1" == "0000000000000000000000000000000000000000" ] ; then
               commits=$new_sha1
           else
               commits=`git rev-list $old_sha1..$new_sha1`
           fi

           for commit in $commits
           do
		...

When somebody pushes to an existing branch, you list all the new
commits that came in (i.e. 'git rev-list' is bounded by $old_sha1 at
the bottom).  But when somebody pushes to a new branch, you only
include the tip to the list.

And you check everything on that list.  Why?  If I push three-commit
series to a new branch, wouldn't you want to validate all three of
them, just like you validate my push of a three-commit enhancement
to an existing branch?

	while read old new name
        do
		case "$name" in refs/heads/tags/*) continue ;; esac
		if test "$old" = 0000000000000000000000000000000000000000
		then
			git rev-list $old
		else
                	git rev-list $old..$new
		fi
	done |
	while read commit
        do
        	Do a check on $commit
	done

or something instead?
