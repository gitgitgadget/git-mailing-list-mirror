From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH v6 15/16] remote-svn: add marks-file regeneration
Date: Sat, 25 Aug 2012 17:55:13 +0200
Message-ID: <001c01cd82da$03abbb00$0b033100$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 17:55:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5Ihy-00089x-Os
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 17:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab2HYPz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 11:55:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:62997 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab2HYPz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 11:55:27 -0400
Received: from DualCore (dsdf-4d0a03be.pool.mediaWays.net [77.10.3.190])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M6fVk-1TsZPU3QEW-00wWdn; Sat, 25 Aug 2012 17:55:25 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2C2gLvAb1n8HILTy6eFwlSeL6x8A==
Content-Language: de
X-Provags-ID: V02:K0:GNG2WHxzIIudljvkZWHUtG77F/4zf7zk6KshjJvpZD9
 i4uWmr7q+sdCoaxQKgW4Yp8mnYhHlUkWfw18gGUsa2kigsatH5
 sJaiK7bNy+EqJ1ojjeYOqBTzr4uBAmGUNRFdhEQhWAqtC0RvrZ
 zYSoz8UA83UI9d6/DIW9jKMxTzUA9SZ+9IftZsfPARY1ncDd3a
 WZf/RY7rbxE3SxBZpQ3fLVXjZRu0SqOe2pLZvea4kIYfM+lDE7
 TwqHw+FXgrQOj1ZlBptwAd4hODC52xGeEZpl4ZUcQDuswpBblt
 usae3e8Psiz6ddEy+/HSicnld4K/qYE3eqn6F2vCX7jn99blf4
 1xCbIjGDAbSa2RyT/5usmln1xT/wi8dHWqi2w/ecdTC9xmAIa6
 ZKRzNXBMg4NDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204274>

"Florian Achleitner" <florian.achleitner.2.6.31@gmail.com> schrieb im Newsbeitrag
news:<1345662961-9587-16-git-send-email-florian.achleitner.2.6.31@gmail.com>...
> fast-import mark files are stored outside the object database and are
> therefore not fetched and can be lost somehow else.  marks provide a
> svn revision --> git sha1 mapping, while the notes that are attached
> to each commit when it is imported provide a git sha1 --> svn revision
> mapping.
> 
> If the marks file is not available or not plausible, regenerate it by
> walking through the notes tree.  , i.e.  The plausibility check tests
> if the highest revision in the marks file matches the revision of the
> top ref. It doesn't ensure that the mark file is completely correct.
> This could only be done with an effort equal to unconditional
> regeneration.
> 
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  remote-testsvn.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index e90d221..09dc304 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
...
> +static void check_or_regenerate_marks(int latestrev) {
> +	FILE *marksfile;
> +	char *line = NULL;
> +	size_t linelen = 0;
> +	struct strbuf sb = STRBUF_INIT;
> +	int found = 0;
> +
> +	if (latestrev < 1)
> +		return;
> +
> +	init_notes(NULL, notes_ref, NULL, 0);
> +	marksfile = fopen(marksfilename, "r");
> +	if (!marksfile) {
> +		regenerate_marks();
> +		marksfile = fopen(marksfilename, "r");
> +		if (!marksfile)
> +			die_errno("cannot read marks file %s!", marksfilename);
> +		fclose(marksfile);
> +	} else {
> +		strbuf_addf(&sb, ":%d ", latestrev);
> +		while (getline(&line, &linelen, marksfile) != -1) {

getline() is not available to anybody, e.g. it is not in HP NonStop.

Bye, Jojo
