From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Thu, 23 May 2013 16:33:21 +0530
Message-ID: <CALkWK0kBzsti=gqu6G1mGLA3cc5kv7+hc0=vgA7UGw2REXRi1w@mail.gmail.com>
References: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
 <1369219195-20096-2-git-send-email-artagnon@gmail.com> <7vhahukjeg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 13:04:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfTJY-0001jP-8k
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 13:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758468Ab3EWLEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 07:04:04 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58073 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758022Ab3EWLEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 07:04:02 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so792565iea.23
        for <git@vger.kernel.org>; Thu, 23 May 2013 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RZUl2zxf1kj/J+25RfRYbv6Y42QfqF5uphY9tIsJ4So=;
        b=LUBAz16Om4n4G6fqJ6+uELz0UWUrPbwWnVyDaDuiZpShWBGGBQmf7SBLP3pTNsy5U5
         hJ2bWsxYmvmFUUaaKfeC68zSTyI3WF6trtUD4dDMoHZchkwcuDli2XHl7+X6brIeNVOu
         pG0W4Y8Kf7k8tpBLP57ic23icsWeZFEy0UAKJvrFa4Azgu5L+kX2ykIw9p5MSe72DhYk
         J91QElwVYX1Qtv95zyVQ04pP6D2FTYKwGrds8kiCIi7chk/ZWImGYWAywUFla9Ho/y05
         iJ2mxWrAZY+jnaG63ulDyNIEi9iWn7LUWd3by3zZfOYdojwFQvPsCVjYFUzeFaRrm/vW
         smkA==
X-Received: by 10.50.66.197 with SMTP id h5mr11159645igt.63.1369307041778;
 Thu, 23 May 2013 04:04:01 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 04:03:21 -0700 (PDT)
In-Reply-To: <7vhahukjeg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225239>

Junio C Hamano wrote:
> If you have to ask why, and cannot answer the question yourself,
> then you would not know if such a caller exists.  After a code
> audit, I know there is no such caller that appends @{u} but if you
> were writing a quick-and-dirty caller, I would not be surprised if
> you find it more convenient to form a textual extended SHA-1
> expression and have get_sha1() do its work, instead of asking the
> same question programmatically.

I'll mention that a simple grep for "@{u}" and "@{upstream}" found nothing.

> In this case, I think you already checked there is no such problem,
> and it is a more straight-forward justification to say that you did
> a code-audit and made sure that all the callers that used to hit one
> of these errors() want to die().

It's not about callers eventually wanting to die(); it's about whether
callers want to die() without doing anything useful after getting this
-1.  And that is impossible for me to say with confidence, unless I do
a _very_ extensive code review (which I didn't do).

> Also such a caller, if existed, would either
>
>     (1) want to die itself, in which case these error() messages are
>         superfluous; or
>
>     (2) want to continue (possibly dying with its own message), in
>         which case these error() messages are unwanted.
>
> Because you are changing only the existing call sites of error()
> into die(), and not changing silent -1 returns to die(), this change
> is safe for both kinds of such callers, I think.

Take the example of git branch (-vv) output: let's imagine a universe
in which it determines upstream by calling in with a hard-coded "@{u}"
string.  Should the entire program die() and stop printing the rest of
the branches?  Ofcourse not.  Is your argument that no caller should
do this in the first place, because of spurious error() messages
polluting the output (of git branch)?  How is this argument stronger
than my grep for "@{u}"?

>> +             die(
>>                       _("Upstream branch '%s' not stored as a remote-tracking branch"),
>>                       upstream->merge[0]->src);
>
> OK, but I would fix the indentation while at it if I were doing this change.

But my Emacs reports that the indentation is correct.  Did you mean:

diff --git a/sha1_name.c b/sha1_name.c
index b7e008a..b00ea0f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1051,8 +1051,7 @@ int interpret_branch_name(const char *name,
struct strbuf *buf)
 			die(_("No upstream configured for branch '%s'"),
 				upstream->name);
 		}
-		die(
-			_("Upstream branch '%s' not stored as a remote-tracking branch"),
+		die(_("Upstream branch '%s' not stored as a remote-tracking branch"),
 			upstream->merge[0]->src);
 	}
 	free(cp);


Yeah, I'll do this.
