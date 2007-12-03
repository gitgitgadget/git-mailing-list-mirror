From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Mon, 3 Dec 2007 09:26:30 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712030922250.8458@woody.linux-foundation.org>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <7vhcj0seok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:28:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzF5a-0004Za-AI
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbXLCR1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 12:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbXLCR1y
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:27:54 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37830 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754AbXLCR1y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 12:27:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB3HQVRT007298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Dec 2007 09:26:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB3HQVPF009515;
	Mon, 3 Dec 2007 09:26:31 -0800
In-Reply-To: <7vhcj0seok.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66929>



On Sun, 2 Dec 2007, Junio C Hamano wrote:
> "Anatol Pomozov" <anatol.pomozov@gmail.com> writes:
> >
> > I just start learning git and I found a bug (but sorry if the
> > functionality I am trying to blame as a bug not actually bug and it
> > was made by intention)
> 
> I think it is rather a sloppy error checking than a bug.  It should be
> throwing a stone back at you when you feed it a full path, or converting
> it back to work tree relative path before using.

How about this patch?

It makes "get_pathspec()" make all the paths it returns relative, if it 
can. HOWEVER! I think it should actually die() if it sees an absolute path 
that it cannot convert (because it really cannot do anything sane about 
it), but I commented that out for now because that requires some test case 
change: right now we actually have a few test cases for insane filename 
arguments, and they expect the old behaviour.

Comments? This changes behaviour subtly (and if we enable the "die(..)" 
logic, not-so-subtly), but I think that in any case where it changes 
behaviour, the new behaviour would be an improvement, and the old one 
would be nonsensical (ie you get *some* results with an absolute pathname, 
just not the ones you'd expect!)

Note the die() comment in the bad case in "make_relative()".

		Linus
---
 setup.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 2c7b5cb..fadf4ee 100644
--- a/setup.c
+++ b/setup.c
@@ -111,11 +111,26 @@ void verify_non_filename(const char *prefix, const char *arg)
 		die("'%s': %s", arg, strerror(errno));
 }
 
+static const char *make_relative(const char *file, const char *pwd, int pwdlen)
+{
+	if (strncmp(file, pwd, pwdlen))
+		goto bad;
+	if (file[pwdlen] != '/')
+		goto bad;
+	return file + pwdlen + 1;
+
+bad:
+	/* Should we die() here or just do a "return file"? */
+	/* die("pathname '%s' is not in the repository", file); */
+	return file;
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
+	const char *pwd;
 	const char *entry = *pathspec;
 	const char **p;
-	int prefixlen;
+	int prefixlen, pwdlen;
 
 	if (!prefix && !entry)
 		return NULL;
@@ -127,9 +142,26 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 		return spec;
 	}
 
+	pwd = NULL;
+	pwdlen = 0;
+	p = pathspec;
+	do {
+		if (*entry == '/') {
+			if (!pwd) {
+				char buffer[PATH_MAX + 1];
+				if (!getcwd(buffer, sizeof(buffer)))
+					break;
+				pwd = buffer;
+				pwdlen = strlen(buffer);
+			}
+			*p = make_relative(entry, pwd, pwdlen);
+		}
+	} while ((entry = *++p) != NULL);
+
 	/* Otherwise we have to re-write the entries.. */
 	p = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
+	entry = *p;
 	do {
 		*p = prefix_path(prefix, prefixlen, entry);
 	} while ((entry = *++p) != NULL);
