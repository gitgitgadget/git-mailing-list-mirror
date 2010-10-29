From: Kevin Ballard <kevin@sb.org>
Subject: Re: `git status --porcelain` disagrees with documentation about quoting filenames with spaces
Date: Thu, 28 Oct 2010 18:51:58 -0700
Message-ID: <A2E979E4-899B-4295-A8CF-72EF8E585D3A@sb.org>
References: <4AC7298E-73D7-4074-91CD-7C10DE414532@sb.org> <7v39rqb1ji.fsf@alter.siamese.dyndns.org> <EFFE2D68-BBA3-4EF4-B56A-AA4882EDE1E4@sb.org> <7vocad996g.fsf@alter.siamese.dyndns.org> <CAA0934C-A48A-4E45-9875-7629BF6D909F@sb.org> <7vaalx9430.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 03:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBe8W-0001AZ-Ev
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 03:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759621Ab0J2BwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 21:52:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38903 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759518Ab0J2BwB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 21:52:01 -0400
Received: by gxk23 with SMTP id 23so1716774gxk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 18:52:01 -0700 (PDT)
Received: by 10.150.12.5 with SMTP id 5mr21310956ybl.257.1288317120953;
        Thu, 28 Oct 2010 18:52:00 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id p1sm1284007ybn.17.2010.10.28.18.51.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 18:52:00 -0700 (PDT)
In-Reply-To: <7vaalx9430.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160261>

If you don't mind I've brought this back onto the list.

On Oct 28, 2010, at 6:32 PM, Junio C Hamano wrote:

>> BTW, I'm trying an experiment here to see if I can just paste the patch into
>> Mail.app without it being mangled. I sent it to myself first, and Mail.app
>> is applying quoted-printable encoding to the patch, but it appears git-am
>> can still understand it. Please let me know if this isn't acceptable and I
>> will send it separately.
> 
> Almost but not quite; it appears that all the leading SP on the context
> lines and the diffstat are lost by somebody.

Well, it looks like I screwed up. I sent a test email to myself and it came
through fine, so I selected all, hit copy, and pasted that into the new
reply to the list. Unfortunately, copying from Mail.app's rich markup view
seems to have lost the spaces. If I copy from the Raw Source view it works
fine. I'll have to try again without making that mistake.

> The patch seems to unconditionally dq even when there is no rename
> (i.e. when d->head_path is NULL).
> 
> I think it _is_ intended (otherwise it becomes unwieldy to tell if you
> renamed "foo" to "bar" or if you touched "foo -> bar" without looking at
> the status letters) but the behaviour does not seem to match what the log
> message says it does.

Good point. I hadn't thought this through properly. Here's an updated patch
with a fixed description. And this time I'm not copying it from a test email ;)

---8<---
Subject: status: Quote paths with spaces in short format

According to the documentation for git-status, in short-format mode,
paths with spaces or unprintable characters are quoted. However
28fba29 (Do not quote SP., 2005-10-17) removed the behavior that quotes
paths that have spaces but not unprintable characters. Unfortunately this
makes the output of `git status --porcelain` non-parseable in certain
(rather unusual) edge cases. In the interest of removing ambiguity when
parsing the output of `git status --porcelain`, restore the behavior of
quoting paths with spaces in git-status's short-format mode.

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
