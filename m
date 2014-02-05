From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Thu, 06 Feb 2014 00:45:50 +0100
Message-ID: <87vbwtjf81.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<87r47hvrqt.fsf@fencepost.gnu.org>
	<xmqqob2l2ta7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 00:46:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBCAX-0004OO-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 00:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbaBEXqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 18:46:08 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:50222 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaBEXqG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 18:46:06 -0500
Received: from localhost ([127.0.0.1]:49262 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WBCAP-0007Jw-KL; Wed, 05 Feb 2014 18:46:06 -0500
Received: by lola (Postfix, from userid 1000)
	id 6434DE8721; Thu,  6 Feb 2014 00:45:50 +0100 (CET)
In-Reply-To: <xmqqob2l2ta7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Feb 2014 12:34:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241676>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> which I think is the prevalent style in our codebase.  The same for
>>> the other loop we see in the new code below.
>>>
>>>  - avoid assignments in conditionals when you do not have to.
>>
>> commit a77a48c259d9adbe7779ca69a3432e493116b3fd
>> Author: Junio C Hamano <gitster@pobox.com>
>> Date:   Tue Jan 28 13:55:59 2014 -0800
>>
>>     combine-diff: simplify intersect_paths() further
>> [...]
>>
>> +       while ((p = *tail) != NULL) {
>>
>> Because we can.
>
> Be reasonable.  You cannot sensibly rewrite it to
>
> 	p = *tail;
>         while (p) {
>         	...
> 		p = *tail;
> 	}
>
> when you do not know how ... part would evolve in the future.

The only unknown here is the potential presence of "continue;" in
... and that can be addressed by writing

    for (p = *tail; p; p = *tail) {
       ...
    }

However, that only makes sense where ... is rather large and diverse and
the assignment in question provides a unifying point.  In this case, the
loop is rather small and perfectly fits on one screen.  It turns out
that the assignment only serves for _obfuscating_ the various code
paths.  We have:

        while ((p = *tail) != NULL) {
                cmp = ((i >= q->nr)
                       ? -1 : strcmp(p->path, q->queue[i]->two->path));

                if (cmp < 0) {
                        /* p->path not in q->queue[]; drop it */
                        *tail = p->next;
                        free(p);
                        continue;
                }

                if (cmp > 0) {
                        /* q->queue[i] not in p->path; skip it */
                        i++;
                        continue;
                }

                hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
                p->parent[n].mode = q->queue[i]->one->mode;
                p->parent[n].status = q->queue[i]->status;

                tail = &p->next;
                i++;
        }

While we could instead have:
      p = curr;
      while (p) {
                cmp = ((i >= q->nr)
                       ? -1 : strcmp(p->path, q->queue[i]->two->path));

                if (cmp < 0) {
                        struct combine_diff_path *n = p->next;
                        /* p->path not in q->queue[]; drop it */
                        free(p);
                        p = *tail = n;
                        continue;
                }

                if (cmp > 0) {
                        /* q->queue[i] not in p->path; skip it */
                        i++;
                        continue;
                }

                hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
                p->parent[n].mode = q->queue[i]->one->mode;
                p->parent[n].status = q->queue[i]->status;

                p = *(tail = &p->next);
                i++;
        }

Of course, it only makes limited sense to recheck p after the second if, so
it would be clearer to write

      p = curr;
      while (p) {
                cmp = ((i >= q->nr)
                       ? -1 : strcmp(p->path, q->queue[i]->two->path));

                if (cmp < 0) {
                        struct combine_diff_path *n = p->next;
                        /* p->path not in q->queue[]; drop it */
                        free(p);
                        p = *tail = n;
                        continue;
                }

                if (cmp > 0) {
                        /* q->queue[i] not in p->path; skip it */
                        i++;
                        continue;
                }

                hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
                p->parent[n].mode = q->queue[i]->one->mode;
                p->parent[n].status = q->queue[i]->status;

                p = *(tail = &p->next);
                i++;
        }

But that's sort of a red herring since the actual loop structure is
hidden in conditions where it does not belong.  (i >= q->nr) is a
_terminal_ condition.

So it's more like

    p = curr;
    while (p) {
        if (i >= q->nr) {
            *tail = NULL;
            do {
                struct combine_diff_path *n = p->next;
                free(p);
                p = n;
            } while (p);
            break;
        }
        cmp = strcmp(p->path, q->queue[i]->two->path));
        if (cmp < 0) {
                struct combine_diff_path *n = p->next;
                /* p->path not in q->queue[]; drop it */
                free(p);
                p = *tail = n;
                continue;
        }
        if (cmp == 0) {
                hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
                p->parent[n].mode = q->queue[i]->one->mode;
                p->parent[n].status = q->queue[i]->status;

                p = *(tail = &p->next);
        }
        i++;
    }

> 	if ((p = *tail) != NULL) {
>         	...
>
> is a totally different issue.

Yes: it was just a matter of style instead of preventing _other_ code to
be rewritten in a clearer manner.

For a "don't look elsewhere" solution,

        while ((p = *tail) != NULL)

can _always_ be equivalently replaced with

        for (p = *tail; p; p = *tail)

and in this case already trivially improved with

        for (p = curr; p; p = *tail)

which meets your style prescription "avoid assignments in conditionals
when you do not have to." but in this particular case, the "don't look
elsewhere" solution was not called for.  It unifies code paths that
deserve to stay separate: we don't _want_ the assignment to take place
for every path leading to the loop control.  It makes it less clear to
see what happens.

-- 
David Kastrup
