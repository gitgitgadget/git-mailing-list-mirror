From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 17:06:59 +0100
Organization: OPDS
Message-ID: <C79FDE949E6D43478E1176342FA09E0E@PhilipOakley>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com> <1380283828-25420-4-git-send-email-artagnon@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 18:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPaZS-0008DM-8h
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 18:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab3I0QHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 12:07:05 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:26085 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753488Ab3I0QHE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Sep 2013 12:07:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlkGALesRVJOl3GZ/2dsb2JhbABbgweJcbdaCoEbF3SCIAUBAQQBCAEBHREeAQEhBQYBAQMFAgEDDgcBCyUUAQQIEgYHFwYBEggCAQIDAYdjAwkKsAwNiWqMZoJrgyaBAQOJAYYShwOOLYU0gyU7
X-IPAS-Result: AlkGALesRVJOl3GZ/2dsb2JhbABbgweJcbdaCoEbF3SCIAUBAQQBCAEBHREeAQEhBQYBAQMFAgEDDgcBCyUUAQQIEgYHFwYBEggCAQIDAYdjAwkKsAwNiWqMZoJrgyaBAQOJAYYShwOOLYU0gyU7
X-IronPort-AV: E=Sophos;i="4.90,994,1371078000"; 
   d="scan'208";a="438197797"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with SMTP; 27 Sep 2013 17:06:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235467>

----- Original Message ----- 
From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Friday, September 27, 2013 1:10 PM
> Introduce %(upstream:track) to display "[ahead M, behind N]" and
> %(upstream:trackshort) to display "=", ">", "<", or "<>"
> appropriately (inspired by contrib/completion/git-prompt.sh).
>
> Now you can use the following format in for-each-ref:
>
>  %C(green)%(refname:short)%C(reset)%(upstream:trackshort)
>
> to display refs with terse tracking information.
>
> Note that :track and :trackshort only work with "upstream", and error
> out when used with anything else.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> Documentation/git-for-each-ref.txt |  6 +++++-
> builtin/for-each-ref.c             | 44 
> ++++++++++++++++++++++++++++++++++++--
> 2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt 
> b/Documentation/git-for-each-ref.txt
> index f1d4e9e..682eaa8 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -93,7 +93,11 @@ objectname::
> upstream::
>  The name of a local ref which can be considered ``upstream''
>  from the displayed ref. Respects `:short` in the same way as
> - `refname` above.
> + `refname` above.  Additionally respects `:track` to show
> + "[ahead N, behind M]" and `:trackshort` to show the terse
> + version (like the prompt) ">", "<", "<>", or "=".  Has no
> + effect if the ref does not have tracking information
> + associated with it.
>

"=" and "<>" I can easily understand (binary choice), but ">" and "<" 
will
need to be clear which way they indicate in terms of matching
the "[ahead N]" and  "[behind M]" options.

Otherwise a good idea.

Philip

> HEAD::
>  Used to indicate the currently checked out branch.  Is '*' if
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index e54b5d8..10843bb 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -631,6 +631,7 @@ static void populate_value(struct refinfo *ref)
>  int eaten, i;
>  unsigned long size;
>  const unsigned char *tagged;
> + int upstream_present = 0;
>
>  ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
>
> @@ -648,6 +649,7 @@ static void populate_value(struct refinfo *ref)
>  int deref = 0;
>  const char *refname;
>  const char *formatp;
> + struct branch *branch;
>
>  if (*name == '*') {
>  deref = 1;
> @@ -659,7 +661,6 @@ static void populate_value(struct refinfo *ref)
>  else if (!prefixcmp(name, "symref"))
>  refname = ref->symref ? ref->symref : "";
>  else if (!prefixcmp(name, "upstream")) {
> - struct branch *branch;
>  /* only local branches may have an upstream */
>  if (prefixcmp(ref->refname, "refs/heads/"))
>  continue;
> @@ -669,6 +670,7 @@ static void populate_value(struct refinfo *ref)
>      !branch->merge[0]->dst)
>  continue;
>  refname = branch->merge[0]->dst;
> + upstream_present = 1;
>  }
>  else if (!strcmp(name, "flag")) {
>  char buf[256], *cp = buf;
> @@ -686,6 +688,7 @@ static void populate_value(struct refinfo *ref)
>  } else if (!strcmp(name, "HEAD")) {
>  const char *head;
>  unsigned char sha1[20];
> +
>  head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
>  if (!strcmp(ref->refname, head))
>  v->s = "*";
> @@ -698,11 +701,48 @@ static void populate_value(struct refinfo *ref)
>  formatp = strchr(name, ':');
>  /* look for "short" refname format */
>  if (formatp) {
> + int num_ours, num_theirs;
> +
>  formatp++;
>  if (!strcmp(formatp, "short"))
>  refname = shorten_unambiguous_ref(refname,
>        warn_ambiguous_refs);
> - else
> + else if (!strcmp(formatp, "track") &&
> + !prefixcmp(name, "upstream")) {
> + char buf[40];
> +
> + if (!upstream_present)
> + continue;
> + stat_tracking_info(branch, &num_ours, &num_theirs);
> + if (!num_ours && !num_theirs)
> + v->s = "";
> + else if (!num_ours) {
> + sprintf(buf, "[behind %d]", num_theirs);
> + v->s = xstrdup(buf);
> + } else if (!num_theirs) {
> + sprintf(buf, "[ahead %d]", num_ours);
> + v->s = xstrdup(buf);
> + } else {
> + sprintf(buf, "[ahead %d, behind %d]",
> + num_ours, num_theirs);
> + v->s = xstrdup(buf);
> + }
> + continue;
> + } else if (!strcmp(formatp, "trackshort") &&
> + !prefixcmp(name, "upstream")) {
> + if (!upstream_present)
> + continue;
> + stat_tracking_info(branch, &num_ours, &num_theirs);
> + if (!num_ours && !num_theirs)
> + v->s = "=";
> + else if (!num_ours)
> + v->s = "<";
> + else if (!num_theirs)
> + v->s = ">";
> + else
> + v->s = "<>";
> + continue;
> + } else
>  die("unknown %.*s format %s",
>      (int)(formatp - name), name, formatp);
>  }
> -- 
> 1.8.4.478.g55109e3
>
> --
