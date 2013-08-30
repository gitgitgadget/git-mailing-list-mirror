From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 00:40:25 -0500
Message-ID: <CAMP44s2=S=6_DAVuiG+0iO+rxQuPqqsL8fEtzGkSxJfaBu3hdQ@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 07:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHRh-0003Rt-65
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 07:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab3H3Fk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 01:40:29 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:45259 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3H3Fk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 01:40:28 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so1160650lab.36
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 22:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Rp8NBP9VXM08scLSgtV3cNV34MHqDNCnlWiDhr/G0L4=;
        b=iniplDvnL96rf5qIcENRYxsAkX3bM8WDUQ996zNN3YcDGZ5+lM0wT2DH+e2KxWiedd
         79ECb1aEQretkBEhc92wuftOec3x2G1aZmhIh7YIxmq06cjve2cUtCq2zlJuGXm66We7
         lzYUbc0LeSfsh09H2WN5YHqCfZkjNdRH0FbSjcAq6+yx8SzjN337JGSgwstaC4/zp3qH
         LuBE6trUkfseRnNtZhroMa3At+GBj8sMUQ9HVjd7b3JrFtrySXMhQDeD4IgN4lamZ/4a
         Wpn1MppWR3+635x4W3P8iN7d9Z2xi26jDFBMIQTAj33m+ExrNyE0dFL214dP9yCA6CCv
         LVNg==
X-Received: by 10.112.168.170 with SMTP id zx10mr6420429lbb.0.1377841225707;
 Thu, 29 Aug 2013 22:40:25 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 29 Aug 2013 22:40:25 -0700 (PDT)
In-Reply-To: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233394>

On Fri, Aug 30, 2013 at 12:00 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So that it's possible to remove certain refs from the list without
> removing the objects that are referenced by other refs.
>
> For example this repository:
>
>   * 374e8dd (crap) crap
>   * 4cbbf7b (test) two
>   * d025ae0 (HEAD, master) one
>
> When using '--branches --except crap':
>
>   * 4cbbf7b (test) two
>   * d025ae0 (HEAD, master) one
>
> But when using '--branches --not crap' nothing will come out.

Doesn't work with certain refs, here's a fix:

diff --git a/revision.c b/revision.c
index 375adab..25564c1 100644
--- a/revision.c
+++ b/revision.c
@@ -2575,6 +2575,13 @@ void reset_revision_walk(void)
        clear_object_flags(SEEN | ADDED | SHOWN);
 }

+static int refcmp(const char *a, const char *b)
+{
+       a = prettify_refname(a);
+       b = prettify_refname(b);
+       return strcmp(a, b);
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
        int nr = revs->pending.nr;
@@ -2591,7 +2598,7 @@ int prepare_revision_walk(struct rev_info *revs)
                for (i = 0; i < revs->cmdline.nr; i++) {
                        struct rev_cmdline_entry *ce;
                        ce = &revs->cmdline.rev[i];
-                       if ((ce->flags & SKIP) && !strcmp(ce->name, e->name))
+                       if ((ce->flags & SKIP) && !refcmp(ce->name, e->name))
                                goto next;
                }
                if (commit) {
diff --git a/t/t6112-rev-list-except.sh b/t/t6112-rev-list-except.sh
index b8f9a61..a295f43 100755
--- a/t/t6112-rev-list-except.sh
+++ b/t/t6112-rev-list-except.sh
@@ -32,4 +32,11 @@ test_expect_success 'rev-list --except with extra' '
        test_cmp expect actual
 '

+test_expect_success 'rev-list --except with full ref' '
+
+       git rev-list --topo-order --branches --except refs/heads/merge
> actual &&
+       git rev-list --topo-order test > expect &&
+       test_cmp expect actual
+'
+
 test_done

-- 
Felipe Contreras
