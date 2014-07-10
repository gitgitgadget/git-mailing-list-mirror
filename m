From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: No fchmd. was: Re: [PATCH 00/14] Add submodule test harness
Date: Thu, 10 Jul 2014 22:55:04 +0200
Message-ID: <53BEFDA8.7020409@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de>	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>	<53BD7A36.2030300@kdbg.org>	<xmqqr41u9w27.fsf@gitster.dls.corp.google.com>	<20140709195619.GA17454@dcvr.yhbt.net>	<xmqqion69ovj.fsf@gitster.dls.corp.google.com>	<53BE3127.8020805@web.de> <xmqq61j5805g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, Johannes Sixt <j6t@kdbg.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?UTF-8?B?4buNYyBEdXk=?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5LNa-0007Of-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaGJUzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:55:42 -0400
Received: from mout.web.de ([212.227.17.12]:64101 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbaGJUzl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:55:41 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LudGm-1Wehij1XpA-00zmVt; Thu, 10 Jul 2014 22:55:30
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq61j5805g.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:epkkywvDn90inKIgKv8pDmqSVfOG0TLbFVyK6G1rAvdqSHYPjwq
 hbD9bTwrS3lerzfT7p+HUf1sQ26kmhWO+LHKXSH+k0RRv25CkM+NY+HCm7QVDhUUZVElUqi
 1JBeMaqtPPZ+jyIcZ89UAhR52gmLU03+ri/VtJcHRFwYb5POf97MbzzCm4IVYGW3fSwj0CX
 ++qXhxMEP9YJQHB+NMHfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253219>

On 2014-07-10 21.49, Junio C Hamano wrote:
[]
> If we limit the case to "Inherit permissions from the file we are
> replacing by taking a lock on it", which is the topic of discussion
> in this thread, we do not have to worry about how to configure the
> value (we do not have to) and adding a new parameter to tell the
> mode to hold-lock-file-for-update is unneeded (the function will
> have a pathname of the original and can learn the current permission
> bits itself).
So something like this:
(I will probably not have the time to make a proper patch :-(


diff --git a/lockfile.c b/lockfile.c
index 4899270..134d5c8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -156,6 +156,11 @@ static void resolve_symlink(struct strbuf *path)
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
+       int perms = 0666;
+       struct stat st;
+       if (!lstat(path, &st))
+               perms = st.st_mode & 0777;
+
        if (!lock_file_list) {
                /* One-time initialization */
                sigchain_push_common(remove_lock_file_on_signal);
@@ -179,7 +184,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
        if (!(flags & LOCK_NODEREF))
                resolve_symlink(&lk->filename);
        strbuf_addstr(&lk->filename, LOCK_SUFFIX);
-       lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+       lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, perms);
        if (lk->fd < 0) {
                strbuf_reset(&lk->filename);
                return -1;
