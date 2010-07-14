From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too
 early
Date: Wed, 14 Jul 2010 16:30:43 -0500
Message-ID: <20100714213043.GA1590@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 23:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ9YR-0004yO-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 23:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419Ab0GNVbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 17:31:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56815 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab0GNVbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 17:31:40 -0400
Received: by gxk23 with SMTP id 23so204208gxk.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 14:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=x1Q3YS/OFHVi6Mf9I6YYnT2l2LSm0oNAkAIr6shJ5S4=;
        b=sV45QuAVR+bNmBkJXGol5vkVxoIfweDTSBry+FKBGzkdmRYPBkY7ky2Qj6BApFX6JG
         NHOzd6kBiXL9QwaDTdQV0CrC5beH7NuKy2fgLLZt/WQJvUd9Kc0ivKl7pcAbWrGCj42t
         eH73CurtbgQXQ4s6x8EWsnwnwvxK4B/C+9F1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YHsOhAn+gQ3kXiAQ50g2vKb+xpQH/2ZGYYFh5U8uPFztQQDmUV7DoDkc3LeATKk5Nm
         ojKdLLRI5MYb/M+ziuMAaXuJnArR1n5tHmeYCYCE/z8IEQLmEIFuy80sPk125IefDq77
         mUC4+ZbhTgYhMvKYbwlpR2cN/B4TQ3Z2T8TgA=
Received: by 10.224.1.42 with SMTP id 42mr9762261qad.91.1279143099086;
        Wed, 14 Jul 2010 14:31:39 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id js14sm1192643qcb.18.2010.07.14.14.31.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 14:31:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v630hyf5r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151037>

Junio C Hamano wrote:

> ... and for commands that do not use RUN_SETUP, what happens?

run_builtin() still commits pager choice.  The bug is neither
fixed nor made worse for them.

> Missing from the above enumeration are are external commands.  They depend
> on commit_pager_choice() to be called before execv_dashed_external() gets
> called.  For example, "git -p request-pull $args" no longer works with
> this patch.

Something like the following may help.

This does not protect against calling setup_pager() more than
once.  Once the first pager has been set up, isatty(1) is false,
preventing additional pagers from being spawned and competing with it.

As futureproofing against --paginate=always, setup_pager() should
probably be taught to check pager_in_use(), but that should
probably wait for a separate patch.

diff --git a/git.c b/git.c
index 25e7693..2dcd952 100644
--- a/git.c
+++ b/git.c
@@ -162,6 +162,7 @@ static int handle_alias(int *argcp, const char ***argv)
 	int unused_nongit;
 
 	subdir = setup_git_directory_gently(&unused_nongit);
+	commit_pager_choice();
 
 	alias_command = (*argv)[0];
 	alias_string = alias_lookup(alias_command);
@@ -433,6 +434,7 @@ static void execv_dashed_external(const char **argv)
 	int status;
 
 	strbuf_addf(&cmd, "git-%s", argv[0]);
+	commit_pager_choice();
 
 	/*
 	 * argv[0] must be the git command, but the argv array
-- 
