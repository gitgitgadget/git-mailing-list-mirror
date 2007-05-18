From: Andy Parkins <andyparkins@gmail.com>
Subject: autocrlf
Date: Fri, 18 May 2007 11:11:52 +0100
Message-ID: <200705181111.53823.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 18 12:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HozRd-0003hR-Qg
	for gcvg-git@gmane.org; Fri, 18 May 2007 12:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbXERKMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 06:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbXERKMJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 06:12:09 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:42305 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994AbXERKMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 06:12:08 -0400
Received: by mu-out-0910.google.com with SMTP id w1so554972mue
        for <git@vger.kernel.org>; Fri, 18 May 2007 03:12:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=A9YCuDYsRMtvKLdWzYbQDAXoTI2BRG25HjslMerzX9kYGCGO2kv4A5dQjq88kVoKEd7Y9d/c20nP7QklIf/nvzehVyeY8U3BYLIV7lx+quCnxNSMQHfQpqEmh6XvKvLHNSxzE4S6q+eekADb/BsLyCG0VmHaKurknPCgMYEdwL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TeGg50Icunlgm7OXDMwFfSD343iZy+XLvIJOmWi9zzNpubDJCaeVgQOx6ZbZEI6b7DsULqvQIa0o0s0/qAWbmkRIEY8uqJo2os+o/Cj6liZefl0SSGNK5Q0twP2HDWXZ0NcPcskNU/i27131Cfh5XdPnSMixbS0QBu7hOlhrxYE=
Received: by 10.82.169.4 with SMTP id r4mr2481599bue.1179483126212;
        Fri, 18 May 2007 03:12:06 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm67940ika.2007.05.18.03.12.01;
        Fri, 18 May 2007 03:12:03 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47587>

Hello,

I've just been playing with gitattributes and was trying the crlf attribute.  
The behaviour of this and/or core.autocrlf is not as I was expecting.

What I had imagined was that I could use .gitattributes to tell git which 
files in my tree were text.  Then the line endings on checkout would be set 
as appropriate to my platform, and on check in set to LF.

What actually happens is that any file with the crlf attribute is being 
checked out with LF expanded to CRLF (I'm running Linux of course), which is 
completely not what I wanted.

I've looked at convert.c:crlf_to_worktree(), and it seems that that is exactly 
what is programmed:

    dst = buffer;
    do {
        unsigned char c = *src++;
        if (c == '\n' && last != '\r')
            *dst++ = '\r';
        *dst++ = c;
        last = c;
    } while (--size);

This seems completely crazy.  What is automatic about that?  I had imagined 
the point of the crlf flag was to make it possible for windows users and 
linux users to work on the same project, each using their native line endings 
locally.  Have I misunderstood?  Am I doing something wrong?

How would you set up a repository so that checking it out on Linux results in 
LF endings, and on Windows it results in CRLF endings?

This also makes me think that the crlf attribute is wrong; what I really want 
to say in .gitattributes is something like

# Check out text to platform-dependent endings
*.txt lineending=native
# Check out svg to LF endings
*.svg lineending=lf
# Check out Z80 assembly files to CRLF
*.mac lineending=crlf
# Check out png untouched
*.png lineending=binary

With the default for the lineending attribute being "binary".

Then in .git/config I would have "core.nativelineending = crlf"; with the 
default being to use the ending appropriate to the platform.

I'll write patches for this, but I wanted to make sure I haven't completely 
gotten the wrong end of the stick before I do.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
