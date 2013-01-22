From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822
 continuation in footer
Date: Tue, 22 Jan 2013 01:35:51 -0800
Message-ID: <CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
	<1358757627-16682-2-git-send-email-drafnel@gmail.com>
	<20130122075413.GB6085@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 10:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxaHA-0003p6-LN
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 10:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab3AVJfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 04:35:54 -0500
Received: from mail-vb0-f51.google.com ([209.85.212.51]:35658 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3AVJfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 04:35:52 -0500
Received: by mail-vb0-f51.google.com with SMTP id fq11so5378316vbb.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=o3/FTpvrFQTfGHwhsxB+OTlpdULKGPx92D4wWRDlcGY=;
        b=yHsLvDpLGG2xWsyAXFW0by2EJmYD9gvRa/dUzCru63Nf0kmknaBFU25S+5dIQCQIWi
         e/FEK73EfyF7LfE/0t1xrRdJ/zptEKf+aiqwdd1etGXodVjmPYQIRrdrwB0pZaXgFbCk
         34bjQHIwNeXk+AnqxDBR/ZYx4D4KLeZL5rvbTKhBbC+ivJPUAyt380IWbvpe4LxhDORe
         QeiwgEm19Z2S5zsrXpRcC4JhJAgEk1peY4UOJXg+eSlYFSPwj1RLb+RhgVxzXQm/oz3v
         z+OrnafW8AjbRoL0xN4cm5wT22wUOWVwt56x3fnrp/2rUQv0e57wDoNM6M8EeYlEKI3Q
         HGqg==
X-Received: by 10.52.74.104 with SMTP id s8mr19701482vdv.6.1358847352022; Tue,
 22 Jan 2013 01:35:52 -0800 (PST)
Received: by 10.58.216.1 with HTTP; Tue, 22 Jan 2013 01:35:51 -0800 (PST)
In-Reply-To: <20130122075413.GB6085@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214224>

On Mon, Jan 21, 2013 at 11:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Brandon Casey wrote:
>
>> --- a/sequencer.c
>> +++ b/sequencer.c
> [...]
>> @@ -1042,13 +1041,8 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
>
> Git is checking if (sb->buf) ends with a "Signed-off-by:" style
> line.  If it doesn't, it will need to add an extra blank line
> before adding a new sign-off.
>
> First (snipped), it seeks back two newlines from the end and then
> forward to the next non-newline character, so (buf + i) is at the
> start of the last line of (the interesting part of) sb.

Did you catch that the two newlines have to be adjacent to each other?
 i.e. it seeks back until it finds a blank line.  Then it seeks
forward so that buf + i points at the first line of the last paragraph
of sb.

> Now:
>
>>       for (; i < len; i = k) {
>>               for (k = i; k < len && buf[k] != '\n'; k++)
>>                       ; /* do nothing */
>>               k++;
>
> (buf + k) points to the end of this line.

buf + k points to the start of the next line.  Not sure if that is the
same thing as what you said.

>> -             if ((buf[k] == ' ' || buf[k] == '\t') && !first)
>> -                     continue;
>
> This is always the first line examined, so this "continue" never
> triggers.

This is just totally broken and always has been.  The index variable
should be 'i' not 'k'.  It is supposed to check whether the current
line is a continuation of the previously inspected line.  An rfc2822
continuation line begins with space or tab.  The first line of the
paragraph obviously can't be a continuation line, so the /first/
variable is used as a guard against matching the first line.

>> -
>> -             first = 0;
>> -
>>               for (j = 0; i + j < len; j++) {
>
> If the line matches /^[[:alnum:]-]*:/, it passes and git moves on to
> the (nonexistent) next line.  Otherwise, it fails.
>
> Do I understand correctly?

No, I think you misread the for loop that you snipped out.  It seeks
back to the beginning of the last paragraph, not the last line.  The
for loop that you included above, inspects each line of that
paragraph.  If any line does not match /^[[:alnum:]-]*:/, then the
function returns false (0).  If every line matches, it returns true
(1).

> If so, this patch should be a no-op, which
> is good, I guess.

You're correct here though.  The patch is a no-op.  This patch removes
the code that was supposed to parse rfc2822 continuation lines, but it
was broken.  Thankfully it was broken utterly and completely so it
never allowed anything through that wasn't /^[[:alnum:]-]*:/.

-Brandon
