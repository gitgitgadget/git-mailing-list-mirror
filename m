From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [bug] generic issue with git_config handlers
Date: Mon, 4 Feb 2008 07:27:44 +0100
Message-ID: <200802040727.44522.chriscool@tuxfamily.org>
References: <20080131091627.GB24403@artemis.madism.org> <7v1w7ye48j.fsf@gitster.siamese.dyndns.org> <20080131101037.GG24403@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 07:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLuiw-0001SO-Cr
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 07:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbYBDGVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 01:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYBDGVr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 01:21:47 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56271 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYBDGVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 01:21:46 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8922F1AB2B0;
	Mon,  4 Feb 2008 07:21:44 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4BEFC1AB2BB;
	Mon,  4 Feb 2008 07:21:44 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080131101037.GG24403@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72463>

Le jeudi 31 janvier 2008, Pierre Habouzit a =E9crit :
> On Thu, Jan 31, 2008 at 09:25:32AM +0000, Junio C Hamano wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:
> > >   One of my co-workers stumbled upon a misfeature of the git conf=
ig
> > > parser. The following syntax is allowed:
> > >
> > >     [section]
> > > 	 foo
> >
> > Yeah, that is how "truth" value of boolean is spelled.
> >
> > > [user]
> > >     name
> >
> > That's very unfortunate.  Whatever is expecting string value
> > should check for NULL.  Fix should probably be easy enough for
> > any git-hacker-wannabe to tackle ;-)
>
>   I think so too, though my count is something like 40 functions to
> investigate (the 40 handlers) and where it recurses into ;) Too much
> work for the time I have right now.

I would suggest this patch:

---8<---
diff --git a/config.c b/config.c
index 526a3f4..92613c5 100644
--- a/config.c
+++ b/config.c
@@ -139,7 +139,7 @@ static int get_value(config_fn_t fn, char *name,=20
unsigned in
                if (!value)
                        return -1;
        }
-       return fn(name, value);
+       return fn(name, value ? value : "");
 }

 static int get_extended_base_var(char *name, int baselen, int c)
---8<---

but it breaks some test cases.

$ ./t1300-repo-config.sh -d -i -v

[...]

* expecting success: git config --get-regexp novalue > output &&
         cmp output expect
output expect differ: char 17, line 1
* FAIL 34: get-regexp variable with no value
        git config --get-regexp novalue > output &&
                 cmp output expect

$ cat output | hexdump -C
00000000  6e 6f 76 61 6c 75 65 2e  76 61 72 69 61 62 6c 65  |
novalue.variable|
00000010  20 0a                                             | .|
00000012

$ cat expect | hexdump -C
00000000  6e 6f 76 61 6c 75 65 2e  76 61 72 69 61 62 6c 65  |
novalue.variable|
00000010  0a                                                |.|
00000011

I don't know if the added space is a big problem.

It comes from the following code in builtin-config.c:44

	if (show_keys) {
		if (value_)
			printf("%s%c", key_, key_delim);
		else
			printf("%s", key_);

where "value_" is now "" instead of NULL.

At this point, as I don't know much the code in these files, I think I =
could=20
very well use some advice from people more familiar with this.

Thanks in advance,
Christian.
