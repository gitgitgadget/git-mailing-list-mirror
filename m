From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 2 May 2011 14:20:10 +0200
Message-ID: <BANLkTikvYLKKj_Wd0EOxZh+vANxju4CV6Q@mail.gmail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
	<BANLkTi=NOaWN56qBACoTE2WQWFM3rHXfWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 14:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGs6r-0004tm-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 14:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab1EBMUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 08:20:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62358 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab1EBMUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 08:20:12 -0400
Received: by ewy4 with SMTP id 4so1722538ewy.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hhC7HvK2N09AJuWZrk9mcHIP2wZN8HI0bFyGY92N8XA=;
        b=ut3s61QIzLwdH0v7VVdnId66STyR9PrV6ZGrEpZinE0mgi4n7GaC48ZKIc4QUMdIfj
         uDz168jluFDWOJCFukXkwvQLUDWpm3ZYx89wC6PdgLxm3L5mLh3GTzf27algQviSC1qZ
         QtpWf6FaXMltmVxMNrJsE0/SU10ke92IUBQ5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Mb6m5gUttI/IFxZH72iduvYCNiMpMOJCioHX+hhPaVtNFmtlIP8b0m5fAZ1c6HCf77
         b8L5LfwUntKbl9YCXiIQGSWT6WwYfQPXUB7r2ZPJ53tXuEt54hZse/l+8mgWlZcb3gfE
         4QeFDkbaI1jPT00/KKZl/Df5A5vtiLTsn6pn0=
Received: by 10.223.5.3 with SMTP id 3mr1350154fat.56.1304338810686; Mon, 02
 May 2011 05:20:10 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 05:20:10 -0700 (PDT)
In-Reply-To: <BANLkTi=NOaWN56qBACoTE2WQWFM3rHXfWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172578>

On Mon, May 2, 2011 at 13:54, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Mon, May 2, 2011 at 13:39, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> This series will teach git grep to match at specified line numbers. This is
>> particular usefull, if you want to see the lines which emits warnings or errors
>> from a build run (where you only get the line number) and present it nicely to
>> the user with function and context lines.
>
> Can you give a concrete example of how you'd use this? I'm not sure I
> understand the described use case.

I parse the output of compiling a file, there may be warnings or even
errors, I collect the given line numbers, and then call 'git grep -p
-C -n (-@ <lno>)+ -- <path>' to show me what these warnings are about.

For example clang 2.9 (while clang is a bad example, because it prints
the offending line already, but gcc does not generate any warnings on
master currently) gives the following warning (which is probably worth
a patch, btw):

    CC grep.o
grep.c:231:16: warning: comparison of unsigned enum expression < 0 is
always false [-Wtautological-compare]
                if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
                    ~~~~~~~~ ^ ~
1 warning generated.

I can than call 'git grep -3 -n -h -p -@ 231 -- grep.c', and get:

218=static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
--
228-    for (p = opt->header_list; p; p = p->next) {
229-            if (p->token != GREP_PATTERN_HEAD)
230-                    die("bug: a non-header pattern in grep header list.");
231:            if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
232-                    die("bug: unknown header field %d", p->field);
233-            compile_regexp(p, opt);
234-    }

Another use case would be to restrict the matching to a block of
lines, this would need the mentioned patch 5, which than will support
line ranges, so that you can say 'match foo, but only in the first 10
lines'.

Bert

>
> --
> Cheers,
>
> Sverre Rabbelier
>
