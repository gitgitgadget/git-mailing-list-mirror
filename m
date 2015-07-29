From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Wed, 29 Jul 2015 10:42:21 -0700
Message-ID: <xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438185076-28870-1-git-send-email-ps@pks.im>
	<1438185076-28870-6-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Jul 29 19:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVN6-0006da-HI
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbbG2RmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:42:24 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34075 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbbG2RmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:42:23 -0400
Received: by pdbbh15 with SMTP id bh15so9405386pdb.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iiHGzcFBmUIOBioOm0dM82gl1Dy1gbG3tPzWv1ZAdLw=;
        b=VVuKDOhCcHULrQWaigH6pFL5luGXyiPQiUWbe20Or70rs+3ZOZ0kHT72MxC8DLuhR0
         J/SXvwx3NA+TqsH+cD4SRFhcgy6RvLOCph+Oyp01tKTMalLjpYJHMPm1NmVPrt87Jwzb
         9rv5Fx2Itq/CQaf/nSu0VB27oFn4p8xIyJov7CEYEaxomBSN2FviaiLB9uzFg/rQJh95
         bPSvmb75Xm9vbuk1TGhxPWR577nV4tkHKJGSj4bju/7BvfKo80fCa4DJyBH/dNV5aaAx
         qE3Y+KcXa5AIVHTr2zuS7nQGKVMsW1XBcFRai/r7PKSZj8cZRwZ2wHxiEX+jvvruz3uF
         /PtQ==
X-Received: by 10.70.43.72 with SMTP id u8mr95332895pdl.33.1438191742851;
        Wed, 29 Jul 2015 10:42:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id pu4sm41862936pdb.86.2015.07.29.10.42.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 10:42:21 -0700 (PDT)
In-Reply-To: <1438185076-28870-6-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Wed, 29 Jul 2015 17:51:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274923>

Patrick Steinhardt <ps@pks.im> writes:

> We fail to guess a sensible directory name for a newly cloned
> repository when the path component of the URL is empty. E.g.
> cloning a repository 'ssh://user:password@example.com/' we create
> a directory 'password@example.com' for the clone.
>
> Fix this by ...

It is clear that you do not want to have that password in the
resulting directory name from the problem description, but you
started saying "Fix this" without saying what the desired outcome
is.  "We want to use only the hostname, e.g. 'example.com', in such
a case instead." or something, perhaps, at the end of the first
paragraph?  "Fix this by doing such and such" becomes understandable
only after we know what end result you want to achieve by "doing
such and such".

> ... using parse_connect_url to split host and path
> components and explicitly checking whether we need to fall back
> to the hostname for guessing a directory name.

I cannot help wonder why this much change (including patches 3 and
4) is needed.  Isn't it just the matter of making this part of the
existing code be aware of '@' in addition to ':'?

> -	/*
> -	 * Find last component, but be prepared that repo could have
> -	 * the form  "remote.example.com:foo.git", i.e. no slash
> -	 * in the directory part.
> -	 */
> -	start = end;
> -	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
> -		start--;

Regardless of the issue you are trying to address, we may want to
limit that "be prepared for and careful with ':'" logic in the
existing code to the case where the "last component" does not have
any other component before it.  That is:

	http://example.com/foo:bar.git/

would be stripped to

	http://example.com/foo:bar

and then we scan backwards for ':' or '/' and declare that "bar" is
the name of the repository, but we would probably want "foo:bar"
instead (or we may not, as some filesystems do not want to have a
colon in its path components).


 builtin/clone.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a72ff7e..3d6328a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -165,10 +165,12 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	/*
 	 * Find last component, but be prepared that repo could have
 	 * the form  "remote.example.com:foo.git", i.e. no slash
-	 * in the directory part.
+	 * in the directory part, or "http://user@example.com/" with
+	 * the whole site serving a single repository.
 	 */
 	start = end;
-	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
+	while (repo < start &&
+	       !(is_dir_sep(start[-1]) || start[-1] == ':' || start[-1] == '@'))
 		start--;
 
 	/*
