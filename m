From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/9] ref-filter: introduce format_ref_array_item()
Date: Tue, 06 Oct 2015 21:38:58 +0200
Message-ID: <vpqlhbfg52l.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-7-git-send-email-Karthik.188@gmail.com>
	<vpqoagg9n2l.fsf@grenoble-inp.fr>
	<CAOLa=ZTMf9i=+9Rgi9oO==vr_JGtG3J9DvQWk18Zx-yd5_35XA@mail.gmail.com>
	<vpq1td9zolv.fsf@grenoble-inp.fr>
	<CAOLa=ZSr19+0OVoyACdN_YfSFeWugtS40WNu0GB9=uZFEu8N5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 21:39:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjY4z-00027N-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 21:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbbJFTjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 15:39:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42207 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbbJFTjL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 15:39:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t96JctSI000941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 6 Oct 2015 21:38:55 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t96JcwpD030475;
	Tue, 6 Oct 2015 21:38:58 +0200
In-Reply-To: <CAOLa=ZSr19+0OVoyACdN_YfSFeWugtS40WNu0GB9=uZFEu8N5A@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 7 Oct 2015 00:46:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Oct 2015 21:38:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t96JctSI000941
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444765139.2266@T0yYJ7SnqKmo7NZZJW+Txg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279163>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Oct 5, 2015 at 2:19 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>> which does not play well with the implementation of --column as done
>>> in tag.c. Where, If I'm not wrong the --column option captures all
>>> output, formats it and then prints it to stdout. Hence when using
>>> colors, we're told that the printing isn't done to a tty which
>>> supports colors, hence we lose out on colors.
>>
>> What I don't understand is how --column is different from --no-column
>> wrt colors.
>>
>> In any case, this should be explained better in comments.
>
> Well, If we use column the way we do in tag.c then it'll replace the tty
> and color will not print color because it will assume the output tty doesn't
> support colors.
>
> I hope that's what you're asking

Looking a bit more closely at the code, I think I understand what's
going on. branch.c used print_columns which does all the clever things
wrt columns display. tag.c used run_column_filter which pipes the output
to "git column" (hence, indeed, color detection does not work since
we're writting to a pipe).

The branch.c way seems good to me (why fork another process when we can
format the list ourselves ?). Probably tag.c could (should?) be modified
to use it too. It should just be justified, like, replacing this commit
message with:

-- 8< --
To allow column display, we will need to first render the output in a
string list to allow print_columns() to compute the proper size of each
column before starting the actual output. Introduce the function
format_ref_array_item() that does the formatting of a ref_array_item to
an strbuf.

show_ref_array_item() is kept as a convenience wrapper around it which
obtains the strbuf and prints it the standard output.
-- 8< --

and adding a comment next to if (column_active(colopts)) { in patch
8/9:

	/* format to a string_list to let print_columns() do its job */

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
