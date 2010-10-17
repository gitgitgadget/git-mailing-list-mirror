From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] merge-file: correctly find files when called in subdir
Date: Sun, 17 Oct 2010 12:39:13 +0200
Message-ID: <201010171239.13990.trast@student.ethz.ch>
References: <33ab2f03ed522e1a9be202017b7bbfe35e6d7a99.1287228637.git.trast@student.ethz.ch> <AANLkTimzuF3Ku_Jjnq0qKFtrDfAfz8YxChomZr8+Shm1@mail.gmail.com> <20101017011111.GA26656@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 12:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7QeB-0001SF-5h
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 12:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab0JQKjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 06:39:17 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:24064 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932281Ab0JQKjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 06:39:16 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 17 Oct
 2010 12:39:16 +0200
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 17 Oct
 2010 12:39:15 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc7-31-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20101017011111.GA26656@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159203>

Jonathan Nieder wrote:
> Bert Wesarg wrote:
> > On Sat, Oct 16, 2010 at 13:33, Thomas Rast <trast@student.ethz.ch> wrote:
> 
> >> --- a/builtin/merge-file.c
> >> +++ b/builtin/merge-file.c
> >> @@ -65,10 +66,18 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
> [...]
> >> +               if (prefix)
> >> +                       name = prefix_filename(prefix, prefixlen, argv[i]);
> >> +               else
> >> +                       name = argv[i];
> >
> > I think you can safe this condition, if you set prefixlen to 0.
> 
> I'm not so sure.  On Windows, prefix_filename() starts with
> 
> 	char *p;
> 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
> 	if (is_absolute_path(arg))
> 		pfx_len = 0;
> 	else
> 		memcpy(path, pfx, pfx_len);
> 
> and memcpy() has undefined behavior when pfx is NULL (even with
> pfx_len of 0; see WG14/N1256: 7.21.1 "String function conventions").
> Even if the win32api memcpy does the right thing with NULL pfx, I
> cannot trust GCC when they are given that kind of license. :)

Hmmh.

I was ready to say "you're right" to Bert's suggestion.  So maybe, for
the sake of foolproof-ness, we should do something like the patch
below?

diff --git i/setup.c w/setup.c
index a3b76de..7c8906d 100644
--- i/setup.c
+++ w/setup.c
@@ -55,7 +55,7 @@
 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
 	if (is_absolute_path(arg))
 		pfx_len = 0;
-	else
+	else if (pfx && *pfx)
 		memcpy(path, pfx, pfx_len);
 	strcpy(path + pfx_len, arg);
 	for (p = path + pfx_len; *p; p++)


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
