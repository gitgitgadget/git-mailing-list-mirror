From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the presentation layer
Date: Tue, 28 Jul 2015 15:09:02 +0200
Message-ID: <vpqbnewxwcx.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:09:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK4d9-0003Ph-Iz
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 15:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbbG1NJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 09:09:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60257 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbbG1NJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 09:09:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6SD90Dv003490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 15:09:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SD92Y8032104;
	Tue, 28 Jul 2015 15:09:02 +0200
In-Reply-To: <1438066594-5620-7-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 28 Jul 2015 15:09:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SD90Dv003490
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438693743.22651@zP2F15Hft/g5N3J1a2hCNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274769>

Karthik Nayak <karthik.188@gmail.com> writes:

> We check if given ref is the current branch in print_ref_list().  Move
> this check to print_ref_item() where it is checked right before
> printing.

This means that the '*' and the different color are coded in C, hence
it's not possible to mimick this using "git for-each-ref --format ...".

I do not consider this as blocking, but I think the ultimate goal should
be to allow this, so that all the goodies of "git branch" can be made
available to other ref-listing commands.

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -534,9 +534,9 @@ static char *get_head_description(void)
>  }
>  
>  static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
> -			   int abbrev, int current, const char *remote_prefix)
> +			   int abbrev, int detached, const char *remote_prefix)
>  {
> -	char c;
> +	char c = ' ';
>  	int color;
>  	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
>  	const char *prefix = "";
> @@ -547,7 +547,11 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>  
>  	switch (item->kind) {
>  	case REF_LOCAL_BRANCH:
> -		color = BRANCH_COLOR_LOCAL;
> +		if (!detached && !strcmp(item->name, head)) {
> +			color = BRANCH_COLOR_CURRENT;
> +			c = '*';
> +		} else
> +			color = BRANCH_COLOR_LOCAL;
>  		break;
>  	case REF_REMOTE_BRANCH:
>  		color = BRANCH_COLOR_REMOTE;
> @@ -556,18 +560,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>  	case REF_DETACHED_HEAD:
>  		color = BRANCH_COLOR_CURRENT;
>  		desc = get_head_description();
> +		c = '*';
>  		break;
>  	default:
>  		color = BRANCH_COLOR_PLAIN;
>  		break;
>  	}
>  
> -	c = ' ';
> -	if (current) {
> -		c = '*';
> -		color = BRANCH_COLOR_CURRENT;
> -	}

I actually prefered the old way: current is a Boolean that says
semantically "this is the current branch", and the Boolean is turned
into presentation directives in a separate piece of code.

I'd write

char c;
int current = 0;

...

if (...)
	current = 1;
...
case REF_DETACHED_HEAD:
	current = 1;
...

and keep the last hunk.

(IOW, turn current from a parameter into a local variable)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
