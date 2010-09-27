From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Mon, 27 Sep 2010 15:19:51 +0200
Message-ID: <AANLkTi=p13eTY-dqGZJYaogRyj0Z5uO3YM8n1RW4iBUi@mail.gmail.com>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
 <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com> <7vy6asoz0i.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 15:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Dcz-0007Ux-6W
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 15:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759141Ab0I0NUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 09:20:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40656 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0I0NUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 09:20:12 -0400
Received: by pzk34 with SMTP id 34so1196443pzk.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=h9oeYjoouEDUTjplVnn/3etur5BTcst6ANeY6VIqabM=;
        b=pGR+ZGAwBVBPmWu2bCl9wbDnn5Qjs9o1BOkiga66F7idKV8FKjkRDvmWsEZ5gBatGE
         /CpnQ22Zs1IIK/RuhO8eE2c1hNVOHVEB/VLnv2qeaBDlyU//wV0qZTm7XJ9ER8zm5BW6
         qz2gvNquR2KlZvcs+1PAzNnyeGSPZS9GZu44U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=gxQqHwMEuWy/iCa3FEPaTXf0c0+OVKtUazbiQqrxw7KYJ3HYYOSUQTGPJMrlcmSoeS
         atfBrub8Y2ffNXb4L5vyBM+azfxpBSbix0Am/Qf59+JIGomGPtySpiwoGhIk5iSSU4FB
         2DxhHCwmaZokzt+JtAjo1UNHRR3k74kKvOrBU=
Received: by 10.142.238.9 with SMTP id l9mr6413915wfh.230.1285593611916; Mon,
 27 Sep 2010 06:20:11 -0700 (PDT)
Received: by 10.220.95.193 with HTTP; Mon, 27 Sep 2010 06:19:51 -0700 (PDT)
In-Reply-To: <7vy6asoz0i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157329>

On Fri, Sep 24, 2010 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> Since open() already sets errno correctly for the NULL-case, let's just
>>> avoid the problematic strcmp.
>>>
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>
>> I guess I should add a comment as to why this patch is needed:
>>
>> This seems to be the culprit for issue 523 in the msysGit issue
>> tracker: http://code.google.com/p/msysgit/issues/detail?id=523
>>
>> fetch_and_setup_pack_index() apparently pass a NULL-pointer to
>> parse_pack_index(), which in turn pass it to check_packed_git_idx(),
>> which again pass it to open(). This all looks intentional to my
>> (http.c-untrained) eye.
>
> Surely, open(NULL) should be rejected by a sane system, and your patch
> looks sane to me.
>

Since this doesn't seem to be in git.git yet, perhaps you could squash
this on top? I didn't notice it in time, but fopen lacked the same
check (freopen already had the check). It's not as important, because
it doesn't seem like we have any code reaching this path so far, but
it would IMO be better to fix this now rather than having to chase
down the issue again later...

diff --git a/compat/mingw.c b/compat/mingw.c
index 4595aaa..f069fea 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -160,7 +160,7 @@ ssize_t mingw_write(int fd, const void *buf, size_t count)
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
-	if (!strcmp(filename, "/dev/null"))
+	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
 	return fopen(filename, otype);
 }
