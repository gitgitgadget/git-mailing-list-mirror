From: Tor Arvid Lund <torarvid@gmail.com>
Subject: A little mystery - crash caused by empty commit message.
Date: Tue, 10 Feb 2009 12:15:54 +0100
Message-ID: <1a6be5fa0902100315q554dc457j8c8476d3f59a314f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:17:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqcM-0004P2-Bi
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbZBJLP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbZBJLP5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:15:57 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:41780 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbZBJLP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:15:56 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1392170mue.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 03:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=T7Dps2jtyhrQCgie4pA8G5RQ4EnlUdm+gfuK8wyUiQg=;
        b=G15XtO/bg0E8uzdrJv2TWoV+D7b+CXPE7UPTdeFmHGu6gnN983CCw0tGOYlnLN4iTY
         GZxrmQrmTNoakQVcT8aHRIHEAaAxEnG8PM8I1Y9ZTJWizGkAvl4qESzSt9bGC1UALZBO
         cLlvpjqMXRRSnLLw5uGAO0X5BuUxeC7+iUPDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JWGVUWovUfFdjyl+NrzhKuotjieA2xp+23lR7NfS4pZHSrKZ2BenhFZ0Zox2w6RGV6
         gdpZqtpNMnnRGzp4YrrA17jOvYOw5sZ+Simx0oJxpRzOOxY7OASxlBSUb9n/kWATYKba
         Dpf1pwFj64XKYO6TPeOlQKKUqBFHQMYR8f0Qk=
Received: by 10.103.225.11 with SMTP id c11mr2702819mur.24.1234264554566; Tue, 
	10 Feb 2009 03:15:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109207>

Hi, all.

So - I started noticing a problem where for instance "git log" or "git
branch -av" would crash in one of my repositories. My environment is
Windows Vista x64, using msysgit. I have compiled several versions of
git, but I think I had version 1.6.0.3 then this problem arose. When
the crash occurred, Windows would just pop up a dialog window saying
"git.exe has stopped working". So I tried running it with gdb, which
told me there was a segfault in strchr() but no more. Git is built
with debug symbols (-g), so I am guessing this may be a problem with
my msysgit environment (maybe in conjunction with 64-bit Vista) or
something. But I don't really know what I'm talking about, and it is
another topic anyway...

Then I tried copying the repository to a linux box and tried gdb
there. Much better. strchr(line, '\n') is called in pretty.c in the
get_header function. For one of the commits, the 'line' parameter was
NULL, so I managed to make it not crash with this little patch:

diff --git a/pretty.c b/pretty.c
index 8d4dbc9..1b2d097 100644
--- a/pretty.c
+++ b/pretty.c
@@ -230,6 +230,8 @@ static char *get_header(const struct commit
*commit, const char *key)
       const char *line = commit->buffer;

       for (;;) {
+               if (line == NULL)
+                       return NULL;
               const char *eol = strchr(line, '\n'), *next;

               if (line == eol)



The result from "git log" for me is then:

...
commit 6a1ac5bc05b2cdd276c7f8a39565681f9d8017d7
<normal output>

commit f67f77edf06bbcebabf430735c751245a4b70f14
Author: Tor Arvid Lund <toral@qsystems.no>
Date:   Thu Feb 5 17:47:09 2009 +0100

commit 6d109492008c68d28af821b96b82f807f338caf6
<normal output>
...

That is - a handful of commits that are output "normally", followed by
one commit where the message is just blank, and then more "normal"
output... By the way - I tried running git fsck --full --strict, and
it did not report any errors (just the "common" list of dangling blobs
and such...

But the question is then - how did I manage to get my repository in
this state? The commit in question was made by me - I know I entered a
message when I committed it. I can even find the commit *with* the
original commit message in another branch... I am sorry to say that my
memory fails me, so I cannot remember all the times I may have moved
commits around, rebased, etc. I do such things often, as I use git-p4
to communicate with the "official company repo" (and because its so
nice :)). I don't know the core git code well, but when I'm in the
mood for speculation, I feel like a rebase or a cherry-pick must have
been the reason for this to have happened...

Well - I just thought I should tell you all about it. My simple little
patch makes it "not crash", but it should maybe report an error or
warning to the user - as something is most likely wrong somewhere.

-Tor Arvid-
