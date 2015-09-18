From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Fri, 18 Sep 2015 21:09:04 +0200
Message-ID: <vpqlhc3h7e7.fsf@anie.imag.fr>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
	<CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
	<vpqeghviqu1.fsf@anie.imag.fr>
	<CAGZ79kZxAwMvv6UoZLBd2wTOdj1DFWKQqSPBYL449KSokA8DQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jacob Keller <jacob.keller@gmail.com>,
	git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd12P-0004Qk-5v
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbbIRTJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 15:09:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53633 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbbIRTJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 15:09:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8IJ92YF027823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 21:09:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IJ947s018049;
	Fri, 18 Sep 2015 21:09:04 +0200
In-Reply-To: <CAGZ79kZxAwMvv6UoZLBd2wTOdj1DFWKQqSPBYL449KSokA8DQQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 18 Sep 2015 10:32:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Sep 2015 21:09:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8IJ92YF027823
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443208147.18493@IhZ9q6fHVWdfBkI55pCsUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278216>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Sep 18, 2015 at 10:23 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> On Fri, Sep 18, 2015 at 9:59 AM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> I'm getting it even if there's a tag and/or a branch pointing to the
>>>> same commit.
>>>>
>>>> Any idea what's going on?
>>>
>>> Any chance you accidentally made a branch or tag named HEAD?
>>
>> Nice try ;-), but no:
>
> I was playing around with origin/master and origin/pu and
> I cannot reproduce this bug.

I investigated a bit more. The root of the problem is "git checkout
--detach" and the reflog. Here's a reproduction script:


rm -fr test-repo
git init test-repo
cd test-repo
echo foo>bar; git add bar; git commit -m "foo"
echo boz>bar; git add bar; git commit -m "boz"
git checkout --detach
git status
git branch
rm -fr .git/logs/
git status
git branch

The end of the output is:

  + git checkout --detach
  + git status
  HEAD detached at HEAD
  nothing to commit, working directory clean
  + git branch
  * (HEAD detached at HEAD)
    master
  + rm -fr .git/logs/
  + git status
  Not currently on any branch.
  nothing to commit, working directory clean
  + git branch
  * (no branch)
    master

If one replaces "git checkout --detach" with "git checkout HEAD^0", then
the output is the one I expected:

  HEAD detached at cb39b20

The guilty line in the reflog is:

  checkout: moving from master to HEAD

One possible fix is to resolve HEAD when encountering it in the reflog,
like this:

--- a/wt-status.c
+++ b/wt-status.c
@@ -1319,6 +1319,13 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
        hashcpy(cb->nsha1, nsha1);
        for (end = target; *end && *end != '\n'; end++)
                ;
+       if (!memcmp(target, "HEAD", end - target)) {
+               /* Don't say "HEAD detached at HEAD" */
+               unsigned char head[GIT_SHA1_RAWSZ];
+               get_sha1("HEAD", head);
+               strbuf_addstr(&cb->buf, find_unique_abbrev(head, DEFAULT_ABBREV));
+               return 1;
+       }
        strbuf_add(&cb->buf, target, end - target);
        return 1;
 }

What do you think?

Shall I turn this into a proper patch?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
