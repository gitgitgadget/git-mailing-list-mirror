From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 15:57:17 +0200
Message-ID: <200905121557.18542.Hugo.Mildenberger@namir.de>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <200905121103.00432.Hugo.Mildenberger@namir.de> <81b0412b0905120354p6e1bf517y154601132f0901a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 15:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3sV3-0001t6-Fe
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 15:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbZELN6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbZELN6P
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 09:58:15 -0400
Received: from mx02.qsc.de ([213.148.130.14]:59902 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbZELN6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 09:58:14 -0400
Received: from localhost (port-87-234-69-58.dynamic.qsc.de [87.234.69.58])
	by mx02.qsc.de (Postfix) with ESMTP id 77BCA16C001A;
	Tue, 12 May 2009 15:58:14 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0905120354p6e1bf517y154601132f0901a3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118895>

> OTOH, a warning about commonly used delimiters not fitting a name
> context, maybe a good idea. Like "\r\n\t", backslash (came up recently
> on this list). Such a check and associated warning may be useful for
> repository names and branches.
>
> Still, it's more of a policy issue and I would make it optional, even
> if enabled by default. Maybe even by defining a regexp which the
> repo name or branch name must (for hard error) or should (for a warning)
> match.
>
> For your specific case, you can take a look at builtin-clone.c,
> just after the line containing "guess_dir_name(repo_name"...
> --

But at least the git versions I tried (up to 1.6.3) really do have a problem 
when facing a trailing newline in repository names; so one should enforce a 
convention. Although the situation here is certainly a far-flung, uncommon 
one, it could also happen when git was called from scripts.

I looked into guess_dir_name(). A regex call would be easy to fit, but 
currently the git binary does not depend on libpcre. Is it generally 
considered to be acceptable to add such a dependency? 

While I like the idea to make use of a configurable regular expression, such 
an expression had to be a command line parameter with a reasonable default 
value, because .git/config still would not exist when the value would be 
needed. 

Last not least, I managed to reproduce the problem almost exactly:

1.) hm@localhost git 
clone "git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-testing.git
"  
	(Note the trailing linefeed)

2.) hm@localhost ~/tmp/bluetooth-testing.git $ make
	Makefile:313: /home/hm/tmp/bluetooth-testing.git
	/scripts/Kbuild.include: No such file or directory
	make[1]: /home/hm/tmp/bluetooth-testing.git: No such file or directory
	make[1]: *** No rule to make target `/home/hm/tmp/bluetooth-testing.git'.
	Stop.
	make: *** No rule to make target `include/config/auto.conf', needed by
	`include/config/kernel.release'.  Stop.

3.) hm@localhost ~/tmp/bluetooth-testing.git $ git pull
	fatal: Error in line 2:

4.) ".git/config" now contains

url = 
git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-testing.git\n

I particulary liked the git message "fatal: Error in line 2:" ... 

grep says, it would stem from builtin-fmt-merge-msg.c/fmt_merge_msg():
270         /* get a line */
271         while (pos < in->len) {
272                 int len;
273                 char *newline, *p = in->buf + pos;
274
275                 newline = strchr(p, '\n');
276                 len = newline ? newline - p : strlen(p);
277                 pos += len + !!newline;
278                 i++;
279                 p[len] = 0;
280                 if (handle_line(p))
281                         die ("Error in line %d: %.*s", i, len, p);
282         }
