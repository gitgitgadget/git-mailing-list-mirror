From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 23:07:32 -0500
Message-ID: <CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 06:07:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfMoX-0005Ku-C3
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 06:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab3EWEHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 00:07:35 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:41322 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3EWEHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 00:07:34 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so2898864lbd.1
        for <git@vger.kernel.org>; Wed, 22 May 2013 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iqtS9b/vfNo7gB1hgaQ3B+EPR0Mi/UTxzpDOkwkJ9uk=;
        b=Ro3DJ0UKneMklEpr9CB8QQ7qoy3Cfyibto8TGrO4VA/7f4FT7Oqu5vgV662UI0dlRc
         tiCX11cEpD/CJsQssbM8s/c0f4bBt4u6+yi2QDmuKaOpxm4yBZKF71CvsrCy0dSeRWYV
         vIkhFDfqwa8r0uWVvkeDXVFXf+F48r031068TEwWyBG8kO1jJrerQC0SC9ghn0sGl3fH
         I9b+CJ+LWxT0PmS0fZMJjTYf/nvvkdShZPyH4iKg2CRnJLXsET/PgdN4QnEZznIZds7X
         WXLtYPyf3DOgma3z+FngZtoG0TaGI1nqK5UOzyt8selLZESJbWymiHjCgK7VtvcwfJIx
         s1PQ==
X-Received: by 10.152.28.67 with SMTP id z3mr5433553lag.47.1369282052108; Wed,
 22 May 2013 21:07:32 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 21:07:32 -0700 (PDT)
In-Reply-To: <7vvc6ah81g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225211>

On Wed, May 22, 2013 at 7:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> IIRC, git-gui runs two blames, one without any -C and one with (I do
>>> not offhand recall how many -C it uses) to show both.
>>
>> 'git blame' is a very expensive operation, perhaps we should add
>> another option so users don't need to run two blames to find this.
>
> Yes, you could add a "struct origin *suspect_in_the_same_file" next
> to the current "struct origin *suspect" to the blame_entry in order
> to represent the origin you would get if you were to stop at a "move
> across files" event, and keep digging, when you are operating under
> "-C -C" or higher mode.

No, this is what I meant:

--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1509,16 +1509,6 @@ static void found_guilty_entry(struct blame_entry *ent)
        if (ent->guilty)
                return;
        ent->guilty = 1;
-       if (incremental) {
-               struct origin *suspect = ent->suspect;
-
-               printf("%s %d %d %d\n",
-                      sha1_to_hex(suspect->commit->object.sha1),
-                      ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-               emit_one_suspect_detail(suspect, 0);
-               write_filename_info(suspect->path);
-               maybe_flush_or_die(stdout, "stdout");
-       }
 }

 /*
@@ -1536,12 +1526,24 @@ static void assign_blame(struct scoreboard *sb, int opt)
                struct origin *suspect = NULL;

                /* find one suspect to break down */
-               for (ent = sb->ent; !suspect && ent; ent = ent->next)
-                       if (!ent->guilty)
+               for (ent = sb->ent; ent; ent = ent->next)
+                       if (!ent->guilty) {
                                suspect = ent->suspect;
+                               break;
+                       }
+
                if (!suspect)
                        return; /* all done */

+               if (incremental &&
!is_null_sha1(suspect->commit->object.sha1)) {
+                       printf("%s %d %d %d\n",
+
sha1_to_hex(suspect->commit->object.sha1),
+                                       ent->s_lno + 1, ent->lno + 1,
ent->num_lines);
+                       emit_one_suspect_detail(suspect, 0);
+                       write_filename_info(suspect->path);
+                       maybe_flush_or_die(stdout, "stdout");
+               }
+
                /*
                 * We will use this suspect later in the loop,
                 * so hold onto it in the meantime.

-- 
Felipe Contreras
