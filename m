From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 2 Feb 2014 12:13:30 +0100
Message-ID: <20140202111330.GB14729@mule>
References: <20140131202142.GA9731@mule>
 <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391306351-13237-4-git-send-email-martinerikwerner@gmail.com>
 <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 12:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9uzb-0001iT-VM
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbaBBLNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 06:13:36 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:56817 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaBBLNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 06:13:35 -0500
Received: by mail-la0-f45.google.com with SMTP id b8so4597639lan.4
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 03:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HMkrqhKM68IVkviIbRSDlBPEHpTfN3CIZkhLrQfKajw=;
        b=Q5/lS/MLcaWohbs6DpmTdsAcrKLybJpMctdWYFQGlLGaofZHT4J3TDfomNQluaV/1v
         rooL29OECNzBwuDe4Sv9Y3Z18uGmcOnt5BefqqpF5uEMuPRDeP4cNuHYnuIlM8Ql9eRG
         7IyHi8mhA9FDxXr0hFzWLZ02zer48Mfcv6KhZmotAAcHT+UrJVi19wFZ2pTBQDQGTXQI
         8HrAmmfgG+4Fhalx58mVKvNIGiBWRv+NQMi3pwvOssTiCsQUKyrOVdnrW/FmB35RUGf3
         yxcWwEcy2StSPZHq72EKM/EI+/ovsS8WhAiw4cMz3q1SnAAqq5+c8W86qp11/ayDj5yC
         oL2Q==
X-Received: by 10.112.73.100 with SMTP id k4mr9036310lbv.25.1391339613936;
        Sun, 02 Feb 2014 03:13:33 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id cu8sm17193284lbb.12.2014.02.02.03.13.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 03:13:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241359>

On Sun, Feb 02, 2014 at 09:19:04AM +0700, Duy Nguyen wrote:
> On Sun, Feb 2, 2014 at 8:59 AM, Martin Erik Werner
> <martinerikwerner@gmail.com> wrote:
> > +       /* check if work tree is already the prefix */
> > +       if (strncmp(path, work_tree, wtlen) == 0) {
> > +               if (path[wtlen] == '/')
> > +                       memmove(path, path + wtlen + 1, len - wtlen);
> > +               else
> > +                       /* work tree is the root, or the whole path */
> > +                       memmove(path, path + wtlen, len - wtlen + 1);
> > +               return 0;
> > +       }
> 
> No the 4th time is not the charm yet :) if path is "/abc/defghi" and
> work_tree is "/abc/def" you don't want to return "ghi" as the prefix
> here.

Ah indeed, this should catch that:

diff --git a/setup.c b/setup.c
index 2270bd4..5817875 100644
--- a/setup.c
+++ b/setup.c
@@ -32,9 +32,11 @@ static inline int abspath_part_inside_repo(char *path)
 	if (strncmp(path, work_tree, wtlen) == 0) {
 		if (path[wtlen] == '/')
 			memmove(path, path + wtlen + 1, len - wtlen);
-		else
+		else if (path[wtlen - 1] == '/' || path[wtlen] == '\0')
 			/* work tree is the root, or the whole path */
 			memmove(path, path + wtlen, len - wtlen + 1);
+		else
+			return -1;
 		return 0;
 	}
 	path0 = path;

Is it worth adding a test for this as well?:

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index f6f378b..05d3366 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -201,6 +201,10 @@ test_expect_success 'prefix_path works with only absolute path to work tree' '
 	test_cmp expected actual
 '
 
+test_expect_success 'prefix_path rejects absolute path to dir with same beginning as work tree' '
+	test_must_fail test-path-utils prefix_path prefix "$(pwd)a"
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX

> > +       path0 = path;
> > +       path += offset_1st_component(path);
> > +
> > +       /* check each level */
> > +       while (*path != '\0') {
> > +               path++;
> 
> To me it looks like we could write
> 
> for (; *path; path++) {
> 
> or even
> 
> for (path += offset_1st_component(path); *path; path++) {
> 
> but it's personal taste..

Yeah, I think aesthetically I don't like cramming too much into the for loop:

for (path += offset_1st_component(path0) + 1; *path; path++) {

neither leaving the init expression unused. So as long as it's just personal
taste I think I'll stick with the current while loop format. But I'll exchange
(*path == '\0') for (*path) though.

--
Martin Erik Werner <martinerikwerner@gmail.com>
