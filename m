From: t.gummerer@gmail.com
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file"
 DWIM better.
Date: Sun, 15 Mar 2015 19:13:22 +0100
Message-ID: <20150315181322.GC17591@hank>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
 <20150315173451.GB17591@hank>
 <CAHLaBNLQ8-JzEBjypvJDDzhW8SwfzujuOknC_QWar+cL18cR3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:13:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXD2Y-0007td-VV
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbCOSN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 14:13:26 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37816 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbCOSN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 14:13:26 -0400
Received: by wixw10 with SMTP id w10so25562357wix.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9OMrcY1pBDX9j08RrL77eMg+b1uk1KfFrOZHwitPKlg=;
        b=toVv/8yhqG5Z3uzV4ozMWlzsFNwsaQm7zhKyk7280Uv2+KUF6inh2h0pQGHQU4HAzn
         /sDXlRKwEbfyYaAMkAzgEAp9ddD4gdLjgfmHFmE6MCeemFov363eSOwJnJJInzJj5dsG
         c0RWsEzAg1wpxwTH0oBOHSzn2pl4Y12tJmz/kMaBqgvPBUr6Ree18Ivg+ZVoJS0lBOMo
         wzAtIPqsT2UhBi5EzeZGx8umMaosrVLAnqud/sNCSLVh8Fm/Ix8FQoYAEjkzNMsCgkaX
         oFoMLvhnwl3xQJDTkFkhH16+be9P1ZG1PEoFTlt2kDJRlsLONaxFuOosDDZ2/KpsKQFf
         aomg==
X-Received: by 10.194.90.7 with SMTP id bs7mr78959098wjb.7.1426443204629;
        Sun, 15 Mar 2015 11:13:24 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id lj13sm11896584wic.9.2015.03.15.11.13.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2015 11:13:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHLaBNLQ8-JzEBjypvJDDzhW8SwfzujuOknC_QWar+cL18cR3A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265509>

[re-added cc to the list]

On 03/15, Yurii Shevtsov wrote:
> Hi, and thank for your reply
> 
> >>  1 files changed, 19 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/diff-no-index.c b/diff-no-index.c
> >> index 265709b..4e71b36 100644
> >> --- a/diff-no-index.c
> >> +++ b/diff-no-index.c
> >> @@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
> >>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
> >>                 return -1;
> >>
> >> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> >> -               return error("file/directory conflict: %s, %s", name1, name2);
> >> +       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> >> +               struct strbuf dirnfile;
> >> +               const char *dir, *file;
> >> +               char *filename;
> >> +               int ret = 0;
> >> +
> >> +               dir = S_ISDIR(mode1) ? name1 : name2;
> >> +               file = (dir == name1) ? name2 : name1;
> >
> > This makes git diff --no-index $directory $file the same as
> > git diff --no-index $file $directory.  Shouldn't these commands give
> > different results?  (See the behaviour of diff in this case, and
> > compare it to the behaviour you introduced here)
> 
> I really checked behavior of usual diff. And swapping arguments
> doesn't affect result. At first I had doubts about task formulation,
> so I asked about it and got the answer:
> gmane.comp.version-control.git/265479 Am I misunderstood it again?

Using the same example as in that thread, I get the following output:

tommy at hank in work[1]  $ diff -u git junk/diff.h
--- git/diff.h	 2014-12-26 21:00:20.690774933 +0100
+++ junk/diff.h	 2015-03-15 18:02:03.441049918 +0100
@@ -357,3 +357,4 @@
 extern void setup_diff_pager(struct diff_options *);

 #endif /* DIFF_H */
 +hello
tommy at hank in work $ diff -u junk/diff.h git
--- junk/diff.h	 2015-03-15 18:02:03.441049918 +0100
+++ git/diff.h	 2014-12-26 21:00:20.690774933 +0100
@@ -357,4 +357,3 @@
 extern void setup_diff_pager(struct diff_options *);

 #endif /* DIFF_H */
 -hello

Notice the +hello vs. -hello in the last line off the diff.  Git with
your patch on the other hand gives me +hello in both cases.

tommy at hank in work[1]  $ g diff --no-index git junk/diff.h
diff --git a/git/diff.h b/junk/diff.h
index b4a624d..81671dd 100644
--- a/git/diff.h
+++ b/junk/diff.h
@@ -357,3 +357,4 @@ extern int print_stat_summary(FILE *fp, int files,
 extern void setup_diff_pager(struct diff_options *);

 #endif /* DIFF_H */
 +hello
tommy at hank in work[1]  $ g diff --no-index junk/diff.h git
diff --git a/git/diff.h b/junk/diff.h
index b4a624d..81671dd 100644
--- a/git/diff.h
+++ b/junk/diff.h
@@ -357,3 +357,4 @@ extern int print_stat_summary(FILE *fp, int files,
 extern void setup_diff_pager(struct diff_options *);

 #endif /* DIFF_H */
 +hello

So while I think the behaviour with git diff --no-index $directory $file
is correct (minus the comments by Matthieu), git diff --no-index $file
$directory is not, I think.
