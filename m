From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Trailing spaces in branchname (git-svn)
Date: Wed, 15 Jun 2011 16:00:10 +0200
Message-ID: <BANLkTikaeXxRMJErAYy3-LSrvfNZXAbEEw@mail.gmail.com>
References: <0014af8a-3b24-4398-88aa-7a3e460f2283@s11g2000yqh.googlegroups.com>
 <AANLkTinZnd0R8Rnv4kaiJAGP0qKEwgbU+nP=donmbEbp@mail.gmail.com> <12ada6de-4345-4259-b832-371a74df9775@l6g2000vbn.googlegroups.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Barthus <magnus.kallstrom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 16:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWqeO-0006JO-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 16:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab1FOOAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 10:00:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46589 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab1FOOAu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 10:00:50 -0400
Received: by pzk9 with SMTP id 9so256413pzk.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=JfKzYZ+6rpP7rzYCo4/anfOKhDT9NEL2kR6LQXJT0tM=;
        b=E/2WjiONdZHXM//fbAwM0deH2SLJLGJJCEAOXCjt7LWhpVg9pp3UXIWVH3h1KODmg0
         SrU3073m0pz+x8J08SRPDzQ9AHNyeVFYg9sq8tpZQdSQs5yBsLR7BDk+XAuuEj0ObT1v
         Qag5W0L0uUxTotqdcEYobgtDR95YNO8pkAkRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=B6F7g9nlvxT6rWXDRuL1TP2z2knn1RFEyjf2rJ+ueIw92AgmpmgVUOxduKbv2f54wW
         39x+2Q/8qnaOIw5U2zXQV0b8bI/5OZYv51lUkDyoWI6+8w+bwf9NvBe/vxd1RddcDbux
         zEPf2OC3ROZbv+qN7Zg6BhaWZI80Pkvhj/Viw=
Received: by 10.68.39.132 with SMTP id p4mr269452pbk.369.1308146450092; Wed,
 15 Jun 2011 07:00:50 -0700 (PDT)
Received: by 10.68.50.197 with HTTP; Wed, 15 Jun 2011 07:00:10 -0700 (PDT)
In-Reply-To: <12ada6de-4345-4259-b832-371a74df9775@l6g2000vbn.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175833>

Please don't cull the CC-list.

On Wed, Jun 15, 2011 at 3:38 PM, Barthus <magnus.kallstrom@gmail.com> wrote:
>
>> This kind of question is usually better to ask on the main Git mailing
>> list, as it's not really Windows specific.
>
> I found a similar (older) thread in the git-mailing-list, discussing
> the same issue. This led me to try cloning the same repository on a
> Linux-machine - with success. Linux (at least my distro - Ubuntu)
> handles trailing spaces in directory names.
>
> Isn't this a msysgit-issue? (I just want to make sure that I don't
> spend my (and your) time in the wrong place)

If it works on Linux then yes, it's probably a Git for Windows issue.

Some quick testing reveals that paths can have a trailing space on
Linux, but not on Windows. It sounds to me like you need to modify the
refname subroutine in git-svn.perl to escape this. Something like this
seems to work for me:
---8<---
diff --git a/git-svn.perl b/git-svn.perl
index 7849cfc..7a44145 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2126,6 +2126,9 @@ sub refname {
 	# @{ becomes %40{
 	$refname =~ s{\@\{}{%40\{}g;

+	# trailing space is not not allowed on Windows
+	$refname =~ s{ $}{%20};
+
 	return $refname;
 }


---8<---
If it works for you, I'll submit a proper patch for it.
