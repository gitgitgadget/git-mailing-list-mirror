From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 1/4] commit.h: add 'type' to struct name_decoration
Date: Sat, 19 Jun 2010 09:37:33 +0800
Message-ID: <1276911456-18466-1-git-send-email-ayiehere@gmail.com>
References: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 03:38:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPn0U-0005qs-0x
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 03:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab0FSBht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 21:37:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60837 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab0FSBhr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 21:37:47 -0400
Received: by pvg6 with SMTP id 6so659979pvg.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SWIIj1/fFBipWQc5jYPyjNqLm7vVeGLiol+nKJnR5mA=;
        b=fXRlZBAUd+YPu+AGQtSrEQMqcT4OGVLA4lE5gPKefOYRAhgxs2mMtgC3a0qCGnDmVE
         mDYvOVVZm8bDzBlqfOUqXk0ItpVAcQ1JFQOLB0vjvG0LqsyE+ncmnfmLS6v9nulAaIV4
         QSFLqvcYCYOAyf9gmRwTU7W0hoPgSCi+NTZEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Sqvv1NHqXNJfNfjqqdU2FXLT8svdP/QhA81OH3E+jo0POWOsKXu7hSGp8//IHwdpe1
         K862YPCm0W+M6uIYi+DbMhZpytcClBPvS0gIAot8fOqGA11qCPbcqXqiwT0OkAEIYeaW
         O/pwiH48pD0dlF0HPrvDoAysNrIY6RvdkT9N0=
Received: by 10.140.56.12 with SMTP id e12mr1519231rva.65.1276911466692;
        Fri, 18 Jun 2010 18:37:46 -0700 (PDT)
Received: from localhost.localdomain ([115.132.104.117])
        by mx.google.com with ESMTPS id s9sm3587164rvl.5.2010.06.18.18.37.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 18:37:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
In-Reply-To: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149369>

This allows for semantically better handling of decoration type.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
I have splitted the patch into four logical commits:

      1. commit.h: add 'type' to struct name_decoration
      2. log-tree.c: Use struct name_decoration's type for classifying decoration
      3. log --decorate: Colorize commit decorations
      4. Allow customizable coloring of commit decorations

This should make it easier for you (or anyone else)  to spot any problem with
my approach in colorizing --decorate stuff.

This is the first commit, and the rest will follow suit.

My reply to your comments are as follows:

On Fri, Jun 18, 2010 at 4:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Configuration variable names are either 2-level or 3-level.  There are
> existing examples for <slot> (e.g. color.branch.<slot>).

Fixed. Now the slots are no longer tied to log, and they are named like
this:

        color.decorate.reflocal
        color.decorate.refremote
        color.decorate.reftag
        color.decorate.refstash
        color.decorate.refhead

This should allow for handling different type of decorations in the
future.

> I don't think any of the above belongs to "decorate.c", which is the
> generic mechanism to annotate commits with arbitrary data.  The Porcelain
> feature "log --decorate" is just one user that happens to use refname as
> that "arbitrary data", and that is what you are coloring.  The code for
> that is in log-tree.c, I think.
>
>> diff --git a/decorate.h b/decorate.h
>> index e732804..d593d32 100644
>
> So is any change to this file.

Fixed. decorate.[ch] is no longer affected by this series.

> When color is not in use (e.g. output is not going to the terminal), you
> would lose "tag: " prefix, wouldn't you?

No. The "tag: " prefix is not lost. It will be shown by show_decorations() if
the type of the decoration matches DECORATION_REF_TAG.

>> +     else if (!prefixcmp(refname, "refs/stash"))
>> +             type = DECORATION_STASH;
>> +     else if (!prefixcmp(refname, "HEAD"))
>> +             type = DECORATION_HEAD;
>
> I suspect that users would expect DECORATION_HEAD to be used to highlight
> the object at the tip of the current branch, but I also suspect this code
> would not do so.

No the code would not do so. It would only colorize the literal printed 'HEAD'
string. The current --decorate shows only 'HEAD' for symbolic refs (is this the
right term for it?) and nothing else (it seems that way to me, I might be wrong
here).

nazri

 commit.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/commit.h b/commit.h
index 6ef88dc..ba818fc 100644
--- a/commit.h
+++ b/commit.h
@@ -28,6 +28,7 @@ extern const char *commit_type;
 extern struct decoration name_decoration;
 struct name_decoration {
 	struct name_decoration *next;
+	int type;
 	char name[1];
 };
 
-- 
1.7.1.245.g7c42e.dirty
