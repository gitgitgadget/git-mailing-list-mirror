From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: add --except option
Date: Sat, 31 Aug 2013 14:27:08 -0500
Message-ID: <CAMP44s0D98tggTjQsMn+-03KgSsbrh3nxYfLofpC1gfnJpEPyw@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<5220503F.2080608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:27:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqpH-0007Mt-VS
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab3HaT1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:27:11 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:51981 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab3HaT1K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:27:10 -0400
Received: by mail-la0-f50.google.com with SMTP id es20so2442417lab.23
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ut8fEkWhzwpEViQv5MrZlHo7+7V/ml7BXvGCTv+78G8=;
        b=woaqFZmklg6v+6foUYGiuh/l++Th2Aogke3rNgWZ8+65beqZpzyVjR7lA4MLMqCqco
         3wqjubid8hRoLXOIk2pgXVMLmrEzbBsdJudspxEGramUpKtWDJuQgsRJ7AFtZhPZeNNQ
         Jo17rN39Mi7DFsc3VmGOaePKyXePuzQ28yBQALj1fhGdjAAlu9dF2lCtsajbpGVydbjZ
         +StQa0IHnE2cQI2Hpy9sO5lkU6SXD80mXWFH5U8z2IGq9iRVO6hZ41HP1Qj+k5CNz35F
         Y1W3B1VjmbZX5as5ILkSm7Tm9yX/CxHgkb/0SywYa7pQDAk5ttKtq5fD+gzjIwdsNTuw
         A+Nw==
X-Received: by 10.112.149.197 with SMTP id uc5mr13063441lbb.19.1377977228799;
 Sat, 31 Aug 2013 12:27:08 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 12:27:08 -0700 (PDT)
In-Reply-To: <5220503F.2080608@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233544>

On Fri, Aug 30, 2013 at 2:56 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/30/2013 8:32, schrieb Junio C Hamano:
>> If you have a history where
>>
>>  - branches "master" and "maint" point at commit A;
>>  - branch "next" points at commit B that is a descendant of A; and
>>  - there are tags X and Y pointing at commits that are ahead of B
>>    or behind A
>>
>> i.e.
>>
>>       ----X----A----B----Y
>>
>> what are the desired semantics for these?
>
> I think the simplest were that --except trumps everything and means
> "whatever else I say, do as if I did not mention the following".

Actually, my patch is almost there, I attach the necessary changed
below to make everything work. I've added debug prints to show what
it's actually doing:

>>  (1) --branches --except maint
>
> => master next

=> master next

>>  (2) --all --not --branches --except maint
>
> => X Y --not master next

=> ^master ^next X Y HEAD

>>  (3) ^master next --except maint
>
> => ^master next

=> ^master next

> (4) Y next --except master next --not --branches
>
> this => Y --not maint
> or this => Y --not maint master next

=> Y

Remember that maint (or rather ^maint) is after --except.

> (5) --branches --except ^master
>
> this => maint next
> or this => maint master next ^master
> or error("--except does not allow negated revisions")

=> maint next

Here's the diff:

--- a/revision.c
+++ b/revision.c
@@ -2578,7 +2578,11 @@ void reset_revision_walk(void)
 static int refcmp(const char *a, const char *b)
 {
        a = prettify_refname(a);
+       if (*a == '^')
+               a++;
        b = prettify_refname(b);
+       if (*b == '^')
+               b++;
        return strcmp(a, b);
 }

@@ -2594,13 +2598,14 @@ int prepare_revision_walk(struct rev_info *revs)
        revs->pending.alloc = 0;
        revs->pending.objects = NULL;
        while (--nr >= 0) {
-               struct commit *commit = handle_commit(revs, e->item, e->name);
+               struct commit *commit;
                for (i = 0; i < revs->cmdline.nr; i++) {
                        struct rev_cmdline_entry *ce;
                        ce = &revs->cmdline.rev[i];
                        if ((ce->flags & SKIP) && !refcmp(ce->name, e->name))
                                goto next;
                }
+               commit = handle_commit(revs, e->item, e->name);
                if (commit) {
                        if (!(commit->object.flags & SEEN)) {
                                commit->object.flags |= SEEN;

-- 
Felipe Contreras
