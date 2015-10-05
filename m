From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Mon, 05 Oct 2015 20:43:53 +0200
Message-ID: <vpq7fn1qhp2.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-9-git-send-email-Karthik.188@gmail.com>
	<vpqvbao86pj.fsf@grenoble-inp.fr>
	<CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 20:44:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjAk3-0002X5-Q4
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 20:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbbJESoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 14:44:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57047 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbbJESoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 14:44:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t95Ihpia008647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 5 Oct 2015 20:43:52 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t95IhrvZ008120;
	Mon, 5 Oct 2015 20:43:53 +0200
In-Reply-To: <CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 5 Oct 2015 23:16:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 05 Oct 2015 20:43:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t95Ihpia008647
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444675435.4637@F1lAzKp02DnSetCHhdaf4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279066>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Sat, Oct 3, 2015 at 6:11 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Actually, this is not a performance-cricical piece of code at all, so I
>> think it's even better to build an strbuf little by little using
>> repeated strbuf_addf calls. This way you can do things like
>>
>> strbuf_addf(fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
>>             branch_get_color(BRANCH_COLOR_CURRENT));
>> strbuf_addf(fmt, "%%(align:%d,left)%%(refname:short)%%(end)", maxwidth);
>>
>> which makes it much easier to pair the %s and the corresponding
>> branch_get_color() or the %d and maxwidth.
>>
>> But fundamentally, I think this function is doing the right thing. The
>> function is a bit complex (I think it will be much nicer to read when
>> better factored), but 1) it allows getting rid of a lot of specific code
>> and 2) it's a proof that --format is expressive enough.
>>
>
> I like the idea of using "#define" it might make things simpler.
>
> Not sure about using a strbuf cause I don't see how that could make things
> simpler, we'll end up with something similar to what we have
> currently.

It allows you to really break the way you build the string into several
small steps, and use if/then locally on steps which require it.

For example, you currently have

+        if (filter->verbose) {
+                if (filter->verbose > 1)
+                        local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
+                                        " %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
+                                        "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
+                                        branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
+                                        branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
+
+                else
+                        local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%"
+                                        "%(refname:short)%%(end)%s %%(objectname:short,7) %%(if)%%(upstream:track)%"
+                                        "%(then)%%(upstream:track) %%(end)%%(contents:subject)",
+                                        branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET));
+
+                remote = xstrfmt("  %s%%(align:%d,left)%s%%(refname:short)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
+                                 "%%(else) %%(objectname:short,7) %%(contents:subject)%%(end)",
+                                 branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
+                                 remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
+                final = xstrfmt("%%(if:notequals=remotes)%%(path:short)%%(then)%s%%(else)%s%%(end)", local, remote);
+
+        } else {
+                local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(refname:short)%s",

The first bits of local are identical in all branches of the two-level
if/else. You could use something like

	strbuf_addf(format, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
		    branch_get_color(BRANCH_COLOR_CURRENT));
	if (filter->verbose) {
		...
	}

to factor it out of the if/else. Similarly, the "if (filter->verbose >
1)" could be much smaller, and probably doesn't require an else branch
(just say "if very verbose, then add XYZ at this point in the format
string").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
