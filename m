From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 20:57:58 +0200
Message-ID: <vpqtwqlt13d.fsf@grenoble-inp.fr>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 20:58:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZepFC-0003PG-8s
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 20:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbbIWS6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 14:58:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36379 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883AbbIWS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 14:58:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8NIvuHk006981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 23 Sep 2015 20:57:56 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8NIvwEL009866;
	Wed, 23 Sep 2015 20:57:58 +0200
In-Reply-To: <1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 23 Sep 2015 23:41:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Sep 2015 20:57:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8NIvuHk006981
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443639478.70942@NgmnI6BjECEXB2rYF/ciMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278502>

Karthik Nayak <karthik.188@gmail.com> writes:

> Remove the error reporting variable to make the code easier to port
> over to using ref-filter APIs.
>
> This also removes the error from being displayed. As branch.c will use
> ref-filter APIs in the following patches, the error checking becomes
> redundant with the error reporting system found in the ref-filter
> (ref-filter.c:1336).

I would have written

As branch.c will use ref-filter APIs in the following patches, the error
checking becomes redundant with the error reporting system found in the
ref-filter: error "branch '%s' does not point at a commit" is redundant
with the check performed in ref_filter_handler (ref-filter.c:1336).
Error "some refs could not be read" can only be triggered as a
consequence of the first one hence becomes useless.

> @@ -370,10 +369,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
>  	commit = NULL;
>  	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
>  		commit = lookup_commit_reference_gently(oid->hash, 1);
> -		if (!commit) {
> -			cb->ret = error(_("branch '%s' does not point at a commit"), refname);
> +		if (!commit)
>  			return 0;
> -		}

Am I correct that the "return 0" statement above is dead code after the
end of the series?

If so, you should add a comment explaining that it's there "just in
case" but not supposed to happen, or replace the if statement with
"assert(commit);" IMHO. I have a preference for assert(): I don't like
silent failures.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
