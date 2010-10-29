From: Kevin Ballard <kevin@sb.org>
Subject: Re: `git status --porcelain` disagrees with documentation about quoting filenames with spaces
Date: Thu, 28 Oct 2010 17:41:01 -0700
Message-ID: <CAA0934C-A48A-4E45-9875-7629BF6D909F@sb.org>
References: <4AC7298E-73D7-4074-91CD-7C10DE414532@sb.org> <7v39rqb1ji.fsf@alter.siamese.dyndns.org> <EFFE2D68-BBA3-4EF4-B56A-AA4882EDE1E4@sb.org> <7vocad996g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 02:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBd1y-0005nq-NF
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 02:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542Ab0J2AlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 20:41:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48584 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab0J2AlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 20:41:05 -0400
Received: by yxk8 with SMTP id 8so1356986yxk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 17:41:04 -0700 (PDT)
Received: by 10.100.171.9 with SMTP id t9mr7575794ane.151.1288312864208;
        Thu, 28 Oct 2010 17:41:04 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id 25sm1784578anq.8.2010.10.28.17.41.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 17:41:03 -0700 (PDT)
In-Reply-To: <7vocad996g.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160256>

On Oct 28, 2010, at 4:41 PM, Junio C Hamano wrote:

>>> Kevin Ballard <kevin@sb.org> writes:
>>> 
>>> [jc: why do you send messages with toooooooooooo loooooong lines sometimes
>>> and normal line lengths some other times...?]
>> 
>> I use a GUI mail client to write email. Anything I copy&paste is hard-wrapped,
>> anything I write directly tends to not include hard linebreaks at all. Would it
>> be better if I hard-wrapped my lines?
> 
> It is not better vs worse but is acceptable vs unacceptable, as hard
> wrapped messages have been the norm around here from day one.  As far as I
> remember you only recently started sending messages with long lines, so I
> suspected perhaps you changed your environment and are doing so without
> realizing the pain you are causing to others.

I apologize, I did not realize it caused a problem to others. I'm not used
to interacting with people using terminal mail clients (e.g. mutt). I didn't
give it much thought, but I just assumed the ML was hard-wrapping everybody's
messages (of course this is obviously wrong, as evidenced by my own messages).
I will bear this in mind for future emails.

>>> The best would probably be to special case SP (which is normally not to be
>>> quoted) _only_ in the context of "something" -> "something".
>> 
>> That's what I was thinking. I'll look into doing just that.
> 
> Yeah, if we wanted to be perfect, it would be better to do so without
> causing unnecessary pain.

Turns out it's fairly simple to do.

BTW, I'm trying an experiment here to see if I can just paste the patch into
Mail.app without it being mangled. I sent it to myself first, and Mail.app
is applying quoted-printable encoding to the patch, but it appears git-am
can still understand it. Please let me know if this isn't acceptable and I
will send it separately.

---8<---
Subject: status: Quote renamed/copied paths with spaces in short format

According to the documentation for git-status, in short output mode,
paths with spaces or unprintable characters are quoted. However
28fba29 (Do not quote SP., 2005-10-17) removed the behavior that quotes
paths that have spaces but not unprintable characters. Unfortunately this
makes the output of `git status --porcelain` non-parseable in certain
(rather unusual) edge cases. In the interest of removing ambiguity when
parsing the output of `git status --porcelain`, restore the behavior of
quoting paths with spaces but only for renamed/copied paths.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
wt-status.c |   10 ++++++++++
1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index fc2438f..9624865 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -744,10 +744,20 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
		const char *one;
		if (d->head_path) {
			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
+			if (*one != '"' && strchr(one, ' ') != NULL) {
+				putchar('"');
+				strbuf_addch(&onebuf, '"');
+				one = onebuf.buf;
+			}
			printf("%s -> ", one);
			strbuf_release(&onebuf);
		}
		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		if (*one != '"' && strchr(one, ' ') != NULL) {
+			putchar('"');
+			strbuf_addch(&onebuf, '"');
+			one = onebuf.buf;
+		}
		printf("%s\n", one);
		strbuf_release(&onebuf);
	}
-- 
1.7.3.2.195.ge42d1.dirty
