From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Move pathspec validation into interactive_add
Date: Sat, 24 Nov 2007 14:34:36 -0800
Message-ID: <7vtznbp91f.fsf@gitster.siamese.dyndns.org>
References: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
	<1195908922-88023-1-git-send-email-win@wincent.com>
	<1195908922-88023-2-git-send-email-win@wincent.com>
	<1195908922-88023-3-git-send-email-win@wincent.com>
	<7vir3rqwts.fsf@gitster.siamese.dyndns.org>
	<4D81F973-8951-458A-958D-E24C826CA548@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 23:35:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw3aZ-0003Hi-I4
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 23:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbXKXWeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2007 17:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbXKXWeo
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 17:34:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36117 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbXKXWen convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Nov 2007 17:34:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C7EFE2EF;
	Sat, 24 Nov 2007 17:35:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1025C995E9;
	Sat, 24 Nov 2007 17:35:00 -0500 (EST)
In-Reply-To: <4D81F973-8951-458A-958D-E24C826CA548@wincent.com> (Wincent
	Colaiuta's message of "Sat, 24 Nov 2007 22:50:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65964>

Wincent Colaiuta <win@wincent.com> writes:

> El 24/11/2007, a las 20:15, Junio C Hamano escribi=C3=B3:
>
>> Wincent Colaiuta <win@wincent.com> writes:
>>
>>> Instead of throwing away the return status of pathspec_match() I am
>>> keeping it, and any successful match breaks out of the loop early.
>>
>> Leaving it early before checking if all the given pathspecs are
>> used defeats the whole "error-unmatch" business, doesn't it?
>
> No, I probably didn't explain that clearly enough... If you look at
> the patch, I break out of the *inner* loop the first time a particula=
r
> pattern matches. Then I move on to the next pattern, and any single
> invalid pattern will be enough to provide the "error-unmatch"
> indication.

Heh, I missed that the code was doing something so stupid ;-).

The helper function pathspec_match() takes a single path and a
set of pathspecs (NULL terminated), and says if the path is
covered with that set, while recording which one of the
pathspecs caused the match in the ps_matched array.

You are checking first with the full set of patterns, then the
full set minus the first pattern, and then the full set minus
the first two patterns, and so on.  No wonder it is inefficient.

Why are you trying to micro-optimize this part in the first
place?  Have you benchmarked and determined that iterating over
full cache is the bottleneck?

In order to prove that there is a pathspec (or more) that does
not match anything in the cache, you need to interate over the
whole cache at least once.  The only case you can short-cut is
when you can tell that all of them have been used before you
iterated over all cache entries.

So lose that silly outer loop, and replace the inner function
with something like this:

        static int validate_pathspec(const char *prefix, const char **p=
attern)
        {
                int i, ret =3D 0, num_patterns;
                char *m;

                if (!pattern || !*pattern)
                        return 0;

                for (num_patterns =3D 0; pattern[num_patterns]; num_pat=
terns++)
                        ;
                m =3D xcalloc(1, num_patterns + 1);
                for (i =3D 0; i < active_nr; i++) {
                        struct cache_entry *ce =3D active_cache[i];

                        if (pathspec_match(pattern, m, ce->name, 0)) {
                                /*
                                 * You could micro optimize by leaving
                                 * the loop early when you notice that =
all
				 * patterns are used.
				 *
                                 * if (strlen(m) =3D=3D num_patterns)
                                 * 	goto ok;
				 *
                                 */=20
				; /* nothing */
			}
                }
                report_path_error(m, pattern, prefix ? strlen(prefix) :=
 0);
        ok:
                free(m);
                return ret;
        }

My gut feeling is that the micro-optimization is not worth it here, but
I didn't try.  I think without the micro-optimization the above is the
same as I gave you earlier.
