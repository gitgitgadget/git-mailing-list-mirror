From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Port branch.c to use ref-filter APIs
Date: Tue, 28 Jul 2015 15:35:05 +0200
Message-ID: <vpqoaiwwgl2.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:35:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK52U-00036U-HR
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 15:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbbG1NfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 09:35:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60872 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbbG1NfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 09:35:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6SDZ4El008745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 15:35:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SDZ5nK032564;
	Tue, 28 Jul 2015 15:35:05 +0200
In-Reply-To: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 28 Jul 2015 12:25:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 28 Jul 2015 15:35:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SDZ4El008745
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438695308.3605@vPVbBMQalJULzGnHpEK/OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274770>

Karthik Nayak <karthik.188@gmail.com> writes:

> This version also doesn't use the printing options provided by
> branch.c.

Do you mean "provided by ref-filter.{c,h}"?

> I wanted to discuss how exactly to go about that, because in branch.c,
> we might need to change the --format based on attributes such as
> abbrev, verbose and so on. But ref-filter expects us to verify the
> format before filtering.

I took time to understand the problem, but here's my understanding:

ref-filter expects the code to look like

	format = ...;
	verify_ref_format(format);
	filter_refs(...);
	for (...)
		show_ref_array_item(..., format, ...);

and in the case of "git branch -v", you need to align the sha1s based on
the longest branch name, i.e. use %(padright:N+1) where N is the longest
branch name. And you can get N only after calling filter_refs, while you
need it for verify_ref_format().

Is my understanding correct?

If so, what prevents swapping the order of verify_ref_format and
filter_refs? I understand that verify_ref_format() builds used_atom and
other data-structures, hence it has to be called before
show_ref_array_item() and before sorting, but I don't think you need it
before filter_refs (I may have missed something though).

So, the code could look like:

filter_refs(...)
if (--format is given)
	format = the argument of --format
else
	format = STRBUF_INIT;
	strbuf_add(&format, "%(some_directive_to_display '*' if needed)");
	if (verbose)
		strbuf_addf(&format, "%(padright:%d)", max_width);
	...
verify_ref_format(format);
ref_array_sort(...);
for (...)
	show_ref_array_item(...);

(BTW, a trivial helper function to display the whole ref_array could
help. It would avoid having each caller write the 'for' loop)

Ideally, you could also have a modifier atom %(alignleft) that would
not need an argument and that would go through the ref_array to find the
maxwidth, and do the alignment. That would give even more flexibility to
the end users of "for-each-ref --format".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
