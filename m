From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git merge --abort? [was: Re: [PATCHv4 00/21] git notes merge]
Date: Fri, 22 Oct 2010 10:48:15 -0500
Message-ID: <20101022154815.GE9224@burratino>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <201010221611.15425.johan@herland.net>
 <20101022145553.GA9224@burratino>
 <201010221712.06059.johan@herland.net>
 <AANLkTimzryq2Qa5sZNmXVY5Z1epg5Zxe3TMk9CX_+VX8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, bebarino@gmail.com,
	avarab@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Juf-0007G9-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab0JVPwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:52:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46265 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0JVPwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:52:05 -0400
Received: by gyg4 with SMTP id 4so734575gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s2nSPLTmK4NXDvTKGXNK65BIOQUxpUNyQUOioA+7oNI=;
        b=ugOxlkiq9dzzXFsAaJXbD70fAWkpfTREVs+OWLKM9dGrTYgfwkpUPcsa6DearpIZVZ
         Sppf7pfL46SHw+mjwdd+SzpPiwXqqARXiWgBDl/WsKkmJjbHbPOAMa6CjrD26j7WR5HN
         YjdlVwNQr9j7prQWX0N1lmZVzF5Yk9S92+DFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HSg1X1+LfqdEI27F1WeXSu0VdGmq4VsF5NNaW9wz/LwkF0mAkeZy2zKd5NODVIATfz
         fq3LFvuTipB3ragHaDc8g+Xn8LI5NEizQQbUu9VjviS7ugvM3vO3+U7hw6wWuOIPwjT8
         AwLAkqB/Ytj1ov0rEbSC1W4fTPfzCYJ5Zz1Tg=
Received: by 10.239.169.194 with SMTP id p2mr1003558hbe.96.1287762723731;
        Fri, 22 Oct 2010 08:52:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z36sm1656415vbw.17.2010.10.22.08.52.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 08:52:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimzryq2Qa5sZNmXVY5Z1epg5Zxe3TMk9CX_+VX8@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159704>

Sverre Rabbelier wrote:
> On Fri, Oct 22, 2010 at 10:12, Johan Herland <johan@herland.net> wrote:

>> Yes, that makes sense to me, especially if we make a 'git merge --abort'
>> synonym. Alternatively, we can make 'git merge --abort' check for
>> MERGE_HEAD, and then defer to 'git reset --merge', while leaving 'git
>> reset --merge' as-is.
>
> ACK to that. I think people using 'git reset --merge' know what
> they're doing, and should be able to clobber their changes (viz. `git
> reset --hard`),

Wait a second: isn't that exactly what 'git reset --hard' is for?

I doubt[*] 'git reset --merge' could be anything but a mistake when used
outside the context of a merge (remember that the plumbing is called
"read-tree", not "reset").

[*] This is disingenuous of me.  I used to use "git reset --merge <commit>"
with the intent of "git reset --keep <commit>", since the latter did
not exist yet.  But I was wrong. :)

Here's a start for the interested:

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..a4fc7b3 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -335,6 +335,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die("%s reset is not allowed in a bare repository",
 		    reset_type_names[reset_type]);
 
+	if (reset_type == MERGE && !file_exists(git_path("MERGE_HEAD")))
+		die("You are not in the middle of a merge (MERGE_HEAD does not exist).");
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
